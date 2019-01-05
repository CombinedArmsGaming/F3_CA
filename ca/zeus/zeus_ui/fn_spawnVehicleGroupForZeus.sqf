//	Zeus extensions for CA, by Bubbus.
//
//	ca_fnc_spawnvehiclegroup does not add spawned units to zeus so they can't move them around etc.  We fix that here.
//
//	PARAMETERS:
//
//		See parameters for ca_fnc_spawnvehiclegroup.

params [
	"_units",
	"_camPos",
	"_veh",
	"_gear",
	"_side",
	["_spawn_suppress", false, [false]]
];

_groupVeh = [_units, _camPos, _veh, _gear, _side] call ca_fnc_spawnvehiclegroup;

{
	_group = _groupVeh select 0;
	_vehicle = _groupVeh select 1;

	_units = units _group;
	_units pushBack _vehicle;
	_curator = _x;

	_curator addCuratorEditableObjects [_units, true];

} forEach allCurators;

if (_spawn_suppress) then
{
	private _group = _groupVeh select 0;
	[_group] call ca_fnc_groupSuppressiveAI;
};
