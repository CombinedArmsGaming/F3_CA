

params ["_ticketdifference"];

_side = side player;

_display = findDisplay 1809;

_aliveplayers = _display displayCtrl 1812;
_deadplayers = _display displayCtrl 1813;
_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;
_sideticketcontrol = _display displayCtrl 1816;
_squadticketcontrol = _display displayCtrl 1817;

_group = ca_selectedgroup;
_groupid = ca_selectedgroupid;

_squadtickets = 0;
_sidetickets = 0;
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

// ---------------------------------------------------------------------


// ---------------------------------------------------------------------
// Get group ticket variables 


_squadtickets = ca_selectedgroup getVariable "ca_grouptickets";


if (isnil {_squadtickets}) exitWith {
	systemChat "Group tickets are not available for selected group";
};

if ((typename _sidetickets  != "SCALAR") || typename _squadtickets != "SCALAR") exitWith {
	systemChat "Error in the ticket number!";
};

if (_sidetickets - _ticketdifference < 0) exitWith {
	systemChat "We are out of tickets!";
};

if (_squadtickets + _ticketdifference < 0) exitWith {
	systemChat "Not possible to subtract more tickets from this group";
};

if (!(ca_respawnmode == 3)) exitWith {systemChat "This mission doesn't use group respawn!"; _display closeDisplay 1};

_rankid = rankid player;
_newticketnumb = 0;
_newnumber = 0;
if (_rankid >= ca_corank) then {
if (ca_ticketradiusmechanic) then {
	
if (player distance (leader ca_selectedgroup) > ca_ticketradius) exitWith { 
_sideticketcontrol ctrlSetText (format ["%1 Tickets:%2",_side,_sidetickets]);
_squadticketcontrol ctrlSetText (format ["Group Tickets:%1",(_squadtickets)]);

systemChat format ["Selected group is too far away, you must be within %1 meters to be able to transfer tickets",ca_ticketradius];
};
};

_newnumber = _squadtickets + _ticketdifference;
ca_selectedgroup setVariable ["ca_grouptickets",_newnumber, true];

switch (_side) do {
	case west: {
	_newticketnumb = ca_WestTickets - _ticketdifference;
	missionNamespace setVariable ['ca_WestTickets',_newticketnumb, true]; 
	};
	case east: {
	_newticketnumb = ca_EastTickets - _ticketdifference;
	missionNamespace setVariable ['ca_EastTickets',_newticketnumb, true]; 
	};
	case independent: {
	_newticketnumb = ca_IndependentTickets - _ticketdifference;
	missionNamespace setVariable ['ca_IndependentTickets',_newticketnumb, true]; 
	};
};
_sideticketcontrol ctrlSetText (format ["%1 Tickets:%2",_side,_newticketnumb]);
_squadticketcontrol ctrlSetText (format ["%2 Tickets:%1",(_newnumber),_groupid]);

} else {
    systemChat "You are not Authorized to do this, it can only be done by the commanding officer";
};



