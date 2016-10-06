//Captainblaffer's most inefficiently written JIP TP script ever

scopeName "main";
_id = _this select 2;
_leader = (leader player);
_tpaction = (_this select 2);

hintSilent "No one found to teleport to";
if (count units group player == 1) then {

{
	if (isPlayer _x) then {
	if (side _x == side player) then {
	if (alive _x) then {
	if (_x != player) then {
	if (_x distance player > 50) then {
	
	_bguy = _x;
	{
		if (((side (group _x)) getFriend (side (group player)) < 0.6 ) && alive _x) then {//check for enemies near player
			if (_x distance _bguy < 25) then {
				hintSilent "Enemies nearby, try again later"; 
				breakTo "main";
			};
		};
	}foreach allUnits;
	if ((vehicle _x) != _x) then { //Checks if the squad leader is in a vehicle
		if ((vehicle _x) emptyPositions "cargo" == 0) then { //Checks if vehicle has empty seats
			hintSilent "No more room in the group's vehicle, try again later"; 
		}
		else {
			_unit = player;
			[["JIP",[format ["%1 has joined your group.",name _unit]]],"BIS_fnc_showNotification",units (group _unit) - [_unit]] spawn BIS_fnc_MP;
			player removeAction _tpaction;
			tpAction = nil;
			hintSilent "";
			cutText ["", "BLACK FADED"];
			player moveincargo (vehicle _x);
			sleep 0.5;
			titleCut ["", "BLACK IN", 5];
			hintSilent format ["Teleported to %1",name _x]; 
			sleep 2;
			breakTo "main";
		};
	}
	else {
		_unit = player;
		[["JIP",[format ["%1 has joined your group.",name _unit]]],"BIS_fnc_showNotification",units (group _unit) - [_unit]] spawn BIS_fnc_MP;
		player removeAction _tpaction;
		tpAction = nil;
		hintSilent "";
		cutText ["", "BLACK"];
		sleep 2;
		player setPosASL (getposASL _x);
		titleCut ["", "BLACK IN", 5];
		hintSilent format ["Teleported to %1",name _x]; 
		sleep 2;
		breakTo "main";
	};
	
	};
	};
	};
	};
	};
}foreach playableUnits;

} else {

if (_leader == player) then {
{
	if (_x != _leader) then {
	if (_x distance player > 50) then {
	_bguy = _x;
	{
		if (((side (group _x)) getFriend (side (group player)) < 0.6 ) && alive _x) then {//check for enemies near player
			if (_x distance _bguy < 25) then {
				hintSilent "Enemies nearby, try again later"; 
				breakTo "main";
			};
		};
	}foreach allUnits;
	if ((vehicle _x) != _x) then { //Checks if the squad leader is in a vehicle
		if ((vehicle _x) emptyPositions "cargo" == 0) then { //Checks if vehicle has empty seats
			hintSilent "No more room in the group's vehicle, try again later"; 
		}
		else {
			_unit = player;
			[["JIP",[format ["%1 has joined your group.",name _unit]]],"BIS_fnc_showNotification",units (group _unit) - [_unit]] spawn BIS_fnc_MP;
			player removeAction _tpaction;
			tpAction = nil;
			hintSilent "";
			cutText ["", "BLACK FADED"];
			player moveincargo (vehicle _x);
			sleep 0.5;
			titleCut ["", "BLACK IN", 5];
			hintSilent format ["Teleported to %1",name _x]; 
			sleep 2;
			breakTo "main";
		};
	}
	else {
		_unit = player;
		[["JIP",[format ["%1 has joined your group.",name _unit]]],"BIS_fnc_showNotification",units (group _unit) - [_unit]] spawn BIS_fnc_MP;
		player removeAction _tpaction;
		tpAction = nil;
		hintSilent "";
		cutText ["", "BLACK"];
		sleep 2;
		player setPosASL (getposASL _x);
		titleCut ["", "BLACK IN", 5];
		hintSilent format ["Teleported to %1",name _x]; 
		sleep 2;
		breakTo "main";
	};
	} else {};
	} else {};
} foreach units group player;

} else {
	{
		if (((side (group _x)) getFriend (side (group player)) < 0.6 ) && alive _x) then {//check for enemies near player
			if (_x distance _leader < 25) then {
				hintSilent "Enemies nearby, try again later"; 
				breakTo "main";
			};
		};
	}foreach allUnits;
	if ((vehicle _leader) != _leader) then { //Checks if the squad leader is in a vehicle
		if ((vehicle _leader) emptyPositions "cargo" == 0) then { //Checks if vehicle has empty seats
			hintSilent "No more room in the group's vehicle, try again later"; 
		}
		else {
			_unit = player;
			[["JIP",[format ["%1 has joined your group.",name _unit]]],"BIS_fnc_showNotification",units (group _unit) - [_unit]] spawn BIS_fnc_MP;
			player removeAction _tpaction;
			tpAction = nil;
			hintSilent "";
			cutText ["", "BLACK FADED"];
			player moveincargo (vehicle _leader);
			sleep 0.5;
			titleCut ["", "BLACK IN", 5];
			hintSilent format ["Teleported to %1",name _leader]; 
			sleep 2;
			breakTo "main";
		};
	}
	else {
		_unit = player;
		[["JIP",[format ["%1 has joined your group.",name _unit]]],"BIS_fnc_showNotification",units (group _unit) - [_unit]] spawn BIS_fnc_MP;
		player removeAction _tpaction;
		tpAction = nil;
		hintSilent "";
		cutText ["", "BLACK"];
		sleep 2;
		player setPosASL (getposASL _leader);
		titleCut ["", "BLACK IN", 5];
		hintSilent format ["Teleported to %1",name _leader]; 
		sleep 2;	
		breakTo "main";
	};
};
};
