/*
 * Author: Killzone kid (F3_CA version)
 * Enables the vehicle to become self driving. Uses agent, which might have degraded performance under heavy server load. Caveat emptor. 
 *
 * Arguments:
 * 0: Vehicle to be driveable, Object 
 * Example:
 *     [this] call ca_fnc_aidriver;
 *      [vehicle player] call ca_fnc_aidriver;
 */

params ["_vehicle"];


_adddriver = {
  params ["_vehicle"];
  if (_vehicle getVariable ["ca_hasAidriver",false] || (driver vehicle _vehicle) in (crew vehicle _vehicle)) exitWith {systemchat "Vehicle already has a driver!"};

  _ai = createAgent [(typeOf player), [0,0,0], [], 0, "NONE"];
  _ai allowDamage false;
  _ai moveInDriver _vehicle;
  _vehicle setVariable ["ca_hasAidriver",true, true];
  _vehicle lockDriver true;
  _ai remoteExec ["hideObjectGlobal", 2];
  systemchat "Driver Added!";

};

_removedriver = {
  params ["_vehicle"];
  systemchat "Driver Removed!";
  deleteVehicle (driver _vehicle);
  _vehicle lockDriver false;
  _vehicle setVariable ["ca_hasAidriver",false, true];

};
_aidriveraction = ["ca_aidriver","CA AI Driver","",{},{true}] call ace_interact_menu_fnc_createAction;

_adddriveraction = ["ca_adddriver","Add AI driver","",_adddriver,{true},{}] call ace_interact_menu_fnc_createAction;

_removedriveraction = ["ca_removedriver","Remove AI driver","",_removedriver,{true},{}] call ace_interact_menu_fnc_createAction;

[_vehicle, 1, ["ACE_SelfActions"], _aidriveraction] call ace_interact_menu_fnc_addActionToObject;

[_vehicle, 1, ["ACE_SelfActions","ca_aidriver"], _adddriveraction] call ace_interact_menu_fnc_addActionToObject;

[_vehicle, 1, ["ACE_SelfActions","ca_aidriver"], _removedriveraction] call ace_interact_menu_fnc_addActionToObject;
