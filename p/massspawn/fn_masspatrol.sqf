/*
 * Author: Poulern
 * Spawns patrolling AI on each of the markers provided in an array.
 *
 * Arguments:
 * 0: An array of markers ["mkr","mkr_1","mkr_2","mkr_3"]
 * 1: array of units according to F3 ["ftl","r","ar","aar","rat"]
 * 2: side of group eg west east independent
 * 3: radius of area to patrol eg 200
 * Return Value:
 * Nothing.
 *
 * Example:
 * [["mkr","mkr_1","mkr_2","mkr_3"],["ftl","r","m","rat","ar","aar"],"spawnmarker",independent,200,5,"MOVE","AWARE","GREEN","FULL","STAG COLUMN","",[3,6,9]] call p_fnc_masspatrol;
 *
 * Public: [Yes/No]
 */


params ["_markerarray","_unitarray","_side",
      ["_radius", 200, [2]]
      ];
  private ["_group"];
{
  _group = [_unitarray,_x,_side,_radius] call p_fnc_spawnpatrol;

} forEach _markerarray;
