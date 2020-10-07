/*
  Author: Gibbs (edited by Bubbus)
  Randomly add wounds to the given unit. Intended for medical training.

  Args:
  0: The Unit to target <OBJECT>
  1: The maximum number of wounds <NUMBER> (default 6)
  2: The wound types to inflict <ARRAY<STRING>> (defaults to all)
  3: The body parts to wound <ARRAY<STRING>> (defaults to all)
  4: The range of damage to inflict, Gaussian distro [min, mid, max] <ARRAY<NUMBER, 3>> (default [0, 0.5, 1])

  Example Usage:
  [player] call f_fnc_woundunitrandomly
  [player, 3, ["stab"]] call f_fnc_woundunitrandomly
  [player, 3, nil, ["head", "body"], [0.5, 0.6, 0.9]] call f_fnc_woundunitrandomly

*/

params ["_unit", ["_maxWounds", 6], ["_forceWoundTypes", []], ["_forceWoundLocations", []], ["_damageRange", [0, 0.5, 1]]];

// Select between given wound locations or default (all)
_woundLocations = if (count _forceWoundLocations > 0) then
{
    _forceWoundLocations
}
else
{
    ["head", "body", "leftArm", "rightArm", "leftLeg", "rightLeg"]
};

// Select between given damage types or default (all)
_woundTypes = if (count _forceWoundTypes > 0) then
{
    _forceWoundTypes
}
else
{
    ["bullet", "grenade", "explosive", "shell", "vehiclecrash", "collision", "backblast", "stab", "punch", "falling", "ropeburn", "drowning"]
};


_numberOfWounds = floor (random _maxWounds) + 1;

// Apply the appropriate numbder of random wounds to the unit.
for "_i" from 0 to _numberOfWounds do
{
    _woundLocation = selectRandom _woundLocations;
    _woundType = selectRandom _woundTypes;
    _damage = random _damageRange;


    [_unit, _damage, _woundLocation, _woundType] call ace_medical_fnc_addDamageToUnit;

};
