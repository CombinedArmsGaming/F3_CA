// CA cba_settings.sqf 
// All settings not defined here will use the standard CBA settings defined in Configure addons menu (See https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System for more info)
// Make sure to change line 75 in description.ext if you delete this file

// ACE medical with reopening 80%
force ace_medical_ai_enabledFor = 2;
force ace_medical_AIDamageThreshold = 1;
force ace_medical_bleedingCoefficient = 1;
ace_medical_blood_bloodLifetime = 900;
force ace_medical_blood_enabledFor = 2;
ace_medical_blood_maxBloodObjects = 500;
force ace_medical_fatalDamageSource = 0;
ace_medical_feedback_bloodVolumeEffectType = 0;
ace_medical_feedback_painEffectType = 0;
force ace_medical_fractureChance = 0.8;
force ace_medical_fractures = 1;
ace_medical_gui_enableActions = 0;
force ace_medical_gui_enableMedicalMenu = 1;
force ace_medical_gui_enableSelfActions = true;
ace_medical_gui_interactionMenuShowTriage = 1;
force ace_medical_gui_maxDistance = 3;
force ace_medical_gui_openAfterTreatment = true;
force ace_medical_ivFlowRate = 3.5;
force ace_medical_limping = 1;
force ace_medical_painCoefficient = 1;
force ace_medical_playerDamageThreshold = 1;
force ace_medical_spontaneousWakeUpChance = 0.8;
force ace_medical_spontaneousWakeUpEpinephrineBoost = 7.5;
force ace_medical_statemachine_AIUnconsciousness = false;
ace_medical_statemachine_cardiacArrestBleedoutEnabled = true;
force ace_medical_statemachine_cardiacArrestTime = 120;
force ace_medical_statemachine_fatalInjuriesAI = 0;
force ace_medical_statemachine_fatalInjuriesPlayer = 1;
force ace_medical_treatment_advancedBandages = 2;
force ace_medical_treatment_advancedDiagnose = true;
force ace_medical_treatment_advancedMedication = true;
force ace_medical_treatment_allowBodyBagUnconscious = true;
ace_medical_treatment_allowLitterCreation = true;
force ace_medical_treatment_allowSelfIV = 1;
force ace_medical_treatment_allowSelfPAK = 1;
force ace_medical_treatment_allowSelfStitch = 1;
force ace_medical_treatment_allowSharedEquipment = 0;
force ace_medical_treatment_clearTraumaAfterBandage = false;
force ace_medical_treatment_consumePAK = 0;
force ace_medical_treatment_consumeSurgicalKit = 0;
force ace_medical_treatment_convertItems = 0;
force ace_medical_treatment_cprSuccessChance = 0.902491;
force ace_medical_treatment_holsterRequired = 0;
ace_medical_treatment_litterCleanupDelay = 600;
force ace_medical_treatment_locationEpinephrine = 0;
force ace_medical_treatment_locationPAK = 3;
force ace_medical_treatment_locationsBoostTraining = true;
force ace_medical_treatment_locationSurgicalKit = 3;
ace_medical_treatment_maxLitterObjects = 500;
force ace_medical_treatment_medicEpinephrine = 1;
force ace_medical_treatment_medicIV = 1;
force ace_medical_treatment_medicPAK = 2;
force ace_medical_treatment_medicSurgicalKit = 1;
force ace_medical_treatment_timeCoefficientPAK = 0.5;
force ace_medical_treatment_treatmentTimeAutoinjector = 5;
force ace_medical_treatment_treatmentTimeBodyBag = 10;
force ace_medical_treatment_treatmentTimeCPR = 12;
force ace_medical_treatment_treatmentTimeIV = 8;
ace_medical_treatment_treatmentTimeSplint = 7;
force ace_medical_treatment_treatmentTimeTourniquet = 3;
force ace_medical_treatment_woundReopenChance = 0.2;
force ace_medical_treatment_woundStitchTime = 2.5;

// ACEX Headless	
force acex_headless_delay = 15;	
force acex_headless_enabled = true;	
force acex_headless_endMission = 0;	
force acex_headless_log = false;	
force acex_headless_transferLoadout = 1;	

// ACRE 2	
force acre_sys_core_terrainLoss = 0;	


// ACE Crew Served Weapons - If using player operated CSWs you may want to remove this and update the settings to use the ammo handling, but be aware the AI does not interact well with this system so if you intend to use AI turrets leave this be
force ace_csw_ammoHandling = 0;
force ace_csw_defaultAssemblyMode = false;
ace_csw_dragAfterDeploy = false;
force ace_csw_handleExtraMagazines = false;
force ace_csw_progressBarTimeCoefficent = 1;