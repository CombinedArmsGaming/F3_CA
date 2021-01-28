
_side = side player;

if (count _this > 0) then {
    _side = _this select 0;
};
_isadmin = serverCommandAvailable '#kick';


if ( ((ca_respawnmode == 0) || !ca_respawnready) && !_isadmin) exitWith {
    if (!ca_respawnready) then {
        systemChat "HQ to command: Reinforcements are not ready to deploy yet!";
    } else {
        systemChat "HQ to command: Respawn is disabled for this mission!";
    };
};


if((rankid player < ca_corank) && !_isadmin) exitWith {systemchat 'You are not high enough rank to call in reinforcements'};
_respawner = player;
_enemiesclose = false;


_listplayers = []; // List of players to respawn per side 
_specplayers = [] call ace_spectator_fnc_players; // List of players currently in spectate 
_allWestPlayerGroupsfill = []; //Filter 
_allEastPlayerGroupsfill = [];
_allIndependentPlayerGroupsfill = [];
{
    if (side _x == west && (isObjectHidden _x)) then {_allWestPlayerGroupsfill pushBackUnique _x};
    if (side _x == east && (isObjectHidden _x)) then {_allEastPlayerGroupsfill pushBackUnique _x};
    if (side _x == independent && (isObjectHidden _x)) then {_allIndependentPlayerGroupsfill pushBackUnique _x};
} forEach _specplayers;

_sidetickets = ca_WestTickets;
switch (_side) do {
    case west: {
    _listplayers = _allWestPlayerGroupsfill;
    _sidetickets = ca_WestTickets;
    };
    case east: {
    _listplayers = _allEastPlayerGroupsfill;
    _sidetickets = ca_EastTickets;
    };
    case independent: {
    _listplayers = _allIndependentPlayerGroupsfill;
    _sidetickets = ca_IndependentTickets;
    };
};
_numbertorespawn = count _listplayers;
//=================================================================

{
	if ((((side (group _x)) getFriend (side (group player)) < 0.6 ) && alive _x) && !_isadmin) then {//check for enemies near player
		if (_x distance _respawner < ca_enemyradius) then {
			_enemiesclose = true;
		};
	};
} foreach allUnits;

if (_enemiesclose) exitWith {Systemchat "Enemies nearby, try again later";};
//=================================================================
// ==================================================================
_vehiclehasnoroom = false;
if ((vehicle _respawner) != _respawner) then { 
	if ((vehicle _respawner) emptyPositions "cargo" < _numbertorespawn) then {
		_vehiclehasnoroom = true;
	};
};
if (_vehiclehasnoroom) exitWith {Systemchat "Not enough room in the vehicle to respawn, step outside or try again later";};

//Sort players to respawn 
// ==================================================================

if (_sidetickets < (count _listplayers) && !_isadmin) exitWith {Systemchat "Not enough tickets to respawn!";};
//============================================
_actuallyrespawned = [];
if (ca_respawnmode == 2 || ca_respawnmode == 3) then {
{
    [[player],{
		params ["_respawnerguy"];
		cutText ["","BLACK OUT",0.1];
        sleep 2;
		ca_respawnwave = true;  
		sleep 2;
		if ((vehicle _respawnerguy) != _respawnerguy) then {
            player setposASL (getPosASL _respawnerguy);
            sleep random 5;
			player moveincargo (vehicle _respawnerguy);
			systemchat format ["You've been respawned in %1's vehicle",(name _respawnerguy)];
		} else {
			player setposASL (getPosASL  _respawnerguy);
			systemchat format ["You've been respawned at %1's position",(name _respawnerguy)];
		};
        player action ["WeaponOnBack", player];
		cutText ["", "BLACK IN", 5];
        sleep 10;
        ca_respawnwave = false; 
		}] remoteExec ['spawn',_x];
		systemchat format ["%1 has respawned at your position",(name _x)];
		_actuallyrespawned pushBackUnique _x;

} forEach _listplayers;
};

//======================================
if (ca_respawnmode == 1) then {
{
    [[player],{
		params ["_respawnerguy"];
        _respawnmarker = "";
        _side = side player;
    switch (_side) do {
        case west: {
        _respawnmarker = "respawn_west";
        };
        case east: {
        _respawnmarker = "respawn_east";
        };
        case independent: {
        _respawnmarker = "respawn_guerrila";
        };
    };

    cutText ["","BLACK OUT",0.1];
    sleep 2;
    ca_respawnwave = true;  
    sleep 2;
    player action ["WeaponOnBack", player];
    player setposASL (getMarkerPos [_respawnmarker, true]);

    systemchat format ["You've been respawned at %1's base",(_side)];

    cutText ["", "BLACK IN", 5];
    sleep 10;
    ca_respawnwave = false; 
    }] remoteExec ['spawn',_x];
    systemchat format ["%1 has respawned at your base",(name _x)];
    _actuallyrespawned pushBackUnique _x;

} forEach _listplayers;

};

if (count _actuallyrespawned == 0) exitWith {Systemchat "No units were respawned!";};

_newsquadticketnumber = _sidetickets - (count _actuallyrespawned);

if (!_isadmin) then {
    switch (_side) do {
        case west: {
        missionNamespace setVariable ['ca_WestTickets',_newsquadticketnumber, true]; 
        };
        case east: {
        missionNamespace setVariable ['ca_WestTickets',_newsquadticketnumber, true]; 
        };
        case independent: {
        missionNamespace setVariable ['ca_IndependentTickets',_newsquadticketnumber, true]; 
        };
    };
};


//=====================================================================

[] spawn {
// Set variables so it cannot be spammed
missionNamespace setVariable ['ca_respawnready',false, true];
// Post message letting everyone know there is a wave on.

//Let the wave last for 60 seconds just incase anyone dies etc.
_time = time;
missionNamespace setVariable ['ca_respawntime',_time, true]; // For the countdown on the respawn panel.
sleep ca_wavetime;
missionNamespace setVariable ['ca_respawnwave',false, true];
sleep ca_wavecooldown;
missionNamespace setVariable ['ca_respawnready',true, true];
};
