//	Zeus extensions for CA, by Bubbus.
//
//	Spawns a squad where the zeus camera is aiming, according to the passed-in squad definition.
//	NOTE: This is not a squad definition from ca_fnc_zeusSetupUnits - it has been transformed by ca_fnc_zeusFillUnits before it reaches here.
//
//	PARAMETERS:
//
//		_def
//			The squad definition to use for spawning the squad.

_camPos = screenToWorld [0.5, 0.5];

params ["_def"];

if (isNil "_def") exitWith {};

_type = _def select 0;

// DUCT TAPE, LOTS OF DUCT TAPE
if (isNil "zeus_spawn_vcom") then {zeus_spawn_vcom = false};
if (isNil "zeus_spawn_guerrillas") then {zeus_spawn_guerrillas = false};
if (isNil "zeus_spawn_suppress") then {zeus_spawn_suppress = false};

switch (_type) do
{

	case "inf":
	{
		_units = _def select 1;
		_gear = _def select 2;
		_side = _def select 3;

		[_units, _camPos, _gear, _side, zeus_spawn_vcom, zeus_spawn_guerrillas, zeus_spawn_suppress] remoteExec ["ca_fnc_spawnGroupForZeus", 2];
	};

	case "veh":
	{
		_units = _def select 1;
		_veh = _def select 2;
		_gear = _def select 3;
		_side = _def select 4;

		[_units, _camPos, _veh, _gear, _side, zeus_spawn_suppress] remoteExec ["ca_fnc_spawnVehicleGroupForZeus", 2];
	};

};
