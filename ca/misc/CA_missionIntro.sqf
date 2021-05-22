/* CA Mission Intro
by Khaki
_missionName and _author are set in description.ext
Date and time are set to real world UTC
*/

waitUntil{!(isNil "BIS_fnc_init")};
sleep 30;


_hour = if (systemTimeUTC select 3 < 10) then {"0" + str(systemTimeUTC select 3)} else {str(systemTimeUTC select 3)};
_min = if (systemTimeUTC select 4 < 10) then {"0" + str(systemTimeUTC select 4)} else {str(systemTimeUTC select 4)};

_missionName = getText (missionConfigFile >> "onLoadName");
_author = getText (missionConfigFile >> "author");
_terrain = worldName;

[
	[
		[_missionName, "<t align = 'right' shadow = '1' size = '0.7'>%1</t><br/>"],
		["by " + _author, "<t align = 'right' shadow = '1' size = '0.5'>%1</t><br/><br/>"],
		[_terrain, "<t align = 'right' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>"],
		[str(systemTimeUTC select 2) + "." + str(systemTimeUTC select 1) + "." + str(systemTimeUTC select 0) + " - " + _hour + _min + " Zulu", "<t align = 'right' shadow = '1' size = '0.5'>%1</t>",60]
	],
	0.5,1
] spawn BIS_fnc_typeText;