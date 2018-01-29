if (isDedicated) exitWith {};


_units = 
[
	[
		"NATO Infantry",
		"inf", "blu_f", west,
		[
			[
				"NATO Rifleman",
				["r"]
			],
		
			[
				"NATO Fireteam 6x",
				["ftl", "ar", "aar", "rat", "r", "r"]
			],
		
			[
				"NATO MAT Team",
				["matag", "matg"]
			],
			
			[
				"NATO MMG Team",
				["mmgag", "mmgg"]
			],
			
			[
				"NATO SAM Team",
				["msamag", "msamg"]
			],
			
			[
				"NATO Sniper Team",
				["sp", "sn"]
			],
			
			[
				"NATO Engineer Team",
				["eng", "eng", "engm", "engm"]
			],
			
			[
				"NATO Diver Team",
				["div", "div", "div", "div"]
			]
		]
	], 
	
	[
		"NATO Vehicles", 
		"veh", "blu_f", west,
		[
			[
				"M2A4 Slammer UP",
				"B_MBT_01_TUSK_F",
				["vc","vd","vg"]
			],
		
			[
				"AMV-7 Marshall",
				"B_APC_Wheeled_01_cannon_F",
				["vc","vd","vg"]
			],
			
			[
				"IFV-6c Panther",
				"B_APC_Tracked_01_rcws_F",
				["vc","vd","vg"]
			],
			
			[
				"Hunter MMG",
				"B_MRAP_01_MMG_F",
				["vc","vd","vg"]
			],
			
			[
				"HEMTT Transport",
				"B_Truck_01_transport_F",
				["vc","vd"]
			],
			
			[
				"UH-80 Ghost Hawk",
				"B_Heli_Transport_01_F",
				["pp","pp","pc","pcc"]
			],
			
			[
				"CH-67 Huron",
				"B_Heli_Transport_03_F",
				["pp","pp","pc","pcc"]
			],
			
			[
				"AH-99 Blackfoot",
				"B_Heli_Attack_01_F",
				["pp","pcc"]
			]
		]
	],
	
	[
		"CSAT Infantry",
		"inf", "opf_f", east,
		[
			[
				"CSAT Rifleman",
				["r"]
			],
		
			[
				"CSAT Fireteam 6x",
				["ftl", "ar", "aar", "rat", "r", "r"]
			],
		
			[
				"CSAT MAT Team",
				["matag", "matg"]
			],
			
			[
				"CSAT MMG Team",
				["mmgag", "mmgg"]
			],
			
			[
				"CSAT SAM Team",
				["msamag", "msamg"]
			],
			
			[
				"CSAT Sniper Team",
				["sp", "sn"]
			],
			
			[
				"CSAT Engineer Team",
				["eng", "eng", "engm", "engm"]
			],
			
			[
				"CSAT Diver Team",
				["div", "div", "div", "div"]
			]
		]
	], 
	
	[
		"CSAT Vehicles", 
		"veh", "opf_f", east,
		[
			[
				"T-100 Varsuk",
				"O_MBT_02_cannon_F",
				["vc","vd","vg"]
			],
		
			[
				"MSE-3 Marid",
				"O_APC_Wheeled_02_rcws_F",
				["vc","vd","vg"]
			],
			
			[
				"BTR-K Kamysh",
				"O_APC_Tracked_02_cannon_F",
				["vc","vd","vg"]
			],
			
			[
				"Ifrit MMG",
				"O_MRAP_02_MMG_F",
				["vc","vd","vg"]
			],
			
			[
				"Zamak Transport",
				"O_Truck_02_transport_F",
				["vc","vd"]
			],
			
			[
				"PO-30 Orca",
				"O_Heli_Light_02_unarmed_F",
				["pp","pcc"]
			],
			
			[
				"Mi-290 Taru",
				"O_Heli_Transport_04_covered_F",
				["pp","pc","pcc"]
			],
			
			[
				"Mi-48 Kajman",
				"O_Heli_Attack_02_black_F",
				["pp","pcc"]
			]
		]
	],
	
	[
		"AAF Infantry",
		"inf", "ind_f", independent,
		[
			[
				"AAF Rifleman",
				["r"]
			],
		
			[
				"AAF Fireteam 6x",
				["ftl", "ar", "aar", "rat", "r", "r"]
			],
		
			[
				"AAF MAT Team",
				["matag", "matg"]
			],
			
			[
				"AAF MMG Team",
				["mmgag", "mmgg"]
			],
			
			[
				"AAF SAM Team",
				["msamag", "msamg"]
			],
			
			[
				"AAF Sniper Team",
				["sp", "sn"]
			],
			
			[
				"AAF Engineer Team",
				["eng", "eng", "engm", "engm"]
			],
			
			[
				"AAF Diver Team",
				["div", "div", "div", "div"]
			]
		]
	],
	
	[
		"AAF Vehicles", 
		"veh", "ind_f", independent,
		[
			[
				"MBT-52 Kuma",
				"I_MBT_03_cannon_F",
				["vc","vd","vg"]
			],
		
			[
				"AFV-4 Gorgon",
				"I_APC_Wheeled_03_cannon_F",
				["vc","vd","vg"]
			],
			
			[
				"FV-720 Mora",
				"I_APC_Tracked_03_cannon_F",
				["vc","vd","vg"]
			],
			
			[
				"Strider MMG",
				"I_MRAP_03_MMG_F",
				["vc","vd","vg"]
			],
			
			[
				"Zamak Transport",
				"I_Truck_02_transport_F",
				["vc","vd"]
			],
			
			[
				"WY-55 Hellcat (Unarmed)",
				"I_Heli_light_03_unarmed_F",
				["pp","pcc"]
			],
			
			[
				"CH-49 Mohawk",
				"I_Heli_Transport_02_F",
				["pp","pcc"]
			],
			
			[
				"WY-55 Hellcat",
				"I_Heli_light_03_F",
				["pp","pcc"]
			]
		]
	]
	
];

ca_zeus_unitsStructure = _units;