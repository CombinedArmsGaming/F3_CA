#include "macros.hpp"

if (isNil 'f_arr_squadMarkers') exitWith {};
if (IS_TRUE(f_var_hideSquadMarkers)) exitWith {};

params ["_map"];

_baseUnitIcon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";



// NOTE: Only supports custom textures (in mission folder).
_drawMarker =
{
	params ["_map", "_icon", "_name", "_colour", "_pos"];

	_map drawIcon
	[
		format ["%1%2",MISSION_ROOT,_icon],
		_colour,
		_pos,
		28,
		28,
		0,
		_name,
		2,
		0.06
	];

};




_drawUnitMarker =
{
	params ["_map", "_icon", "_name", "_colour", "_pos", "_dir"];

	_map drawIcon
	[
		_baseUnitIcon,
		[0,0,0,1],
		_pos,
		20,
		20,
		_dir
	];

	_map drawIcon
	[
		_icon,
		_colour,
		_pos,
		16,
		16,
		_dir,
		_name,
		2,
		0.04
	];

};




_getSmoothPosition =
{
	_unit = _this;
	_curPos = getPos _unit;

	if (local _unit or {_unit isEqualTo player} or {(vehicle _unit) isEqualTo (vehicle player)}) exitWith
	{
		_unit setVariable ["f_var_smoothMarkers_lerpFrom", []];
		_unit setVariable ["f_var_smoothMarkers_lerpTo", []];
		_curPos
	};

	_lerpFrom = _unit getVariable ["f_var_smoothMarkers_lerpFrom", []];

	if (_lerpFrom isEqualTo []) exitWith
	{
		_unit setVariable ["f_var_smoothMarkers_lerpFrom", [_curPos, time]];
		_unit setVariable ["f_var_smoothMarkers_lerpTo", [_curPos, time]];
		_curPos
	};

	_lerpFrom = _unit getVariable "f_var_smoothMarkers_lerpFrom";
	_lerpTo = _unit getVariable "f_var_smoothMarkers_lerpTo";

	if (!(_curPos isEqualTo (_lerpTo select 0)) or {(time - (_lerpTo select 1)) > 0.5}) then
	{
		_lerpFrom = _lerpTo;
		_lerpTo = [_curPos, time];

		_unit setVariable ["f_var_smoothMarkers_lerpFrom", _lerpFrom];
		_unit setVariable ["f_var_smoothMarkers_lerpTo", _lerpTo];

	};

	_interval = (_lerpTo select 1) - (_lerpFrom select 1);
	_progress = time - (_lerpTo select 1);

	(vectorLinearConversion [0, _interval, _progress, (_lerpFrom select 0), (_lerpTo select 0), false])

};




{
	_x params ["_group", "_icon", "_name", "_colour"];

	if !(isNull _group or {count units _group <= 0}) then
	{
		_pos = (leader _group) call _getSmoothPosition;

		[_map, _icon, _name, _colour, _pos] call _drawMarker;

	};

} forEach f_arr_squadMarkers;




_playerGroup = group player;

{
	_x params ["_group", "_unit", "_name", "_colour"];

	_inDifferentGroup = !(_playerGroup isEqualTo _group);
	_isGroupLeader = (leader _unit isEqualTo _unit);
	_shouldDrawMarker = _inDifferentGroup and {alive _unit} and {!_isGroupLeader};

	if (_shouldDrawMarker) then
	{
		_pos = (_unit call _getSmoothPosition);
		_dir = getDir _unit;

		private "_icon";

		// Requires shacktac hud.
		if !(isNil 'STHud_Icon') then
		{
			_icon = _unit call STHud_Icon;
		}
		else
		{
			_icon = _baseUnitIcon;
		};

		[_map, _icon, _name, _colour, _pos, _dir] call _drawUnitMarker;
	};

} forEach f_arr_unitMarkers;
