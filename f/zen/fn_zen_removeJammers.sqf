/*
Created By: Gibbs
*/
params ["_object"];

if (isNull _object) then
{
    systemChat "No unit found to remove jammers from.";
}
else
{
	[_object] remoteExec ["f_fnc_zen_doRemoveJammers", 2];
};
