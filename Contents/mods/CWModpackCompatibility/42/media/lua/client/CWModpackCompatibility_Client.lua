-- Build 42 compatibility overrides.
CWModpackCompatibility = CWModpackCompatibility or {}

local Compat = CWModpackCompatibility

local function isActive(modID)
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains(modID)
end

local function log(message)
    print("[CWModpackCompatibility] " .. tostring(message))
end

local function applyFastForwardExactMinuteClockFix()
    if not isActive("FastForward") then return end
    if not isActive("ExactMinuteClock") then return end

    if not FFPanel or not FFPanel.setY then return end
    if FFPanel.__cwExactMinuteClockAnchor then return end

    local originalSetY = FFPanel.setY

    -- Fast Forward's prerender uses UIManager.getClock():isVisible(). Exact
    -- Minute Clock intentionally hides that vanilla Java widget every frame
    -- and draws its own replacement, so Fast Forward takes its y=10 fallback
    -- and overlaps the replacement. Intercept only that fallback coordinate
    -- on FFPanel; every other panel and every other setY call is untouched.
    FFPanel.setY = function(self, y)
        if y == 10 and ExactMinuteClock and ExactMinuteClock.instance then
            local clock = ExactMinuteClock.instance
            if clock.visible and clock.getHeight and clock.getY then
                y = clock:getY() + clock:getHeight() + 16
            end
        end
        return originalSetY(self, y)
    end

    FFPanel.__cwExactMinuteClockAnchor = true
    log("Applied Fast Forward + Exact Minute Clock HUD anchor fix.")
end

local function applyExactMinuteClockAMPMFix()
    if not isActive("ExactMinuteClock") then return end
    if not ExactMinuteClock or not ExactMinuteClock.renderDisplay then return end
    if ExactMinuteClock.__cwTopRowAMPM then return end

    local originalRenderDisplay = ExactMinuteClock.renderDisplay

    ExactMinuteClock.renderDisplay = function(self, ghost, color)
        local sourceTimeDigits = self.timeDigits
        local digits, isPM, is24 = sourceTimeDigits(self)
        if is24 then
            return originalRenderDisplay(self, ghost, color)
        end

        -- Exact Minute Clock intentionally moved AM/PM to the date row and
        -- used its normal top-row slot for weight. During the original draw,
        -- report 24-hour mode to suppress that bottom label and temporarily
        -- disable weight while preserving its reserved width and alarm layout.
        local savedInstanceTimeDigits = rawget(self, "timeDigits")
        local savedOptions = ExactMinuteClockOptions
        local weightOff = { getValue = function() return false end }

        self.timeDigits = function(clock)
            local currentDigits, currentIsPM = sourceTimeDigits(clock)
            return currentDigits, currentIsPM, true
        end
        ExactMinuteClockOptions = {
            getOption = function(_, id)
                if id == "ShowWeight" then return weightOff end
                return savedOptions and savedOptions:getOption(id) or nil
            end,
        }

        originalRenderDisplay(self, ghost, color)

        ExactMinuteClockOptions = savedOptions
        self.timeDigits = savedInstanceTimeDigits

        -- Restore the familiar vanilla position immediately after the time.
        local ux = self.uxOriginal
        for i = 1, 4 do
            ux = ux + self.digitsMain[0]:getWidth()
            if i == 2 then
                ux = ux + self.colonSpacing + self.colon:getWidth() + self.colonSpacing
            elseif i < 4 then
                ux = ux + self.largeDigitSpacing
            end
        end
        ux = ux + self.ampmSpacing
        local uy = self.uyOriginal

        if ghost then
            self:drawTexture(self.texAm, ux, uy + self.amVerticalSpacing, color.a, color.r, color.g, color.b)
            self:drawTexture(self.texPm, ux, uy + self.pmVerticalSpacing, color.a, color.r, color.g, color.b)
        elseif isPM then
            self:drawTexture(self.texPm, ux, uy + self.pmVerticalSpacing, color.a, color.r, color.g, color.b)
        else
            self:drawTexture(self.texAm, ux, uy + self.amVerticalSpacing, color.a, color.r, color.g, color.b)
        end
    end

    ExactMinuteClock.__cwTopRowAMPM = true
    log("Applied Exact Minute Clock AM/PM placement fix.")
end

local function applyQuartermasterRuntimeCategoryFix()
    if not isActive("Quartermaster") then return end

    require("LootSorter_Categories")
    require("LootSorter_Picker")
    if not LootSorter or not LootSorter.getCategories then return end
    if LootSorter.__cwRuntimeCategoryDiscovery then return end

    local originalGetCategories = LootSorter.getCategories
    local originalGetItemsInCategory = LootSorter.getItemsInCategory
    local originalOpenPicker = LootSorter.openPicker
    local originalOpenPresetEditor = LootSorter.openPresetEditor
    local runtimeCategories = {}
    local runtimeItems = {}

    local function rememberItem(item)
        if not item then return end

        local ok, category = pcall(function()
            return item:getDisplayCategory()
        end)
        if not ok or type(category) ~= "string" or category == "" then return end

        runtimeCategories[category] = true

        local itemName
        local fullType
        pcall(function()
            itemName = item:getDisplayName()
            fullType = item:getFullType()
        end)
        if itemName and itemName ~= "" then
            runtimeItems[category] = runtimeItems[category] or {}
            runtimeItems[category][itemName] = fullType
        end
    end

    local function scanContainer(container, seenContainers)
        if not container or seenContainers[container] then return end
        seenContainers[container] = true

        local items = container:getItems()
        if not items then return end
        for index = 0, items:size() - 1 do
            local item = items:get(index)
            rememberItem(item)
            if item and instanceof(item, "InventoryContainer") then
                scanContainer(item:getItemContainer(), seenContainers)
            end
        end
    end

    local function scanInventoryPage(page, seenContainers)
        if not page or not page.backpacks then return end
        for _, button in ipairs(page.backpacks) do
            scanContainer(button and button.inventory, seenContainers)
        end
    end

    local function rememberConfiguredCategories(categories)
        if not categories then return end
        for category, selected in pairs(categories) do
            if selected and type(category) == "string" and category ~= "" then
                runtimeCategories[category] = true
            end
        end
    end

    local function discoverRuntimeCategories(playerNum, targetObj, targetCI)
        local seenContainers = {}
        local player = getSpecificPlayer(playerNum or 0)
        if player then
            scanContainer(player:getInventory(), seenContainers)
        end

        if targetObj and targetObj.getContainerByIndex then
            scanContainer(targetObj:getContainerByIndex(targetCI or 0), seenContainers)
            if LootSorter.getBoxCats then
                rememberConfiguredCategories(LootSorter.getBoxCats(targetObj, targetCI or 0))
            end
        end

        pcall(function()
            scanInventoryPage(getPlayerInventory(playerNum or 0), seenContainers)
        end)
        pcall(function()
            scanInventoryPage(getPlayerLoot(playerNum or 0), seenContainers)
        end)
    end

    -- Quartermaster enumerates ScriptItem categories once, but mods may assign
    -- categories to individual InventoryItem instances based on recorded media,
    -- fluid contents, condition, or other runtime state. Merge every category
    -- observed on real items without knowing or hard-coding its name.
    LootSorter.getCategories = function(...)
        local categories = originalGetCategories(...) or {}
        local result = {}
        local seen = {}
        for _, category in ipairs(categories) do
            if category and category ~= "" and not seen[category] then
                seen[category] = true
                result[#result + 1] = category
            end
        end
        for category in pairs(runtimeCategories) do
            if not seen[category] then
                seen[category] = true
                result[#result + 1] = category
            end
        end
        table.sort(result)
        return result
    end

    if originalGetItemsInCategory then
        LootSorter.getItemsInCategory = function(category, ...)
            local result = {}
            local seenNames = {}
            for _, record in ipairs(originalGetItemsInCategory(category, ...) or {}) do
                result[#result + 1] = record
                if record.name then seenNames[record.name] = true end
            end
            for itemName, fullType in pairs(runtimeItems[category] or {}) do
                if not seenNames[itemName] then
                    result[#result + 1] = { name = itemName, fullType = fullType }
                end
            end
            table.sort(result, function(a, b) return (a.name or "") < (b.name or "") end)
            return result
        end
    end

    if originalOpenPicker then
        LootSorter.openPicker = function(obj, ci, playerNum, ...)
            discoverRuntimeCategories(playerNum, obj, ci)
            return originalOpenPicker(obj, ci, playerNum, ...)
        end
    end

    if originalOpenPresetEditor then
        LootSorter.openPresetEditor = function(name, playerNum, parent, ...)
            discoverRuntimeCategories(playerNum, parent and parent.targetObj, parent and parent.targetCI)
            return originalOpenPresetEditor(name, playerNum, parent, ...)
        end
    end

    LootSorter.discoverRuntimeCategories = discoverRuntimeCategories
    LootSorter.__cwRuntimeCategoryDiscovery = true
    log("Applied Quartermaster runtime category discovery fix.")
end

local function applyClientFixes()
    applyFastForwardExactMinuteClockFix()
    applyExactMinuteClockAMPMFix()
    applyQuartermasterRuntimeCategoryFix()
end

Events.OnGameStart.Add(applyClientFixes)
