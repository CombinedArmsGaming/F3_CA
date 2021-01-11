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


// Join in progress and instant respawn handling
if ((time < 10) || (isNull _corpse)) exitWith {
    _loadout = (_unit getVariable "f_var_assignGear");
    _unit setVariable ["f_var_assignGear_done",false,true];
    [_loadout,player] call f_fnc_assignGear;
    [] execVM "f\acre2\acre2_init.sqf";
    sleep 5;
    if (isnil {f_var_downtimeExperienceActive}) then {
    [] spawn ca_fnc_downtimeMonitor;
    [] spawn ca_fnc_blockSelfInteractWhileUnconscious;
    };
    if (!f_var_JIP_JIPMenu) exitWith {}; //do JIP players get teleport menu?
    
    if (isNil "F3_JIP_reinforcementOptionsAction") then {
    	[player] execVM "f\JIP\f_JIP_addReinforcementOptionsAction.sqf";
    };
};
//Set player to dead
player setVariable ["ca_playerisdeaddead",true];

_group = group player;
_groupid = groupid _group;
_originalgroup = _unit getvariable ["ca_originalgroup","nogroupfound"];
_OGgroupid = groupid _originalgroup;

//Check if player is part of his original group, if not rejoin it (TEST, not 100% sure if group leaving is a result of respawn or ace spectator, this is a fix for the latter)
if (_OGgroupid != _groupid) then {
    [_unit] joinsilent _originalgroup;
};

// Enter spectator - See downtime\fn_downtimeSpectate.sqf
// ====================================================================================================================
//[true,true,false] call ace_spectator_fnc_setSpectator;

player setvariable ["ace_medical_allowdamage",false];
player remoteExec ["hideObjectGlobal", 2];
{_unit removeItem _x;} forEach ([] call acre_api_fnc_getCurrentRadioList);  //Remove any additional radios for sure, readded in gearscript


// Setup respawn variables 
// ====================================================================================================================

// Get time when respawn will be available
_respawntime = _group getVariable ["ca_grouprespawntime",1];
// If time to respawn is less than current time and a member of the group is not already in spectate, add cooldown to the group

if (_respawntime < time && (_group getVariable ["ca_groupspectatebool",true])) then {
    _cooldowntime = ca_grouprespawncooldown + time;
    _group setVariable ["ca_grouprespawntime",_cooldowntime, true];
    _group setVariable ["ca_groupspectatebool",false, true];	
};
//
if (isnil {f_var_downtimeExperienceActive}) then {
    [] spawn ca_fnc_downtimeMonitor;
    [] spawn ca_fnc_blockSelfInteractWhileUnconscious;
};

// Wait for respawn to happen
// ====================================================================================================================

waitUntil { ca_respawnwave };
player setVariable ["ca_playerisdeaddead",false];

//player setvariable ["ace_medical_allowdamage",true];
// Exit spectator
// ====================================================================================================================
//[false] call ace_spectator_fnc_setSpectator;

// F3 assign radio and gear
// ====================================================================================================================
_loadout = (_unit getVariable "f_var_assignGear");
_unit setVariable ["f_var_assignGear_done",false,true];
[_loadout,player] call f_fnc_assignGear;
[] execVM "f\acre2\acre2_init.sqf";
[player] call ace_medical_treatment_fnc_fullHealLocal;      // medical rewrite compatibility (ACE v3.13.0 and higher)

// ====================================================================================================================
//[player,false] remoteExec ["hideObjectGlobal", 2];
// Reset for downtime


if (!f_var_JIP_RespawnMenu) exitWith {}; //do respawning players get menu?
sleep 5;
if (isNil "F3_JIP_reinforcementOptionsAction") then {
    [player] execVM "f\JIP\f_JIP_addReinforcementOptionsAction.sqf";
};

/*

{
        _x setVariable ["ca_grouprespawntime",1];
    _x setVariable ["ca_groupspectatebool",true];	
    
} forEach allgroups;
*/