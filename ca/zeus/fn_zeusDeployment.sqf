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
//		_allowDeployMode
//			If true, binds the unit to the zeus camera position to help with hearing player ACRE speech.
//			Also gives a button in zeus-cam mode to toggle deplyoment mode.
//			* If the button is pressed, the player is teleported to terrain under the camera position when zeus-cam mode is exited.
//			* If the button is unpressed, the player will be teleported to [0,0,0] or the position of a marker named "zeus_default".
//			* If the button is unpressed, the player has simulation disabled at all times to stop AI shooting at them.

_alreadyRan = missionNamespace getVariable ["ca_zeusDeployment_alreadyRan", false];
if (_alreadyRan) exitWith {};

params ["_unit", "_spawnMenu", "_allowDeployMode"];

_unit setVariable ["ace_w_allow_dam",false,true];
_unit allowDamage false;

zeus_deployment = false;


if (_spawnMenu and _allowDeployMode) then
{
	_unit addAction ["Add menus to Zeus mode", 
	{
		params ["_target", "_caller", "_actionId"];
		
		[] spawn ca_fnc_zeusSpawnButtons;
		[false] spawn ca_fnc_zeusDeployButtons;
		
		_target removeAction _actionId;
	}];
}
else
{
	if (_spawnMenu) then
	{
		_unit addAction ["Add unit-spawner to Zeus mode", 
		{
			params ["_target", "_caller", "_actionId"];
			
			[] spawn ca_fnc_zeusSpawnButtons;
			
			_target removeAction _actionId;
		}];
	}
	else
	{
		if (_allowDeployMode) then
		{
			_unit addAction ["Add deploy-button to Zeus mode", 
			{
				params ["_target", "_caller", "_actionId"];
				
				[true] spawn ca_fnc_zeusDeployButtons;
				
				_target removeAction _actionId;
			}];
		};
	};
};




if (_allowDeployMode) then
{
	[_unit] spawn 
	{
		params ["_unit"];
		
		_default_pos = getMarkerPos "zeus_default";
		
		zeus_camPosLast = getPos _unit;
		
		while {true} do 
		{
			_camPos = getPos curatorCamera;
			if (_camPos isEqualTo [0,0,0]) then 
			{
				if (zeus_deployment) then
				{
					zeus_camPosLast set [2, 0];
					[_unit, true] remoteExec ["ca_fnc_activateZeusPlayer", 2];
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
			
			while {!(getPos curatorCamera isEqualTo [0,0,0])} do 
			{
				_camPos = getPos curatorCamera;
				_unit setPos _camPos;
				zeus_camPosLast = _camPos;
				
				sleep 0.5;
			}
		};
	};
};

missionNamespace setVariable ["ca_zeusDeployment_alreadyRan", true];