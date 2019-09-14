/*
 * Author: Poulern
 * Sets up the group with variables that can be used in the hierarchy and radios. 
 *
 * Arguments:
 * 0: Groupid (String): The groupid that is set in the editor field callsign.
 * 1: Superior (String): The one thats in charge of this group, if equal to groupid, then the group is an independent group or CO.
 * 2: Rank (Number): The number from 1-6 that the unit rank should be. 
 * 3: Short range radio channel (Number): What channel the 343 will be on by default and on respawn. 
 * 4: Long range radio Array (Array): Array of channels the long range radios will be on by default and on respawn. 
 * 5: Group color (String): The color of the hierarchy and marker .
 * 6: Group tickets (Number): The number of tickets this group gets to play with at the start of the mission. 
 * 7: Group type (String): What markertype the unit has. 
 */
params ["_groupid","_superior","_side",["_rank",2],["_SRradioCH",16],["_LRradioarray",[4]],["_groupcolor","ColorWhite"],["_grouptickets",5],["_grouptype","none"]];


//Create a global variable for this group, so it can be bypassed in the hierarchy if needed (CO-ASl-A1 -> CO-A1)
_superiorID = format ["%1_%2",_groupid,_side];

missionNamespace setVariable [_superiorID,_superior, true]; 

//Create a JIP array for that process if needed 
_grouparray = [_groupid,_superior,_rank,_SRradioCH,_LRradioarray,_groupcolor,_grouptickets,_grouptype];

//Create a code bin for each side to execute later
_setupgroup = {
	params ["_group","_superior","_rank","_SRradioCH","_LRradioarray","_groupcolor","_grouptickets","_grouptype"];
	
	_group setVariable ["ca_groupsetup",true, true];
	_group setVariable ["ca_superior",_superior, true];
	_group setVariable ["ca_SRradioCH",_SRradioCH, true];
	_group setVariable ["ca_LRradioarray",_LRradioarray, true];
	_group setVariable ["ca_groupcolor",_groupcolor, true];
	_group setVariable ["ca_grouptickets",_grouptickets, true];
	_group setVariable ["ca_grouptype",_grouptype, true];
	_group setVariable ["ca_grouprespawntime",ca_grouprespawncooldown, true];
	{
		if (leader _group == _x) then {
			[leader _group,_rank] spawn ca_fnc_setrank;
		};
	} forEach (units _group);
	//PUT IN GROUP MARKERS HERE (remoteexec becauser its server executing only)
	_group remoteExec ["ca_fnc_groupMarker",_side,true];
};

switch (_side) do {
	case west: {
		// Find the group in the list of units to the side west 
		_findgroup = ca_allWestPlayerGroups select { (groupid _x) == _groupid};
		// If not found pushback the ID to the JIParray which the group can search in later 
		if(count _findgroup == 0) exitWith {ca_WestJIPgroups pushBackUnique [_grouparray,_groupid]; };
		_group = _findgroup select 0;
		//Call the code bin above 
		[_group,_superior,_rank,_SRradioCH,_LRradioarray,_groupcolor,_grouptickets,_grouptype] call _setupgroup;
	};
	case east: {
		// Find the group in the list of units to the side west 
		_findgroup = ca_allEastPlayerGroups select { (groupid _x) == _groupid};
		// If not found pushback the ID to the JIParray which the group can search in later 
		if(count _findgroup == 0) exitWith {ca_EastJIPgroups pushBackUnique [_grouparray,_groupid]; };

		_group = _findgroup select 0;
		//Call the code bin above 
		[_group,_superior,_rank,_SRradioCH,_LRradioarray,_groupcolor,_grouptickets,_grouptype] call _setupgroup;
	};
	case independent: {
		// Find the group in the list of units to the side independent 
		_findgroup = ca_allIndependentPlayerGroups select { (groupid _x) == _groupid};
		// If not found pushback the ID to the JIParray which the group can search in later 
		if(count _findgroup == 0) exitWith {ca_IndependentJIPgroups pushBackUnique [_grouparray,_groupid]; };

		_group = _findgroup select 0;
		//Call the code bin above 
		[_group,_superior,_rank,_SRradioCH,_LRradioarray,_groupcolor,_grouptickets,_grouptype] call _setupgroup;
	};
	default {diag_log format ["Error in the side input for (%1), group(%3)",_side,_groupid]};
};

