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

_group = group player;
//Set the group for repsawn purposes
player setvariable ["ca_originalgroup",_group];

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


// Wait for respawn to happen
// ====================================================================================================================
waitUntil { ca_respawnwave };

player setvariable ["ace_medical_allowdamage",true];
// Exit spectator
// ====================================================================================================================
[false] call ace_spectator_fnc_setSpectator;
//Check if player is part of his original group, if not rejoin it (TEST, not 100% sure if group leaving is a result of respawn or ace spectator, this is a fix for the latter)
if (count units _group == 1) then {
    _group setVariable ["ca_originalgroup", _group, true];
} else {
    _group = createGroup [(side player), true];
    [player] join _group;
    player setVariable ["ca_originalgroup", _group, true];
};

// F3 assign radio and gear
// ====================================================================================================================
_loadout = (_unit getVariable "f_var_assignGear");
_unit setVariable ["f_var_assignGear_done",false,true];
[_loadout,player] call f_fnc_assignGear;
[] execVM "f\radios\radio_init.sqf";
[player] call ace_medical_treatment_fnc_fullHealLocal;      // medical rewrite compatibility (ACE v3.13.0 and higher)

// ====================================================================================================================
[player,false] remoteExec ["hideObjectGlobal", 2];

if (!f_var_JIP_RespawnMenu) exitWith {}; //do respawning players get menu?
sleep 5;
if (isNil "F3_JIP_reinforcementOptionsAction") then {
    [player] execVM "f\JIP\f_JIP_addReinforcementOptionsAction.sqf";
};

