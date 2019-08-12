// CA - Filling listbox for the ca marker management system.
/*
things for the hierarchy dialog: 
1. SET: LONG RANGE CHS 
2. SET: SHORT RANGE CHANNELS 
3. REGISTER your squad 
3a. CHANGE group (for co? Only FTLS? SLs? Either or?) in hierarchy
3b promote group to squad (and promote leader to SL)
4. give local marker to invididual units like medics or pilots 
5. Respawn a dead group
5a. show a list of dead PLAYERS
6. show a list of the players in a group 
*/
disableSerialization;
_display = findDisplay 1809;
_tree = _display displayCtrl 1811;
_side = side player;

_allsquads = [];
_allplayergroups = [];
allplayergroups = [];
_co = grpNull;


if(isnil {ca_platoonsetup}) exitwith {systemChat "Hierarchy setup is not done yet, try again"; _display closeDisplay 1};

_findcolor = {
    params ["_input"];  
    _output = [];  
{ 
 _colour = getArray (_x >> "color") call BIS_fnc_colorConfigToRGBA;  
 _colourName = configName _x;  
 _output = _output + [_colourName,_colour];  
} forEach configProperties [configFile >> "CfgMarkerColors"];  
 
_colorpos = _output find _input; 
 
_rgbarray = _output select _colorpos+1; 
 
_rgbarray
}; 

_allWestPlayerGroupsfill = [];
_allEastPlayerGroupsfill = [];
_allIndependentPlayerGroupsfill = [];

_specplayers = [] call ace_spectator_fnc_players;

{
	if (side _x == west) then {_allWestPlayerGroupsfill pushBackUnique group _x};
	if (side _x == east) then {_allEastPlayerGroupsfill pushBackUnique group _x};
	if (side _x == independent) then {_allIndependentPlayerGroupsfill pushBackUnique group _x};
} forEach allunits;
_noco = false;

switch (_side) do {
	case west: {
    if (isnil {ca_westCO}) then { _noco = true;} else {_co = ca_westCO; };
    _allsquads = ca_allWestSquads;
    _allplayergroups = _allWestPlayerGroupsfill;
	};
	case east: {
    
    if (isnil {ca_eastCO}) then { _noco = true;} else {_co = ca_eastCO; };
    _allsquads = ca_allEastSquads;
    _allplayergroups = _allEastPlayerGroupsfill;
	};
	case independent: {
    
    if (isnil {ca_independentCO}) then { _noco = true;} else {_co = ca_independentCO; };
    _allsquads = ca_allIndependentSquads;
    _allplayergroups = _allIndependentPlayerGroupsfill;
	};
};

_allSLgroups = [];
_allFTLgroups = [];
_overflow = [];
{
    _d = _x getVariable ["ca_squadID",[]];
    if (typename _d == "ARRAY") then {
        _overflow pushBackUnique _x;
    }else
    {
            _rankid = (rankid leader _x);
        if (_rankid == ca_slrank) then {
            _allSLgroups pushBackUnique _x;
        };
        if (_rankid == ca_ftlrank) then {
            _allFTLgroups pushBackUnique _x;
        };
        if ((_rankid > ca_slrank) && (_x == _co)) then {
            _overflow pushBackUnique _x;
        };
        if ((_rankid < ca_ftlrank) && (_x == _co)) then {
            _overflow pushBackUnique _x;
        };

    };
} forEach _allplayergroups;


if (_noco) then {
    _co = _allSLgroups select 0;

    switch (_side) do {
        case west: {
        ca_westCO = _co;
        missionNamespace setVariable ['ca_westCO',_co, true];
        };
        case east: {
        ca_eastCO = _co;
        missionNamespace setVariable ['ca_eastCO',_co, true];
        };
        case independent: {
        ca_independentCO = _co;
        missionNamespace setVariable ['ca_independentCO',_co, true];
        };
    };
    systemChat format ["Until CO JIPs, %1 will be considered CO",_co];
        _ranktogive = "";
    switch (ca_corank) do {
        case 1: { _ranktogive = "CORPORAL" };
        case 2: { _ranktogive = "SERGEANT"};
        case 3: { _ranktogive = "LIEUTENANT"};
        case 4: { _ranktogive = "CAPTAIN"};
        case 5: { _ranktogive = "MAJOR"};
        case 6: { _ranktogive = "COLONEL"};
    };
    (leader _co) setUnitRank _ranktogive;


} else {
/*
if (_co in _allSLgroups) then {
    _allSLgroups = _allSLgroups - [_co];
};
if (_co in _allFTLgroups) then {
    _allFTLgroups = _allFTLgroups - [_co];
};
*/
};


//Setup the groups 





// Create CO parent 
_parentIndex = _tree tvAdd [[],(groupid _co)];
{
    _squadid = _x getVariable ["ca_squadID","notsameA"];
    _SqL = leader _x;
    _COfficer = leader _co;

    _childIndex = [];
    if (_squadid == "notsameA") then {
        _overflow pushBackUnique _x;
    } else {
    _childIndex = _tree tvAdd [[_parentIndex],(groupid _x)];
    _rawcolor = "";
    _rawcolor = _x getVariable ["ca_groupcolor","ColorWhite"];
    
    _color = _rawcolor call _findcolor;
    _tree tvSetColor [[_parentIndex,_childIndex], _color];
    _x setVariable ["ca_xo",_COfficer,true];
    _x setVariable ["ca_xo2",_COfficer,true];
    };
    {
        _squadidft = _x getVariable ["ca_squadID","notsamez"];

        if (_squadidft == _squadid) then {
            _grandChildIndex = _tree tvAdd [[_parentIndex,_childIndex],(groupid _x)];
            _rawcolor = "";
            _rawcolor = _x getVariable ["ca_groupcolor","ColorWhite"];
            
            _color = _rawcolor call _findcolor;
            _tree tvSetColor [[_parentIndex,_childIndex,_grandChildIndex], _color];
        _x setVariable ["ca_xo",_SqL,true];
        _x setVariable ["ca_xo2",_COfficer,true];

        } else {
            _overflow pushBackUnique _x;
        };
    } forEach _allFTLgroups;

} forEach _allSLgroups;

if (count _allSLgroups == 0) then {
    _overflow = _overflow + _allFTLgroups;
};
_overflowIndex = _tree tvAdd [[],"Overflow/Missing SL"];

{
    _childIndex = _tree tvAdd [[_overflowIndex],(groupid _x)];
    _rawcolor = "";
    _rawcolor = _x getVariable ["ca_groupcolor","ColorWhite"];
    _color = _rawcolor call _findcolor;

} forEach _overflow;



tvExpandAll _tree;

_tree ctrlAddEventHandler ["TreeSelChanged", {
    _groupid = tvText [1811,(_this select 1)]; 
    [_groupid] call ca_fnc_treeselect;
}
];

//_tree tvSetCurSel [0];