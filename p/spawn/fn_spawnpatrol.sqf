/*
 * Author: Poulern and Bohemia interactive(Joris-Jan van 't Land and BIS_fnc_taskPatrol)
 * Spawns a group and patrols the area according to the radius set.
 *
 * Arguments:
 * 0: array of units according to F3 ["ftl","r","ar","aar","rat"]
 * 1: start position, marker, coordinates, location, existing unit/group.
 * 2: side of group eg west east independent
 * 3: radius of area to patrol eg 200
 * 4: waypoint count, amount of waypoints within the radius
 * 5: waypoint type, eg "MOVE", "SAD", "HOLD","SENTRY","GUARD","SUPPORT"
 * 6: behaviour of group, eg "CARELESS","SAFE","AWARE","COMBAT","STEALTH"
 * 7: combat mode, eg "BLUE","GREEN","WHITE","YELLOW","RED"
 * 8: speed of group "LIMITED","NORMAL","FULL"
 * 9: formation aka "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE" or "LINE"
 * 10: Oncomplete code to run when done with each waypoint.
 * 11: time to stop at each waypoint eg [3,6,9] in seconds
 * Return Value:
 * Nothing.
 *
 * Example:
 * [["ftl","r","m","rat","ar","aar"],"spawnmarker",independent,200,5,"MOVE","SAFE","GREEN","FULL","STAG COLUMN","",[3,6,9]] call p_fnc_spawnpatrol;
 *
 * Public: [Yes/No]
 */

 params ["_unitarray","_markerposition","_side",
	     ["_radius", 200, [2]]
			 ];

	 private ["_group","_markerpos"];
	 _group = [_unitarray,_markerposition,_side] call p_fnc_spawngroup;
   _markerpos = markerPos _markerposition;

   //Validate parameter count
   if ((count _this) < 3) exitWith {debugLog "Log: [taskPatrol] Function requires at least 3 parameters!"; false};

   private ["_group", "_markerpos", "_radius", "_blacklist"];

   _blacklist = [];


   //Create a string of randomly placed waypoints.
   private ["_prevPos"];
   _prevPos = _markerpos;
   for "_i" from 0 to (2 + (floor (random 3))) do
   {
   	private ["_wp", "_newPos"];
   	_newPos = [_prevPos, 50, _radius, 1, 0, 60 * (pi / 180), 0, _blacklist] call BIS_fnc_findSafePos;
   	_prevPos = _newPos;

   	_wp = _group addWaypoint [_newPos, 0];
   	_wp setWaypointType "MOVE";
   	_wp setWaypointCompletionRadius 20;

   	//Set the group's speed and formation at the first waypoint.
   	if (_i == 0) then
   	{
   		_wp setWaypointSpeed "NORMAL";
   		_wp setWaypointFormation "STAG COLUMN";
   	};
   };

   //Cycle back to the first position.
   private ["_wp"];
   _wp = _group addWaypoint [_markerpos, 0];
   _wp setWaypointType "CYCLE";
   _wp setWaypointCompletionRadius 20;

_group
