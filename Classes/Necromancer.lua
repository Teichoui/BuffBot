---@type Mq
local mq = require('mq')
---@type ImGui
local imgui = require 'ImGui'

local necromancer = {}
necromancer.version = '1.0.1'

local toon = mq.TLO.Me.Name() or ''
local class = mq.TLO.Me.Class() or ''
local iniPath = mq.configDir .. '\\BuffBot\\Settings\\' .. 'BuffBot_' .. toon .. '_' .. class .. '.ini'

necromancer.summon_Spell = {
    'Summon Remains'
}

necromancer.deadManFloating_Buffs = {
    'Dead Man Floating',
    'Dead Men Floating'
}

necromancer.necromancer_settings = {
    version = necromancer.version,
    runDebug = DEBUG,
    summonSpells = necromancer.summon_Spell,
    summonEnabled = false,
    summon_current_idx = 1,
    deadManFloatingBuffs = necromancer.deadManFloating_Buffs,
    deadManFloatingEnabled = false,
    deadManFloating_current_idx = 1,
}

function necromancer.saveSettings()
    ---@diagnostic disable-next-line: undefined-field
    mq.pickle(iniPath, necromancer.necromancer_settings)
end

function necromancer.Setup()
    local conf
    local configData, err = loadfile(iniPath)
    if err then
        necromancer.saveSettings()
    elseif configData then
        conf = configData()
        if conf.version ~= necromancer.version then
            necromancer.saveSettings()
            necromancer.Setup()
        else
            necromancer.necromancer_settings = conf
        end
    end
end

function necromancer.MemorizeSpells()
    if necromancer.necromancer_settings.deadManFloatingEnabled then
        Casting.MemSpell(
            necromancer.necromancer_settings.deadManFloatingBuffs[
                necromancer.necromancer_settings.deadManFloating_current_idx
            ],
            1
        )
    end
end

function necromancer.Buff()
    if necromancer.necromancer_settings.deadManFloatingEnabled then
        Casting.CastBuff(
            necromancer.necromancer_settings.deadManFloatingBuffs[
                necromancer.necromancer_settings.deadManFloating_current_idx
            ],
            'gem1'
        )
    end
end

local summonEnabled
local summon_current_idx
local deadManFloatingEnabled
local deadManFloating_current_idx

function necromancer.ShowClassBuffBotGUI()
    --
    -- Help
    --
    if imgui.CollapsingHeader("Necromancer v" .. necromancer.version) then
        ImGui.Text("NECROMANCER:")
        ImGui.BulletText('Please invite me to "summon" your corpse.')
        ImGui.Separator();

        --
        -- Summon
        --
        if ImGui.TreeNode('Summon') then
            ImGui.SameLine()
            necromancer.necromancer_settings.summonEnabled = ImGui.Checkbox('Enable',
                necromancer.necromancer_settings.summonEnabled)
            if summonEnabled ~= necromancer.necromancer_settings.summonEnabled then
                summonEnabled = necromancer.necromancer_settings.summonEnabled
                necromancer.saveSettings()
            end
            ImGui.Separator()

            necromancer.necromancer_settings.summon_current_idx = GUI.CreateBuffBox:draw("Summon Spell",
                necromancer.necromancer_settings.summonSpells,
                necromancer.necromancer_settings.summon_current_idx);
            if summon_current_idx ~= necromancer.necromancer_settings.summon_current_idx then
                summon_current_idx = necromancer.necromancer_settings.summon_current_idx
                necromancer.saveSettings()
            end
            imgui.TreePop()
        end

        ImGui.Separator()

        if ImGui.TreeNode('Dead Man Floating') then
            ImGui.SameLine()
            necromancer.necromancer_settings.deadManFloatingEnabled =
                ImGui.Checkbox(
                    'Enable',
                    necromancer.necromancer_settings.deadManFloatingEnabled
                )
            if deadManFloatingEnabled ~= necromancer.necromancer_settings.deadManFloatingEnabled then
                deadManFloatingEnabled = necromancer.necromancer_settings.deadManFloatingEnabled
                necromancer.saveSettings()
            end

            ImGui.Separator()

            necromancer.necromancer_settings.deadManFloating_current_idx =
                GUI.CreateBuffBox:draw(
                    "Dead Man Floating Spell",
                    necromancer.necromancer_settings.deadManFloatingBuffs,
                    necromancer.necromancer_settings.deadManFloating_current_idx
                )
            if deadManFloating_current_idx ~= necromancer.necromancer_settings.deadManFloating_current_idx then
                deadManFloating_current_idx = necromancer.necromancer_settings.deadManFloating_current_idx
                necromancer.saveSettings()
            end

            imgui.TreePop()
        end

        ImGui.Separator()

        --
        -- Help
        --
        if imgui.CollapsingHeader("Necromancer Options") then
            Settings.advertise = ImGui.Checkbox('Enable Advertising', Settings.advertise)
            ImGui.SameLine()
            ImGui.HelpMarker('Enables adversing to the player about the bots capabilities.')
            if Advertise ~= Settings.advertise then
                Advertise = Settings.advertise
                SaveSettings(IniPath, Settings)
            end

            Settings.advertiseChat = ImGui.InputText('Advertise Command', Settings.advertiseChat)
            ImGui.SameLine()
            ImGui.HelpMarker('The command used by the Buffer to advertises its capabilities to the player.')
            if AdvertiseChat ~= Settings.advertiseChat then
                AdvertiseChat = Settings.advertiseChat
                SaveSettings(IniPath, Settings)
            end

            Settings.advertiseMessage = ImGui.InputText('Advertise Message', Settings.advertiseMessage)
            ImGui.SameLine()
            ImGui.HelpMarker('The message displayed when the Buffer advertises its capabilities to the player.')
            if AdvertiseMessage ~= Settings.advertiseMessage then
                AdvertiseMessage = Settings.advertiseMessage
                SaveSettings(IniPath, Settings)
            end
            ImGui.Separator()

            if imgui.Button('REBUILD##Save File') then
                SaveSettings(iniPath, necromancer.necromancer_settings)
            end
            ImGui.SameLine()
            ImGui.Text('Class File')
            ImGui.SameLine()
            ImGui.HelpMarker('Overwrites the current ' .. iniPath)
            ImGui.Separator();
        end
    end
end

return necromancer
