local mod = get_mod("DisposalObjectives")

math.randomseed(os.time())

mod:hook("Wwise", "set_state", function(func, state_group, state_value)
    if state_group == "music_objective" and state_value ~= "None" then
        local force_lms_change = mod:get("force_lms_change")
        local show_log = mod:get("show_log")

        if force_lms_change and state_value == "last_man_standing" then
            state_value = "kill_event"
            if show_log then
                mod:echo("Clutch or kick")
            end
        else
            local roll = math.random(1, 100)
            local disposal_unit_chance = mod:get("disposal_unit_chance")
            if show_log then
                mod:echo("Objective: " .. state_value .. " | Roll: " .. roll .. "/" .. disposal_unit_chance)
            end

            if roll <= disposal_unit_chance then
                state_value = "kill_event"
            end
        end
    end

    func(state_group, state_value)
end)