
_side = side player;

_display = findDisplay 1809;

_aliveplayers = _display displayCtrl 1812;


if (lbSize _aliveplayers < 1) exitWith {
	systemChat "No group selected or selected group has no players in it";
};


_rankid = rankId player;
_superior = group player getVariable ["ca_superior","meme"];
_samesquad = (ca_selectedgroup getVariable ["ca_superior","sdferaNO"]) == _superior;


if ((((ca_selectedgroup == (group player)) && _rankid >= ca_ftlrank) || _samesquad && _rankid >= ca_slrank) || (_rankid >= ca_corank) || (serverCommandAvailable '#kick')) then {


_index = lbCurSel _aliveplayers;
_unitname = _aliveplayers lbData _index;

_groupid = groupid ca_selectedgroup;

{
	if (name _x == _unitname) then {
		if (_x getVariable ["ca_specialistmarker",false]) exitWith {
			systemChat "Removing specialist marker";
			_x setVariable ["ca_specialistmarker",false];
		};
		if (_x == leader ca_selectedgroup) exitWith {
			systemChat "Unit is the leader of the group, use groupmarker instead";
		};
		systemChat format ["Marker assigned for: %1",_unitname];
		_x setVariable ["ca_specialistmarker",true];
		[_x] remoteExec ["ca_fnc_SpecialistMarker",_side];
	};
} forEach (units ca_selectedgroup);


} else {
    systemChat "You are not Authorized to do this, it can only be done by the commanding Fireteam, Squad or Commanding officer of sufficient rank";
};


