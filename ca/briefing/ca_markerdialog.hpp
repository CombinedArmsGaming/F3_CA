
class ca_groupid
{
	idd= 1995;
	movingenable=false;
    onLoad= "[] spawn { [] execvm 'ca\briefing\ca_marker_listboxfill.sqf'}";
	class controls
	{

	        class frame: RscFrame
	        {
	        	idc = 1800;
			style = ST_HUD_BACKGROUND;
	    		colorBackground[] = {0,0,0,0.7};
			text = "Callsign and marker Management System";
            x = 50 * 0.00126263 * 8 + safeZoneX;
            y = 29 * 0.0016835 * 8 + safeZoneY;
            w = 325 * (0.00126263 * 2);
            h = 220 * (0.0016835 * 2);
	        };
	        class infotext: RscFrame
	        {
		    idc = -1;
		    style = ST_HUD_BACKGROUND;
		    colorBackground[] = {0,0,0,0.7};
		    text = "Enter groupid(callsign) below";
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 32 * 0.0016835 * 8 + safeZoneY;
            w = 100 * (0.00126263 * 2);
            h = 30 * (0.0016835 * 2);
	        };
	        class edittype: RscEdit
	        {
	        	idc = 1400;
	        	text = "";
				x = 52 * 0.00126263 * 8 + safeZoneX;
				y = 42 * 0.0016835 * 8 + safeZoneY;
				w = 100 * (0.00126263 * 2);
				h = 30 * (0.0016835 * 2);
	        };
	        class button: RscButton
	        {
	        	idc = -1;
	        	text = "Apply";
				x = 52 * 0.00126263 * 8 + safeZoneX;
				y = 70 * 0.0016835 * 8 + safeZoneY;
				w = 50 * (0.00126263 * 2);
				h = 30 * (0.0016835 * 2);
	            action =  "(ca_selectedgroup) setgroupidglobal [ctrlText 1400]; _ind1 = lbCurSel 1500;(ca_selectedgroup) setVariable ['ca_groupcolor',(lbData [1500,_ind1]),true]; _ind2 = lbCurSel 1501; (ca_selectedgroup) setVariable ['ca_grouptype', (lbData [1501,_ind2]),true]; closeDialog 0; [] execvm 'ca\hierarchy\ca_hierarchydialogsupport.sqf';";
	            //closeDialog 0;
	        };
	        class button1: RscButton
	        {
	            idc = -1;
	            text = "Close";
				x = 70 * 0.00126263 * 8 + safeZoneX;
				y = 70 * 0.0016835 * 8 + safeZoneY;
				w = 50 * (0.00126263 * 2);
				h = 30 * (0.0016835 * 2);
	            action =  "closeDialog 0;";
	        };
	        class listbox1: RscListbox
	        {
	        	idc = 1500;
				x = 85 * 0.00126263 * 8 + safeZoneX;
				y = 30 * 0.0016835 * 8 + safeZoneY;
				w = 55 * (0.00126263 * 2);
				h = 200 * (0.0016835 * 2);
	        };
	        class listbox2: RscListbox
	        {
			idc = 1501;
				x = 100 * 0.00126263 * 8 + safeZoneX;
				y = 30 * 0.0016835 * 8 + safeZoneY;
				w = 55 * (0.00126263 * 2);
				h = 200 * (0.0016835 * 2);
	        };
	        class pic: RscPicture
	        {
	            idc = 1200;
	            text = "ca\briefing\ca_markers.jpg";
				x = 115 * 0.00126263 * 8 + safeZoneX;
				y = 30 * 0.0016835 * 8 + safeZoneY;
				w = 55 * (0.00126263 * 2);
				h = 200 * (0.0016835 * 2);
	        };
	};
};
