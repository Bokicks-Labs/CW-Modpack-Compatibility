-- Optional client-only search/navigation for Build 42's Mod Options page.
-- It indexes the registered PZAPI options and scrolls the existing page to a
-- selected match. It never changes option values or rebuilds mod controls.
require "OptionScreens/MainOptions"
require "PZAPI/ModOptions"
require "ISUI/ISButton"
require "ISUI/ISCollapsableWindow"
require "ISUI/ISLabel"
require "ISUI/ISScrollingListBox"
require "ISUI/ISTextEntryBox"

CWModOptionsSearch = CWModOptionsSearch or {}
local Search = CWModOptionsSearch
local TOP_SPACE = 34
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

local function translated(value)
    if value == nil then return "" end
    local ok, result = pcall(getText, tostring(value))
    if ok and result then return tostring(result) end
    return tostring(value)
end

local function normalized(value)
    return string.lower(translated(value)):gsub("^%s+", ""):gsub("%s+$", "")
end

local function elementY(element)
    if not element then return nil end
    if element.txt then element = element.txt end
    if element.getY then return element:getY() end
    return element.y
end

function Search.buildIndex()
    local results = {}
    for _, options in ipairs(PZAPI.ModOptions.Data or {}) do
        local modName = translated(options.name)
        local fallbackY = nil
        for _, option in ipairs(options.data or {}) do
            fallbackY = fallbackY or elementY(option.element)
        end
        for _, option in ipairs(options.data or {}) do
            local optionName = translated(option.name)
            local description = translated(option.text or option.tooltip)
            local targetY = elementY(option.element) or fallbackY
            if optionName ~= "" or description ~= "" then
                table.insert(results, {
                    modName = modName,
                    optionName = optionName,
                    description = description,
                    targetY = targetY,
                    searchText = normalized(modName .. " " .. optionName .. " " .. description),
                })
            end
        end
        if #(options.data or {}) == 0 then
            table.insert(results, {
                modName = modName,
                optionName = "",
                description = "",
                targetY = fallbackY,
                searchText = normalized(modName),
            })
        end
    end
    return results
end

local SearchWindow = ISCollapsableWindow:derive("CWModOptionsSearchWindow")

function SearchWindow:createChildren()
    ISCollapsableWindow.createChildren(self)
    local titleHeight = self:titleBarHeight()
    self.entry = ISTextEntryBox:new("", 8, titleHeight + 8, self.width - 16, 24)
    self.entry.font = UIFont.Small
    self.entry.onTextChange = SearchWindow.onTextChange
    self.entry:initialise()
    self.entry:instantiate()
    self:addChild(self.entry)

    self.results = ISScrollingListBox:new(8, self.entry:getBottom() + 6, self.width - 16, self.height - titleHeight - 78)
    self.results:initialise()
    self.results:instantiate()
    self.results.itemheight = FONT_HGT_SMALL + 8
    self.results.font = UIFont.Small
    self.results.doDrawItem = SearchWindow.drawResult
    self.results:setOnMouseDoubleClick(self, SearchWindow.openResult)
    self.results.anchorRight = true
    self.results.anchorBottom = true
    self:addChild(self.results)

    self.goButton = ISButton:new(8, self.height - 34, 110, 26, "Go to setting", self, SearchWindow.openSelected)
    self.goButton:initialise()
    self.goButton:instantiate()
    self.goButton.anchorTop = false
    self.goButton.anchorBottom = true
    self:addChild(self.goButton)

    self.status = ISLabel:new(128, self.height - 31, 20, "", 0.8, 0.8, 0.8, 1, UIFont.Small, true)
    self.status:initialise()
    self.status.anchorTop = false
    self.status.anchorBottom = true
    self:addChild(self.status)
    self:refreshResults()
end

function SearchWindow:drawResult(y, item, alt)
    if self.selected == item.index then
        self:drawRect(0, y, self:getWidth(), self.itemheight, 0.3, 0.25, 0.55, 0.85)
    elseif alt then
        self:drawRect(0, y, self:getWidth(), self.itemheight, 0.12, 0.12, 0.12, 0.8)
    end
    self:drawRectBorder(0, y, self:getWidth(), self.itemheight, 0.3, 0.6, 0.6, 0.6)
    self:drawText(item.text, 8, y + 4, 1, 1, 1, 1, self.font)
    return y + self.itemheight
end

function SearchWindow:onTextChange()
    local window = Search.window
    if window then window:refreshResults() end
end

function SearchWindow:refreshResults()
    local query = normalized(self.entry and self.entry:getInternalText() or "")
    self.results:clear()
    if #query < 2 then
        self.status:setName("Type at least 2 characters")
        return
    end
    local count = 0
    for _, result in ipairs(Search.buildIndex()) do
        if string.find(result.searchText, query, 1, true) then
            local label = result.modName
            if result.optionName ~= "" then label = label .. "  >  " .. result.optionName end
            self.results:addItem(label, result)
            count = count + 1
        end
    end
    self.status:setName(tostring(count) .. (count == 1 and " match" or " matches"))
end

function SearchWindow:openResult(result)
    if result then Search.goTo(result) end
end

function SearchWindow:openSelected()
    local selected = self.results.items[self.results.selected]
    if selected then Search.goTo(selected.item) end
end

function SearchWindow:close()
    self:setVisible(false)
    self:removeFromUIManager()
    Search.window = nil
end

function SearchWindow:new(x, y, width, height)
    local window = ISCollapsableWindow.new(self, x, y, width, height)
    window.title = "Search Mod Options"
    window.resizable = true
    window.minimumWidth = 420
    window.minimumHeight = 240
    return window
end

function Search.open(mainOptions, panel)
    Search.mainOptions = mainOptions or Search.mainOptions
    Search.modPanel = panel or Search.modPanel
    if Search.window then
        Search.window:setVisible(true)
        Search.window:bringToTop()
        Search.window:refreshResults()
        return
    end
    local width, height = 620, 420
    local x = math.floor((getCore():getScreenWidth() - width) / 2)
    local y = math.floor((getCore():getScreenHeight() - height) / 2)
    Search.window = SearchWindow:new(x, y, width, height)
    Search.window:initialise()
    Search.window:addToUIManager()
end

function Search.goTo(result)
    local panel = Search.modPanel
    if not panel or not result or not result.targetY then return end
    local maximum = math.max(0, panel:getScrollHeight() - panel:getHeight())
    local wanted = math.max(0, math.min(maximum, result.targetY - 45))
    panel:setYScroll(-wanted)
    if Search.window then Search.window:close() end
end

local function install()
    if not MainOptions or not MainOptions.addModOptionsPanel then return end
    if MainOptions.__cwModOptionsSearchInstalled then return end
    MainOptions.__cwModOptionsSearchInstalled = true
    local original = MainOptions.addModOptionsPanel
    MainOptions.addModOptionsPanel = function(self, ...)
        local result = original(self, ...)
        local panel = self.mainPanel
        if not panel then return result end

        local existing = {}
        for _, child in pairs(panel:getChildren()) do
            table.insert(existing, child)
        end
        for _, child in ipairs(existing) do
            child:setY(child:getY() + TOP_SPACE)
        end
        panel:setScrollHeight(panel:getScrollHeight() + TOP_SPACE)

        local button = ISButton:new(10, 4, 170, 26, "Search Mod Options...", self, function(owner)
            Search.open(owner, panel)
        end)
        button:initialise()
        button:instantiate()
        panel:addChild(button)
        Search.mainOptions = self
        Search.modPanel = panel
        return result
    end
    print("[CWModOptionsSearch] Installed Mod Options search navigation.")
end

install()
