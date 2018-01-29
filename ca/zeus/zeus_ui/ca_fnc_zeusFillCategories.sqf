if (isDedicated) exitWith {};

params ["_listIDC"];

_units = missionNamespace getVariable "ca_zeus_unitsStructure";

{
	_category = _x;
	
	_name = _category select 0;
	
	[_listIDC, _name] call ca_fnc_addToList;

} forEach _units;