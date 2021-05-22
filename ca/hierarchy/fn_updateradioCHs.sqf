params ["_groupid"];

_side = side player;

_display = findDisplay 1809;

_aliveplayers = _display displayCtrl 1812;
_deadplayers = _display displayCtrl 1813;
_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;

_test = compile ctrlText _longrangechannels;
_testsr = compile ctrlText _shortrangech;

if (lbSize _aliveplayers == 0) exitWith {systemChat "Select a group first!";};

if (isnil {_test}) exitWith {systemChat "Error! Long Range channel field cannot be empty or is corrupted!";};
if (isnil {_testsr}) exitWith {systemChat "Short range channel field cannot be empty!";};

_rankid = rankId player;
_superior = group player getVariable ["ca_superior","meme"];
_samesquad = (ca_selectedgroup getVariable ["ca_superior","sdferaNO"]) == _superior;


if ((((ca_selectedgroup == (group player)) && _rankid >= ca_ftlrank) || _samesquad && _rankid >= ca_slrank) || (_rankid >= ca_corank)) then {


    _SRradioarray = call compile ctrlText _shortrangech;
    _LRradioarray = call compile ctrlText _longrangechannels;

    if ( typename _SRradioarray != "SCALAR" ) exitWith {
    systemChat "Input not accepted, must be a number from 1-256, or else it will break";
    };
    if (_SRradioarray > 256 ) exitWith {
    systemChat "Number must be from 1-256, or else it will break radio assignment";
    };
    if (typename _LRradioarray != "ARRAY" ) exitWith {
    systemChat "Input not accepted, must be a an array in the form of [1,2,3] (With square brackets!), or else it will break";
    };
    _test = _LRradioarray findIf { typename _x != "SCALAR"};
    if (_test != -1) exitWith {
    systemChat "Input not accepted, must be a an array in the form of [1,2,3] (With square brackets!), or else it will break";
    };

    systemChat "Radio Channels updated";

    ca_selectedgroup setVariable ["ca_SRradioCH",_SRradioarray, true];
    ca_selectedgroup setVariable ["ca_LRradioarray",_LRradioarray, true];

} else {
    systemChat "You are not Authorized to do this, it can only be done by the commanding Fireteam, Squad or Commanding officer of sufficient rank";
};
