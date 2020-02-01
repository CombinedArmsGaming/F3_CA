/* CA - Public Variables/General mission settings
To change a setting Change the middle variable in the array. ie for the example below change east to west
 missionNamespace setVariable ["ca_defaultside",east, true];
 missionNamespace setVariable ["Variable name for scripts etc",VALUE TO CHANGE, JIP compatability];
*/
// CA - Public Variables for CA folder
missionNamespace setVariable ["ca_defaultside",east, true]; // Default side for spawning enemies if side parameter is not present
missionNamespace setVariable ["ca_hcshowmarkers",false, true]; // If FPS markers should be viewable in the bottom left corner (Server plus HC)


// CA - Public Variables for Respawn system
missionNamespace setVariable ['ca_respawnmode',2, true]; // Respawn modes: 0: Off, 1: Base respawn, 2: Hierarchy Spawn
missionNamespace setVariable ['ca_respawnwave',false, true]; // set to true to disable the respawn system, and respawn players as soon as they die.
missionNamespace setVariable ['ca_wavecooldown',1740, true]; // Seconds between each wave plus wavetime below
missionNamespace setVariable ['ca_wavetime',60, true]; // How many seconds each wave lasts where you can die and instantly respawn (Incase someone gets armaed on respawn or similar incidents)
// F3 and also CA respawn variables
missionNamespace setVariable ["f_var_JIP_JIPMenu",true, true]; // Do JIP players get the JIP/teleport menu?
missionNamespace setVariable ["f_var_JIP_RespawnMenu",false, true]; // Do respawning players get the JIP menu? Use for a quick fast respawn system with group rejoin!
missionNamespace setVariable ["f_var_JIP_RemoveCorpse",false, true]; // Remove the old corpse of respawning players?
missionNamespace setVariable ["f_var_JIP_Spectate",false, true]; // JIP players go into spectate straight away?

_respawnmsg = "Respawn wave deployed"; // Message sent to everyone in chat about reinforcement wave happening, set to "" to have no message
missionNamespace setVariable ['ca_respawnmsg',_respawnmsg, true];

// F3 Parameters
missionNamespace setVariable ['f_var_debugMode',0, true]; // Debug mode, deprecated but outputs some info for F3. 0 = off, 1 = on.
missionNamespace setVariable ['f_param_backpacks',1, true]; // LEGACY SUPPORT! SET IN THE GEARSCRIPT FILE ITSELF NOW! Assigngear backpack loadout. 0 = light, 1 = medium, 2 = heavy
missionNamespace setVariable ['f_var_radios',3, true]; // Radio system. 0 = none, 2 = TFR, 3 = ACRE2
missionNamespace setVariable ['f_var_mission_timer',5, true]; // Safestart duration. Value in minutes
missionNamespace setVariable ['f_param_caching',0, true]; // Ai Caching distance in meters, 0 = off

missionNamespace setVariable ['f_var_smoothMarkers',true, true]; // Use smooth markers instead of the standard markers.
missionNamespace setVariable ['f_var_smoothMarkers_showAI',true, true]; // Show positions of allied AI groups? (Smooth markers only).
missionNamespace setVariable ['f_var_smoothMarkers_hide',false, true]; // Hide all markers?  Useful for some mission situations, can be changed mid-mission (Smooth markers only).

// Allow init.sqf to go ahead
missionNamespace setVariable ['ca_initserver',true, true];

// Extend the file to the CA folder
[] execVM "ca\ca_initServer.sqf";
[] execVM "ca_platoonSetup.sqf";
[] call f_fnc_initSmoothMarkers;

// CA - Parachute spawning
//_parachutearea = ""; // Name of area marker players will spawn in
// OR
//_parachutearea = [[0,1500,3000],[0,1500,3000]]; // Gaussian where first array is x(left to right) and second is y(up and down) with [min,normal,max]
// missionNamespace setVariable ['ca_parachutearea',_parachutearea, true];
/*
waitUntil {time>2; sleep 0.1;}; // initial paradrop, need to wait until spawned
{
[_x] remoteExec ["ca_fnc_parachute", _x, false];
} forEach playableUnits;
*/
