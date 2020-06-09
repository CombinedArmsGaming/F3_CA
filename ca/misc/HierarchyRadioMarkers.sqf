/*
 * Author: Poulern
 * Create markers to show The hierarchy.
 *
 * Automatically executed on game start by ca_init.sqf
 *
 */

ca_showRadioMarkers = true;
_side = side player;
_LRmarkerarray = [];
_LRchannels = [];
_SRchannels = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
_SRmarkerarray = [];
// do stuff from here 
/*
_allthegroups = [];

{
	if (side _x == west) then {_allthegroups pushBackUnique _x};
	if (side _x == east) then {_allthegroups pushBackUnique _x};
	if (side _x == independent) then {_allthegroups pushBackUnique _x};
} forEach allGroups;

missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_blufor',_caWestLongrangeChannelList, true]; 
missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_opfor',_caEastLongrangeChannelList, true]; 
missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_indfor',_caIndependentLongrangeChannelList, true]; 
_shortrangechannel = (_group) getVariable ["ca_SRradioCH",1];
_longrangeArray = (_group) getVariable ["ca_LRradioarray",[4]];

*/

switch (_side) do {
	case west: {
		_LRchannels = f_radios_settings_acre2_lr_groups_blufor;
		_mkrcolor = "colorBLUFOR";

		{
			_LRmarkerthing = createMarkerLocal [format ["%1_hierarchyLRmarker",_x], [100,(500 - ( 15 * _forEachIndex))]];
			_LRmarkerthing setMarkerShapeLocal "ICON";
			_LRmarkerthing setMarkerTypeLocal "loc_Transmitter";
			_LRmarkerthing setMarkerTextLocal format ["Long Range CH%1: %2",(_forEachIndex+1),_x];
			_LRmarkerthing setMarkerColorLocal _mkrcolor;
			
			_LRmarkerarray pushBackUnique _LRmarkerthing;
		} forEach _LRchannels;
		{
			_SRmarkerthing = createMarkerLocal [format ["%1_hierarchySRmarker",_x], [100,(750 - ( 15 * _forEachIndex))]];
			_SRmarkerthing setMarkerShapeLocal "ICON";
			_SRmarkerthing setMarkerTypeLocal "loc_Transmitter";
			_SRmarkerthing setMarkerTextLocal format ["Short Range CH%1:",(_forEachIndex+1)];
			_SRmarkerthing setMarkerColorLocal _mkrcolor;
			
			_SRmarkerarray pushBackUnique _SRmarkerthing;
		} forEach _SRchannels;
	};
	case east: {
	_LRchannels = f_radios_settings_acre2_lr_groups_opfor;
	_mkrcolor = "colorOPFOR";
		{
			_LRmarkerthing = createMarkerLocal [format ["%1_hierarchyLRmarker",_x], [100,(500 - ( 15 * _forEachIndex))]];
			_LRmarkerthing setMarkerShapeLocal "ICON";
			_LRmarkerthing setMarkerTypeLocal "loc_Transmitter";
			_LRmarkerthing setMarkerTextLocal format ["Long Range CH%1: %2",(_forEachIndex+1),_x];
			_LRmarkerthing setMarkerColorLocal _mkrcolor;
			
			_LRmarkerarray pushBackUnique _LRmarkerthing;
			

		} forEach _LRchannels;
		{
			_SRmarkerthing = createMarkerLocal [format ["%1_hierarchySRmarker",_x], [100,(750 - ( 15 * _forEachIndex))]];
			_SRmarkerthing setMarkerShapeLocal "ICON";
			_SRmarkerthing setMarkerTypeLocal "loc_Transmitter";
			_SRmarkerthing setMarkerTextLocal format ["Short Range CH%1:",(_forEachIndex+1)];
			_SRmarkerthing setMarkerColorLocal _mkrcolor;
			
			_SRmarkerarray pushBackUnique _SRmarkerthing;
		} forEach _SRchannels;
	};
	case independent: {
		_LRchannels = f_radios_settings_acre2_lr_groups_indfor;
		_mkrcolor = "colorIndependent";

		{
			_LRmarkerthing = createMarkerLocal [format ["%1_hierarchyLRmarker",_x], [100,(500 - ( 15 * _forEachIndex))]];
			_LRmarkerthing setMarkerShapeLocal "ICON";
			_LRmarkerthing setMarkerTypeLocal "loc_Transmitter";
			_LRmarkerthing setMarkerTextLocal format ["Long Range CH%1: %2",(_forEachIndex+1),_x];
			_LRmarkerthing setMarkerColorLocal _mkrcolor;

			_LRmarkerarray pushBackUnique _LRmarkerthing;
		} forEach _LRchannels;

		{
			_SRmarkerthing = createMarkerLocal [format ["%1_hierarchySRmarker",_x], [100,(750 - ( 15 * _forEachIndex))]];
			_SRmarkerthing setMarkerShapeLocal "ICON";
			_SRmarkerthing setMarkerTypeLocal "loc_Transmitter";
			_SRmarkerthing setMarkerTextLocal format ["Short Range CH%1:",(_forEachIndex+1)];
			_SRmarkerthing setMarkerColorLocal _mkrcolor;
			
			_SRmarkerarray pushBackUnique _SRmarkerthing;
		} forEach _SRchannels;
	};
	default {diag_log format ["Error in the side input for (%1) hierarchy mapmarkers",_side]};
};

//Update created markers 
while { true } do {

	if (ca_showRadioMarkers) then {
		
		_allthegroups = [];

		switch (_side) do {
			case west: {
				{
					if (side _x == west) then {_allthegroups pushBackUnique _x};
				} forEach allGroups;
			};
			case east: {
				{
					if (side _x == east) then {_allthegroups pushBackUnique _x};
				} forEach allGroups;
			};
			case independent: {
				{
					if (side _x == independent) then {_allthegroups pushBackUnique _x};
				} forEach allGroups;
			};
		};
		{
			_channeltocheck = (_forEachIndex+1);
			_LRgroups = [];
			{
			if ((_x getvariable ["ca_LRradioarray",[111]]) find _channeltocheck != -1) then {
				_LRgroups pushBackUnique (groupId _x);
			};
			} forEach _allthegroups;
			_x setMarkerTextLocal format ["Long Range CH%1: %2. Callsigns: %3",(_forEachIndex+1),(_LRchannels select _forEachIndex),_LRgroups];
		} forEach _LRmarkerarray;
		{
			_channeltocheck = (_forEachIndex+1);
			_SRgroups = [];
			{
			if ((_x getvariable ["ca_SRradioCH",111]) == _channeltocheck) then {
				_SRgroups pushBackUnique (groupId _x);
			};
			} forEach _allthegroups;
			_x setMarkerTextLocal format ["Short Range CH%1: Callsigns: %2",(_forEachIndex+1),_SRgroups];
		} forEach _SRmarkerarray;


	};



	uisleep 15;


};
