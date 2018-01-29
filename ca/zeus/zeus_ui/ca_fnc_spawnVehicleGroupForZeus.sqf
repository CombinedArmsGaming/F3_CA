params ["_units", "_camPos", "_veh", "_gear", "_side"];

_groupVeh = [_units, _camPos, _veh, _gear, _side] call ca_fnc_spawnvehiclegroup;

{
	_group = _groupVeh select 0;
	_vehicle = _groupVeh select 1;
	
	_units = units _group;
	_units pushBack _vehicle;
	_curator = _x;
	
	_curator addCuratorEditableObjects [_units, true];
	
} forEach allCurators;