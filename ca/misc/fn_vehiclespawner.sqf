/*
 * Author: Poulern
 * Enables logistics truck to spawn vehicle. Note that the addaction is available on every client this is run. To restrict access do for example
 if (group player == logigroup) then {
    [logitruck] call ca_fnc_vehiclespawner;
};
Where logigroup is the group variable and logitruck is the parameter for this function. Will Throw an error when logi team is not slotted for testing.
 *
 * Arguments:
 * 0: Logistics Truck thats placed on the map, Object
 * 1: Classname of the vehicle, String
 * 2: Amount of spare vehicle, Number
 * 3: Description that appears in the hints/addaction eg Warrior, Panther, Sherman etc., String
 * 
 *
 * Example:
 *     [logitruck,"I_APC_tracked_03_cannon_F",5,"Warrior"] call ca_fnc_vehiclespawner;
 *
 */
params ["_spawner","_classname","_sparevehicles",["_description","Vehicle"]];
_addactiontext = str format ["Unload %1",_description];

missionNamespace setVariable [_classname,_sparevehicles, true];

_spawner addaction [_addactiontext, {

  params ["_spawner"];

  _classname = _this select 3 select 0;
  _description = _this select 3 select 1;
  if (!(rank player == 'MAJOR' || rank player == 'COLONEL')) exitWith {Hint "You need to be authorized to do this!"};

  if (0>=(missionNamespace getVariable _classname)) exitWith {
      hint format["No more %1 (s)",_description];
  };
  _newnumb = (missionNamespace getVariable _classname) - 1;
missionNamespace setVariable [_classname,_newnumb, true];

 hint format["%1 is unloading, stand clear!",_description];
   playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss",_spawner];
  sleep 5;

_vehicle = createVehicle  [_classname, [0,0,0], [], 15, "NONE"];

_dir = getDir _spawner;
_vehicle setDir _dir;

_pos = _spawner modelToWorld [5,0,0];
["v_ifv",_vehicle,"blu_f"] call f_fnc_assignGear;
/*
_vehicle setObjectTextureGlobal [0,"TurretTextureDes.paa.paa"];
_vehicle setObjectTextureGlobal [1,"BodyTextureDes.paa.paa"];
if using textures change it here Wallace
*/

  _vehicle setpos _pos;

  hint format ["%2 deployed, %1 %2 (s) left", _newnumb,_description];

},[_classname,_description]];

