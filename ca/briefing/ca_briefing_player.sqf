// CA - Briefing
// ====================================================================================
if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
}; 
_briefing = "";
_briefing = _briefing + "
<font size='20'>Player Controls</font><br/><br/>
|- <execute expression=""_handle=createdialog 'ca_hierarchydialog';"">
Platoon Hierarchy, wave respawn and marker management</execute><br/>
<br/>
<font size='20'>Addactions</font><br/><br/>
|- <execute expression=""player addAction ['Hierarchy', {_handle=createdialog 'ca_hierarchydialog';}];"">
Add Platoon Hierarchy as an addaction</execute><br/>
|- <execute expression=""removeAllActions player"">
Remove all addactions</execute><br/>
<br/>
<font size='20'>Admin actions</font><br/><br/>
|- <execute expression=""if (serverCommandAvailable '#kick') then { [] execvm 'ca\briefing\ca_briefing_admin.sqf'}else {hint 'You need to be an admin to get this!'};"">
Give self admin menu</execute><br/>
";
// ====================================================================================
// CREATE DIARY ENTRY

player createDiaryRecord ["diary", ["CA Player Controls",_briefing]];
