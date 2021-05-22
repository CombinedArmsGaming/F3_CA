/*
 * Function: Set rank
 * Sets rank (BIS fnc is unreliable, setrank is unreliable in MP).
 *
 * Arguments:
 * 0: Object to give rank
 * 1: Rank or rankid to give 
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * ["marker1"] call ca_fnc_getdirpos
 *
 */
 params ["_object","_rank"];
 
 switch (typename _rank) do {
	case "STRING": {[_object,_ranktogive] remoteExec ["setrank"];};
	case "SCALAR": {
		_ranktogive = "";
		if (_rank == 1) then { _ranktogive = "CORPORAL"};
		if (_rank == 2) then { _ranktogive = "SERGEANT"};
		if (_rank == 3) then { _ranktogive = "LIEUTENANT"};
		if (_rank == 4) then { _ranktogive = "CAPTAIN"};
		if (_rank == 5) then { _ranktogive = "MAJOR"};
		if (_rank == 6) then { _ranktogive = "COLONEL"};
		[_object,_ranktogive] remoteExec ["setrank"];
	};
 };

