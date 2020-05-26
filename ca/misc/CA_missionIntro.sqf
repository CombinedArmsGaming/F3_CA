/* CA Mission Intro. Replacement for the defunct and pretty useless PM Mission Intro.
Pulls from the mission name (located in the mission.sqm file) and displays it using the BIS 
Info Text function. Also shows the current in game date, and the grid position of the player.
*/

waitUntil{!(isNil "BIS_fnc_init")};
sleep 5;
[briefingName, str(date select 1) + "." + str(date select 2) + "." + str(date select 0), mapGridPosition player] spawn BIS_fnc_infoText;
sleep 5;


/*

Other examples of BIS Text functions that could work, the InfoText was chosen for it's relatively clean look and nice typing effect.

[ briefingName, format ["Year %1", date select 0], mapGridPosition player ] spawn BIS_fnc_infoText;
[[briefingName,4,5],[str(date select 1) + "." + str(date select 2) + "." + str(date select 0),3,5,8]] spawn BIS_fnc_EXP_camp_SITREP;
