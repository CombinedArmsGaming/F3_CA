params ["_groupid"];

_side = side player;

_display = findDisplay 1809;

_aliveplayers = _display displayCtrl 1812;
_deadplayers = _display displayCtrl 1813;
_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;

_testsr = compile ctrlText _shortrangech;

if (lbSize _aliveplayers == 0) exitWith {systemChat "Select a group first!";};

if (isnil _testsr) exitWith {systemChat "Short range channel field cannot be empty!";};

_rankid = rankId player;
_superior = group player getVariable ["ca_superior","meme"];
_samesquad = (ca_selectedgroup getVariable ["ca_superior","sdferaNO"]) == _superior;


if ((((ca_selectedgroup == (group player)) && _rankid >= ca_ftlrank) || _samesquad && _rankid >= ca_slrank) || (_rankid >= ca_corank)) then {



	_shortrangeCH = (ca_selectedgroup) getVariable ["ca_SRradioCH",1];


    [_shortrangeCH, {
    _radioSR = [f_radios_settings_acre2_standardSHRadio] call acre_api_fnc_getRadioByType;
    [_radioSR, _this] call acre_api_fnc_setRadioChannel;
    }] remoteExec ["call", ca_selectedgroup];


    systemChat "Short range radio applied to units of the group";

} else {
    systemChat "You are not Authorized to do this, it can only be done by the commanding Fireteam, Squad or Commanding officer of sufficient rank";
};
