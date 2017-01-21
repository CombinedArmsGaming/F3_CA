/*
 * Author: Liberation & Poulern
 * Create markers to show fps on each headless client and the server.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [] spawn ca_fnc_hccount;
 *
 */
if (!isserver) exitwith {};
while {ca_hc} do {
_allHs = [];
_allHs = entities "HeadlessClient_F";
_notHCs = [];
 {
     if (!isplayer _x) then {
       _notHCs pushBack _x;
     };
 } forEach _allHs;
_allHCs = _allHs - _notHCs;

_hccounts = [];
{
  _headlessid = owner _x;
  _hcount = {groupOwner _x == _headlessid} count allGroups;
  _hccounts pushBack _hcount;
} forEach _allHCs;
missionNamespace setVariable ["ca_hccounts",_hccounts, true];
missionNamespace setVariable ["ca_hclist",_allHCs, true];
uisleep 0.1;
if (count _allHCs == 0) then {
  missionNamespace setVariable ["ca_hc",false, true];
  missionNamespace setVariable ["ca_hclist",[], true];
  missionNamespace setVariable ["ca_hccounts",[], true];
};
};
