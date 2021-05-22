/*
 * Function: Setup group.
 * Sets up the group with variables that can be used in the hierarchy and radios. 
 *
 * Arguments:
 * 0: Side (Side): This is set automatically, if you need to set up for multiple sides copy the template and name it _westhierarchy, _easthierachy etc. as needed and change the call below
 Every element below this is optional, but reccomended to set. 
 * 1: Superior (String): The groupid of the group that ranks above it in the hierarchy, if equal to groupid, then the group is an independent group or its own platoon.
 * 2:  Groupid (String): The groupid that is set in the editor field callsign.
 * 3: Short range radio channel (Number): What channel the 343 will be on by default and on respawn. 
 * 4: Long range radio Array (Array): Array of channels the long range radios will be on by default and on respawn. There will be one radio given per channel to ranks set in ca_acre2settings.sqf
 * 5: Group color (String): The color of the group in the hierarchy and its groupmarker. Available colors: "ColorBlack","ColorGrey","ColorRed","ColorBrown","ColorOrange","ColorYellow","ColorKhaki","ColorGreen","ColorBlue","ColorPink","ColorWhite"
 * 6: Group tickets (Number): The number of tickets this group gets to play with at the start of the mission. 
 * 7: Group marker (Boolean): Should each team get a group marker assigned to them? Default: True. 
 * 8: Group type (String): What markertype the unit has. This is if you want to use the non-automatic mode that the groupmarker uses. For non smooth markers its any A3 marker, for smooth markers its "b_hq","b_inf","b_support","b_motor_inf","b_mortar","b_maint","b_mech_inf","b_armor","b_recon","b_air","b_plane","b_art"

Example: [west,"ASL","CO",1,[4,1],"ColorRed",5] spawn ca_fnc_setupGroup;

 */
params ["_side","_groupid","_superior",["_SRradioCH",16],["_LRradioarray",[1]],["_groupcolor","ColorWhite"],["_grouptickets",0],["_groupmarkerboolean",true],["_grouptype","auto"]];


//Create a global variable for this group, so it can be bypassed in the hierarchy if needed (CO-ASl-A1 -> CO-A1)
_superiorID = format ["%1_%2",_groupid,_side];

missionNamespace setVariable [_superiorID,_superior, true]; 

//Create a JIP array for that process if needed 
_grouparray = [_groupid,_superior,_SRradioCH,_LRradioarray,_groupcolor,_grouptickets,_groupmarkerboolean,_grouptype,_side];

//Create a code bin for each side to execute later
_setupgroup = {
	params ["_group","_superior","_SRradioCH","_LRradioarray","_groupcolor","_grouptickets","_groupmarkerboolean","_grouptype","_side"];
	
	_group setVariable ["ca_groupsetup",true, true];
	_group setVariable ["ca_superior",_superior, true];
	_group setVariable ["ca_SRradioCH",_SRradioCH, true];
	_group setVariable ["ca_LRradioarray",_LRradioarray, true];
	_group setVariable ["ca_groupcolor",_groupcolor, true];
	_group setVariable ["ca_grouptickets",_grouptickets, true];
	_group setVariable ["ca_grouptype",_grouptype, true];
	_group setVariable ["ca_grouprespawntime",ca_grouprespawncooldown, true];
	_group setVariable ["ca_groupmarkerboolean",_groupmarkerboolean, true];
	//PUT IN GROUP MARKERS HERE (remoteexec becauser its server executing only)
	if (_groupmarkerboolean) then {
	_group remoteExec ["ca_fnc_groupMarker",_side,true];	
	};
};

switch (_side) do {
	case west: {
		// Find the group in the list of units to the side west 
		_findgroup = ca_allWestPlayerGroups select { (groupid _x) == _groupid};
		// If not found pushback the ID to the JIParray which the group can search in later 
		if(count _findgroup == 0) exitWith {ca_WestJIPgroups pushBackUnique [_grouparray,_groupid]; };
		_group = _findgroup select 0;
		//Call the code bin above 
		[_group,_superior,_SRradioCH,_LRradioarray,_groupcolor,_grouptickets,_groupmarkerboolean,_grouptype,_side] call _setupgroup;
	};
	case east: {
		// Find the group in the list of units to the side west 
		_findgroup = ca_allEastPlayerGroups select { (groupid _x) == _groupid};
		// If not found pushback the ID to the JIParray which the group can search in later 
		if(count _findgroup == 0) exitWith {ca_EastJIPgroups pushBackUnique [_grouparray,_groupid]; };

		_group = _findgroup select 0;
		//Call the code bin above 
		[_group,_superior,_SRradioCH,_LRradioarray,_groupcolor,_grouptickets,_groupmarkerboolean,_grouptype,_side] call _setupgroup;
	};
	case independent: {
		// Find the group in the list of units to the side independent 
		_findgroup = ca_allIndependentPlayerGroups select { (groupid _x) == _groupid};
		// If not found pushback the ID to the JIParray which the group can search in later 
		if(count _findgroup == 0) exitWith {ca_IndependentJIPgroups pushBackUnique [_grouparray,_groupid]; };

		_group = _findgroup select 0;
		//Call the code bin above 
		[_group,_superior,_SRradioCH,_LRradioarray,_groupcolor,_grouptickets,_groupmarkerboolean,_grouptype,_side] call _setupgroup;
	};
};

