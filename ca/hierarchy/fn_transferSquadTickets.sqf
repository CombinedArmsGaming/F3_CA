

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

_co = grpNull;
_squadtickets = 0;
_sidetickets = 0;
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


// ---------------------------------------------------------------------
// Get Squad ticket variables 
_squadid = _group getVariable ["ca_squadID",false];

_squadtickets = missionNamespace getVariable format ["%1tickets",_squadID]; 

_squadticketID = format ["%1tickets",_squadID]; 

if (isnil {_squadtickets}) exitWith {
	systemChat "Squad tickets are not available for selected group";
};


if ((typename _sidetickets  != "SCALAR") || typename _squadtickets != "SCALAR") exitWith {
	systemChat "Error in the ticket number!";
};

if (_sidetickets - _ticketdifference < 0) exitWith {
	systemChat "We are out of tickets!";
};

if (_squadtickets + _ticketdifference < 0) exitWith {
	systemChat "Not possible to subtract more tickets from this squad";
};

_rankid = rankid player;
_newticketnumb = 0;
_newnumber = 0;
if (group player == _co && _rankid >= ca_corank) then {

if (player distance (leader ca_selectedgroup) > ca_ticketradius) exitWith { systemChat "Selected group is too far away, you must be closer to be able to transfer tickets";};

_newnumber = _squadtickets + _ticketdifference;
	missionNamespace setVariable [_squadticketID,_newnumber, true];

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

} else {
    systemChat "You are not Authorized to do this, it can only be done by the commanding officer";
};


_sideticketcontrol ctrlSetText (format ["%1 Tickets:%2",_side,_newticketnumb]);
_squadticketcontrol ctrlSetText (format ["Squad Tickets:%1",(_newnumber)]);

