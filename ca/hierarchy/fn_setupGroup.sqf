/*
 * Author: Poulern
 * Third function called 
 *
 * Arguments:
 * 0: Array
 * 1: Side 
 */
params ["_grouparray","_side","_squadID"];

_groupid = _grouparray select 0;
_SRradioarray = _grouparray select 1;
_LRradioarray = [];

if(count _grouparray > 2) then {
	_LRradioarray = _grouparray select 2;

};


switch (_side) do {
case west: {
_findgroup = ca_allWestPlayerGroups select { (groupid _x) == _groupid};
if(count _findgroup == 0) exitWith {ca_WestJIPgroups pushBackUnique [_grouparray,_squadID]; };
_group = _findgroup select 0;

_group setVariable ["ca_squadID",_squadID, true];
_group setVariable ["ca_SRradioCH",_SRradioarray, true];
_group setVariable ["ca_LRradioarray",_LRradioarray, true];

};
case east: {
_findgroup = ca_allEastPlayerGroups select { (groupid _x) == _groupid};
if(count _findgroup == 0) exitWith {ca_EastJIPgroups pushBackUnique [_grouparray,_squadID]; };

_group = _findgroup select 0;

_group setVariable ["ca_squadID",_squadID, true];
_group setVariable ["ca_SRradioCH",_SRradioarray, true];
_group setVariable ["ca_LRradioarray",_LRradioarray, true];

	 };
case independent: {
_findgroup = ca_allIndependentPlayerGroups select { (groupid _x) == _groupid};
if(count _findgroup == 0) exitWith {ca_IndependentJIPgroups pushBackUnique [_grouparray,_squadID]; };

_group = _findgroup select 0;

_group setVariable ["ca_squadID",_squadID, true];
_group setVariable ["ca_SRradioCH",_SRradioarray, true];
_group setVariable ["ca_LRradioarray",_LRradioarray, true];

	};
default {diag_log format ["Error side(%1) not selected correctly setupgroup,(%2), group(%3)",_side,_squadID,_groupid]};
};

