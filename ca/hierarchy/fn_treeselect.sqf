params ["_groupid"];

_side = side player;

_display = findDisplay 1809;

_aliveplayers = _display displayCtrl 1812;
_deadplayers = _display displayCtrl 1813;
_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;
_sideticketcontrol = _display displayCtrl 1816;
_squadticketcontrol = _display displayCtrl 1817;



_allsquads = [];
_allplayergroups = [];
allplayergroups = [];
_co = grpNull;
_sidetickets = 0;
_squadtickets = 0;

_allWestPlayerGroupsfill = [];
_allEastPlayerGroupsfill = [];
_allIndependentPlayerGroupsfill = [];

_sidespectators = [];
_specplayers = [] call ace_spectator_fnc_players;

{
	if (side _x == west) then {_allWestPlayerGroupsfill pushBackUnique group _x};
	if (side _x == east) then {_allEastPlayerGroupsfill pushBackUnique group _x};
	if (side _x == independent) then {_allIndependentPlayerGroupsfill pushBackUnique group _x};
} forEach allunits;




switch (_side) do {
	case west: {
    _co = ca_westCO;
    _allsquads = ca_allWestSquads;
    _allplayergroups = _allWestPlayerGroupsfill;
	_sidetickets = ca_WestTickets;
	};
	case east: {
    _co = ca_eastCO;
    _allsquads = ca_allEastSquads;
    _allplayergroups = _allEastPlayerGroupsfill;
	_sidetickets = ca_EastTickets;
	};
	case independent: {
    _co = ca_independentCO;
    _allsquads = ca_allIndependentSquads;
    _allplayergroups = _allIndependentPlayerGroupsfill;
	_sidetickets = ca_IndependentTickets;
	};
};
// ---------------------------------------------------------------------
// Setup controls 
_findgroup = _allplayergroups select { (groupid _x) == _groupid};

lbClear _aliveplayers;
lbClear _deadplayers;


if(count _findgroup == 0) exitwith {
	if (_groupid == "Overflow/Missing SL") then {
			systemChat "This is the remaining groups that arent in the hierarchy for some reason, use select squad and move selected squad to place them in the hierarchy, make sure to drain any squad tickets if applicable.";
	} else {
	systemChat "Group doesnt exists in game anymore for some reason.";
	};
};
_group = _findgroup select 0;

ca_selectedgroup = _group;
ca_selectedgroupid = _groupid;

{
if (_x in _specplayers) then {
	_deadplayers lbAdd (name _x); _deadplayers lbSetData [_forEachIndex, (name _x)];	
} else {
	if (alive _x) then {

_aliveplayers lbAdd (name _x); _aliveplayers lbSetData [_forEachIndex, (name _x)];	
};

}
} forEach (units _group);


{
	_acepreviousgrouparray = _x getvariable "ace_common_previousGroupSwitchTo";
	if ((_acepreviousgrouparray select 0 select 0) == _group) then {
		_deadplayers lbAdd (name _x); _deadplayers lbSetData [_forEachIndex, (name _x)];	
	};
	
} forEach _specplayers;


_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;

_shortrangechannel = (_group) getVariable ["ca_SRradioCH",1];
_longrangeArray = (_group) getVariable ["ca_LRradioarray",[4]];

_shortrangech ctrlSetText (format ["%1",(_shortrangechannel)]);
_longrangechannels ctrlSetText (format ["%1",(_longrangeArray)]);

_aliveplayers lbSetCurSel 1;


_squadid = _group getVariable ["ca_squadID",(_co getVariable ["ca_squadID","noco"])];


_squadtickets = missionNamespace getVariable format ["%1tickets",_squadID]; 


_sideticketcontrol ctrlSetText (format ["%1 Tickets:%2",_side,_sidetickets]);
_squadticketcontrol ctrlSetText (format ["Squad Tickets:%1",(_squadtickets)]);

