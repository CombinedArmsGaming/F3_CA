
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

if (_groupid == "Overflow/Dead") exitWith {
		systemChat "Select a real group to register.";
};

if (_check) exitWith {systemchat format ["%1 is already registered!",_groupid]};



_group setVariable ["ca_groupsetup",true, true];
_group setVariable ["ca_grouptickets",0, true];
_group setVariable ["ca_grouptype","auto", true];
_group setVariable ["ca_SRradioCH",1, true];
_group setVariable ["ca_LRradioarray",[1], true];
_group setVariable ["ca_groupcolor","ColorWhite", true];
_cooldowntime = ca_grouprespawncooldown + time;
_group setVariable ["ca_grouprespawntime",_cooldowntime, true];
_group setVariable ["ca_superior",_groupid, true];
_group setVariable ["ca_groupmarkerboolean",true, true];




systemChat format ["%1 is registered, remember to set rank and give tickets if needed",_groupid];
tvClear _tree;
sleep 1;
[] execvm 'ca\hierarchy\ca_hierarchydialogsupport.sqf';
