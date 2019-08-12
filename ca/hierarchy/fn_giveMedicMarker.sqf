
_side = side player;

_display = findDisplay 1809;

_aliveplayers = _display displayCtrl 1812;


if (lbSize _aliveplayers < 1) exitWith {
	systemChat "No group selected or selected group has no players in it";
};

_rankid = rankId player;
_squadid = group player getVariable ["ca_squadID","meme"];
_samesquad = (ca_selectedgroup getVariable ["ca_squadID","sdferaNO"]) == _squadid;
_co = grpNull;
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

if (((ca_selectedgroup == (group player)) && _rankid >= ca_ftlrank) || (_samesquad && _rankid >= ca_slrank) || (group player == _co && _rankid >= ca_corank)) then {


_index = lbCurSel _aliveplayers;
_unitname = _aliveplayers lbData _index;

_groupid = groupid ca_selectedgroup;


{
	if (name _x == _unitname) then {
		if (_x == leader ca_selectedgroup) exitWith {
			systemChat "Unit is the leader of the group, use groupmarker instead";
		};
		systemChat format ["Marker assigned for: %1",_unitname];
		[(str _x),"b_med", format ["%1 M",_groupid], "ColorBlack"] remoteExec ["f_fnc_localSpecialistMarker",_side];
	};
} forEach (units ca_selectedgroup);



} else {
    systemChat "You are not Authorized to do this, it can only be done by the commanding Fireteam, Squad or Commanding officer of sufficient rank";
};


