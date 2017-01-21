/*
 * Author: Poulern
 * Creates a vehicle and locks it and removes whatever is inside of it and locks it for players
 *
 * Arguments:
 * 0: Vehicle type, vehicle classname
 * 1: Position, anything, also direction
 * 2: lock, 0 = unlocked, 1 = locked, 2 = default 3 = locked for players
 *
 * Return Value:
 * Vehicle
 *
 * Example:
 * [player,"C_Quadbike_01_F",0] call ca_fnc_spawnvehicle
 *
 */
params ["_position","_vehicletype",["_locknumber",3]];

_posdir = _position call ca_fnc_getdirpos;
_spawnpos = _posdir select 0;
_dir = _posdir select 1;

_vehicle = createVehicle  [_vehicletype, _spawnpos, [], 15, "NONE"];
_vehicle setDir _dir;

_vehicle lock _locknumber;
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

_vehicle
