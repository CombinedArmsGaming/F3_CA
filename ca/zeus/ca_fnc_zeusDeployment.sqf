params ["_unit", "_spawnMenu", "_deployMenu"];

_unit setVariable ["ace_w_allow_dam",false,true];
_unit allowDamage false;

zeus_deployment = false;
_unit addAction ["Toggle Zeus Deployment mode", 
{
	zeus_deployment = !zeus_deployment;
	_onOff = "OFF";
	if (zeus_deployment) then {_onOff = "ON";};
	hint format ["Zeus deployment is %1.", _onOff];
}];

if (_spawnMenu and _deployMenu) then
{
	_unit addAction ["Add unit-spawner to Zeus mode", 
	{
		execVM "ca\zeus\zeus_ui\ca_fnc_zeusSpawnButtons.sqf";
		[false] execVM "ca\zeus\zeus_ui\ca_fnc_zeusDeployButtons.sqf";
	}];
}
else
{
	if (_spawnMenu) then
	{
		_unit addAction ["Add unit-spawner to Zeus mode", 
		{
			execVM "ca\zeus\zeus_ui\ca_fnc_zeusSpawnButtons.sqf";
		}];
	}
	else
	{
		if (_deployMenu) then
		{
			_unit addAction ["Add unit-spawner to Zeus mode", 
			{
				[true] execVM "ca\zeus\zeus_ui\ca_fnc_zeusDeployButtons.sqf";
			}];
		};
	};
};


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