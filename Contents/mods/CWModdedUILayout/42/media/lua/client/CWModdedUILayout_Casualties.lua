-- Layout only. Keep this in the optional UI submod, separate from CW core fixes.
local function install()
    if not getActivatedMods or not getActivatedMods():contains("CasualtiesUndead") then return end

    require "ISUI/ISCUVitalsUI"
    require "ISUI/ISCUDebugUI"
    require "ISUI/ISMinigameBaseUI"

    if ISCUVitalsUI and not ISCUVitalsUI.__cwLayout then
        ISCUVitalsUI.__cwLayout = true
        local follow = ISCUVitalsUI.follow
        ISCUVitalsUI.follow = function(panel)
            follow(panel)
            local ui = ISCUVitalsUI.instance
            if not ui then return end
            local width = 344
            ui:setWidth(width)
            if ui.todoBtn then ui.todoBtn:setX(width - ui.todoBtn:getWidth() - 4) end
            local screen = getCore():getScreenWidth()
            if ui:getX() + width > screen - 8 then
                ui:setX(math.max(8, panel:getAbsoluteX() - width - 6))
            end
        end

        local row = ISCUVitalsUI.row
        ISCUVitalsUI.row = function(self, y, ...)
            return row(self, y, ...) + 7
        end

        local bar = ISCUVitalsUI.bar
        ISCUVitalsUI.bar = function(self, x, y, w, h, ...)
            return bar(self, x, y + 6, w, h, ...)
        end
    end

    if ISCUDebugUI and not ISCUDebugUI.__cwLayout then
        ISCUDebugUI.__cwLayout = true
        ISCUDebugUI.createChildren = function(self, ...)
            local tm = getTextManager()
            local widest = 0
            for _, section in ipairs(ISCUDebugUI.SECTIONS) do
                for _, entry in ipairs(section.items) do
                    widest = math.max(widest, tm:MeasureStringX(UIFont.Small, entry[1]))
                end
            end
            local width = math.min(getCore():getScreenWidth() - 32,
                                   math.max(620, (widest + 28) * 2 + 36))
            self:setWidth(width)
            self:setX(math.floor((getCore():getScreenWidth() - width) / 2))
            ISCollapsableWindow.createChildren(self)
            local top = self:titleBarHeight() + 2
            self:setHeight(math.max(280, math.min(760, getCore():getScreenHeight() - self.y - 30)))
            local content = ISPanel:new(0, top, width, self.height - top - 10)
            content:initialise()
            content:instantiate()
            content.background = false
            content:addScrollBars()
            content:setScrollChildren(true)
            content.onMouseWheel = function(panel, delta)
                panel:setYScroll(panel:getYScroll() - delta * 36)
                return true
            end
            content.prerender = function(panel)
                panel:setStencilRect(0, 0, panel.width, panel.height)
                for _, row in ipairs(self.rows or {}) do
                    panel:drawText(row.label, 8, row.y, 0.75, 0.75, 0.78, 1, UIFont.Small)
                end
            end
            content.render = function(panel) panel:clearStencilRect() end
            self:addChild(content)
            self.content = content

            local columns, gap, pad, buttonH = 2, 6, 8, 26
            local buttonW = math.floor((width - pad * 2 - 16 - gap) / columns)
            local y = pad
            self.rows = {}
            for _, section in ipairs(ISCUDebugUI.SECTIONS) do
                self.rows[#self.rows + 1] = { label = section.title, y = y }
                y = y + 22
                for i, entry in ipairs(section.items) do
                    local col = (i - 1) % columns
                    local bx = pad + col * (buttonW + gap)
                    local by = y + math.floor((i - 1) / columns) * (buttonH + gap)
                    local btn = ISButton:new(bx, by, buttonW, buttonH, entry[1], self, ISCUDebugUI.onPress)
                    btn.internal = entry
                    btn:initialise()
                    btn:instantiate()
                    btn.borderColor = { r = 0.4, g = 0.4, b = 0.4, a = 1 }
                    content:addChild(btn)
                end
                y = y + math.ceil(#section.items / columns) * (buttonH + gap) + 10
            end
            content:setScrollHeight(y + pad)
        end
    end

    if ISMinigameBaseUI and not ISMinigameBaseUI.__cwLayout then
        ISMinigameBaseUI.__cwLayout = true
        ISMinigameBaseUI.MONITOR_FRACTION = math.max(ISMinigameBaseUI.MONITOR_FRACTION or 0, 0.40)
        local drawBar = ISMinigameBaseUI.drawBar
        ISMinigameBaseUI.drawBar = function(self, x, y, w, h, ...)
            if self.monitorX and x >= self.monitorX then y = y + 6 end
            return drawBar(self, x, y, w, h, ...)
        end
    end
end

Events.OnGameStart.Add(install)
