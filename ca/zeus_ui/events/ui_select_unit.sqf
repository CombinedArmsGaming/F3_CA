// A unit is selected
case "ui_select_unit": {
	_eventExists = true;

	// Fetch our params
	_args params ["", "_index"];

	// Save the unit index
	missionNamespace setVariable [MACRO_VARNAME_UI_UNITINDEX, _index];
};
