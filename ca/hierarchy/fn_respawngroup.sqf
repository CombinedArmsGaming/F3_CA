

// Find the controls and variables to edit/get data from 
// ==================================================================

_side = side player;

_display = findDisplay 1809;

_aliveplayers = _display displayCtrl 1812;
_deadplayers = _display displayCtrl 1813;
_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;
_sideticketcontrol = _display displayCtrl 1816;
_squadticketcontrol = _display displayCtrl 1817;

// Setup variables used in the script  
// ==================================================================
_allsquads = [];
_allplayergroups = [];
_sidetickets = 0;
_squadtickets = 0;

_sidespectators = [];
_specplayers = [] call ace_spectator_fnc_players;


// Setup variables unique to the side 
// ==================================================================

switch (_side) do {
	case west: {
	_sidetickets = ca_WestTickets;
	};
	case east: {
	_sidetickets = ca_EastTickets;
	};
	case independent: {
	_sidetickets = ca_IndependentTickets;
	};
};

// Get the group variables and number of people to respawn.
// ==================================================================

_group = ca_selectedgroup;
_groupid = ca_selectedgroupid;
_numbertorespawn = lbSize _deadplayers;

if(_numbertorespawn < 1 ) exitWith {systemChat "There are currently none in the selected group to respawn, or group has not been selected"};

if (ca_respawnmode < 3 && !(serverCommandAvailable '#kick')) exitWith {systemChat "This mission does not allow group respawn!"; _display closeDisplay 1};

// Check if group is available to respawn 
// ==================================================================

_respawntime = _group getVariable ["ca_grouprespawntime",900000];

_infotime = ceil (_respawntime - time);
if (_infotime > 90000) exitWith {systemChat format ["Group is not registered, and thus cant be respawned",_groupid] };

if (_respawntime > time && !(serverCommandAvailable '#kick')) exitWith {systemChat format ["Group respawn is not ready yet, please wait %1 Seconds",_infotime] };


// Get Group ticket variables 
// ==================================================================
_squadtickets = _group getVariable "ca_grouptickets";
_rankid = rankId player;
_superior = group player getVariable ["ca_superior","meme"];
_samesquad = (ca_selectedgroup getVariable ["ca_superior","sdferaNO"]) == _superior;

// Setup a check if the player can respawn this group 
_allowed = (((ca_selectedgroup == (group player)) && _rankid >= ca_ftlrank) || _samesquad && _rankid >= ca_slrank) || (_rankid >= ca_corank) || (serverCommandAvailable '#kick');

if (!_allowed) exitWith {systemChat "You are not Authorized to do this, it can only be done by leaders of sufficient rank" };

// if out of tickets then exit 
if(_squadtickets == 0 && !(serverCommandAvailable '#kick')) exitWith {systemChat "No more group tickets remaining for that group, get more from CO"};
//If less tickets than dead then set the amount to be respawned to less 
if (ca_respawnmode == 3) then {
	if(_numbertorespawn > _squadtickets ) then {
	_overflow = _squadtickets - _numbertorespawn;

	_numbertorespawn = _numbertorespawn + _overflow;
	systemChat format ["Not enough tickets to respawn the whole group, respawning %1 units instead",_numbertorespawn];
};

} else {
	if(_numbertorespawn > _sidetickets ) then {
	_overflow = _sidetickets - _numbertorespawn;

	_numbertorespawn = _numbertorespawn + _overflow;
	systemChat format ["Not enough tickets to respawn the whole group, respawning %1 units instead",_numbertorespawn];
};

};
//Setup if check variables
_enemiesclose = false;
_toofaraway = false;
_respawner = player;

// Check for enemies near player
// ==================================================================
{
	if (((side (group _x)) getFriend (side (group player)) < 0.6 ) && alive _x && !(serverCommandAvailable '#kick')) then {//check for enemies near player
		if (_x distance _respawner < ca_enemyradius) then {
			_enemiesclose = true;
		};
	};
} foreach allUnits;

if (_enemiesclose) exitWith {Systemchat "Enemies nearby, try again later";};

// ==================================================================
/*
if (group player != _co) then {
_firstofficer = group player getVariable ["ca_xo","nonxcvxe"];

if (_codead) exitWith {};
if (isnil {_firstofficer} && isnil {_backupofficer} ) exitWith {Systemchat "Your commanding officer or CO has disappeared"; _toofaraway = true};
if (_firstofficer in _specplayers && !_codead) exitWith {Systemchat "Your commanding officer is dead";_toofaraway = true};
if (_respawner distance _firstofficer < ca_ticketradius && _backupofficer distance _firstofficer < ca_ticketradius) then { _toofaraway = true};

};

if (_toofaraway) exitWith {systemChat format ["Your commanding officer or CO must be within %1 meters to rally that team, try again later",ca_ticketradius];};
*/

// Check if vehicle player is in has room 
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
	//Get the original group of the player from the player
	_pgrp = _x getvariable ["ca_originalgroup",grpnull];
	_goodtorespawn = false;
	if (isnull _pgrp) then {
		if (group _x == ca_selectedgroup) then {
				_goodtorespawn = true;
		};
	} else {
		if (_pgrp == ca_selectedgroup) then {
			_goodtorespawn = true;
		};
	};
	//If more to respawn than this then exit
	if ((count _actuallyrespawned) == _numbertorespawn) then {
		_goodtorespawn = false;
	};
	// Don't respawn people who are unconcious. Might possibly respawn zeus, but camera should be instantly moved anyways based on experience.
	if !(isObjectHidden _x) then {
		_goodtorespawn = false;
	};
    if(_goodtorespawn) then {
		_actuallyrespawned pushBackUnique _x;
    [[player],{
		params ["_respawnerguy"];
		titleCut ["", "BLACK OUT", 0.1];
		sleep 2;
		ca_respawnwave = true;  
		sleep 5;
		if ((vehicle _respawnerguy) != _respawnerguy) then {
			sleep random 5;
			player moveincargo (vehicle _respawnerguy);
			systemchat format ["You've been respawned in %1's vehicle",(name _respawnerguy)];
		} else {
			player setposASL (getPosASL  _respawnerguy);
			systemchat format ["You've been respawned at %1's position",(name _respawnerguy)];
		};
		titleCut ["", "BLACK IN", 5];
		sleep 10;
		ca_respawnwave = false; 
		}] remoteExec ['spawn',_x];
		systemchat format ["%1 has respawned at your position",(name _x)];
    };

} forEach _specplayers;

//Reset group respawn
_group setVariable ["ca_groupspectatebool",true, true];	

//Deduct tickets based on mode 
if (count _actuallyrespawned == 0) exitWith {Systemchat "No units respawned, please take a screenshot and bugreport to github/discord";};
_newsquadticketnumber = _squadtickets - (count _actuallyrespawned);
if (ca_respawnmode == 3) then {
_group setVariable ["ca_grouptickets",_newsquadticketnumber, true];	
} else {
missionNamespace setVariable [_sidetickets,(count _actuallyrespawned), true]; 
};

_squadticketcontrol ctrlSetText (format ["Group Tickets:%1",(_newsquadticketnumber)]);
