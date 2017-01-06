
params ["_unitarray","_position","_side"];

_group = [_unitarray,_position,_side] call p_fnc_spawngroup;

	_posgroup = getpos leader _group;
	 while {(count (waypoints _group)) > 0} do
 {
  deleteWaypoint ((waypoints _group) select 0);
 };
	//waypoint 0
	_wayp = _group addWaypoint [_posgroup, 0, 0];
	_wayp setWaypointType "MOVE";
	_wayp setWaypointBehaviour "SAFE";
	_wayp setWaypointSpeed "LIMITED";
	_wayp setWaypointTimeout [5, 10, 6];

	//waypoint 1

	_riot1 = _posgroup select 0;

	_riotriot1 = _riot1 + 200;

	_posgroup set [0,_riotriot1];

	_wayp1 = _group addWaypoint [_posgroup, 50, 1];
	_wayp1 setWaypointType "MOVE";


	//wypoint 2


	_riot2= _posgroup select 1;

	_riotriot2 = _riot2 - 200;

	_posgroup set [1,_riotriot2];

	_wayp2 =_group addWaypoint [_posgroup, 50, 2];
	_wayp2 setWaypointType "MOVE";
	_wayp2 setWaypointTimeout [5, 10, 6];


		//waypoint 3

	_riot3 = _posgroup select 0;

	_riotriot = _riot3 - 200;

	_posgroup set [0,_riotriot3];


	_wayp3 = _group addWaypoint [_posgroup, 50, 3];
	_wayp3 setWaypointType "MOVE";
	_wayp3 setWaypointTimeout [5, 10, 6];


		//waypint 4

	_riot4 = _posgroup select 1;

	_riotriot4 = _riot4 + 200;

	_posgroup set [1,_riotriot4];

	_wayp4 = _group addwaypoint [_posgroup, 0, 4];

	_wayp4 setWaypointType "CYCLE";
