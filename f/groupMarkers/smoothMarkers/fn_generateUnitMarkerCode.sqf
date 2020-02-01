params ["_unitType", "_displayName"];

_sqfDoesntHaveClosures = '(_this + ["%1", "%2"]) call f_fnc_addGroupMemberMarkers;';
_closeEnough = format [_sqfDoesntHaveClosures, _unitType, _displayName];

_output = compile _closeEnough;

_output
