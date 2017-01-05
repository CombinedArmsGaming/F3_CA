
/*
 * Author: Poulern
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
 * [ ["ftl","r","ar","m"],player,west] call ca_fnc_spawngroup;
 * [["ftl","r","ar","m"],[123,67,0],west] call p_fnc_spawngroup;
 * Public: No
 */

_params = params ["_unitarray","_position","_side"];
private ["_spawnpos","_unittype","_unit","_group","_pos","_unittype"];

_ishc = !hasInterface && !isDedicated;
//Use headless instead?
if (ca_hc && !_ishc) exitwith {
	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;
};

//Getting a good position from the parsed values
_spawnpos = [_position] call ca_fnc_getpos;


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

} forEach _unitarray;


_group setFormation "LINE";

_group
