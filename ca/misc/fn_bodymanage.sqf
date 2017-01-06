/*
init.sqf put in:
if(isserver) then {
  missionNamespace setVariable ['p_bodymanageon',true, true];
  [] spawn p_fnc_bodymanage;
};

<font size='18'>Body manager control</font><br/><br/>
|- <execute expression="" missionNamespace setVariable ['p_bodymanageon',true, true]; [] remoteexec ['p_fnc_bodymanage',2,true];"">
Turn on body manager</execute><br/>
|- <execute expression=""missionNamespace setVariable ['p_bodymanageon',false, true];"">
Turn off body manager</execute><br/>
|- <execute expression="" hint format ['%1 for bodymanager being on',p_bodymanageon]"">
Check bodymanager status</execute><br/>

*/
uisleep 5;

while {p_bodymanageon} do {
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
} forEach vehicles;
  uisleep 5;


};
