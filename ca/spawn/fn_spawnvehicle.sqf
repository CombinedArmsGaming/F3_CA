/*
 * Author: Poulern
 * Creates a vehicle and locks it and removes whatever is inside of it and locks it for players
 *
 * Arguments:
 * 0: Vehicle type, vehicle classname
 * 1: Position, anything, also direction
 *
 * Return Value:
 * Vehicle
 *
 * Example:
 * [player,"C_Quadbike_01_F"] call ca_fnc_spawnvehicle
 *
 */
params ["_position","_vehicletype"];

_posdir = _position call ca_fnc_getdirpos;
_spawnpos = _posdir select 0;
_dir = _posdir select 1;

_vehicle = createVehicle  [_vehicletype, _spawnpos, [], 15, "NONE"];
_vehicle setDir _dir;

_vehicle lock 3;
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

_vehicle
