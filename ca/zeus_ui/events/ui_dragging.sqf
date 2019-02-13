// Dragging the frame
case "ui_dragging": {
	_eventExists = true;

	// Fetch our dragged control
	private _ctrl = _zeusUI_mainCtrlGrp controlsGroupCtrl MACRO_IDC_MAIN_DRAGGING_FRAME;

	// Only continue if the control is still being dragged
	if (_ctrl getVariable [MACRO_VARNAME_UI_ISBEINGDRAGGED, false]) then {

		// Fetch our mouse position
		getMousePosition params ["_posX", "_posY"];

		// Fetch our position offset
		(_zeusUI_mainCtrlGrp getVariable [MACRO_VARNAME_UI_MOUSEOFFSET, [0, 0]]) params ["_offsetX", "_offsetY"];

		// Reposition our main UI's controls group
		private _pos = ctrlPosition _zeusUI_mainCtrlGrp;
		_pos set [0, _posX - _offsetX];
		_pos set [1, _posY - _offsetY];
		_zeusUI_mainCtrlGrp ctrlSetPosition _pos;
		_zeusUI_mainCtrlGrp ctrlCommit 0;
	};
};
