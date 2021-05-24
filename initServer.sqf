/* CA - Public Variables/General mission settings
To change a setting Change the middle variable in the array. ie for the example below change east to west
 missionNamespace setVariable ["ca_defaultside",east, true];
 missionNamespace setVariable ["Variable name for scripts etc",VALUE TO CHANGE, JIP compatability];
*/
// CA - Public Variables for CA folder
missionNamespace setVariable ["ca_defaultside",east, true]; // Default side for spawning enemies if side parameter is not present
missionNamespace setVariable ["ca_hcshowmarkers",true, true]; // If FPS markers should be viewable in the bottom left corner (Server plus HC)


// CA - Public Variables for Respawn system
// Check other respawn settings in ca_platoonsetup.sqf
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

missionNamespace setVariable ['ca_specialistMarkerClasses',["med","sur","uav"], true]; //Individual specialist markers (ie medic markers). Refer to assinggear files for a complete list of f3 loadout classes (eg dc, ftl, eng, sp, pp, vc etc.). Smooth markers and normal markers

// CA UNCONCIOUS SPECTATOR
missionNamespace setVariable ['CA2_Downtime_OptOut',false, true]; // Disable unconcious spectator entirely. Will still go into spectate on death. TRUE = NO UNCONCIOUS SPECTATOR
missionNamespace setVariable ['CA2_Downtime_SpectatorWaitTime',17, true]; // Number of seconds before entering spectate. 17 seconds is the least amount found through testing to rule out temporary shock.
missionNamespace setVariable ['CA2_Downtime_SpectatorCameraModes',[0,1], true]; // Which camera modes to allow. [0,1] All modes. [0] = Freecam. [1] = 1PP only. Do not use 3pp [2] as it requires an effects handler which isn't present. 
missionNamespace setVariable ['CA2_Downtime_SpectatorVisionModes',[-1,0,1], true]; // Which visionmodes to allow (freecam). [-1,0,1] All modes. [-1] = NVG. [0] = White hot. [1] black hot. It goes all the way up to 7(Thermal red/green), but please ask for help before doing so. 

// Allow init.sqf to go ahead
missionNamespace setVariable ['ca_initserver',true, true];

// Extend the file to the CA folder
[] execVM "ca\ca_initServer.sqf";
[] execVM "ca_platoonSetup.sqf";

