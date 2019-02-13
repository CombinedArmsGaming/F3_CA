// Started dragging the frame
case "ui_dragging_start": {
	_eventExists = true;

	// Fetch our params
	_args params ["_ctrl", "_button", "_offsetX", "_offsetY"];

	// Only detect left clicks
	if (_button == 0 and {!(_ctrl getVariable [MACRO_VARNAME_UI_ISBEINGDRAGGED, false])}) then {

		// Save the mouse position offset
		_zeusUI_mainCtrlGrp setVariable [MACRO_VARNAME_UI_MOUSEOFFSET, [_offsetX, _offsetY]];

		// Mark the control as being dragged
		_ctrl setVariable [MACRO_VARNAME_UI_ISBEINGDRAGGED, true];

		// Move the zeus UI if the mouse is moving
		private _mouseMovingEH = _zeusUI displayAddEventHandler ["MouseMoving", {
			// Call the zeus UI function to handle dragging
			["ui_dragging"] call ca_fnc_zeusUI;
		}];
		_zeusUI_mainCtrlGrp setVariable [MACRO_VARNAME_UI_DRAGGING_EH, _mouseMovingEH];

		//Add an event handler to stop dragging
		private _mouseButtonUpEH = _zeusUI displayAddEventHandler ["MouseButtonUp", {
			["ui_dragging_stop", _this] call ca_fnc_zeusUI;
		}];
		_zeusUI_mainCtrlGrp setVariable [MACRO_VARNAME_UI_DRAGGING_STOP_EH, _mouseButtonUpEH];
	};
};
