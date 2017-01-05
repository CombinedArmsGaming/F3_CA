/*
 * Author: Poulern
 * Description: Initializes the headless framework component
 *
 *
 */
 if !(isServer) exitWith {};
_allHCs = entities "HeadlessClient_F";

if (count _allHCs == 0) then {
  missionNamespace setVariable ["ca_hc",false, true];
  [] spawn ca_fnc_hcmarker;
} else {
  missionNamespace setVariable ["ca_hc",true, true];
  uiSleep 1;
  [] spawn ca_fnc_hccount;
  [] spawn ca_fnc_hcmarker;
  { remoteExec ["ca_fnc_hcmarker", _x]; } forEach _allHCs;
};
