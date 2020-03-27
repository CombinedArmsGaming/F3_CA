#include "macros.hpp"

if (isNil 'f_arr_squadMarkers') exitWith {};
if (IS_TRUE(f_var_hideSquadMarkers)) exitWith {};

params ["_map", "_smallMarkers"];

_baseUnitIcon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";



// NOTE: Only supports custom textures (in mission folder).
_drawMarker =
{
	params ["_map", "_icon", "_name", "_colour", "_pos", "_smallMarkers"];

	_scaleFactor = if (_smallMarkers) then {0.9} else {1};

	_map drawIcon
	[
		format ["%1%2",MISSION_ROOT,_icon],
		_colour,
		_pos,
		28 * _scaleFactor,
		28 * _scaleFactor,
		0,
		_name,
		2,
		0.06 * _scaleFactor
	];

};




_drawUnitMarker =
{
	params ["_map", "_icon", "_name", "_colour", "_pos", "_dir", "_smallMarkers"];

	_scaleFactor = if (_smallMarkers) then {0.9} else {1};

	_map drawIcon
	[
		_baseUnitIcon,
		[0,0,0,1],
		_pos,
		20 * _scaleFactor,
		20 * _scaleFactor,
		_dir
	];

	_map drawIcon
	[
		_icon,
		_colour,
		_pos,
		16 * _scaleFactor,
		16 * _scaleFactor,
		_dir,
		_name,
		2,
		0.04 * _scaleFactor
	];

};




{
	_x params ["_group", "_icon", "_name", "_colour"];

	if !(isNull _group or {count units _group <= 0}) then
	{
		_pos = getPosVisual (leader _group);

		[_map, _icon, _name, _colour, _pos, _smallMarkers] call _drawMarker;

	};

} forEach f_arr_squadMarkers;




_playerGroup = group player;

{
	_x params ["_group", "_unit", "_name", "_colour"];

	_inDifferentGroup = !(_playerGroup isEqualTo _group);
	_isGroupLeader = (leader _unit isEqualTo _unit);
	_shouldDrawMarker = _inDifferentGroup and {[_unit] call ca_fnc_isPlayerAlive} and {!_isGroupLeader};

	if (_shouldDrawMarker) then
	{
		_pos = getPosVisual _unit;
		_dir = getDirVisual _unit;

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

		[_map, _icon, _name, _colour, _pos, _dir, _smallMarkers] call _drawUnitMarker;
	};

} forEach f_arr_unitMarkers;
