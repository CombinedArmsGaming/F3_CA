// Close the presets menu
case "ui_close": {
	_eventExists = true;

	// Close the presets menu
	ctrlDelete _zeusUI_presetsCtrlGrp;

	// Remove the Draw3D event handler
	removeMissionEventHandler ["Draw3D", missionNamespace getVariable [MACRO_VARNAME_UI_DRAW3D_EH, -1]];
	missionNamespace setVariable [MACRO_VARNAME_UI_DRAW3D_EH, -1];

	// Mark the presets menu as being shown
	missionNamespace setVariable [MACRO_VARNAME_UI_PRESETS_ISSHOWN, false];
};
