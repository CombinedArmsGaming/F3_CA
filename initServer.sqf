/* CA - Public Variables/General mission settings
To change a setting Change the middle variable in the array. ie for the example below change east to west
 missionNamespace setVariable ["ca_defaultside",east, true];
 missionNamespace setVariable ["Variable name for scripts etc",VALUE TO CHANGE, JIP compatability];
*/
// CA - Public Variables for CA folder
missionNamespace setVariable ["ca_defaultside",east, true]; // Default side for spawning enemies if side parameter is not present
missionNamespace setVariable ["ca_hcshowmarkers",false, true]; // If FPS markers should be viewable in the bottom left corner (Server plus HC)


// CA - Public Variables for Respawn system
missionNamespace setVariable ['ca_respawnmode',2, true]; // Respawn modes: 0: Off, 1: Base respawn, 2: Hierarchy Wave Spawn 3: Hierarchy group spawn (use group tickets)
missionNamespace setVariable ['ca_respawnwave',false, true]; // set to true to disable the respawn system, and respawn players as soon as they die.
missionNamespace setVariable ['ca_wavecooldown',540, true]; // Seconds between each wave plus wavetime below
missionNamespace setVariable ['ca_wavetime',60, true]; // How many seconds each wave lasts where you can die and instantly respawn (Incase someone gets armaed on respawn or similar incidents)
// F3 and also CA respawn variables
missionNamespace setVariable ["f_var_JIP_JIPMenu",true, true]; // Do JIP players get the JIP/teleport menu?
missionNamespace setVariable ["f_var_JIP_RespawnMenu",false, true]; // Do respawning players get the JIP menu? Use for a quick fast respawn system with group rejoin!
missionNamespace setVariable ["f_var_JIP_RemoveCorpse",false, true]; // Remove the old corpse of respawning players?
missionNamespace setVariable ["f_var_JIP_Spectate",false, true]; // JIP players go into spectate straight away?

// F3 Parameters
missionNamespace setVariable ['f_var_mission_timer',5, true]; // Safestart duration. Value in minutes

// CA SMOOTH MARKER SETTINGS
missionNamespace setVariable ['f_var_smoothMarkers',true, true]; // Use smooth markers instead of the standard markers.
missionNamespace setVariable ['f_var_smoothMarkers_showAI',true, true]; // Show positions of allied AI groups? (Smooth markers only).
missionNamespace setVariable ['f_var_smoothMarkers_hide',false, true]; // Hide all squad markers?  Useful for some mission situations, can be changed mid-mission (Smooth markers only).
missionNamespace setVariable ['f_var_smoothFTMarkers_hide',false, true]; // Same as above, but for fireteam-member markers.  Enable both to hide all markers. (Smooth markers only).

// CA MARKER SETTINGS
// Running a mission with a zeus player?  Put all squads callsign/groupid in here to hide them from the map and hierarchy (Smooth and regular markers).
missionNamespace setVariable ['f_var_hiddenGroups',["Zeus Crew","GOD"], true]; 

missionNamespace setVariable ['ca_specialistMarkerClasses',["m","surgeon","uav"], true]; //Individual specialist markers (ie medic markers). Refer to assinggear files for a complete list of f3 loadout classes (eg dc, ftl, eng, sp, pp, vc etc.). Smooth markers and normal markers

// Allow init.sqf to go ahead
missionNamespace setVariable ['ca_initserver',true, true];

// Extend the file to the CA folder
[] execVM "ca\ca_initServer.sqf";
[] execVM "ca_platoonSetup.sqf";

