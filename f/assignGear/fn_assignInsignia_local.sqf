/* --------------------------------------------------------------------------------------------------------------------
	Author:	 Cre8or
	Description:
		Assigns an insignia class onto the given unit.
		This function gets called by f_fnc_assignInsignia.
	Arguments:
		0:	<OBJECT>	The unit receiving the insignia
		1:	<STRING>	The insignia class to be assigned
	Returns:
		(nothing)
-------------------------------------------------------------------------------------------------------------------- */

// Fetch our params
params [
	["_unit", objNull, [objNull]],
	["_insignia", "", [""]]
];

// If no unit was provided, exit
if (isNull _unit or {uniform _unit == ""}) exitWith {};






private _index = getArray (configfile >> "CfgVehicles" >> getText (configfile >> "CfgWeapons" >> uniform _unit >> "ItemInfo" >> "uniformClass") >> "hiddenSelections") findIf {_x == "insignia"};

if (_index >= 0) then {
	private _texture = getText (configFile >> "CfgUnitInsignia" >> _insignia >> "texture");

	if (_texture != "") then {
		_unit setObjectTexture [_index, _texture];	// NOT global!
	};
};
