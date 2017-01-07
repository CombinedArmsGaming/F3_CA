/*
 * Author: Poulern
 * Description: Initializes the headless framework component
 *
 */
 if !(isServer) exitWith {};
_allHCs = entities "HeadlessClient_F";
[] spawn ca_fnc_hccount;
[] spawn ca_fnc_hcmarker;

if (count _allHCs == 0) then {
  missionNamespace setVariable ["ca_hc",false, true];
} else {
  missionNamespace setVariable ["ca_hc",true, true];
};
