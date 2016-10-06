// F3 - JIP Reinforcement Options
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DECLARE VARIABLES AND FUNCTIONS

private ["_unit","_textAction","_grp","_joinDistance","_loadout","_tpaction","_notAlone"];

// ====================================================================================

// ALLOW PLAYER TO SELECT GROUP
// Using a dialog we allow the player to select the group s/he is going to [re-]join.

["JIP",["Select the group to join."]] call BIS_fnc_showNotification;

f_var_JIP_state = 0;
createDialog "GrpPicker";
waitUntil {f_var_JIP_state == 1};
_grp = (player getVariable "f_var_JIP_grp");

// ====================================================================================

// ALLOW PLAYER TO SELECT LOADOUT
// Using a dialog we allow the player to select the loadout s/he requires.

//f_var_JIP_state = 2;
//if (f_var_JIP_RespawnMenu) then {
//	["JIP",["Select your gear kit."]] call BIS_fnc_showNotification;
//
//	createDialog "KitPicker";
//	waitUntil {f_var_JIP_state == 3};
//
//	_loadout = (player getVariable "f_var_JIP_loadout");
//	[_loadout,player] call f_fnc_assignGear;
//};

// ====================================================================================

// REMOVE REINFORCEMENT OPTIONS ACTION TO PLAYER ACTION MENU
// We remove the action to the player's action menu.
// NB This is on the assumption that the player has made positive selections and not
// cancelled the menu.

if (!isNil "F3_JIP_reinforcementOptionsAction") then {
	player removeAction F3_JIP_reinforcementOptionsAction;
	F3_JIP_reinforcementOptionsAction = nil;
};

// ====================================================================================

// IMPLEMENT CHOICES
// Using the choices made by the player we implement the desired loadout and set the
// target group for her/him to join.
// If the player is already in the group, he simply remains there

_joinDistance = 10;

if (_grp != group player) then {
	[player] joinSilent grpNull;

	if (!isNull _grp) then {
		[player] joinSilent _grp;
		//[_grp,_joinDistance] execVM "f\JIP\f_JIP_nearTargetGroupCheck.sqf";
		["JIP",[format ["Selection successful. Your group leader is %1",name leader _grp]]] call BIS_fnc_showNotification;
	};
};

sleep 5;
_notAlone = false;
{
	if (side (group _x) == side (group player) && _x != player) exitWith {_notAlone = true};
}foreach playableUnits;


if (isNil "tpAction" && _notAlone) then {
	["JIP",["Teleport to Group available"]] call BIS_fnc_showNotification;
	tpAction = player addAction ["<t color='#dddd00'>Teleport to Group", "pa\jipTeleport.sqf",[],6,true,false,"","_target == player"];
	[tpAction,player] spawn 
	{
		private ["_startPos"];
		_startPos = getpos (_this select 1);
		while {_startPos distance getpos (_this select 1) < 100 && alive player} do 
		{
			sleep 5;
		};
		(_this select 1) removeaction (_this select 0);
		tpAction = nil;
	};
};
if (!_notAlone) then {
	["JIP",["Teleport to Group NOT available"]] call BIS_fnc_showNotification;
};