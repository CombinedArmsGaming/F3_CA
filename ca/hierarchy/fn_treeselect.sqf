/*
 * F3_CA Hierarchy
 * Function: Tree select
 * When pressing an element in the tree view, fill in the relevant boxes on the hierarchy interface.
 * 
 * Not called on opening the interface
*/

// Get input from hierachydialogsupport
params ["_groupid"];

//Standard setup, find side, controls and displays to fill in with data
_side = side player;

_display = findDisplay 1809;

_aliveplayers = _display displayCtrl 1812;
_deadplayers = _display displayCtrl 1813;
_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;
_sideticketcontrol = _display displayCtrl 1816;
_squadticketcontrol = _display displayCtrl 1817;
_selectedgroupcontrol = _display displayCtrl 1818;
_superiorgroupcontrol = _display displayCtrl 1819;
_grouprespawntimer = _display displayCtrl 1820;



// In order for the menu to feel dynamically we need to regenerate the list of units every time an item in the hierarchy is selected (which runs this function)

_allplayergroups = [];

_sidetickets = 0;
_squadtickets = 0;

_allWestPlayerGroupsfill = [];
_allEastPlayerGroupsfill = [];
_allIndependentPlayerGroupsfill = [];

_sidespectators = [];
_specplayers = [] call ace_spectator_fnc_players;

{
	if (side group _x == west) then {_allWestPlayerGroupsfill pushBackUnique group _x};
	if (side group _x == east) then {_allEastPlayerGroupsfill pushBackUnique group _x};
	if (side group _x == independent) then {_allIndependentPlayerGroupsfill pushBackUnique group _x};
} forEach allunits;



// In theory potential for (client side) optimalzation by moving above block into below switch statement 
// However it doesn't generate network traffic (allunits is synched anyways) and from testing during heavy events no loading issues were found 
switch (_side) do {
	case west: {
    _allplayergroups = _allWestPlayerGroupsfill;
	_sidetickets = ca_WestTickets;
	};
	case east: {
    _allplayergroups = _allEastPlayerGroupsfill;
	_sidetickets = ca_EastTickets;
	};
	case independent: {
    _allplayergroups = _allIndependentPlayerGroupsfill;
	_sidetickets = ca_IndependentTickets;
	};
};
// ---------------------------------------------------------------------
// Setup controls 

// After generating all groups and filtering into sides and such, match the groupID with the group ingame (GroupID is unique to side).
_findgroup = _allplayergroups select { (groupid _x) == _groupid};
// Clear the alive/dead panels from the previously selected group 
lbClear _aliveplayers;
lbClear _deadplayers;

// Display explanation message if Overflow/Dead is hit 
if(count _findgroup == 0) exitwith {
	if (_groupid == "Overflow/Dead") then {
			systemChat "This is the remaining groups that arent in the hierarchy because they don't have a superior, register if necessary, then use select group and assign subgroup to place them in the hierarchy.";
		ca_selectedgroup = group player;
		ca_selectedgroupid = "Overflow/Dead";
	} else {
	systemChat "Group doesnt exists in game anymore or is bugged.";
	};
};

// Setup global variables to make it easier for the other functions to have a common group 
_group = _findgroup select 0;

ca_selectedgroup = _group;
ca_selectedgroupid = _groupid;

// Setup dead groups.
{
	if (_x in _specplayers and (isObjectHidden _x)) then {
		_deadplayers lbAdd (name _x); _deadplayers lbSetData [_forEachIndex, (name _x)];	
	} else {
		if (alive _x) then {
			_aliveplayers lbAdd (name _x); _aliveplayers lbSetData [_forEachIndex, (name _x)];	
		};
	}
} forEach (units _group);


// Setup various controls for display radiochannel, tickets etc.

_shortrangech = _display displayCtrl 1814;
_longrangechannels = _display displayCtrl 1815;

_shortrangechannel = (_group) getVariable ["ca_SRradioCH",1];
_longrangeArray = (_group) getVariable ["ca_LRradioarray",[1]];

_shortrangech ctrlSetText (format ["%1",(_shortrangechannel)]);
_longrangechannels ctrlSetText (format ["%1",(_longrangeArray)]);

_aliveplayers lbSetCurSel 1;


_squadtickets = _group getVariable ["ca_grouptickets","Not registered!"];




_sideticketcontrol ctrlSetText (format ["%1 Tickets: %2",_side,_sidetickets]);
_squadticketcontrol ctrlSetText (format ["%2 Tickets: %1",(_squadtickets),_groupid]);


_superiorgroupcontrol ctrlSetText (format ["%1",(ca_selectedgroup getVariable ["ca_superior","None"])]);

// Calculate respawn time (group respawn)
_respawntime = _group getVariable ["ca_grouprespawntime",900000];

_infotime = ceil (_respawntime - time);
if (lbSize _deadplayers == 0 || _infotime > 90000 || ca_respawnmode < 3 || (_infotime < 1)) then {
	_grouprespawntimer ctrlSetText (format ["%1 is ready to respawn!",_groupid]);
} else {
	_grouprespawntimer ctrlSetText (format ["%2 can deploy in about %1 sec",(_infotime),_groupid]);
};

// Pinned group controller
if (isnil {ca_switchgroupthiscycle}) then {
	_selectedgroupcontrol ctrlSetText ("None");
	} else {
	if (ca_switchgroupthiscycle ) then {

		_selectedgroupcontrol ctrlSetText (format ["%1",(groupid ca_previousgroup)]);

	} else {
		_selectedgroupcontrol ctrlSetText ("None");
	};	
};
