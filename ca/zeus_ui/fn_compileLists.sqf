/* --------------------------------------------------------------------------------------------------------------------
	Author:		Cre8or
	Description:
		Compiles the categories, units and the presets lists, and saves the results to the mission namespace for
		later use.
	Arguments:
		(nothing)
	Returns:
		(nothing)
-------------------------------------------------------------------------------------------------------------------- */

#include "config\macros.hpp"





// Set up some variables
private _createNamespace = {createLocation ["NameVillage", [0,0,0], 0, 0]};

// Create a namespace for all categories
private _allCategoriesNamespace = call _createNamespace;
private _allCategoriesVars = [];

// Iterate through the categories
{
	// Remember the config path to the category
	private _categoryConfig = _x;

	// Create a namespace for this category
	private _categoryNamespace = call _createNamespace;
	private _categoryVars = [];

	// Fetch the category's settings
	private _categoryName = [_x, "categoryName", ""] call BIS_fnc_returnConfigEntry;
	private _categoryGear = [_x, "gear", ""] call BIS_fnc_returnConfigEntry;
	private _categorySide = [_x, "side", ""] call BIS_fnc_returnConfigEntry;

	// Determine the side based on the string
	switch (toLower _categorySide) do {
		case "west": {_categorySide = west};
		case "east": {_categorySide = east};
		case "resistance": {_categorySide = resistance};
		case "civilian": {_categorySide = civilian};
		default {_categorySide = sideUnknown};		// Fallback for incorrect side inputs
	};

	// Iterate through the unit classes inside this category
	{
		// Create a namespace for the unit
		private _unitNamespace = call _createNamespace;

		// Fetch the data from this unit entry
		private _unitName = [_x, "unitName", ""] call BIS_fnc_returnConfigEntry;
		private _unitVehicle = [_x, "vehicle", ""] call BIS_fnc_returnConfigEntry;
		private _unitRoles = [_x, "units", []] call BIS_fnc_returnConfigEntry;

		// Fill the data of the namespace
		_unitNamespace setVariable [MACRO_VARNAME_UNIT_ROLES, _unitRoles];
		_unitNamespace setVariable [MACRO_VARNAME_UNIT_VEHICLE, _unitVehicle];

		// Save the unit namespace
		_categoryVars pushBack _unitName;
		_categoryNamespace setVariable [_unitName, _unitNamespace];

	} forEach configProperties [_categoryConfig, "isClass _x", false];

	// Fill the category namespace with data
	_categoryNamespace setVariable [MACRO_VARNAME_NAMESPACE_ALLVARIABLES, _categoryVars];
	_categoryNamespace setVariable [MACRO_VARNAME_CATEGORY_GEAR, _categoryGear];
	_categoryNamespace setVariable [MACRO_VARNAME_CATEGORY_SIDE, _categorySide];

	// Save the category namespace
	_allCategoriesVars pushBack _categoryName;
	_allCategoriesNamespace setVariable [_categoryName, _categoryNamespace];

} forEach configProperties [missionConfigFile >> "CA_ZeusUI_Units", "isClass _x", false];





// Next, compile the AI presets
// Create a namespace for all presets
private _allPresetsNamespace = call _createNamespace;
private _allPresetsVars = [];

// Iterate through the presets
{
	// Remember the config path to the preset
	private _presetConfig = _x;

	// Create a namespace for this preset
	private _presetNamespace = call _createNamespace;

	// Fetch the preset's settings
	private _presetName = [_x, "presetName", ""] call BIS_fnc_returnConfigEntry;
	private _enableVCOM = (([_x, "enableVCOM", 0] call BIS_fnc_returnConfigEntry) > 0);

	// Check if this preset uses guerrilla AI
	private _guerrillaAI = false;
	if (isClass (_x >> "GuerrillaAI")) then {
		private ["_varName", "_value"];

		// Fetch the data from the guerrilla AI class
		_guerrillaAI = [];
		{
			_varName = configName _x;
			//_value = [_presetConfig >> "GuerrillaAI", _varName, 0] call BIS_fnc_returnConfigEntry;
			_value = getNumber (_presetConfig >> "GuerrillaAI" >> _varName);

			switch (toLower _varName) do {
				case "flankonly": {
					_guerrillaAI set [0, (_value > 0)];
				};
				case "maxapproachvariation": {
					_guerrillaAI set [1, _value];
				};
				case "minapproachdistance": {
					_guerrillaAI set [2, _value];
				};
				case "maxapproachdistance": {
					_guerrillaAI set [3, _value];
				};
				case "maxsearchduration": {
					_guerrillaAI set [4, _value];
				};
				case "searchareasize": {
					_guerrillaAI set [5, _value];
				};
			};
		} forEach configProperties [_x >> "GuerrillaAI", "!isClass _x", false];
	};

	// Check if this preset uses suppressive AI
	private _suppressiveAI = false;
	if (isClass (_x >> "SuppressiveAI")) then {
		private ["_varName", "_value"];

		// Fetch the data from the suppressive AI class
		_suppressiveAI = [];
		{
			_varName = configName _x;
			//_value = [_presetConfig >> "SuppressiveAI", _varName, 0] call BIS_fnc_returnConfigEntry;
			_value = getNumber (_presetConfig >> "SuppressiveAI" >> _varName);

			switch (toLower _varName) do {
				case "suppressionmultiplier": {
					_suppressiveAI set [0, _value];
				};
				case "suppressiondurationmultiplier": {
					_suppressiveAI set [1, _value];
				};
				case "useanimations": {
					_suppressiveAI set [2, (_value > 0)];
				};
			};
		} forEach configProperties [_x >> "SuppressiveAI", "!isClass _x", false];
	};

	// Check if this preset uses Lambs AI
	private _lambsAI = false;
	if (isClass (_x >> "LambsAI")) then {
		private ["_varName", "_value"];

		// Fetch the data from the Lambs AI class
		_lambsAI = [];
		{
			_varName = configName _x;
			_value = getNumber (_presetConfig >> "LambsAI" >> _varName);

			switch (toLower _varName) do {
				case "enablereinforce": {
					_lambsAI set [0, (_value > 0)];
				};
			};
		} forEach configProperties [_x >> "LambsAI", "!isClass _x", false];
	};

	// Check if this preset uses VCOM AI
	private _enableVCOM = (([_x, "enableVCOM", 0] call BIS_fnc_returnConfigEntry) > 0);

	// Fill the preset namespace with data
	_presetNamespace setVariable [MACRO_VARNAME_PRESET_GAI, _guerrillaAI];
	_presetNamespace setVariable [MACRO_VARNAME_PRESET_SAI, _suppressiveAI];
	_presetNamespace setVariable [MACRO_VARNAME_PRESET_LAMBS, _lambsAI];
	_presetNamespace setVariable [MACRO_VARNAME_PRESET_VCOM, _enableVCOM];

	// Save the preset namespace
	_allPresetsVars pushBack _presetName;
	_allPresetsNamespace setVariable [_presetName, _presetNamespace];

} forEach configProperties [missionConfigFile >> "CA_ZeusUI_AI_Presets", "isClass _x", false];





// Save the categories namespace
missionNamespace setVariable [MACRO_VARNAME_NAMESPACE_CATEGORIES, _allCategoriesNamespace, false];
_allCategoriesNamespace setVariable [MACRO_VARNAME_NAMESPACE_ALLVARIABLES, _allCategoriesVars];

// Save the presets namespace
missionNamespace setVariable [MACRO_VARNAME_NAMESPACE_PRESETS, _allPresetsNamespace, false];
_allPresetsNamespace setVariable [MACRO_VARNAME_NAMESPACE_ALLVARIABLES, _allPresetsVars];

// Wrap up
missionNamespace setVariable [MACRO_VARNAME_UI_LISTSCOMPILED, true, false];
