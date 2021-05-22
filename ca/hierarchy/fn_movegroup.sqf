
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
if (_rankid < ca_corank && !(serverCommandAvailable '#kick')) exitWith {systemChat "You do not have the sufficient authority to change the hierarchy!";};

if (_groupid == "Overflow/Dead") exitWith {
		systemChat "Select a real group to move to.";
};

if (isnil {ca_switchgroupthiscycle}) exitwith {
	systemChat "Select the group first!";
};

if (ca_previousgroup == ca_selectedgroup ) exitwith {
	systemChat "That is the same group!";
};

_check = ca_selectedgroup getVariable ['ca_groupsetup',false]; 

if (!_check) exitwith { systemChat "Group you are trying to pin to is not registered!"; };
if (ca_switchgroupthiscycle) then {
	_grouptomove = ca_previousgroup;

	_grouptomoveid = groupid _grouptomove;

	_newgrouplead = ca_selectedgroup;
	_newgroupleadid = ca_selectedgroupid;

	_description = "Fire team";
	_shortrangechannel = (_newgrouplead) getVariable ["ca_SRradioCH",1];
	_longrangeArray = (_newgrouplead) getVariable ["ca_LRradioarray",[1]];


	_ranklead = rankid (leader _newgrouplead);
	if (_ranklead < ca_slrank) exitWith {
		systemChat "Leader of the group is not of sufficient rank to command other units!";
	};
	if (_ranklead == ca_slrank) then {

		//[leader _grouptomove,ca_ftlrank] call ca_fnc_setrank;
		_grouptomove setVariable ["ca_superior",_newgroupleadid, true];

	};
	if (_ranklead >= ca_corank) then {
		//[leader _grouptomove,ca_slrank] call ca_fnc_setrank;
		_grouptomove setVariable ["ca_superior",_newgroupleadid, true];
		_description = "Squad";
	};

	_grouptomove setVariable ["ca_SRradioCH",_shortrangechannel, true];
	_grouptomove setVariable ["ca_LRradioarray",_longrangeArray, true];

	_name = name leader _grouptomove;
	_rank = toLower rank (leader _grouptomove);
	systemchat format ["Moved group (%1) to the command of: %2",groupid _grouptomove,groupid _newgrouplead];
	systemChat format ["Deselected %1, a %2 lead by %4 %3",_grouptomoveid,_description,_name,_rank];
	_selectedgroupcontrol ctrlSetText ("None");

	tvClear _tree;
	sleep 1;
	[] execvm 'ca\hierarchy\ca_hierarchydialogsupport.sqf';
	ca_switchgroupthiscycle = false;

} else {

	systemChat "Select the group you wish to change in the hierachy first!";

};

