// CA - Briefing
// ====================================================================================
if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
}; 

_version = getText (missionConfigFile >> "version");

_briefing = "";
_briefing = _briefing + format ["
<font size='20'>Player Controls</font><br/><br/>
|- <execute expression=""_handle=createdialog 'ca_hierarchydialog';"">
Platoon Hierarchy, wave respawn and marker management</execute><br/>
<br/>
<font size='20'>Addactions</font><br/><br/>
|- <execute expression=""ca_hierarchyaddaction = player addAction ['Hierarchy', {_handle=createdialog 'ca_hierarchydialog';}];"">
Add Platoon Hierarchy as an addaction for ease of access</execute><br/>
|- <execute expression=""player removeAction ca_hierarchyaddaction"">
Remove hierarchy addaction</execute><br/>
<br/>
<font size='20'>Admin actions</font><br/><br/>
|- <execute expression=""if (serverCommandAvailable '#kick') then { [] execvm 'ca\briefing\ca_briefing_admin.sqf'}else {hint 'You need to be an admin to get this!'};"">
Give self admin menu</execute><br/><br/>
<font size='20'>F3_CA Version: %1</font>
", _version];
// ====================================================================================
// CREATE DIARY ENTRY

player createDiaryRecord ["diary", ["CA Player Controls",_briefing]];
