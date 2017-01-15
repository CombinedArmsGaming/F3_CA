/*
 * Author: Poulern
 * Returns the headless client with the least amount of AI assigned to it
 *
 *
 * Return Value:
 * Return Name <TYPE>
 *
 * Example:
 * [] call ca_fnc_hcfind
 *
 */

_HCaicounts = ca_hccounts;
_headlessclient = 2;
_hclist = [];
_hclist append _HCaicounts;
_hclist sort true;

if (count _hclist == 0) then {
 _headlessclient = 2;
}else{
 _hcid = _hclist select 0;
 _result = _HCaicounts find _hcid;
 if (_result == -1) then {
   _headlessclient = 2;
 } else {
   _headlessclient = ca_hclist select _result;
 };
};
 
 _headlessclient
