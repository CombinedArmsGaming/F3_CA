/*
 * F3_CA
 * Function: Vehicle Spawner. 
 * Enables a vehicle (could also be a static object like a flag pole) to spawn vehicle.
 *
 * Arguments:
 * 0: Logistics Truck thats placed on the map, Object
 * 1: Classname of the vehicle, String
 * 2: Amount of spare vehicle, Number
 * 3: Description that appears in the chat/addaction eg Warrior, Panther, Sherman etc., String
 * 4: How many tickets a vehicle should cost
 * 5: If the spawned vehicle should have the aidriver script available. 
 *
 * Example:
 *    Initline: [this,"I_APC_tracked_03_cannon_F",5,"Warrior",10,true] call ca_fnc_vehiclespawner;
 *    Script where logitruck is the ingame vehicle variable [logitruck,"I_APC_tracked_03_cannon_F",5,"Warrior",10,false] call ca_fnc_vehiclespawner;
 */
params ["_spawner","_classname","_sparevehicles",["_description","Vehicle"],["_ticketcost",5],["_aidriver",true]];
_addactiontext = format ["CA: Unload %1",_description];

missionNamespace setVariable [_classname,_sparevehicles, true];

_vehscript = {

params ["_spawner", "_player", "_params"];
if(isnil {ca_platoonsetup}) exitwith {systemChat "Hierarchy setup is not done yet, try again";};

_classname = _params select 0;
_description = _params select 1;
_ticketdifference = _params select 2;
_aidriver = _params select 3;



_side = side _player;
_groupid = groupid group _player;
_zeusGroups = missionNamespace getVariable ["f_var_hiddenGroups", []];

_authorized = (_groupid == "LOGI")||(_groupid in _zeusGroups);
if (!_authorized) exitWith {systemChat "You need to be a part of LOGI to do this!"};

_sidetickets = 0;
switch (_side) do {
	case west: {
		_sidetickets = ca_WestTickets;
	};
	case east: {
		_sidetickets = ca_EastTickets;
	};
	case independent: {
		_sidetickets = ca_IndependentTickets;
	};
};

if(_ticketdifference > _sidetickets ) exitWith {systemChat "Not enough tickets to spawn this vehicle!"};

if (0>=(missionNamespace getVariable _classname)) exitWith {
	systemchat format["No more %1 (s)",_description];
};
_newnumb = (missionNamespace getVariable _classname) - 1;
missionNamespace setVariable [_classname,_newnumb, true];

systemchat format["%1 is unloading, stand clear!",_description];
playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss",_spawner];

[_spawner,_classname,_newnumb,_description,_ticketdifference,_aidriver,_side] spawn {
	params ["_spawner","_classname","_newnumb","_description","_ticketdifference","_aidriver","_side"];
	sleep 7;
	_vehicle = createVehicle  [_classname, [0,0,0], [], 15, "NONE"];

	_dir = getDir _spawner;
	_vehicle setDir _dir;

_newticketnumb = 0;
switch (_side) do {
	case west: {
	_newticketnumb = ca_WestTickets - _ticketdifference;
	missionNamespace setVariable ['ca_WestTickets',_newticketnumb, true]; 
	["v_ifv",_vehicle,"blu_f"] call f_fnc_assignGear;
	};
	case east: {
	_newticketnumb = ca_EastTickets - _ticketdifference;
	missionNamespace setVariable ['ca_EastTickets',_newticketnumb, true]; 
	["v_ifv",_vehicle,"opf_f"] call f_fnc_assignGear;
	};
	case independent: {
	_newticketnumb = ca_IndependentTickets - _ticketdifference;
	missionNamespace setVariable ['ca_IndependentTickets',_newticketnumb, true]; 
	["v_ifv",_vehicle,"ind_f"] call f_fnc_assignGear;
	};
};
systemChat format ["%1 Unloading, %2 side tickets remaining",_description,_newticketnumb];
if (_aidriver) then {[_vehicle] remoteExec ["ca_fnc_aidriver",0,true]};
/*
_vehicle setObjectTextureGlobal [0,"TurretTextureDes.paa.paa"];
_vehicle setObjectTextureGlobal [1,"BodyTextureDes.paa.paa"];
if using textures change it here mission maker
*/

_pos = _spawner modelToWorld [5,0,0];
_vehicle allowDamage false;
_vehicle setpos _pos;
systemchat format ["%2 deployed, %1 %2 (s) left", _newnumb,_description];
// Might as well make the spawned vehicle bump resistant to reduce !FUN potential
sleep 60;
_vehicle allowDamage true;

};


};


_action = ["ca_unloadvehicle",_addactiontext,"",_vehscript,{true},{},[_classname,_description,_ticketcost,_aidriver], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_spawner, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

