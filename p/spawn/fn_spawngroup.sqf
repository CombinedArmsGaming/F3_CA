
/*
 * Author: Poulern and wolfenswan.
 * [Spawns a group according to F3 assign gear]
 *
 * Arguments:
 * 0: F3 group array
 * 1: Spawn position, marker, object, group, location, array
 * 2: side west east independent
 * Return Value:
 * group
 *
 * Example:
 * [ ["ftl","r","ar","m"],"spawnmarker",west] call p_fnc_spawngroup;
 * [ ["ftl","r","ar","m"],player,west] call p_fnc_spawngroup;
 * [["ftl","r","ar","m"],[123,67,0],west] call p_fnc_spawngroup;
 * Public: No
 */

params ["_unitarray","_position","_side"];
private ["_spawnpos","_unittype","_unit","_group","_pos","_unittype"];


_pos = [];

//Getting a good position from the parsed values
switch (typename _position) do {
	case "STRING": {_pos = getMarkerPos _position};
	case "OBJECT": {_pos = getPosATL _position};
	case "GROUP": {_pos = getPosATL (leader _position)};
	case "LOCATION": {_pos = position _position};
	case "ARRAY": {_pos = _position;};
};


_spawnpos = _pos;


switch(_side) do {
    case west: { _group = createGroup west; _unittype = "B_Soldier_F";};
    case east: { _group = createGroup east; _unittype = "O_Soldier_F"; };
	case independent: { _group = createGroup independent; _unittype = "I_Soldier_F"; };
	default {_group = createGroup east};
								};

	{
	_unit = "";

	_unit = _group  createUnit [_unittype, _spawnpos, [], 0, "FORM"];

	_type = _x;

	[_type,_unit] call f_fnc_assignGear;


	}forEach _unitarray;

	_group setFormation "LINE";

_group
