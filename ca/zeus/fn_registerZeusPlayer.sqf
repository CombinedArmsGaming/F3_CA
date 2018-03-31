//	Zeus extensions for CA, by Bubbus.
//	
//	PARAMETERS:
//	
//		_unit
//			A player unit which is intended to be used for zeusing.  Will be granted godmode by default.
//	
//		_spawnMenu
//			If true, gives the unit a spawn-menu for gearscripted squads which appears in the zeus camera mode.
//	

params ["_unit", "_spawnMenu"];

if (!local _unit) exitWith {};

[_unit, false] remoteExec ["allowDamage", 0, true];
[_unit, ["ace_w_allow_dam",false,true]] remoteExec ["setVariable", 0, true];
[_unit, ["HandleDamage", {false}]] remoteExec ["addEventHandler", 0, true];
_unit addCuratorEditableObjects [(vehicles + allUnits), true];
_unit removeCuratorEditableObjects [_unit, true];

[_unit] spawn 
{
	params ["_unit"];
	
	while {true} do 
	{
		[objNull, _unit] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;
		sleep 1;
	};
	
};

[_unit, _spawnMenu] remoteExec ["ca_fnc_zeusDeployment", _unit, true];
