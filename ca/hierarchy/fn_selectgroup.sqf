
_side = side player;

_display = findDisplay 1809;
_tree = _display displayCtrl 1811;

_aliveplayers = _display displayCtrl 1812;
_deadplayers = _display displayCtrl 1813;
_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;
_sideticketcontrol = _display displayCtrl 1816;
_squadticketcontrol = _display displayCtrl 1817;
_selectedgroupcontrol = _display displayCtrl 1818;


_group = ca_selectedgroup;
_groupid = ca_selectedgroupid;


// ---------------------------------------------------------------------
_rankid = rankid player;
if (_rankid < ca_corank) exitWith {systemChat "You do not have the sufficient authority to change the hierarchy!";};


if (isnil {ca_switchgroupthiscycle}) then {
	ca_switchgroupthiscycle = false;
};


if (ca_switchgroupthiscycle) then {

	ca_switchgroupthiscycle = false;
_rankid = rankid (leader ca_previousgroup);
_name = name (leader ca_previousgroup);
_rank = toLower rank (leader ca_previousgroup);
	_description = "Fire Team";
if (_rankid >= ca_ftlrank) then {
	_description = "Fire Team";
};
if (_rankid >= ca_slrank) then {
	_description = "Squad";
};
if (_rankid >= ca_corank) then {
	_description = "Platoon";
};

_groupid = groupid ca_previousgroup;
systemChat format ["Deselected %1, a %2 lead by %4 %3",_groupid,_description,_name,_rank];

_selectedgroupcontrol ctrlSetText ("None");

} else {
ca_previousgroup = ca_selectedgroup;

_rankid = rankid (leader ca_selectedgroup);
_name = name (leader ca_selectedgroup);
_rank = toLower rank (leader ca_selectedgroup);
	_description = "Fire Team";
if (_rankid >= ca_ftlrank) then {
	_description = "Fire Team";
};
if (_rankid >= ca_slrank) then {
	_description = "Squad";
};
if (_rankid >= ca_corank) then {
	_description = "Platoon";
};

_groupid = groupid ca_selectedgroup;
systemChat format ["Selected %1, a %2 lead by %4 %3",_groupid,_description,_name,_rank];

ca_switchgroupthiscycle = true;
_selectedgroupcontrol ctrlSetText (format ["%1",(_groupid)]);

};

