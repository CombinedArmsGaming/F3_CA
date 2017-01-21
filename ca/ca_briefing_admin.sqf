// CA - Briefing
// ====================================================================================
_briefing = "";
_briefing = _briefing + "
<font size='18'>Body manager control</font><br/><br/>
|- <execute expression="" missionNamespace setVariable ['ca_bodymanageon',true, true]; [] remoteexec ['ca_fnc_bodymanage',2,true];"">
Turn on body manager</execute><br/>
|- <execute expression=""missionNamespace setVariable ['ca_bodymanageon',false, true];"">
Turn off body manager</execute><br/>
|- <execute expression="" hint format ['%1 for bodymanager being on',ca_bodymanageon]"">
Check bodymanager status</execute><br/>
<font size='18'>Headless client markers(Global)</font><br/><br/>
|- <execute expression="" missionNamespace setVariable ['ca_hcshowmarkers',true, true];"">
Show headless markers</execute><br/>
|- <execute expression=""missionNamespace setVariable ['ca_hcshowmarkers',false, true];"">
Hide headless markers</execute><br/>
|- <execute expression="" hint format ['%1 for markers being shown',ca_hcshowmarkers]"">
Check headless marker status</execute><br/>
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
