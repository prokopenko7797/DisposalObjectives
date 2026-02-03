local mod = get_mod("DisposalObjectives")

local MUSIC_OBJECTIVE = "music_objective"
local MUSIC_COMBAT = "music_combat"
local DEFAULT_GROUP_STATE = "None"
local DISPOSAL_UNIT_MUSIC = "kill_event"
local BOSS = "boss"

local is_boss_music_replaced = false
local is_objective_active = false

math.randomseed(os.time())

mod:hook("Wwise", "set_state", function(func, state_group, state_value)
    local show_log = mod:get("show_log")
    
    if state_group == MUSIC_OBJECTIVE then
        if state_value ~= DEFAULT_GROUP_STATE then
            is_objective_active = true
            local force_lms_change = mod:get("force_lms_change")

            if force_lms_change and state_value == "last_man_standing" then
                state_value = DISPOSAL_UNIT_MUSIC

                if show_log then
                    mod:echo("Clutch or kick")
                end
            else
                local roll = math.random(1, 100)
                local objective_chance = mod:get("disposal_unit_chance")

                if show_log then
                    mod:echo("Objective: " .. state_value .. " | Roll: " .. roll .. "/" .. objective_chance)
                end

                if roll <= objective_chance then
                    state_value = DISPOSAL_UNIT_MUSIC
                end
            end
        else
            is_objective_active = false
            
            if show_log then
                mod:echo("Objective end")
            end
        end
    elseif state_group == MUSIC_COMBAT then
        if is_objective_active == false and state_value == BOSS then
            local boss_roll = math.random(1, 100)
            local boss_chance = mod:get("boss_chance")
                
            if show_log then
                mod:echo("Boss roll: " .. boss_roll .. "/" .. boss_chance)
            end

            if boss_roll <= boss_chance then
                is_boss_music_replaced = true
                state_group = MUSIC_OBJECTIVE
                state_value = DISPOSAL_UNIT_MUSIC
            end
        elseif is_boss_music_replaced then
            
            if show_log then
                mod:echo("Boss end")
            end

            is_boss_music_replaced = false
            func(MUSIC_OBJECTIVE, DEFAULT_GROUP_STATE)
        end
    end

    func(state_group, state_value)
end)