/*
 * F3 CA edition
 * Function: Spawn vehicle. Possibly the most useless function in the framework since it doesn't support air.
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

_vehicle = createVehicle  [_vehicletype, _spawnpos, [], 0, "CAN_COLLIDE"];
_vehicle setDir _dir;

// Reapply the position change so that the vehicle aligns with the terrain properly
 switch (typename _position) do {
	case "STRING": {
		_vehicle setPos getMarkerPos _position;
	};
	case "OBJECT": {
		_vehicle setPosATL getPosATL _position;
	};
	case "GROUP": {
		_vehicle setPosATL getPosATL leader _position;
	};
	case "LOCATION": {
		_vehicle setPos position _position;
	};
	case "ARRAY": {
		if (count _position > 2 and {_position # 2 >= 0.1}) then {
			_vehicle setPosATL (_position vectorAdd [0, 0, 0.5]);	// Additional offset, in case the surface is not horizontal
			_vehicle setVectorUp [0,0,1];
		} else {
			_position resize 2; // Ignore the Z component
			_vehicle setPos _position;
		};
	};
 };

_vehicle lock _locknumber;
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

_vehicle
