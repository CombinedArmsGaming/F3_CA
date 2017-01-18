/*
 * Author: Poulern
 * Spawns a group that attacks a location or area.
 *
 * Arguments:
 * 0: array of units
 * 1: start position
 * 2: marker, position or location to attack. If marker is type of area, then it will use that instead.
 * 3: Faction of group used in F3 Assigngear.
 * 4: Side of units spawned, west east independent
 *
 * Return Value:
 * Group.
 *
 * Example:
 * [["ftl","r","m","rat","ar","aar"],"SC1_CA","SC1_CA_A","opf_f",east] spawn ca_fnc_spawnattack;
 *
 */
_ishc = !hasInterface && !isDedicated;
//Use headless instead?
if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
//if there is no headless client, and is player, spawn on the server instead.
if (!ca_hc && hasInterface && !isServer) exitWith {
		[_this,_fnc_scriptName] spawn ca_fnc_hcexec;
};

params ["_unitarray","_position","_attackposition",["_faction",""],["_side", ca_defaultside]];
private ["_group"];
_group = [_unitarray,_position,_faction,_side] call ca_fnc_spawngroup;
_posdir = _attackposition call ca_fnc_getdirpos;
_attackpos = _posdir select 0;

if (typename _attackposition == "STRING") then {
  if (markerShape _attackposition ==  "RECTANGLE" || markerShape _attackposition == "ELLIPSE") then {
    [_group,_attackposition] call CBA_fnc_taskSearchArea;
  }else{
    [_group,_attackpos] call CBA_fnc_taskAttack;
  };
}else{
  [_group,_attackpos] call CBA_fnc_taskAttack;
};

_group
