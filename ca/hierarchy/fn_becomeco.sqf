
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

_check = ca_selectedgroup getVariable ['ca_groupsetup',false]; 

if (!_check) then {
_group setVariable ["ca_groupsetup",true, true];
_group setVariable ["ca_grouptickets",0, true];
_group setVariable ["ca_grouptype","none", true];
_group setVariable ["ca_SRradioCH",1, true];
_group setVariable ["ca_LRradioarray",[4], true];
_group setVariable ["ca_groupcolor","b_hq", true];
_cooldowntime = ca_grouprespawncooldown + time;
_group setVariable ["ca_grouprespawntime",_cooldowntime, true];
};


[player,ca_corank] call ca_fnc_setrank;

(group player) setVariable ["ca_superior",(groupid group player), true];
[[],{ca_nocopresent = false}] remoteExec ["spawn",_side];
systemChat "You are now able to change the hierachy";
};
tvClear _tree;
sleep 1;
[] execvm 'ca\hierarchy\ca_hierarchydialogsupport.sqf';
