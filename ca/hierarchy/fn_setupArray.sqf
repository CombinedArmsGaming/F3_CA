/*
 * Author: Poulern
 * First function called 
 *
 * Arguments:
 * 0: Array
 * 1: Side 
 */
params ["_platoonarray","_side"];

_COgroup = (_platoonarray select 0);
_grouparray = _COgroup;

_groupid = (_COgroup select 0);

_squadID = format ["%1%2",_groupid,_side];
_SRradioarray = _COgroup select 1;
_LRradioarray = _COgroup select 2;

switch (_side) do {
case west: {
_findgroup = ca_allWestPlayerGroups select { (groupid _x) == _groupid};
if(count _findgroup == 0) exitWith {"Warning: No CO slotted for mission!" remoteExec ["systemChat",west];ca_WestJIPgroups pushBackUnique [_grouparray,_squadID]; 
missionNamespace setVariable ["ca_westcojipid",_groupid, true];
};
_group = _findgroup select 0;

_group setVariable ["ca_squadID",_squadID, true];
_group setVariable ["ca_SRradioCH",_SRradioarray, true];
_group setVariable ["ca_LRradioarray",_LRradioarray, true];
missionNamespace setVariable ['ca_westCO',_group, true]; 
_squadticketID = format ["%1tickets",_squadID]; 
missionNamespace setVariable [_squadticketID,ca_WestSquadStartingTickets, true];
missionNamespace setVariable ["ca_westcojipid",_groupid, true];

_newarray = ca_allWestSquads pushBackUnique _squadID;

};
case east: {
_findgroup = ca_allEastPlayerGroups select { (groupid _x) == _groupid};
if(count _findgroup == 0) exitWith {"Warning: No CO slotted for mission!" remoteExec ["systemChat",east];ca_EastJIPgroups pushBackUnique [_grouparray,_squadID];
missionNamespace setVariable ["ca_eastcojipid",_groupid, true];
};

_group = _findgroup select 0;

_group setVariable ["ca_squadID",_squadID, true];
_group setVariable ["ca_SRradioCH",_SRradioarray, true];
_group setVariable ["ca_LRradioarray",_LRradioarray, true];
missionNamespace setVariable ['ca_eastCO',_group, true]; 
_newarray = ca_allEastSquads pushBackUnique _squadID;
_squadticketID = format ["%1tickets",_squadID]; 
missionNamespace setVariable [_squadticketID,ca_EastSquadStartingTickets, true];
missionNamespace setVariable ["ca_eastcojipid",_groupid, true];

	 };
case independent: {
_findgroup = ca_allIndependentPlayerGroups select { (groupid _x) == _groupid};
if(count _findgroup == 0) exitWith {"Warning: No CO slotted for mission!" remoteExec ["systemChat",independent];ca_IndependentJIPgroups pushBackUnique [_grouparray,_squadID];
missionNamespace setVariable ["ca_independentcojipid",_groupid, true];

};

_group = _findgroup select 0;

_group setVariable ["ca_squadID",_squadID, true];
_group setVariable ["ca_SRradioCH",_SRradioarray, true];
_group setVariable ["ca_LRradioarray",_LRradioarray, true];
missionNamespace setVariable ['ca_independentCO',_group, true]; 
_newarray = ca_allIndependentSquads pushBackUnique _squadID;
_squadticketID = format ["%1tickets",_squadID]; 
missionNamespace setVariable [_squadticketID,ca_IndependentSquadStartingTickets, true];
missionNamespace setVariable ["ca_independentcojipid",_groupid, true];

	};
default {diag_log format ["No CO for (%1)(%2)",_side,_squadID]};
};

{
	[_x,_side] spawn ca_fnc_setupSquad;
} forEach (_platoonarray select 1);