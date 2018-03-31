// bub_fnc_isZeusRemoteContrlling
// Original inplementation by Cre8or, edited by Bubbus.
//
// Returns true if _ply is currently remote controlling a unit as Zeus, else false.
// Local execution only.

params ["_ply"];

_remoteControllerExists = false;

if (!isNil "bis_fnc_moduleRemoteControl_unit") then {
	if (typeName bis_fnc_moduleRemoteControl_unit == typeName objNull) then {
		if (!isNull bis_fnc_moduleRemoteControl_unit) then {
			_remoteControllerExists = true;
		};
	};
};

_curatorCameraAbsent = isNull curatorCamera;
_isRemoteControlling =  _remoteControllerExists and _curatorCameraAbsent;

_isRemoteControlling