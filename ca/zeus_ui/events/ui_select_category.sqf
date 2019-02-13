// A category is selected
case "ui_select_category": {
	_eventExists = true;

	// Fetch our params
	_args params ["_ctrlLBCategories", "_index"];

	// Save the category index and reset the units index
	missionNamespace setVariable [MACRO_VARNAME_UI_CATEGORYINDEX, _index];
	missionNamespace setVariable [MACRO_VARNAME_UI_UNITINDEX, 0];

	// Fetch our units listbox
	private _ctrlLBUnits = _zeusUI_mainCtrlGrp controlsGroupCtrl MACRO_IDC_MAIN_UNITS_LISTBOX;

	// Fetch the selected category namespace
	private _allCategoriesNamespace = missionNamespace getVariable [MACRO_VARNAME_NAMESPACE_CATEGORIES, locationNull];
	private _allCategoriesVars = _allCategoriesNamespace getVariable [MACRO_VARNAME_NAMESPACE_ALLVARIABLES, []];
	private _categoryNamespace = _allCategoriesNamespace getVariable [_allCategoriesVars select _index, locationNull];

	// Clear the units listbox
	lbClear _ctrlLBUnits;

	// Populate the units listbox
	{
		_ctrlLBUnits lbAdd _x;
	} forEach (_categoryNamespace getVariable [MACRO_VARNAME_NAMESPACE_ALLVARIABLES, []]);

	// Select the first item in the list
	_ctrlLBUnits lbSetCurSel 0;
};
