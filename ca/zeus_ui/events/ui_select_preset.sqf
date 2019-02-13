// A preset is selected
case "ui_select_preset": {
	_eventExists = true;

	// Fetch our params
	_args params ["", "_index"];

	// If the custom preset was selected, open the presets menu
	if (_index == 0) then {
		["ui_init", [MACRO_VARNAME_UI_ID_PRESETS]] call ca_fnc_zeusUI;
	};

	// Save the preset index
	missionNamespace setVariable [MACRO_VARNAME_UI_PRESETINDEX, _index];
};
