-- Recover an unresolved multiplayer item reference using its inventory ID.
local function install()
    require("TimedActions/ISClothingExtraAction")
    if not ISClothingExtraAction or ISClothingExtraAction.__cwItemRecovery then return end
    local originalNew = ISClothingExtraAction.new
    local originalComplete = ISClothingExtraAction.complete

    function ISClothingExtraAction:new(character, item, extra, itemId)
        if not item and character and itemId then
            item = character:getInventory():getItemById(itemId)
        end
        local action = originalNew(self, character, item, extra)
        action.itemId = item and item:getID() or itemId
        return action
    end

    ISClothingExtraAction.complete = function(self, ...)
        local inventory = self.character:getInventory()
        if not self.item and self.itemId then
            self.item = inventory:getItemById(self.itemId)
        end
        if not self.item or not inventory:contains(self.item) then
            print("[CWModpackCompatibility][ClothingExtra] Skipped stale transformation; target item is no longer in inventory.")
            return true
        end
        return originalComplete(self, ...)
    end
    ISClothingExtraAction.__cwItemRecovery = true
    print("[CWModpackCompatibility][ClothingExtra] Installed multiplayer item recovery.")
end

Events.OnGameStart.Add(install)
if Events.OnServerStarted then Events.OnServerStarted.Add(install) end
