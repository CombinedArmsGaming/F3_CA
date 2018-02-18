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
 *
 *
 * Example:
 *     [logitruck] call ca_fnc_vehiclespawner;
 *
 */
params ["_truck"];
_truck addaction ["Unload Vehicle", {

  if (0>=spare_vehs) exitWith {
      hint "No more Warriors!!!";
  };
  params ["_truck"];
  _newnumb = spare_vehs - 1;
missionNamespace setVariable ["spare_vehs",_newnumb, true];

  hint "Warrior unloading!";
  playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss",_truck];
  sleep 5;

_tank = createVehicle  [ca_spawnerclassname, [0,0,0], [], 15, "NONE"];

_dir = getDir _truck;
_tank setDir _dir;

_pos = _truck modelToWorld [5,0,0];
["v_ifv",_tank,"blu_f"] call f_fnc_assignGear;
/*
_tank setObjectTextureGlobal [0,"TurretTextureDes.paa.paa"];
_tank setObjectTextureGlobal [1,"BodyTextureDes.paa.paa"];
if using textures change it here
*/

  _tank setpos _pos;
  hint format ["Vehicle deployed, %1 Vehicles left", _newnumb];

}];



if (group player == logigroup) then {
    [logitruck] call ca_fnc_spawntank;
};
