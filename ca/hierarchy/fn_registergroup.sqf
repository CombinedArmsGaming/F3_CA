
_side = side player;

_display = findDisplay 1809;
_tree = _display displayCtrl 1811;

_aliveplayers = _display displayCtrl 1812;
_deadplayers = _display displayCtrl 1813;
_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;
_sideticketcontrol = _display displayCtrl 1816;
_squadticketcontrol = _display displayCtrl 1817;

_group = ca_selectedgroup;
_groupid = ca_selectedgroupid;




_check = ca_selectedgroup getVariable ['ca_groupsetup',false]; 


if (_check) exitWith {systemchat format ["%1 is already registered!",_groupid]};



_group setVariable ["ca_groupsetup",true, true];
_group setVariable ["ca_grouptickets",0, true];
_group setVariable ["ca_grouptype","none", true];
_cooldowntime = ca_grouprespawncooldown + time;
_group setVariable ["ca_grouprespawntime",_cooldowntime, true];

_rank = 1;
{
	if (leader _group == _x) then {
		[leader _group,_rank] spawn ca_fnc_setrank;
	};
} forEach (units _group);
//PUT IN GROUP MARKERS HERE (remoteexec becauser its server executing only)
_group remoteExec ["ca_fnc_groupMarker",_side,true];

ca_switchgroupthiscycle = true;

ca_previousgroup = _group;

ca_selectedgroup = group player;

ca_selectedgroupid = groupid group player;


[] spawn ca_fnc_movegroup;

systemChat format ["%1 is registered, don't forget to get closer and give tickets if needed",_groupid];