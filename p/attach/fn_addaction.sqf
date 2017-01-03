/*
 * Author: [Name of Author(s)]
 * [Description]
 *
 * Arguments:
 * 0: Argument Name <TYPE>
 *
 * Return Value:
 * Return Name <TYPE>
 *
 * Example:
 * ["example"] call ace_[module]_fnc_[functionName]
 *
 * Public: [Yes/No]
 */
params ["_truck"];
_truck addaction ["Attach Vehicle", { params ["_truck","_player"];
if ((vehicle _player) isKindOf "rhsusf_m1a2sep1d_usarmy") then {

_tank = vehicle _player;
  _tank attachTo [_truck,[0,-3,2.3]]; 
  _tank setDir 180;
  _tank addaction ["Detach", {

    params ["_tank","_player","_id"];
    _tank = vehicle _player;

  _pos = getposATL _player;
_riot1 =   _pos select 0;
  _riotriot1 = _riot1 + 5;
  _riot2 = _pos select 1;
  _riotriot2 = _riot2 + 5;
  _pos set [0,_riotriot1];
  _pos set [1,_riotriot2];

    _tank setpos _pos;

   Detach _tank;
   _tank removeaction _id;

 }];
};
}];
/*
[[_truck,
["Attach Vehicle", { params ["_truck","_player"];
if ((vehicle _player) isKindOf "rhsusf_m1a2sep1d_usarmy") then {

_tank = vehicle _player;
  _tank attachTo [_truck,[0,-2,2]];
  _tank setDir 180;
  _tank addaction ["Detach", {

    params ["_tank","_player","_id"];
    _tank = vehicle _player;

  _pos = getposATL _player;
_riot1 =   _pos select 0;
  _riotriot1 = _riot1 + 5;
  _riot2 = _pos select 1;
  _riotriot2 = _riot2 + 5;
  _pos set [0,_riotriot1];
  _pos set [1,_riotriot2];

    _tank setpos _pos;

   Detach _tank;
   _tank removeaction _id;

 }];
};
}]],"addAction",true,true,true] call BIS_fnc_MP;
*/
/*
tank attachTo [truck, offset]


String or Code - Either path to the script file, relative to the mission folder or string with code or (since Take On Helicopters) the actual script code. If the string is a path to script file, the script file *must* have extension .SQS or .SQF (in Arma), or .SQS (in OFP). The script, whether it is a file or a code, will run in scheduled environment, i.e. it is ok to use sleep.
Parameters array passed to the script upon activation in _this variable is: [target, caller, ID, arguments]
target (_this select 0): Object - the object which the action is assigned to
caller (_this select 1): Object - the unit that activated the action
ID (_this select 2): Number - ID of the activated action (same as ID returned by addAction)
arguments (_this select 3): Anything - arguments given to the script if you are using the extended syntax
*/
