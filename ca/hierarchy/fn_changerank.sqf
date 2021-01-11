
_side = side player;

_display = findDisplay 1809;

_aliveplayers = _display displayCtrl 1812;

_promote = _this select 0;

if (lbSize _aliveplayers < 1) exitWith {
	systemChat "No group selected or selected group has no players in it";
};


_rankid = rankId player;
_superior = group player getVariable ["ca_superior","meme"];
_samesquad = (ca_selectedgroup getVariable ["ca_superior","sdferaNO"]) == _superior;


if (( _samesquad && _rankid >= ca_slrank) || (_rankid >= ca_corank) || (serverCommandAvailable '#kick')) then {


_index = lbCurSel _aliveplayers;
_unitname = _aliveplayers lbData _index;

_groupid = groupid ca_selectedgroup;


{
	if (name _x == _unitname) then {
		_prevrank = rankid _x;

		if (_promote) then {
			if (_prevrank >= 6) exitWith {
			systemChat "Unit is  max rank!";
			};
			_newrank = _prevrank + 1;
			[_x,_newrank] call ca_fnc_setrank;
			_ranktext = "private";
			switch (_newrank) do {
				case 0: {_ranktext = "private";};
				case 1: {_ranktext = "corporal"; };
				case 2: {_ranktext = "sergeant"; };
				case 3: {_ranktext = "lieutenant"; };
				case 4: {_ranktext = "captain"; };
				case 5: {_ranktext = "major"; };
				case 6: {_ranktext = "colonel"; };
				default {_ranktext = "private"; };
			};
			systemChat format ["Promoted %1 to %2",_unitname, _ranktext];
		} else {
			if (_prevrank <= 0) exitWith {
			systemChat "Unit is lowest rank!";
			};
			_newrank = _prevrank - 1;
			[_x,_newrank] call ca_fnc_setrank;
						_ranktext = "private";
			switch (_newrank) do {
				case 0: {_ranktext = "private";};
				case 1: {_ranktext = "corporal"; };
				case 2: {_ranktext = "sergeant"; };
				case 3: {_ranktext = "lieutenant"; };
				case 4: {_ranktext = "captain"; };
				case 5: {_ranktext = "major"; };
				case 6: {_ranktext = "colonel"; };
				default {_ranktext = "private"; };
			};
			systemChat format ["Demoted %1 to %2",_unitname, _ranktext];
		};
	};
} forEach (units ca_selectedgroup);

} else {
    systemChat "You are not Authorized to do this, it can only be done by the commanding Fireteam, Squad or Commanding officer of sufficient rank";
};


