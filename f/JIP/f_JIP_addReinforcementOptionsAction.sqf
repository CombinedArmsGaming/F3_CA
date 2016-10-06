// F3 - JIP Add Reinforcement Options Action
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DECLARE VARIABLES AND FUNCTIONS

private ["_unit","_textAction"];

// ====================================================================================

// SET KEY VARIABLES

_unit = _this select 0;
_textAction = localize "STR_f_JIP_reinforcementOptionsAction";

// PREVENT THE JIP AI UNITS FROM FOLLOWING THEIR LEADER/MOVING AWAY
_unit disableAI "move";

// ====================================================================================

// ADD REINFORCEMENT OPTIONS ACTION TO PLAYER ACTION MENU
// We add the action to the player's action menu.

if (_unit == player) then {
	F3_JIP_reinforcementOptionsAction = _unit addaction ["<t color='#dddd00'>" + _textAction + "</t>","f\JIP\f_JIP_reinforcementOptions.sqf",[],6,true,false,"","_target == player"];
	["JIP",["See Scroll-wheel Menu for Reinforcement Options"]] call BIS_fnc_showNotification;

	[F3_JIP_reinforcementOptionsAction,_unit] spawn 
	{
			private ["_startPos"];
			_startPos = getpos (_this select 1);
			while {_startPos distance getpos (_this select 1) < 100 && alive (_this select 1) && !(isNil "F3_JIP_reinforcementOptionsAction")} do 
			{
				sleep 5;
			};
			if (!isNil "F3_JIP_reinforcementOptionsAction") then {
				(_this select 1) removeaction F3_JIP_reinforcementOptionsAction;
				F3_JIP_reinforcementOptionsAction = nil;
			};
	};
	
};