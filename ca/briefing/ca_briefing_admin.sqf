// CA - Briefing
// ====================================================================================
if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

_briefing = "";
_briefing = _briefing + "
<font size='18'>Side ticket control</font><br/><br/>
|- <execute expression=""_newnumb = ca_WestTickets + 50; missionNamespace setVariable ['ca_WestTickets',_newnumb, true];"">
Give side west +50 tickets</execute><br/>
|- <execute expression=""_newnumb = ca_EastTickets + 50; missionNamespace setVariable ['ca_EastTickets',_newnumb, true];"">
Give side east +50 tickets</execute><br/>
|- <execute expression=""_newnumb = ca_IndependentTickets + 50; missionNamespace setVariable ['ca_IndependentTickets',_newnumb, true];"">
Give side independent +50 tickets</execute><br/>
<br/>
<font size='18'>Headless client markers(Global)</font><br/><br/>
|- <execute expression="" missionNamespace setVariable ['ca_hcshowmarkers',true, true];"">
Show headless markers</execute><br/>
|- <execute expression=""missionNamespace setVariable ['ca_hcshowmarkers',false, true];"">
Hide headless markers</execute><br/>
|- <execute expression="" hint format ['%1 for markers being shown',ca_hcshowmarkers]"">
Check headless marker status</execute><br/>
<font size='18'>F3 admin menu</font><br/><br/>
|- <execute expression="" [] execvm 'f\briefing\f_briefing_admin.sqf' "">
Give self F3 admin menu</execute><br/>
<font size='18'>Respawn system</font><br/><br/>
<font size='14'>Note that the marker will only be moved if respawn mode is set to 2 (spawn on co)</font><br/><br/>
|- <execute expression=""hint 'Wave spawned!'; [] remoteExec ['ca_fnc_respawnwaveserver', 2];"">
Force respawn wave to happen even with 0 waves (Doesn't move respawn marker)</execute><br/>
|- <execute expression=""hint 'Wave spawned!'; [] call ca_hierarchydialog;"">
Spawn respawn wave(Move respawn marker)</execute><br/>
<br/>
|- <execute expression=""missionNamespace setVariable ['ca_respawnmode',0, true];"">
Disable respawn (set respawnmode to 0)</execute><br/>
|- <execute expression=""missionNamespace setVariable ['ca_respawnmode',1, true];"">
Set respawn mode to base (set respawnmode to 1)</execute><br/>
|- <execute expression=""missionNamespace setVariable ['ca_respawnmode',2, true];"">
Set respawn mode to CO waves (set respawnmode to 2)</execute><br/>
|- <execute expression=""missionNamespace setVariable ['ca_respawnmode',3, true];"">
Set respawn mode to group respawn (set respawnmode to 3)</execute><br/>
<br/>
|- <execute expression=""missionNamespace setVariable ['ca_wavecooldown',1, true];"">
Set respawn wave time to 1 minutes</execute><br/>
|- <execute expression=""missionNamespace setVariable ['ca_wavecooldown',540, true];"">
Set respawn wave time to 10 minutes</execute><br/>
|- <execute expression=""missionNamespace setVariable ['ca_wavecooldown',1740, true];"">
Set respawn wave time to 30 minutes</execute><br/>
";
/*
_briefing = _briefing + "
<font size='18'>Ai spawn buttons </font><br/><br/>
|- <execute expression=""[['SC1_CA','SC1_CA_1','SC1_CA_2'],['ftl','ar','r','r','r'],'SC1_CA_A','opf_f',east] spawn ca_fnc_massattack"">
Spawn big wave on west, east and north hill</execute><br/>
";

*/
// ====================================================================================

// CREATE DIARY ENTRY

player createDiaryRecord ["diary", ["CA Admin",_briefing]];

// ====================================================================================
