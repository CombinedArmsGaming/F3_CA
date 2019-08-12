
_side = side player;

_display = findDisplay 1809;

_aliveplayers = _display displayCtrl 1812;
_deadplayers = _display displayCtrl 1813;
_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;
_sideticketcontrol = _display displayCtrl 1816;
_squadticketcontrol = _display displayCtrl 1817;


_allsquads = [];
_allplayergroups = [];
allplayergroups = [];
_co = grpNull;
_sidetickets = 0;
_squadtickets = 0;

_sidespectators = [];
_specplayers = [] call ace_spectator_fnc_players;




switch (_side) do {
	case west: {
    _co = ca_westCO;
	_sidetickets = ca_WestTickets;
	};
	case east: {
    _co = ca_eastCO;
	_sidetickets = ca_EastTickets;
	};
	case independent: {
    _co = ca_independentCO;
	_sidetickets = ca_IndependentTickets;
	};
};

// ---------------------------------------------------------------------




_group = ca_selectedgroup;



_groupid = ca_selectedgroupid;
_numbertorespawn = lbSize _deadplayers;

if(_numbertorespawn < 1 ) exitWith {systemChat "There are currently none in the selected group to respawn, or group has not been selected"};

// ---------------------------------------------------------------------
// Get Squad ticket variables 
_squadid = _group getVariable ["ca_squadID","false"];
_owngroup = (group player) getVariable ["ca_squadID","false"];
_squadtickets = missionNamespace getVariable format ["%1tickets",_owngroup]; 


_enemiesclose = false;
_toofaraway = false;
_respawner = player;
_rankid = rankId player;
_squadid = group player getVariable ["ca_squadID","meme"];
_samesquad = (ca_selectedgroup getVariable ["ca_squadID","sdferaNO"]) == _squadid;

_allowed = (((ca_selectedgroup == (group player)) && _rankid >= ca_ftlrank) || _samesquad && _rankid >= ca_slrank) || (group player == _co && _rankid >= ca_corank) || (serverCommandAvailable '#kick');
_codead = ((leader _co) in _specplayers || (group player == _co && _rankid <= ca_corank));
if (!_allowed && !_codead && ca_selectedgroup != _co) exitWith {systemChat "You are not Authorized to do this, it can only be done by the Fireteam, Squad or Platoon officer of sufficient rank" };

if(_numbertorespawn > _squadtickets ) exitWith {systemChat "Not enough tickets to respawn the group"};

// ==================================================================
{
	if (((side (group _x)) getFriend (side (group player)) < 0.6 ) && alive _x) then {//check for enemies near player
		if (_x distance _respawner < ca_enemyradius) then {
			_enemiesclose = true;
		};
	};
}foreach allUnits;

if (_enemiesclose) exitWith {Systemchat "Enemies nearby, try again later";};

// ==================================================================

if (group player != _co) then {
_firstofficer = group player getVariable ["ca_xo","nonxcvxe"];
_backupofficer = group player getVariable ["ca_xo2","nonvxcvce"];

if (_codead) exitWith {};
if (isnil {_firstofficer} && isnil {_backupofficer} ) exitWith {Systemchat "Your commanding officer or CO has disappeared"; _toofaraway = true};
if (_firstofficer in _specplayers && !_codead) exitWith {Systemchat "Your commanding officer is dead";_toofaraway = true};
if (_respawner distance _firstofficer < ca_ticketradius && _backupofficer distance _firstofficer < ca_ticketradius) then { _toofaraway = true};

};

if (_toofaraway) exitWith {Systemchat "Your commanding officer or CO is too far away to rally that team, try again later";};

// ==================================================================
_vehiclehasnoroom = false;
if ((vehicle _respawner) != _respawner) then { 
	if ((vehicle _respawner) emptyPositions "cargo" < _numbertorespawn) then {
		_vehiclehasnoroom = true;
	};
};
if (_vehiclehasnoroom) exitWith {Systemchat "Not enough room in the vehicle to respawn, step outside or try again later";};

//Respawn the currently selected group 
// ==================================================================
_actuallyrespawned = [];
{
	_pgrp = _x getvariable "ace_common_previousGroupSwitchTo";
	_goodtorespawn = false;
	if (isnil {_pgrp}) then {
		if (group _x == ca_selectedgroup) then {
				_goodtorespawn = true;
		};
	} else {
		if ((count _pgrp) == 0) then {
			_goodtorespawn = true;
		};
		if ((_pgrp select 0 select 0) == ca_selectedgroup) then {
			_goodtorespawn = true;
		};
	};
    if(_goodtorespawn) then {
    [[player],{
		params ["_respawnerguy"];
		titleCut ["", "BLACK IN", 5];
		ca_respawnwave = true;  
		sleep 2;
		if ((vehicle _respawnerguy) != _respawnerguy) then {
			player moveincargo (vehicle _respawnerguy);
			systemchat format ["You've been respawned in %1's vehicle",(name _respawnerguy)];
		} else {
			player setpos (getPosATL  _respawnerguy);
			systemchat format ["You've been respawned at %1's position",(name _respawnerguy)];
		};
		titleCut ["", "BLACK IN", 5];
		ca_respawnwave = false; 
		}] remoteExec ['spawn',_x];
		systemchat format ["%1 has respawned at your position",(name _x)];
		_actuallyrespawned pushBackUnique _x;
    };

} forEach _specplayers;


if (count _actuallyrespawned == 0) exitWith {Systemchat "No units respawned, Ace spectator issue, find unit under overflow groups instead: Sorry Its consistently inconsistent";};

_newsquadticketnumber = _squadtickets - (count _actuallyrespawned);
_squadticketID = format ["%1tickets",_squadID]; 
missionNamespace setVariable [_squadticketID,_newsquadticketnumber, true];

_squadticketcontrol ctrlSetText (format ["Squad Tickets:%1",(_newsquadticketnumber)]);
