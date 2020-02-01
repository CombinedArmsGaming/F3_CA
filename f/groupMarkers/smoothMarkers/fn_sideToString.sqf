params ["_side"];

switch (_side) do
{
    case west: {"blufor"};
    case east: {"opfor"};
    case independent: {"indfor"};
    case civilian: {"civ"};
    default {""};
}
