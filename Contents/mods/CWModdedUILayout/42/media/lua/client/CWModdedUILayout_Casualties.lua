-- Layout only. Keep this in the optional UI submod, separate from CW core fixes.
local function install()
    if not getActivatedMods or not getActivatedMods():contains("CasualtiesUndead") then return end

    require "ISUI/ISCUVitalsUI"
    require "ISUI/ISCUDebugUI"
    require "ISUI/ISMinigameBaseUI"
    local CU = CasualtiesUndead
    local tm = getTextManager()
    local fontHeight = tm:getFontHeight(UIFont.Small)
    local titleHeight = math.max(27, fontHeight + 9)

    local function fitText(value, width)
        value = tostring(value or "")
        if width <= 0 then return "" end
        if tm:MeasureStringX(UIFont.Small, value) <= width then return value end
        local dots = ".."
        if tm:MeasureStringX(UIFont.Small, dots) > width then return "" end
        while #value > 0 and tm:MeasureStringX(UIFont.Small, value .. dots) > width do
            local last = #value
            while last > 1 do
                local byte = string.byte(value, last)
                if byte < 128 or byte >= 192 then break end
                last = last - 1
            end
            value = string.sub(value, 1, last - 1)
        end
        return value .. dots
    end

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

        ISMinigameBaseUI.drawCasePanel = function(self, y0)
            local x0, w = self.monitorX, self.monitorW
            local h = self.S - y0
            if h < 120 then return end
            local open, ui = self:openT(), self:ui()
            local pad = 14
            local who = self.caseLabel or ((self.patient and self.character and self.patient ~= self.character)
                and (self.patient.getUsername and self.patient:getUsername()
                    or getText("IGUI_CU_MG_Common_PATIENT"))
                or getText("IGUI_CU_MG_Common_PTSELF_2"))
            local title = getText("IGUI_CU_MG_Common_CaseWithName", ISMinigameBaseUI.caps(who))
            local top = self:drawTitledPanel(x0, y0, w, h, fitText(title, w - 32), open)

            -- Keep the original patient figure and active-part marker.
            local k = math.min(w * 0.32, h * 0.27)
            local span = k / self.S
            local u = (x0 + w / 2) / self.S
            local cy = top + 16 + 0.76 * k
            self:drawPatient(u, cy / self.S, span, 0.5 * open)
            local key
            if self.bodyPart and self.bodyPart.getType then
                key = BodyPartType.ToString(self.bodyPart:getType())
            elseif self.limbId then
                key = ({ arm_L = "ForeArm_L", arm_R = "ForeArm_R",
                         leg_L = "LowerLeg_L", leg_R = "LowerLeg_R" })[self.limbId]
            end
            local parts = ISMinigameBaseUI.PATIENT_PARTS
            local patient = self.patient or self.character
            if patient and CU.Figure and CU.Figure.swaddled and CU.Figure.swaddled(patient) then
                parts = ISMinigameBaseUI.SWADDLED_PARTS
            end
            local spot = key and parts[key]
            if spot then
                local px, py = self:U(u) + spot[1] * k, cy + spot[2] * k
                local heart = self.COL.heart
                local pulse = self:beatPulse(420)
                self:drawDisc(px, py, 3 + pulse * 2, open, heart.r, heart.g, heart.b)
                self:drawRing(px, py, 6 + pulse * 8, 1.5, (1 - pulse * 0.5) * 0.8 * open,
                              heart.r, heart.g, heart.b, 18)
            end

            local ty = cy + 1.07 * k + 16
            local name = self:partName()
            if name then
                local label = getText("IGUI_CU_MG_Common_SITE")
                local nameRoom = w - pad * 2 - tm:MeasureStringX(UIFont.Small, label) - 18
                self:drawText(label, x0 + pad, ty, ui.label.r, ui.label.g, ui.label.b,
                              open * 0.8, UIFont.Small)
                self:drawTextRight(fitText(ISMinigameBaseUI.caps(name), nameRoom),
                                   x0 + w - pad, ty, ui.text.r, ui.text.g, ui.text.b,
                                   open, UIFont.Small)
                ty = ty + fontHeight + 12
            end

            local tags = self:injuryTags()
            local tx = x0 + pad
            local tagH = fontHeight + 8
            for i = 1, #tags do
                local label, bad = ISMinigameBaseUI.caps(tags[i][1]), tags[i][2]
                local tw = tm:MeasureStringX(UIFont.Small, label) + 14
                if tx + tw > x0 + w - pad and tx > x0 + pad then
                    tx = x0 + pad
                    ty = ty + tagH + 7
                end
                tw = math.min(tw, x0 + w - pad - tx)
                if ty + tagH > y0 + h - pad then break end
                local c = bad and ui.bad or ui.label
                self:drawRect(tx, ty, tw, tagH, (bad and 0.22 or 0.10) * open, c.r, c.g, c.b)
                self:drawRectBorder(tx, ty, tw, tagH, 0.95 * open, c.r, c.g, c.b)
                self:drawText(fitText(label, tw - 12), tx + 7, ty + 4,
                              c.r, c.g, c.b, open, UIFont.Small)
                tx = tx + tw + 7
            end
            if #tags > 0 then ty = ty + tagH + 14 end

            local log = self.log or {}
            local rowH = fontHeight + 6
            if #log == 0 or ty + rowH > y0 + h - pad then return end
            self:drawRect(x0 + pad, ty, w - pad * 2, 1, 0.65 * open,
                          ui.border.r, ui.border.g, ui.border.b)
            ty = ty + 10
            for i = 1, #log do
                if ty + rowH > y0 + h - pad then break end
                local event = log[i]
                local seconds = math.floor(event.at / 1000)
                local stamp = string.format("%02d:%02d", math.floor(seconds / 60), seconds % 60)
                local alpha = open * (i == 1 and 1 or math.max(0.3, 0.85 - i * 0.12))
                local c = event.bad and self.COL.bad or ui.text
                local textX = x0 + pad + tm:MeasureStringX(UIFont.Small, stamp) + 14
                self:drawText(stamp, x0 + pad, ty, ui.label.r, ui.label.g, ui.label.b,
                              alpha * 0.8, UIFont.Small)
                self:drawText(fitText(event.text, x0 + w - pad - textX), textX, ty,
                              c.r, c.g, c.b, alpha, UIFont.Small)
                ty = ty + rowH
            end
        end

        ISMinigameBaseUI.drawFooter = function(self)
            local ui = self:ui()
            local open = self:openT()
            local wx, _, ww = self:windowRect()
            local y = self.S + 1
            local pad = 14
            self:drawRect(wx + 1, y, ww - 2, ISMinigameBaseUI.BAR_H - 1,
                          0.55 * open, 0.06, 0.06, 0.07)
            self:drawRect(wx + 1, y, ww - 2, 1, 0.75 * open,
                          ui.inner.r, ui.inner.g, ui.inner.b)

            local ty = y + 7
            local x = wx + pad
            local progressLabel = ISMinigameBaseUI.caps(
                self.progressLabel or getText("IGUI_CU_MG_Common_Progress"))
            if progressLabel ~= "" then
                self:drawText(progressLabel, x, ty, ui.label.r, ui.label.g, ui.label.b,
                              open, UIFont.Small)
                x = x + tm:MeasureStringX(UIFont.Small, progressLabel) + 14
            end
            local progressW = math.floor(self.S * 0.25)
            self:drawBar(x, ty + 3, progressW, 11, self.progress or 0, ui.good, open)
            x = x + progressW + 22

            local qualityLabel = ISMinigameBaseUI.caps(
                self.qualityLabel or getText("IGUI_CU_MG_Common_Quality"))
            if qualityLabel ~= "" then
                self:drawText(qualityLabel, x, ty, ui.label.r, ui.label.g, ui.label.b,
                              open, UIFont.Small)
                x = x + tm:MeasureStringX(UIFont.Small, qualityLabel) + 14
                local q = CU.clamp(self.quality or 1, 0, 1)
                local hit = math.max(0, 1 - ((self.elapsed or 0)
                    - (self.qualityHitAt or -1e9)) / 450)
                local qc = (q < 0.5 or hit > 0.2) and ui.bad or ui.good
                local qualityW = math.floor(self.S * 0.13)
                self:drawBar(x, ty + 3, qualityW, 11, q, qc, open)
                x = x + qualityW + 10
                self:drawText(string.format("%d%%", math.floor(q * 100 + 0.5)), x, ty,
                              qc.r, qc.g, qc.b, open, UIFont.Small)
            end
            self:drawTextRight(self.exitHint or getText("IGUI_CU_MG_Common_ExitHint"),
                               wx + ww - pad, ty, ui.label.r, ui.label.g,
                               ui.label.b, 0.85 * open, UIFont.Small)
        end
    end
end

Events.OnGameStart.Add(install)
