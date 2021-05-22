/*
 * CA Hierarchy Dialog
 * Create the treeview and fill the hierarchy interface.
 * 
 * Called on opening the interface
 * fn_treeselect updates the interface when a group has been selected in the three view.
*/

disableSerialization;
_display = findDisplay 1809;
_tree = _display displayCtrl 1811;
_side = side player;
_zeusGroups = missionNamespace getVariable ["f_var_hiddenGroups", []];

//If the mission does not use group tickets, hide those elements from the UI. Except group respawn for admin.
_groupticketdisplays = [1804,1805,1806,1807,1808,1817,1820];
if (serverCommandAvailable '#kick') then {
    _groupticketdisplays deleteAt 1;
};

if (ca_respawnmode < 3) then {
    {
        _controltohide = _display displayCtrl _x;
        ctrlDelete _controltohide; 
    } forEach _groupticketdisplays;
};
// If using smoothmarkers delete non functional button. 
if (f_var_smoothMarkers) then {
        _controltohide = _display displayCtrl 1822;
        ctrlDelete _controltohide; 
};
tvClear _tree;

if(isnil {ca_platoonsetup}) exitwith {systemChat "Hierarchy setup is not done yet, try again"; _display closeDisplay 1};

if (ca_respawnmode == 0) exitWith {systemChat "This mission does not allow respawn!"; _display closeDisplay 1};
//Create a code block to give the hierarchy squads the right color
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

//Get every group in the game and sort based on side
_allplayergroups = [];
_allWestPlayerGroupsfill = [];
_allEastPlayerGroupsfill = [];
_allIndependentPlayerGroupsfill = [];


{
	if (side group _x == west) then {_allWestPlayerGroupsfill pushBackUnique group _x};
	if (side group _x == east) then {_allEastPlayerGroupsfill pushBackUnique group _x};
	if (side group _x == independent) then {_allIndependentPlayerGroupsfill pushBackUnique group _x};
} forEach allunits;

switch (_side) do { 
	case west: {
    _allplayergroups = _allWestPlayerGroupsfill;
	};
	case east: {
    _allplayergroups = _allEastPlayerGroupsfill;
	};
	case independent: {
    _allplayergroups = _allIndependentPlayerGroupsfill;
	};
};
_allCOgroups = [];
_overflow = [];
{
    _d = _x getVariable ["ca_superior",[]];
    if (typename _d == "ARRAY") then {
        _overflow pushBackUnique _x;
    }else
    {
        _rankid = (rankid leader _x);
        if (_rankid >= ca_corank && !(groupid _x in _zeusGroups)) then {
            _allCOgroups pushBackUnique _x;
        };

    };
} forEach _allplayergroups;

if (count _allCOgroups == 0) then {
    missionNamespace setVariable ['ca_WestJIPgroups',ca_WestJIPgroups, true]; 
    [[],{ca_nocopresent = true}] remoteExec ["spawn",_side];

    systemChat "There seems to be no CO in this mission, you can now press the become CO button";
};


//Setup the tree view 
_noncogroups = _allplayergroups - _allCOgroups;
{
    _parentIndex = _tree tvAdd [[],(groupid _x)];
    _rawcolor = "";
    _rawcolor = _x getVariable ["ca_groupcolor","ColorGrey"];
    
    _color = _rawcolor call _findcolor;
    _tree tvSetColor [[_parentIndex], _color];
    _coid = "";
    _coid = groupid _x;
    {
        _slid = groupid _x;
        _superior = "";
        _superior = _x getVariable "ca_superior";
        if (!isnil {_superior}) then {
        if (_coid == _superior) then {
            _childIndex = _tree tvAdd [[_parentIndex],(groupid _x)];
                _rawcolor = "";
                _rawcolor = _x getVariable ["ca_groupcolor","ColorGrey"];
                _color = _rawcolor call _findcolor;
                _tree tvSetColor [[_parentIndex,_childIndex], _color];

            {
                _ftlid = groupid _x;
                _superior = "";
                _superior = _x getVariable "ca_superior";
                if (!isnil {_superior}) then {
                if (_slid == _superior) then {
                    _grandChildIndex = _tree tvAdd [[_parentIndex,_childIndex],(groupid _x)];
                    _rawcolor = "";
                    _rawcolor = _x getVariable ["ca_groupcolor","ColorGrey"];
                    
                    _color = _rawcolor call _findcolor;
                    _tree tvSetColor [[_parentIndex,_childIndex,_grandChildIndex], _color];
                    _noncogroups = _noncogroups - [_x];
                };
                };
            } forEach _noncogroups;

            _noncogroups = _noncogroups - [_x];
            
        };
        };
    } forEach _noncogroups;

} forEach _allCOgroups;



//Pushback those groups that arent in the hierarchy
if (count _noncogroups > 0) then {
    {
        _overflow pushBackUnique _x;
    } forEach _noncogroups;
};

//Create the overflow part 
_overflowIndex = _tree tvAdd [[],"Overflow/Dead"];

{
    if ((groupid _x) in _zeusGroups) then {
        
    } else {
        _overflowchildIndex = _tree tvAdd [[_overflowIndex],(groupid _x)];
        _rawcolor = "";
        _rawcolor = _x getVariable ["ca_groupcolor","ColorGrey"];
        _color = _rawcolor call _findcolor;
        _tree tvSetColor [[_overflowIndex,_overflowchildIndex], _color];
    }
} forEach _overflow;


//Expand the view
tvExpandAll _tree;

// Add EH so that when you click on a group it updates the information panels. 
_tree ctrlAddEventHandler ["TreeSelChanged", {
    _groupid = tvText [1811,(_this select 1)]; 
    [_groupid] call ca_fnc_treeselect;
}
];

