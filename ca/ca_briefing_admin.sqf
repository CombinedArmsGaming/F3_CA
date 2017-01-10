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
|- <execute expression="" missionNamespace setVariable ['ca_hchidemarkers',false, true];"">
Show headless markers</execute><br/>
|- <execute expression=""missionNamespace setVariable ['ca_hchidemarkers',true, true];"">
Hide headless markers</execute><br/>
|- <execute expression="" hint format ['%1 for markers being hidden',ca_hchidemarkers]"">
Check headless marker status</execute><br/>
";
/*
_briefing = _briefing + "
<font size='18'>Ai spawn buttons </font><br/><br/>
|- <execute expression=""[['hill_west','hill_north','hill_east'],['ftl','ar','r','r','r'],'attackmarker',east] spawn ca_fnc_massattack"">
Spawn big wave on west, east and north hill</execute><br/>
";

*/
// ====================================================================================

// CREATE DIARY ENTRY

player createDiaryRecord ["diary", ["CA Admin",_briefing]];

// ====================================================================================
