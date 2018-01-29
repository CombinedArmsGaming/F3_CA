params ["_unit", "_spawnMenu", "_deployMenu"];

if (!isServer) exitWith {};

[_unit, false] remoteExec ["allowDamage", 0, true];
[_unit, ["ace_w_allow_dam",false,true]] remoteExec ["setVariable", 0, true];
[_unit, ["HandleDamage", {false}]] remoteExec ["addEventHandler", 0, true];
_unit addCuratorEditableObjects [(vehicles + allUnits), true];
_unit removeCuratorEditableObjects [_unit, true];

[[_unit, _spawnMenu, _deployMenu], "ca\ca_vm_cl_zeusDeployment.sqf"] remoteExec ["execVM", _unit, true];
