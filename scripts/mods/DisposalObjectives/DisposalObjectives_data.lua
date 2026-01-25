local mod = get_mod("DisposalObjectives")

return {
	name = mod:localize("mod_name"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
        widgets = {
            {
                setting_id = "disposal_unit_chance",
                type = "numeric",
                default_value = 20,
                range = {0, 100},
            },
			{
                setting_id = "force_lms_change",
				type = "checkbox",
				default_value = true,
            },
			{
                setting_id = "show_log",
				type = "checkbox",
				default_value = false,
            },
        },
    },
}