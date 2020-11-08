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

_vehicle addaction ["Activate driver", {
  params ["_vehicle"];
  if (_vehicle getVariable ["ca_hasAidriver",false] || (driver vehicle _vehicle) in (crew vehicle _vehicle)) exitWith {hint "Vehicle already has a driver!"};

  _ai = createAgent [(typeOf player), [0,0,0], [], 0, "NONE"];
  _ai allowDamage false;
  _ai moveInDriver _vehicle;
  _vehicle setVariable ["ca_hasAidriver",true, true];
  _vehicle lockDriver true;
  _ai remoteExec ["hideObjectGlobal", 2];

  hint "Driver added!";
},[],0,true,true,"","true",10];

_vehicle addaction ["Deactivate driver", {
  params ["_vehicle"];
  hint "Driver Removed!";
  deleteVehicle (driver _vehicle);
  _vehicle lockDriver false;
  _vehicle setVariable ["ca_hasAidriver",false, true];
},[],0,true,true,"","true",10];
