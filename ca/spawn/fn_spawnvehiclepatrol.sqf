/*
 * Author: Poulern
 * Spawns a vehicle that patrols an area in a radius from spawnpoint.
 *
 * Arguments:
 * 0: F3 group array
 * 1: Spawn position, marker, object, group, location, array
 * 2: Vehicle classname
 * 2: radius of area to patrol eg 200
 * 3: Faction of group used in F3 Assigngear.
 * 4: Side of units spawned, west east independent
 *
 * Return Value:
 * Array of [group,vehicle]
 *
 * Example:
 * [["ftl","r","ar","m"],"SC1_VC_P","C_Offroad_default_F",500,"opf_f",east] spawn ca_fnc_spawnvehiclepatrol;
 *
 */
_ishc = !hasInterface && !isDedicated;
//Use headless instead?
if (ca_hc && !_ishc) exitwith {	[_this,_fnc_scriptName] spawn ca_fnc_hcexec;};
//if there is no headless client, and is player, spawn on the server instead.
if (!ca_hc && hasInterface && !isServer) exitWith {
     [_this,_fnc_scriptName] spawn ca_fnc_hcexec;
};

params ["_unitarray","_position","_vehicletype",["_radius", 200, [2]],["_faction",""],["_side", ca_defaultside]];

private ["_group"];
_grpvehicle = [_unitarray,_position,_vehicletype,_faction,_side] call ca_fnc_spawnvehiclegroup;
_group = _grpvehicle select 0;
_posdir = _position call ca_fnc_getdirpos;
_patrolpos = _posdir select 0;



[_group,_patrolpos,_radius] spawn {
    params ["_group","_patrolpos","_radius"];
    sleep 5;
    _prevPos = _patrolpos;

    _arr = []; _arr resize (5 + (floor (random 10)));
    private ["_wp", "_newPos"];
    _wp = [];
    {
        _newPos = _patrolpos getPos [(random _radius),(random 360)];
        _prevPos = _newPos;

        _wp = _group addWaypoint [_newPos, 0];
        _wp setWaypointType "MOVE";
        _wp setWaypointCompletionRadius 20;

    } forEach _arr;

    sleep 5;

    _wp2 = _group addWaypoint [_patrolpos,0];
    _wp2 setWaypointType "CYCLE";
    _wp2 setWaypointCompletionRadius 100;
    [_group,0] setWPPos _patrolpos;

    _wayp0 = currentWaypoint _group;
    sleep 30;
    _wayp1 = currentWaypoint _group;

    if (_wayp1 == _wayp0) then {
        _wayp = [_group,(currentWaypoint _group)];
        _wayp setWPPos (getpos (leader _group));
    };
};


_grpvehicle
