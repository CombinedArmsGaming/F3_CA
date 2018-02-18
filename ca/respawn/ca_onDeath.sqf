// CA respawn system with wave respawns

if (isDedicated) exitWith{};


// MAKE SURE THE PLAYER INITIALIZES PROPERLY
if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

params ["_unit","_corpse"];

if (time < 10 || isNull _corpse) exitWith {}; //if first spawn exit out

// Enter spectator
[true] call ace_spectator_fnc_setSpectator;
// Wait for respawn to happen
waitUntil { ca_respawnwave };
// Do f3 assign radio and gear
_loadout = (_unit getVariable "f_var_assignGear");
_unit setVariable ["f_var_assignGear_done",false,true];
[_loadout,player] call f_fnc_assignGear;
[] execVM "f\radios\radio_init.sqf";

// Exit spectator and setpos to respawn_west
[false] call ace_spectator_fnc_setSpectator;
//_unit setPos (getmarkerPos "respawn_west" );

// [_unit] call ca_fnc_parachute;
