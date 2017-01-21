/*
 * Author: Poulern
 * Removes all gear from dead bodies, and removes their dropped weapons as well(Dropped items on the ground from inventory won't get removed).
 *
 *
 * Example:
 * [] spawn ca_fnc_bodymanage;
 *
init.sqf put in:
if(isserver) then {
  missionNamespace setVariable ['ca_bodymanageon',true, true];
  [] spawn ca_fnc_bodymanage;
};

<font size='18'>Body manager control</font><br/><br/>
|- <execute expression="" missionNamespace setVariable ['ca_bodymanageon',true, true]; [] remoteexec ['ca_fnc_bodymanage',2,true];"">
Turn on body manager</execute><br/>
|- <execute expression=""missionNamespace setVariable ['ca_bodymanageon',false, true];"">
Turn off body manager</execute><br/>
|- <execute expression="" hint format ['%1 for bodymanager being on',ca_bodymanageon]"">
Check bodymanager status</execute><br/>

*/
uisleep 5;

while {ca_bodymanageon} do {
  {
    _vest = vest _x;
    _uniform = uniform _x;
    removeVest _x;
    _x addVest _vest;
    removeUniform _x;
    _x forceAddUniform _uniform;
    removeAllWeapons _x;
  	removeAllItemsWithMagazines _x;
  	removeAllAssignedItems _x;
    clearMagazineCargoGlobal (unitBackpack _x);
    clearWeaponCargoGlobal (unitBackpack _x);
		clearMagazineCargoGlobal (unitBackpack _x);
		clearItemCargoGlobal (unitBackpack _x);

    } forEach allDeadMen;

{
    if (_x iskindof "WeaponHolderSimulated") then {
        deleteVehicle _x;
    };
    if(ca_deletevehicles && !alive _x) then {deleteVehicle _x}
} forEach vehicles;
  uisleep 5;

};
