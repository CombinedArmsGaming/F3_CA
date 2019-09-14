// CA respawn system with wave respawns

if (isDedicated) exitWith{};


// MAKE SURE THE PLAYER INITIALIZES PROPERLY
if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player; !isnil {ca_initserver};};
};

params ["_unit","_corpse"];
if (!f_var_JIP_JIPMenu && isNull _corpse) exitWith {}; // If no corpse exists the player is spawned for the first time.
if (time < 10 && isNull _corpse) exitWith {}; //if not a JIP and its the start of the mission exit out

{_unit removeItem _x;} forEach ([] call acre_api_fnc_getCurrentRadioList);  //Remove any additional radios that might get spawned

// Join in progress and instant respawn handling
if ((time < 10) || (isNull _corpse)) exitWith {
    _loadout = (_unit getVariable "f_var_assignGear");
    _unit setVariable ["f_var_assignGear_done",false,true];
    [_loadout,player] call f_fnc_assignGear;
    [] execVM "f\radios\radio_init.sqf";

    if (!f_var_JIP_JIPMenu) exitWith {}; //do JIP players get teleport menu?
    sleep 5;
    if (isNil "F3_JIP_reinforcementOptionsAction") then {
    	[player] execVM "f\JIP\f_JIP_addReinforcementOptionsAction.sqf";
    };
};

Previousgroup = group player;
_group = group player;
// Enter spectator
// ====================================================================================================================
[true,true,false] call ace_spectator_fnc_setSpectator;

player setvariable ["ace_medical_allowdamage",false];
player remoteExec ["hideObjectGlobal", 2];
{_unit removeItem _x;} forEach ([] call acre_api_fnc_getCurrentRadioList);  //Remove any additional radios for sure


// Setup respawn variables 
// ====================================================================================================================

// Get time when respawn will be available
_respawntime = _group getVariable ["ca_grouprespawntime",1];
// If time to respawn is less than current time, add cooldown to the group
if (_respawntime < time) then {
    _cooldowntime = ca_grouprespawncooldown + time;
    _group setVariable ["ca_grouprespawntime",_cooldowntime, true];
};
//Set the group for repsawn purposes
player setvariable ["ca_originalgroup",Previousgroup];

/*
if (count units Previousgroup == 1) then {
    Previousgroup setVariable ["ca_originalgroup", Previousgroup, true];
} else {
    _group = createGroup [(side player), true];
    [player] join _group;
    player setVariable ["ca_originalgroup", Previousgroup, true];
};
*/

// Wait for respawn to happen
// ====================================================================================================================
waitUntil { ca_respawnwave };

player setvariable ["ace_medical_allowdamage",true];
[player,false] remoteExec ["hideObjectGlobal", 2];

// F3 assign radio and gear
// ====================================================================================================================
_loadout = (_unit getVariable "f_var_assignGear");
_unit setVariable ["f_var_assignGear_done",false,true];
[_loadout,player] call f_fnc_assignGear;
[] execVM "f\radios\radio_init.sqf";
[player,player] call ACE_medical_fnc_treatmentAdvanced_fullHealLocal;

// Exit spectator and setpos to respawn_west
// ====================================================================================================================
[false] call ace_spectator_fnc_setSpectator;

if (!f_var_JIP_RespawnMenu) exitWith {}; //do respawning players get menu?
sleep 5;
if (isNil "F3_JIP_reinforcementOptionsAction") then {
    [player] execVM "f\JIP\f_JIP_addReinforcementOptionsAction.sqf";
};

