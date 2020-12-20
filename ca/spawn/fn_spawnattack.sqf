/*
 * F3 CA edition
 * Function: Spawn attack
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
 * [["ftl","rif","med","lat","ar","aar"],"SC1_CA","SC1_CA_A","opf_f",east] spawn ca_fnc_spawnattack;
 *
 */

//If the script is not executed on a server or a headless client, exit as it is likely to be executed on all clients, causing more spawns than intended. 
if (!isServer) exitWith {};


params ["_unitarray","_position","_attackposition",["_faction",""],["_side", ca_defaultside]];
private ["_group"];
_group = [_unitarray,_position,_faction,_side] call ca_fnc_spawngroup;
_posdir = _attackposition call ca_fnc_getdirpos;
_attackpos = _posdir select 0;

if (typename _attackposition == "STRING") then {
  if (markerShape _attackposition ==  "RECTANGLE" || markerShape _attackposition == "ELLIPSE") then {
    [_group,500,15,[],_attackpos] call lambs_wp_fnc_taskHunt;
  }else{
    [_group,_attackpos] call lambs_wp_fnc_taskAssault;
  };
}else{
  [_group,_attackpos] call lambs_wp_fnc_taskAssault;
};

_group
