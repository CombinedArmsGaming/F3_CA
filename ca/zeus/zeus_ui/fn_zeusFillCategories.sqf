//	Zeus extensions for CA, by Bubbus.
//	
//	Fills the squad category list with category definitions from ca_fnc_zeusSetupUnits.
//
//	PARAMETERS:
//	
//		_listIDC
//			The control ID for the on-screen category list.

if (isDedicated) exitWith {};

params ["_listIDC"];

_units = missionNamespace getVariable "ca_zeus_unitsStructure";

{
	_category = _x;
	
	_name = _category select 0;
	
	[_listIDC, _name] call ca_fnc_addToList;

} forEach _units;