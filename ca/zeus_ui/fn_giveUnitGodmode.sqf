//	Zeus extensions for CA, by Bubbus.
//
//  Gives godmode to the passed unit.
//  NOTE: Godmode is not 100% effective and will fail to things like artillery, ACE backblast etc.
//  These kinds of damage ignore whether they should do damage, and just deal the damage anyway.
//	NOTE: This function should be called local to the unit.  Either call this globally or use remoteExec with _unit as the locality parameter.
//
//  PARAMETERS:
//
//		_unit
//			The unit to give godmode to.
//


params ["_unit"];

if (!local _unit) exitWith {};

[_unit, false] remoteExec ["allowDamage", 0, true];
[_unit, ["ace_w_allow_dam",false,true]] remoteExec ["setVariable", 0, true];
[_unit, ["HandleDamage", {false}]] remoteExec ["addEventHandler", 0, true];
_unit addCuratorEditableObjects [(vehicles + allUnits), true];
_unit removeCuratorEditableObjects [_unit, true];

[_unit] spawn
{
	params ["_unit"];

	while {alive _unit} do
	{
		[objNull, _unit] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;
		sleep 1;
	};

};
