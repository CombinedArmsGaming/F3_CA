/*
  Author: Gibbs
  Randomly add wounds to the given unit. Intended for medical training.

  Args:
  0: The Unit to target <OBJECT>

  Example Usage:
  [player] call f_fnc_woundunitrandomly
*/

params ["_unit"];

_woundLocations = ["head", "body", "leftArm", "rightArm", "leftLeg", "rightLeg"];
_woundTypes = ["bullet", "grenade", "explosive", "shell", "vehiclecrash", "collision", "backblast", "stab", "punch", "falling", "ropeburn", "drowning"];

_numberOfWounds = floor(random 6) + 1;

// Apply the appropriate numbder of random wounds to the unit.
for "_i" from 0 to _numberOfWounds do
{
	_woundLocation = _woundLocations select floor(random 6);
	_woundType = _woundTypes select floor(random 12);
	// Random 1 determines the damage to apply between 0 & .99
	[_unit, random 1, _woundLocation, _woundType] call ace_medical_fnc_addDamageToUnit;
};