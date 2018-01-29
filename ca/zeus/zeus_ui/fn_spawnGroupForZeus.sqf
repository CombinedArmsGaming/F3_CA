params ["_units", "_camPos", "_gear", "_side"];

_group = [_units, _camPos, _gear, _side] call ca_fnc_spawngroup;

{
	_units = units _group;
	_curator = _x;
	_curator addCuratorEditableObjects [_units, true];
	
} forEach allCurators;