/*
 * Function: Setup JIP
 * If given an array by the Hierachy, find a string in element 0 and send it to fnc handlestring, else send off array to this function again.
 *
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
//If the group is already setup, then exit
if ((group player) getVariable ["ca_groupsetup",false]) exitWith {};

_side = side player;

_setupgroup = {
	params ["_groupid","_superior","_SRradioCH","_LRradioarray","_groupcolor","_grouptickets","_groupmarkerboolean","_grouptype","_side"];

	_group = group player;

	_group setVariable ["ca_groupsetup",true, true];
	_group setVariable ["ca_superior",_superior, true];
	_group setVariable ["ca_SRradioCH",_SRradioCH, true];
	_group setVariable ["ca_LRradioarray",_LRradioarray, true];
	_group setVariable ["ca_groupcolor",_groupcolor, true];
	_group setVariable ["ca_grouptickets",_grouptickets, true];
	_group setVariable ["ca_grouptype",_grouptype, true];
	_cooldowntime = ca_grouprespawncooldown + time;
	_group setVariable ["ca_grouprespawntime",_cooldowntime, true];
	_group setVariable ["ca_groupmarkerboolean",_groupmarkerboolean, true];

	//PUT IN GROUP MARKERS HERE (remoteexec becauser its server executing only)
	if (_groupmarkerboolean) then {
	_group remoteExec ["ca_fnc_groupMarker",_side,true];	
	};
};


switch (_side) do {
	case west: {
		{
			_possiblegrpid = _x select 1;
			if (_possiblegrpid == _groupid) then {

				(_x select 0) call _setupgroup;
			};
		} forEach ca_WestJIPgroups;
	};
	case east: {
		{
			_possiblegrpid = _x select 1;
			if (_possiblegrpid == _groupid) exitWith {
				(_x select 0) call _setupgroup;
			};
				

		} forEach ca_EastJIPgroups;

	};
	case independent: {
		{
			_possiblegrpid = _x select 1;
			if (_possiblegrpid == _groupid) exitWith {
				(_x select 0) call _setupgroup;
			};
		} forEach ca_IndependentJIPgroups;
	};
	default {(format ["CA hierarchy SetupJIP: Error JIP player(%1) not correctly setup side(%2), group (%3)",player, _side,_group]) remoteExec ["diag_log"]};
};

//If the group is not setup, set it up.
_setup = group player getVariable ["ca_groupsetup",false];
if (!_setup) then {
	[_group,_groupid,16,[1],"ColorGrey",0,false,"auto"] call _setupgroup;
};
(format ["CA Hierarchy SetupJIP: JIP player(%1)setup side(%2), group (%3)",player, _side,_group]) remoteExec ["diag_log"];