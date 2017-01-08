/*
 * Author: Poulern
 * Description: Initializes the headless framework component
 *
 */
 if !(isServer) exitWith {};
_allHCs = entities "HeadlessClient_F";

if (count _allHCs == 0) then {
  missionNamespace setVariable ["ca_hc",false, true];
  missionNamespace setVariable ["ca_hclist",[], true];
  missionNamespace setVariable ["ca_hccounts",[], true];
} else {
  missionNamespace setVariable ["ca_hc",true, true];
};
[] spawn ca_fnc_hccount;
[] spawn ca_fnc_hcmarker;
