//	Zeus extensions for CA, by Bubbus.
//	
//	Fills the unit spawn list with squad definitions from ca_fnc_zeusSetupUnits.
//
//	PARAMETERS:
//	
//		_listIDC
//			The control ID for the on-screen unit spawn list.
//			
//		_categoryIdx
//			The index of the user's currently selected unit category, as defined in ca_fnc_zeusSetupUnits.

if (isDedicated) exitWith {};

params ["_listIDC", "_categoryIdx"];

[_listIDC] call ca_fnc_clearList;

_units = ca_zeus_unitsStructure;

_category = _units select _categoryIdx;
_type = _category select 1;
_gear = _category select 2;
_side = _category select 3;
_defs = _category select 4;

_listDefs = [];

switch (_type) do
{
	case "inf":
	{
		{
			_name = _x select 0;
			_def = [_type, _x select 1, _gear, _side];
			
			[_listIDC, _name] call ca_fnc_addToList;
			
			_listDefs pushBack _def;
		
		} forEach _defs;
		
	};
	
	case "veh":
	{
		{
			_name = _x select 0;
			_def = [_type, _x select 2, _x select 1, _gear, _side];
			
			[_listIDC, _name] call ca_fnc_addToList;
			
			_listDefs pushBack _def;
		
		} forEach _defs;
		
	};
	
};

ca_zeus_listUnits = _listDefs;