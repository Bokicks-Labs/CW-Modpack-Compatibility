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
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

local function optionText(value)
    -- Options:addDescription() already stores translated text, while names and
    -- tooltips may be either localization keys or literal strings. Calling
    -- getText() again is unsafe: several mods have literal '%' characters in
    -- translations, which Java's formatter treats as missing format arguments.
    return value == nil and "" or tostring(value)
end

local function normalized(value)
    return string.lower(optionText(value)):gsub("_", " "):gsub("^%s+", ""):gsub("%s+$", "")
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
        local modName = optionText(options.name)
        local data = options.data or {}
        local positions = {}
        for index, option in ipairs(data) do
            positions[index] = elementY(option.element)
        end
        for index, option in ipairs(data) do
            local optionName = optionText(option.name)
            local description = optionText(option.text or option.tooltip)
            local targetY = positions[index]
            if not targetY then
                -- Titles, separators and descriptions have no option.element.
                -- Prefer the next control in their section, then the previous one.
                for nextIndex = index + 1, #data do
                    if positions[nextIndex] then
                        targetY = positions[nextIndex]
                        break
                    end
                end
                if not targetY then
                    for previousIndex = index - 1, 1, -1 do
                        if positions[previousIndex] then
                            targetY = positions[previousIndex]
                            break
                        end
                    end
                end
            end
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
        if #data == 0 then
            table.insert(results, {
                modName = modName,
                optionName = "",
                description = "",
                targetY = nil,
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
    if result then self:openTarget(result) end
end

function SearchWindow:openSelected()
    local selected = self.results.items[self.results.selected]
    if selected then self:openTarget(selected.item) end
end

function SearchWindow:openTarget(result)
    if not Search.goTo(result) then
        self.status:setName("Setting position unavailable")
    end
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

function Search.open()
    local mainOptions = MainOptions and MainOptions.instance or nil
    local panel = mainOptions and mainOptions.tabs and mainOptions.tabs:getActiveView() or nil
    if not panel then return end
    Search.mainOptions = mainOptions
    Search.modPanel = panel
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
    if not panel or not result or not result.targetY then return false end
    local maximum = math.max(0, panel:getScrollHeight() - panel:getHeight())
    local wanted = math.max(0, math.min(maximum, result.targetY - 45))
    panel:setYScroll(-wanted)
    if Search.window then Search.window:close() end
    return true
end

local function install()
    if not MainOptions or not MainOptions.close then return end
    if MainOptions.__cwModOptionsSearchInstalled then return end
    MainOptions.__cwModOptionsSearchInstalled = true
    local originalClose = MainOptions.close
    MainOptions.close = function(self, ...)
        if Search.window then Search.window:close() end
        Search.mainOptions = nil
        Search.modPanel = nil
        return originalClose(self, ...)
    end

    local api = PZAPI and PZAPI.ModOptions or nil
    if not api or not api.create then return end
    local options = api.getOptions and api:getOptions("CWModOptionsSearch") or nil
    if not options then
        options = api:create("CWModOptionsSearch", "Mod Options Search")
        -- Put the launcher first so it remains easy to find before it is needed.
        for index, candidate in ipairs(api.Data) do
            if candidate == options then
                table.remove(api.Data, index)
                break
            end
        end
        table.insert(api.Data, 1, options)
    end
    if options and options.addButton and not options:getOption("OPEN_SEARCH") then
        options:addButton(
            "OPEN_SEARCH",
            "Search Mod Options...",
            "Search registered mod settings and jump to a result.",
            Search.open
        )
    end
    print("[CWModOptionsSearch] Installed Mod Options search navigation.")
end

install()
