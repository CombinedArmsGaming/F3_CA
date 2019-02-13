// A textbox is clicked
case "ui_textbox_clear": {
	_eventExists = true;

	// Fetch our params
	_args params ["_ctrl", "_button"];

	// Only detect right-clicks
	if (_button == 1) then {

		// Clear the control
		_ctrl ctrlSetText "";
		ctrlSetFocus _ctrl;
	};
};
