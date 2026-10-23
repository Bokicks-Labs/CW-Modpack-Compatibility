-- Layout only. Keep this in the optional UI submod, separate from CW core fixes.
local function install()
    if not getActivatedMods or not getActivatedMods():contains("CasualtiesUndead") then return end

    require "ISUI/ISCUVitalsUI"
    require "ISUI/ISCUDebugUI"
    require "ISUI/ISMinigameBaseUI"
    local fontHeight = getTextManager():getFontHeight(UIFont.Small)
    local titleHeight = math.max(27, fontHeight + 9)

    if ISCUVitalsUI and not ISCUVitalsUI.__cwLayout then
        ISCUVitalsUI.__cwLayout = true
        local follow = ISCUVitalsUI.follow
        ISCUVitalsUI.follow = function(panel)
            follow(panel)
            local ui = ISCUVitalsUI.instance
            if not ui then return end
            local width = 344
            ui:setWidth(width)
            if ui.todoBtn then
                ui.todoBtn:setX(width - ui.todoBtn:getWidth() - 5)
                ui.todoBtn:setY(3)
                ui.todoBtn:setHeight(titleHeight - 6)
            end
            local screen = getCore():getScreenWidth()
            if ui:getX() + width > screen - 8 then
                ui:setX(math.max(8, panel:getAbsoluteX() - width - 6))
            end
        end

        local row = ISCUVitalsUI.row
        ISCUVitalsUI.row = function(self, y, ...)
            return row(self, y, ...) + 11
        end

        local bar = ISCUVitalsUI.bar
        ISCUVitalsUI.bar = function(self, x, y, w, h, ...)
            return bar(self, x, y + 7, w, h, ...)
        end

        ISCUVitalsUI.titleBar = function(self, y, title)
            local w = self.width
            self:drawRect(0, y, w, titleHeight, 0.55, 0.13, 0.13, 0.14)
            self:drawRectBorder(0, y, w, titleHeight, 1, 0.70, 0.71, 0.72)
            self:drawRect(6, y + 7, 5, titleHeight - 14, 1, 0.94, 0.95, 0.96)
            self:drawText(string.upper(title or ""), 17, y + 4, 0.94, 0.95, 0.96, 1, UIFont.Small)
            return y + titleHeight
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
        ISMinigameBaseUI.TITLE_H = titleHeight
        ISMinigameBaseUI.INFO_H = math.max(27, fontHeight + 8)
        ISMinigameBaseUI.BAR_H = math.max(35, fontHeight + 12)
        ISMinigameBaseUI.MONITOR_FRACTION = math.max(ISMinigameBaseUI.MONITOR_FRACTION or 0, 0.40)
        ISMinigameBaseUI.drawTitleBar = function(self, x, y, w, title, a)
            local height = ISMinigameBaseUI.TITLE_H
            local ui = self:ui()
            a = a or 1
            self:drawRect(x, y, w, height, 0.55 * a, ui.inner.r * 0.42,
                          ui.inner.g * 0.42, ui.inner.b * 0.42)
            self:drawRectBorder(x, y, w, height, ui.border.a * a,
                                ui.border.r, ui.border.g, ui.border.b)
            if title and title ~= "" then
                local t = ui.text
                self:drawRect(x + 6, y + 7, 5, height - 14, a, t.r, t.g, t.b)
                self:drawText(self:glitchText(ISMinigameBaseUI.caps(title)), x + 17,
                              y + 4, t.r, t.g, t.b, a, UIFont.Small)
            end
            return y + height
        end
        local drawBar = ISMinigameBaseUI.drawBar
        ISMinigameBaseUI.drawBar = function(self, x, y, w, h, ...)
            if self.monitorX and x >= self.monitorX then y = y + 8 end
            return drawBar(self, x, y, w, h, ...)
        end

        local drawCasePanel = ISMinigameBaseUI.drawCasePanel
        ISMinigameBaseUI.drawCasePanel = function(self, ...)
            local originalDrawText = self.drawText
            local stampY = nil
            local stampWidth = 0
            local tm = getTextManager()
            self.drawText = function(panel, value, x, y, ...)
                if type(value) == "string" and x == panel.monitorX + 10 then
                    if string.match(value, "^%d+:%d%d$") then
                        stampY = y
                        stampWidth = tm:MeasureStringX(UIFont.Small, value)
                    end
                elseif stampY == y and x == panel.monitorX + 50 then
                    local textX = panel.monitorX + 10 + stampWidth + 12
                    local room = panel.monitorX + panel.monitorW - 10 - textX
                    while #value > 2 and tm:MeasureStringX(UIFont.Small, value) > room do
                        value = string.sub(value, 1, -2)
                    end
                    x = textX
                    stampY = nil
                end
                return originalDrawText(panel, value, x, y, ...)
            end
            local ok, result = pcall(drawCasePanel, self, ...)
            self.drawText = originalDrawText
            if not ok then error(result) end
            return result
        end
    end
end

Events.OnGameStart.Add(install)
