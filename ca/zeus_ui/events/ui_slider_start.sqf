// Clicked on a slider
case "ui_slider_start": {
	_eventExists = true;

	// Fetch our params
	_args params ["_ctrl", "_button"];

	// Only detect left clicks
	if (_button == 0) then {

		// Remember the slider on which we clicked
		_zeusUI setVariable [MACRO_VARNAME_UI_ACTIVESLIDER, _ctrl];
	};
};
