params ["_groupid"];

_side = side player;

_display = findDisplay 1809;

_aliveplayers = _display displayCtrl 1812;
_deadplayers = _display displayCtrl 1813;
_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;

_testsr = compile ctrlText _shortrangech;

if (lbSize _aliveplayers == 0) exitWith {systemChat "Select a group first!";};

if (isnil {_testsr}) exitWith {systemChat "Short range channel field cannot be empty!";};

_rankid = rankId player;
_superior = group player getVariable ["ca_superior","meme"];
_samesquad = (ca_selectedgroup getVariable ["ca_superior","sdferaNO"]) == _superior;


if ((((ca_selectedgroup == (group player)) && _rankid >= ca_ftlrank) || _samesquad && _rankid >= ca_slrank) || (_rankid >= ca_corank) || (serverCommandAvailable '#kick')) then {

    _playerexecuting = name player;
    [_playerexecuting, {
        params ["_whodidit"];

        _unit = player;
        _shortrangeCH = (group _unit) getVariable ["ca_SRradioCH",1];
        _longrangeArray = (group _unit) getVariable ["ca_LRradioarray",[1]];

        _presetLRArray = switch (side _unit) do {
            case blufor: {f_radios_settings_acre2_lr_groups_blufor};
            case opfor: {f_radios_settings_acre2_lr_groups_opfor};
            case independent: {f_radios_settings_acre2_lr_groups_indfor};
            default {f_radios_settings_acre2_lr_groups_blufor};
        };

        _radioSR = [f_radios_settings_acre2_standardSHRadio] call acre_api_fnc_getRadioByType;
        //Workaround if f_radios_settings_acre2_standardSHRadio = []
        if(isnil {_radioSR}) then {
        _radioSR = "";
        };
        _radiolist = [] call acre_api_fnc_getCurrentRadioList;
        _radiolist deleteAt (_radiolist find _radioSR);

        _hasSR = ((!isNil {_radioSR}) && {_radioSR != ""});

        if (_hasSR) then {
            [_radioSR, _shortrangeCH] call acre_api_fnc_setRadioChannel;
        };

        if (count _radiolist > 0) then {
            {
                        [_x, (_longrangeArray select _foreachindex)] call acre_api_fnc_setRadioChannel;
            } forEach _radiolist;
            systemChat format ["%1 has changed your 343 channel to CH%2 and your long range channels to %3 (If less LR radios, then apply from left to right)",_whodidit,_shortrangeCH,_longrangeArray];
        } else {
            systemChat format ["%1 has changed your 343 channel to CH%2",_whodidit,_shortrangeCH];
        };
        

    }] remoteExec ["call", ca_selectedgroup];


    systemChat format ["Radio channels applied to units of ",_shortrangeCH];
} else {
    systemChat "You are not Authorized to do this, it can only be done by the commanding Fireteam, Squad or Commanding officer of sufficient rank";
};
