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
//		_allowDeployMode
//			If true, binds the unit to the zeus camera position to help with hearing player ACRE speech.
//			Also gives a button in zeus-cam mode to toggle deplyoment mode.
//			* If the button is pressed, the player is teleported to terrain under the camera position when zeus-cam mode is exited.
//			* If the button is unpressed, the player will be teleported to [0,0,0] or the position of a marker named "zeus_default".
//			* If the button is unpressed, the player has simulation disabled at all times to stop AI shooting at them.

params ["_unit", "_spawnMenu", "_allowDeployMode"];

if (!isServer) exitWith {};

[_unit, false] remoteExec ["allowDamage", 0, true];
[_unit, ["ace_w_allow_dam",false,true]] remoteExec ["setVariable", 0, true];
[_unit, ["HandleDamage", {false}]] remoteExec ["addEventHandler", 0, true];
_unit addCuratorEditableObjects [(vehicles + allUnits), true];
_unit removeCuratorEditableObjects [_unit, true];

[_unit, _spawnMenu, _allowDeployMode] remoteExec ["ca_fnc_zeusDeployment", _unit, true];
