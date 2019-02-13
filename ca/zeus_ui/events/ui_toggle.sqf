// Toggle the UI visibility (hide or show)
case "ui_toggle": {
	_eventExists = true;

	// Fetch our params
	_args params ["_shouldShow"];

	// Fetch the presets control group (if it exists)
	private _zeusUI_presetsCtrlGrp = uiNamespace getVariable [MACRO_VARNAME_UI_PRESETSCTRLGRP, controlNull];

	// Iterate through the control groups
	{
		// Iterate through the control group's child controls
		{
			_x ctrlShow _shouldShow;
		} forEach (_x getVariable [MACRO_VARNAME_UI_CHILDCONTROLS, []]);

	} forEach [
		_zeusUI_mainCtrlGrp,
		_zeusUI_presetsCtrlGrp
	];
};
