// Small function to determine if a unit is considered 'alive' by the current respawn system.
// There isn't a variable set on the player for this so isObjectHidden is used as a metric.

params ["_unit"];

(alive _unit) and {!(isObjectHidden _unit)}