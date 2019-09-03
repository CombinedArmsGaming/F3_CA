
_side = side player;

_display = findDisplay 1809;
_tree = _display displayCtrl 1811;

_aliveplayers = _display displayCtrl 1812;
_deadplayers = _display displayCtrl 1813;
_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;
_sideticketcontrol = _display displayCtrl 1816;
_squadticketcontrol = _display displayCtrl 1817;


if(isnil {ca_nocopresent}) exitwith {systemChat "There is a co already!"};

if (ca_nocopresent) then {

[player,ca_corank] call ca_fnc_setrank;
[[],{ca_nocopresent = false}] remoteExec ["spawn",_side];
systemChat "You are now able to change the hierachy";
};
