
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



_co = grpNull;
switch (_side) do {
	case west: {
    _co = ca_westCO;
	};
	case east: {
    _co = ca_eastCO;
	};
	case independent: {
    _co = ca_independentCO;
	};
};

// ---------------------------------------------------------------------
_rankid = rankid player;
if (_rankid < ca_corank) exitWith {systemChat "You do not have the sufficient authority to change the hierarchy!";};


if (isnil {ca_switchgroupthiscycle}) exitwith {
	systemChat "Select the group first!";
};
if (ca_previousgroup == _co ) exitwith {
	systemChat "That is the CO, do you want to break things?!";
};


if (ca_previousgroup == ca_selectedgroup ) exitwith {
	systemChat "That is the same group!";
};

if (ca_switchgroupthiscycle) then {
	_grouptomove = ca_previousgroup;

	_grouptomoveid = groupid _grouptomove;

	_newgrouplead = ca_selectedgroup;
	_newgroupleadid = ca_selectedgroupid;

	_shortrangechannel = (_newgrouplead) getVariable ["ca_SRradioCH",1];
	_longrangeArray = (_newgrouplead) getVariable ["ca_LRradioarray",[4]];
	_squadID = _newgrouplead getVariable ["ca_squadID",format ["%1%2",(groupid _newgrouplead),_side]];

	_ranklead = rankid (leader _newgrouplead);
	if (_ranklead < ca_slrank) exitWith {
		systemChat "Leader of the group is not of sufficient rank to command other units!";
	};
	if (_ranklead == ca_slrank) then {

		_ranktogive = "";
		switch (ca_ftlrank) do {
			case 1: { _ranktogive = "CORPORAL" };
			case 2: { _ranktogive = "SERGEANT"};
			case 3: { _ranktogive = "LIEUTENANT"};
			case 4: { _ranktogive = "CAPTAIN"};
			case 5: { _ranktogive = "MAJOR"};
			case 6: { _ranktogive = "COLONEL"};
		};


		(leader _grouptomove) setUnitRank _ranktogive;
		_grouptomove setVariable ["ca_squadID",_squadID, true];

	};
	if (_ranklead >= ca_corank) then {
		_ranktogive = "";
		switch (ca_slrank) do {
			case 1: { _ranktogive = "CORPORAL" };
			case 2: { _ranktogive = "SERGEANT"};
			case 3: { _ranktogive = "LIEUTENANT"};
			case 4: { _ranktogive = "CAPTAIN"};
			case 5: { _ranktogive = "MAJOR"};
			case 6: { _ranktogive = "COLONEL"};
		};
	(leader _grouptomove) setUnitRank _ranktogive;
	_newsquadID = format ["%1%2",(groupid _grouptomove),_side];

	_grouptomove setVariable ["ca_squadID",_newsquadID, true];
	_squadticketID = format ["%1tickets",_newsquadID]; 
	missionNamespace setVariable [_squadticketID,0, true];


	};

	_grouptomove setVariable ["ca_SRradioCH",_shortrangechannel, true];
	_grouptomove setVariable ["ca_LRradioarray",_longrangeArray, true];

	systemchat format ["Moved group (%1) to the command of: %2",groupid _grouptomove,groupid _newgrouplead];
	tvClear _tree;

	[] execvm 'ca\hierarchy\ca_hierarchydialogsupport.sqf';
	ca_switchgroupthiscycle = false;

} else {

	ca_previousgroup = ca_selectedgroup;
	systemChat "Select the group you wish to change in the hierachy first!";
	ca_switchgroupthiscycle = true;

};

