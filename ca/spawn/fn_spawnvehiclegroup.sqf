/*
 * Function: spawnvehiclegroup
 * Spawns a vehicle with a crew inside of it
 *
 * Arguments:
 * 0: F3 group array
 * 1: Spawn position, marker, object, group, location, array
 * 2: Vehicle classname
 * 3: Faction of group used in F3 Assigngear.
 * 4: Side of units spawned, west east independent
 *
 * Return Value:
 * Array of [group,vehicle]
 *
 * Example:
 * [["ftl","rif","med","lat","ar","aar"],"SC1_VC_S","C_Offroad_default_F","opf_f",east] spawn ca_fnc_spawnvehiclegroup;
 *
 */
//If the script is not executed on a server, exit as it is likely to be executed on all clients, causing more spawns than intended. 
if (!isServer) exitWith {};


params ["_unitarray","_position","_vehicletype",["_faction",""],["_side", ca_defaultside]];


_vehicle = [_position,_vehicletype] call ca_fnc_spawnvehicle;
_group = [_unitarray,_position,_faction,_side] call ca_fnc_spawngroup;



_units = units _group;
_assigned = [];

_comno = true;
_drino = true;
_gunno = true;

{

if((_vehicle emptyPositions "Commander") > 0 && _comno) then {
    _check = (_x in _assigned);
    if (!_check) then {
        _x assignAsCommander _vehicle;
        _x moveInCommander _vehicle;
        _assigned pushBackUnique _x;
        _comno = false;
    };
};
if((_vehicle emptyPositions "Driver")>0 && _drino) then {
    _check = (_x in _assigned);

    if (!_check) then {

        _x assignAsDriver _vehicle;
        _assigned pushBackUnique _x;
        _drino = false;
        _x moveInDriver _vehicle;
    };

};
if((_vehicle emptyPositions "Gunner")>0 && _gunno) then {
    _check = (_x in _assigned);

    if (!_check) then {

        _x assignAsGunner _vehicle;
        _assigned pushBackUnique _x;
        _x moveInGunner _vehicle;
        _gunno = false;
    };

};
_check = (_x in _assigned);

if (!_check) then {

_x assignAsCargo _vehicle;
_x moveInAny _vehicle;
_assigned pushBackUnique _x;

};

} forEach _units;

_units orderGetIn true;


[_group,_vehicle]
