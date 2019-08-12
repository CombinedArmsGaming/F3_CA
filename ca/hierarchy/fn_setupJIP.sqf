/*
 * Author: Poulern
 * If given an array by the Hierachy, find a string in element 0 and send it to fnc handlestring, else send off array to this function again.
 *
 * Arguments:
 * 0: Array
 * 
 *
 * Example:
 * 
	["AV", 1,[1],west,"ASLWEST"] spawn ca_fnc_setupGroup;
 *
 */
if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player; !isnil {ca_platoonsetup};};
};
sleep 10;
_unit = player;
_group = group player;
_groupid = groupid (group player);
_possiblesquadid = (group player) getVariable ["ca_squadID",[]];
_side = side player;

switch (_side) do {
	case west: {
		if (_possiblesquadid in ca_allWestSquads) exitWith {};
		{
			_comparegroupid = "";
			_comparegroupid = _x select 0 select 0;
			if (_groupid == _comparegroupid) then {
				_grouparray = _x select 0;
				_squadID = _x select 1;

				_groupid = _grouparray select 0;
				_SRradioarray = _grouparray select 1;
				_LRradioarray = [];
				if(count _grouparray > 2) then {_LRradioarray = _grouparray select 2;};
				_group setVariable ["ca_squadID",_squadID, true];
				_group setVariable ["ca_SRradioCH",_SRradioarray, true];
				_group setVariable ["ca_LRradioarray",_LRradioarray, true];
				if (isnil {ca_westcojipid} ) exitWith {};
				if (ca_westcojipid == _groupid) then {missionNamespace setVariable ['ca_westCO',_group, true];};
				_squadticketID = format ["%1tickets",_squadID]; 
				missionNamespace setVariable [_squadticketID,ca_WestSquadStartingTickets, true];
				
			};
		} forEach ca_WestJIPgroups;
	};
	case east: {
		if (_possiblesquadid in ca_allEastSquads) exitWith {};
		{
			_comparegroupid = "";
			_comparegroupid = _x select 0 select 0;
			if (_groupid == _comparegroupid) then {
				_grouparray = _x select 0;
				_squadID = _x select 1;

				_groupid = _grouparray select 0;
				_SRradioarray = _grouparray select 1;
				_LRradioarray = [];
				if(count _grouparray > 2) then {_LRradioarray = _grouparray select 2;};
				_group setVariable ["ca_squadID",_squadID, true];
				_group setVariable ["ca_SRradioCH",_SRradioarray, true];
				_group setVariable ["ca_LRradioarray",_LRradioarray, true]; 
				if (isnil {ca_eastcojipid} ) exitWith {};
				if (ca_eastcojipid == _groupid) then {missionNamespace setVariable ['ca_eastCO',_group, true];};
				_squadticketID = format ["%1tickets",_squadID]; 
				missionNamespace setVariable [_squadticketID,ca_EastSquadStartingTickets, true];
				_squadticketID = format ["%1tickets",_squadID]; 
				missionNamespace setVariable [_squadticketID,ca_IndependentSquadStartingTickets, true];
			};
		} forEach ca_EastJIPgroups;

	};
	case independent: {
		if (_possiblesquadid in ca_allIndependentSquads) exitWith {};
		{
			_comparegroupid = "";
			_comparegroupid = _x select 0 select 0;
			if (_groupid == _comparegroupid) then {
				_grouparray = _x select 0;
				_squadID = _x select 1;

				_groupid = _grouparray select 0;
				_SRradioarray = _grouparray select 1;
				_LRradioarray = [];
				if(count _grouparray > 2) then {_LRradioarray = _grouparray select 2;};
				_group setVariable ["ca_squadID",_squadID, true];
				_group setVariable ["ca_SRradioCH",_SRradioarray, true];
				_group setVariable ["ca_LRradioarray",_LRradioarray, true];
				if (isnil {ca_independentcojipid} ) exitWith {};
				if (ca_independentcojipid == _groupid) then {missionNamespace setVariable ['ca_independentCO',_group, true];};
			};
		} forEach ca_IndependentJIPgroups;
	};
	default {diag_log format ["Error JIP player(%1) not correctly setup side(%2), group (%3)",player, _side,_group]};
};

diag_log format [" JIP player(%1)setup side(%2), group (%3)",player, _side,_group];