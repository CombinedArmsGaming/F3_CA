/*
 * Author: Poulern
 * Execute on the headless client with the least amount of ai the function called;
 *
 * Arguments:
 * 0: Function parameters(_this for most functions). For scripts the normal parameters to the function.
 * 1: Function name(Accessable by passing the magic variable _fnc_scriptName). Alternatively for scripts "ca_fnc_spawngroup"
 * Return Value:
 * Nothing
 *
 * Example:
 * [_this,_fnc_scriptName] call ca_fnc_hcexec;
 * [[["ftl","r","ar","m"],"spawnmarker",west],"ca_fnc_spawngroup"] call ca_fnc_hcexec; (Rather redudant since that function already does that)
 * All functions must be called in that way if called from a function, for scripts use it like the SQF command remoteExec, but with an automatic target.
 *
 */
params ["_fncparameters","_fncname"];
//Sleep for a random amount of time, if not then all the ai might spawn on 1 headless client.
_time = random [0,5,15];
uisleep _time;
_hc = [] call ca_fnc_hcfind;

_fncparameters remoteExec [_fncname, _hc];
