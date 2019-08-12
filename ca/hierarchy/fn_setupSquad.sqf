/*
 * Author: Poulern
 * Second function called 
 *
 * Arguments:
 * 0: Array
 * 1: Side 
 */
params ["_squadArray","_side"];



_SLGroupID = (_squadArray select 0 select 0);

_squadID = format ["%1%2",_SLGroupID,_side];

_squadticketID = format ["%1tickets",_squadID]; 

_defaultsquadtickets = 0;

switch (_side) do {
case west: {   _newarray = ca_allWestSquads pushBackUnique _squadID; _defaultsquadtickets = ca_WestSquadStartingTickets; };
case east: { _newarray = ca_allEastSquads pushBackUnique _squadID; _defaultsquadtickets = ca_EastSquadStartingTickets; };
case independent: {_newarray = ca_allIndependentSquads pushBackUnique _squadID; _defaultsquadtickets = ca_IndependentSquadStartingTickets; };
default {diag_log format ["Error side(%1) not selected correctly setupsquad,(%2), array:%3",_side,_squadID,_squadArray]};
};

if ((count (_squadArray select 0)) > 3) then {
	_squadtickets = (_squadArray select 0 select 3);
	missionNamespace setVariable [_squadticketID,_squadtickets, true];

} else {
	missionNamespace setVariable [_squadticketID,_defaultsquadtickets, true];
};

[(_squadArray select 0),_side,_squadID] spawn ca_fnc_setupGroup;

_ftarray = (_squadArray select 1);
if (count _ftarray == 0) exitWith {};
{
	[_x,_side,_squadID] spawn ca_fnc_setupGroup;
} forEach (_squadArray select 1);


