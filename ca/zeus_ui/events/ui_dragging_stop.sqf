// Stopped dragging the frame
case "ui_dragging_stop": {
	_eventExists = true;

	// Fetch our params
	_args params ["_ctrl", "_button"];

	// Fetch our dragged control
	private _ctrl = _zeusUI_mainCtrlGrp controlsGroupCtrl MACRO_IDC_MAIN_DRAGGING_FRAME;

	// Only detect left clicks
	if (_button == 0 and {_ctrl getVariable [MACRO_VARNAME_UI_ISBEINGDRAGGED, false]}) then {

		// Mark the control as no longer being dragged
		_ctrl setVariable [MACRO_VARNAME_UI_ISBEINGDRAGGED, false];

		// Save the new UI position in the profile namespace
		(ctrlPosition _zeusUI_mainCtrlGrp) params ["_posX", "_posY"];
		profileNamespace setVariable [MACRO_VARNAME_UI_POS_MAINCTRLGRP, [_posX, _posY]];
		saveProfileNamespace;

		// Remove the dragging event handlers
		_zeusUI displayRemoveEventHandler ["MouseMoving", _zeusUI_mainCtrlGrp getVariable [MACRO_VARNAME_UI_DRAGGING_EH, -1]];
		_zeusUI displayRemoveEventHandler ["MouseButtonUp", _zeusUI_mainCtrlGrp getVariable [MACRO_VARNAME_UI_DRAGGING_STOP_EH, -1]];

		// If the presets menu is shown, reposition it
		if (missionNamespace getVariable [MACRO_VARNAME_UI_PRESETS_ISSHOWN, false]) then {
			["ui_init", [MACRO_VARNAME_UI_ID_PRESETS]] call ca_fnc_zeusUI;
		};
	};
};
