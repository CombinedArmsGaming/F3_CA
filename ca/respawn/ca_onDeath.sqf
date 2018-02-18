// CA respawn system with wave respawns

if (isDedicated) exitWith{};


// MAKE SURE THE PLAYER INITIALIZES PROPERLY
if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

params ["_unit","_corpse"];

if (time < 10 || isNull _corpse) exitWith {
    _loadout = (_unit getVariable "f_var_assignGear");
    _unit setVariable ["f_var_assignGear_done",false,true];
    [_loadout,player] call f_fnc_assignGear;
    [] execVM "f\radios\radio_init.sqf";

    if (!f_var_JIP_RespawnMenu && !(isNull _corpse)) exitWith {}; //do respawning players get menu?
    sleep 5;
    if (isNil "F3_JIP_reinforcementOptionsAction") then {
    	[player] execVM "f\JIP\f_JIP_addReinforcementOptionsAction.sqf";
    };
};

// Enter spectator
[true] call ace_spectator_fnc_setSpectator;
// Wait for respawn to happen
waitUntil { ca_respawnwave };
// Do f3 assign radio and gear
_loadout = (_unit getVariable "f_var_assignGear");
_unit setVariable ["f_var_assignGear_done",false,true];
[_loadout,player] call f_fnc_assignGear;
[] execVM "f\radios\radio_init.sqf";

if (typeof _unit != "seagull" && {f_var_JIP_RemoveCorpse && !isNull _corpse}) then {
	_corpse spawn {
		hideBody _this;
		sleep 60;
		deleteVehicle _this;
	};
};

// Exit spectator and setpos to respawn_west
[false] call ace_spectator_fnc_setSpectator;
//_unit setPos (getmarkerPos "respawn_west" );

// [_unit] call ca_fnc_parachute;
