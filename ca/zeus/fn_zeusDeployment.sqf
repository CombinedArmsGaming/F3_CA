//	Zeus extensions for CA, by Bubbus.
//	
//	This function is called from ca_fnc_registerZeusPlayer.
//	
//	PARAMETERS:
//	
//		_unit
//			A player unit which is intended to be used for zeusing.  Will be granted godmode by default.
//	
//		_spawnMenu
//			If true, gives the unit a spawn-menu for gearscripted squads which appears in the zeus camera mode.
//

_alreadyRan = missionNamespace getVariable ["ca_zeusDeployment_alreadyRan", false];
if (_alreadyRan) exitWith {};

params ["_unit", "_spawnMenu"];

_unit setVariable ["ace_w_allow_dam",false,true];
_unit allowDamage false;


if (_spawnMenu) then
{
	_unit addAction ["Add unit-spawner to Zeus mode", 
	{
		params ["_target", "_caller", "_actionId"];
		
		zeus_spawn_guerrillas = false;
		zeus_hide_ui = false;
		
		//[] spawn ca_fnc_zeusSpawnButtons;
		[] execVM "ca\zeus\zeus_ui\fn_zeusSpawnButtons.sqf";
		
		_target removeAction _actionId;
	}];
};



[_unit] spawn 
{
	params ["_unit"];
	
	_default_pos = [0, 0, 0];
	
	zeus_camPosLast = getPos _unit;
	
	while {true} do 
	{
		_camPos = getPos curatorCamera;
		if (_camPos isEqualTo [0,0,0]) then 
		{
			_isRemoteControlling = [_unit] call ca_fnc_isZeusRemoteControlling;
			
			if (!_isRemoteControlling) then
			{
				zeus_camPosLast set [2, 0];
				[_unit, true] remoteExec ["ca_fnc_activateZeusPlayer", 2];
				zeusDeployed = true;
			}
			else
			{
				zeus_camPosLast = _default_pos;
			};
			
			_unit setVehiclePosition [zeus_camPosLast, [], 1, "NONE"];
			
		};
		
		waitUntil 
		{
			!(getPos curatorCamera isEqualTo [0,0,0])
		};
		
		[_unit, false] remoteExec ["ca_fnc_activateZeusPlayer", 2];
		zeusDeployed = false;
		
		while {!(getPos curatorCamera isEqualTo [0,0,0])} do 
		{
			_camPos = getPos curatorCamera;
			_unit setPos _camPos;
			zeus_camPosLast = _camPos;
			
			sleep 0.5;
		}
	};
};

missionNamespace setVariable ["ca_zeusDeployment_alreadyRan", true];