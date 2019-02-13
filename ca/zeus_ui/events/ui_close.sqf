// Close the presets menu
case "ui_close": {
	_eventExists = true;

	// Close the presets menu
	ctrlDelete _zeusUI_presetsCtrlGrp;

	// Mark the presets menu as being shown
	missionNamespace setVariable [MACRO_VARNAME_UI_PRESETS_ISSHOWN, false];
};
