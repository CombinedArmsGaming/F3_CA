//	Zeus extensions for CA, by Bubbus.
//	
//	This function is called from ca_fnc_zeusDeployment.
//	Waits for the zeus display to be created (id = 312), then creates a button which can be clicked to toggle zeus deployment mode.
//	
//	PARAMETERS:
//	
//		_moveDown
//			If true, aligns the button with the bottom of the screen.
//			If false, makes space at the bottom of the screen for the unit spawner.

if (isDedicated) exitWith {};
disableSerialization;

params ["_moveDown"];

_ctrls = missionNamespace getVariable ["ca_zeusDeploy_ctrls", []];
missionNamespace setVariable ["ca_zeusDeploy_ctrls", _ctrls];
_id = 600;

{ ctrlDelete _x } forEach _ctrls;

_fn_newCtrl = 
{
	params ["_type"];
	
	_ctrl = _display ctrlCreate [ _type, _id ];
	
	_id = _id + 1;
	diag_log format ["dispid %1", _id];
	_ctrls pushBack _ctrl;
	
	_ctrl
	
};

private ["_display"];

waitUntil { sleep 0.1; _display = findDisplay 312; !isNull _display };

_bg = ["RscButton"] call _fn_newCtrl;

if (_moveDown) then
{
	_bg ctrlSetPosition [ -0.06, 1.11, 0.3, 0.09 ];
}
else
{
	_bg ctrlSetPosition [ -0.06, 0.885, 0.3, 0.09 ];
};

_bg ctrlSetText "";
_bg ctrlEnable false;
_bg ctrlCommit 0;


_btn = ["RscButton"] call _fn_newCtrl;
ca_zeus_deployBtn_idc = ctrlIDC _btn;

if (_moveDown) then
{
	_btn ctrlSetPosition [ -0.05, 1.125, 0.28, 0.06 ];
}
else
{
	_btn ctrlSetPosition [ -0.05, 0.9, 0.28, 0.06 ];
};


_btn buttonSetAction '[ca_zeus_deployBtn_idc, !zeus_deployment] call ca_fnc_updateZeusDeployment;';
_btn ctrlSetTooltip "Turn OFF before Remote Controlling AI!  Turn ON to deploy Zeus Player under the camera.";

[ca_zeus_deployBtn_idc, zeus_deployment] call ca_fnc_updateZeusDeployment;

_btn ctrlCommit 0;




waitUntil { sleep 0.2; _display = findDisplay 312; isNull _display };
[_moveDown] call ca_fnc_zeusDeployButtons;