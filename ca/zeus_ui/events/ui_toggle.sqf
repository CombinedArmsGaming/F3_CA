// Toggle the UI visibility (hidden or shown)
case "ui_toggle": {
	_eventExists = true;

	// Fetch our params
	_args params ["_shouldShow"];

	// Fetch the presets control group (if it exists)
	private _zeusUI_presetsCtrlGrp = uiNamespace getVariable [MACRO_VARNAME_UI_PRESETSCTRLGRP, controlNull];

	_zeusUI_mainCtrlGrp ctrlShow _shouldShow;
	_zeusUI_presetsCtrlGrp ctrlShow _shouldShow;
};
