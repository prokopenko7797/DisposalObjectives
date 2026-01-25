return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`DisposalObjectives` must be loaded before using it.")

		new_mod("DisposalObjectives", {
			mod_script       = "DisposalObjectives/scripts/mods/DisposalObjectives/DisposalObjectives",
			mod_data         = "DisposalObjectives/scripts/mods/DisposalObjectives/DisposalObjectives_data",
			mod_localization = "DisposalObjectives/scripts/mods/DisposalObjectives/DisposalObjectives_localization",
		})
	end,
	packages = {},
}