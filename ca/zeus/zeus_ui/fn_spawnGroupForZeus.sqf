//	Zeus extensions for CA, by Bubbus.
//	
//	ca_fnc_spawngroup does not add spawned units to zeus so they can't move them around etc.  We fix that here.
//
//	PARAMETERS:
//	
//		See parameters for ca_fnc_spawngroup.

params ["_units", "_camPos", "_gear", "_side"];

_group = [_units, _camPos, _gear, _side] call ca_fnc_spawngroup;

{
	_units = units _group;
	_curator = _x;
	_curator addCuratorEditableObjects [_units, true];
	
} forEach allCurators;

if ((!isNil "zeus_spawn_guerrillas") and {zeus_spawn_guerrillas}) then
{
	[_group] call ca_fnc_groupGuerrillaAI;
}
