Config = {}

Config.Key = 47

Config.AutoCamPosition = true 

Config.AutoCamRotation = true 

Config.HideMinimap = true 

Config.UseOkokTextUI = true 

Config.CameraAnimationTime = 1000 

Config.TalkToNPC = {
	-- ============================================================================================================================================== --
-- ===============================================> ON/OFF DUTY POLITIE/MEDICI <================================================================= --
-- ============================================================================================================================================== --
  { -- ON/OFF DUTY Politie Los Santos
npc = 's_m_m_ciasec_01', 										
header = 'Politia Los Santos', 									
name = '[ ON/OFF DUTY ] Politie',							
uiText = "Angajat Politie",									
dialog = 'Cu ce te pot ajuta?',							
coordinates = vector3(484.99990844726,-999.19348144532,29.689630508422), 			
heading = 358.40875244141,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 2, 								
options = {													
	{'Vreau sa imi deschid pontajul!', 'fpt-dutypolitie:client:addGroup', 'c'},		
	{'Vreau sa imi inchid pontajul!', 'fpt-dutypolitie:client:removeGroup', 'c'},
},
scenario = "WORLD_HUMAN_CLIPBOARD",
  },	


  { -- ON/OFF DUTY Politie Los Santos
  npc = 's_m_m_ciasec_01', 										
  header = 'showroom', 									
  name = '[ ON/OFF DUTY ] Politie',							
  uiText = "Angajat Politie",									
  dialog = 'Cu ce te pot ajuta?',							
  coordinates = vector3(-67.986549377441,72.829200744629,71.899681091309), 			
  heading = 358.40875244141,										
  camOffset = vector3(0.0, 0.0, 0.0), 						
  camRotation = vector3(0.0, 0.0, 0.0),					
  interactionRange = 2, 								
  options = {													
	  {'Vreau sa imi deschid showrooom-ul', 'fp-dealership:viewCatalog', 'c'},		
  },
  scenario = "WORLD_HUMAN_CLIPBOARD",
	},	
-------------------------------------------------------------------------------------------------------------------------------------------------------	
  { -- ON/OFF DUTY Medici Los Santos
npc = 's_m_m_doctor_01', 										
header = 'Spitalul Los Santos', 									
name = '[ ON/OFF DUTY ] Medici',							
uiText = "Angajat Spital",									
dialog = 'Cu ce te pot ajuta?',							
coordinates = vector3(-808.6689453125,-1211.3139648438,6.337426185608), 			
heading = 255.77716064453,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 2, 								
options = {													
	{'Vreau sa imi deschid pontajul!', 'fpt-dutymedici:client:addGroup', 'c'},		
	{'Vreau sa imi inchid pontajul!', 'fpt-dutymedici:client:removeGroup', 'c'},
},
scenario = "WORLD_HUMAN_CLIPBOARD",
  }, 
	{ -- Showroom 
	npc = 'ig_jewelass', 										
	header = 'Los Santos', 									
	name = 'Showroom',							
	uiText = "Angajat Showroom",									
	dialog = 'Cu ce te pot ajuta?',							
	coordinates = vector3(-638.7430, -107.4291, 36.9964),			
	heading = 130.42211914063,										
	camOffset = vector3(0.0, 0.0, 0.0), 						
	camRotation = vector3(0.0, 0.0, 0.0),					
	interactionRange = 2, 								
	options = {													
		{'Doresc sa cumpar o masina!', 'fpt-showroom:openUI', 'c'},	
		{'Am nevoie de chei!', 'flchei:chei', 's'},
	},
	scenario = "WORLD_HUMAN_CLIPBOARD",
},
{ -- JOB Petrolist
npc = 'g_m_y_korean_01', 										
header = 'Petrolist', 									
name = '[ JOB ] Petrolist',							
uiText = "Feng Petrolistul",									
dialog = 'Vrei sa te angajezi?',							
coordinates = vector3(2682.4816894532,1381.3880615234,23.539306640625), 			
heading = 272.42834472656,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 3, 								
options = {															
	{'In ce consta aceasta munca?', 'fpt-petrolist:client:munca', 'c'},		
	{'Trebuie sa imi iau o uniforma?', 'fpt-petrolist:client:uniforma', 'c'},
	{'Vreau sa-mi iau uniforma.', 'fpt-petrolist:client:addUniforma', 'c'},
	{'Imi vreau hainele inapoi.', 'fpt-petrolist:client:removeUniforma', 'c'},
	{"Vreau sa ma angajez.", 'fpt-petrolist:client:addGroup', 'c'}, 
	{"Nu mai vreau sa lucrez.", 'fpt-petrolist:client:removeGroup', 'c'},
	{'Am nevoie de Licenta?', 'fpt-petrolist:client:licenta', 'c'},		
	{'Am nevoie de Atestat?', 'fpt-petrolist:client:atestat', 'c'}	
},
scenario = "WORLD_HUMAN_CLIPBOARD",
jobs = {},
},
{ 
	npc = 'a_f_y_eastsa_01', 										
	header = 'Pescar', 									
	name = 'Pescar - Magazin',							
	uiText = "Raluca Vanzatoarea",									
	dialog = 'Buna ziua!',							
	coordinates = vector3(-1598.3098144532,5200.8989257812,3.3873376846314), 			
	heading = 70.434783935547,										
	camOffset = vector3(0.0, 0.0, 0.0), 						
	camRotation = vector3(0.0, 0.0, 0.0),					
	interactionRange = 2, 								
	options = {													
		{'Vreau sa vand un peste auriu.', 'fpt-pescar:client:pestisoriiAurii', 'c'},		
		{'Am nevoie de Licenta?', 'fpt-pescar:client:licenta', 'c'},
		{"Vreau sa vand pestii.", 'fpt-pescar:client:vindePesti', 'c'}, 
		{"Vreau sa cumpar momeala.", 'fpt-pescar:client:cumparaMomeala', 'c'}, 
	},
},
{ -- JOB Pescar Avansat
npc = 'mp_m_freemode_01', 										
header = 'Pescar', 									
name = '[ JOB ] Pescar Avansat',							
uiText = "Quan Pescarul",									
dialog = 'Vrei sa prinzi alt fel de pesti?',							
coordinates = vector3(-1599.44140625,5225.4731445312,2.9782567024231), 			
heading = 114.78230285645,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 1, 								
options = {													
	{'Ce trebuie sa fac aici?', 'fpt-pescaravansat:client:munca', 'c'},		
	{'Cum trebuie sa ma imbrac?', 'fpt-pescaravansat:client:uniforma', 'c'},
	{"Vreau sa ma angajez.", 'fpt-pescaravansat:client:addGroup', 'c'}, 
	{"Nu mai vreau sa lucrez.", 'fpt-pescaravansat:client:removeGroup', 'c'}, 
	{"Vreau sa cumpar undite.", 'fpt-pescaravansat:client:undite', 'c'},
	{"Ce momeala imi trebuie?", 'fpt-pescaravansat:client:momeala', 'c'}
},
face = 21,
facetexture = 15,
barba = 6,
uniforma = {
	["drawable:2"] = {1,0}, -- Par
	["drawable:3"] = {30,1}, -- Maini
	["drawable:4"] = {9,14}, -- Pantaloni
	["drawable:6"] = {12,15}, -- Incaltaminte
	["drawable:8"] = {15,0}, -- Tricou
	["drawable:11"] = {210,17} -- Geaca
},
scenario = "WORLD_HUMAN_STAND_FISHING",
jobs = {},
},
{ -- JOB Pescar
npc = 'a_m_o_beach_01',
header = 'Pescar',							
name = '[ JOB ] Pescar',							
uiText = "Marinica Pescarul",									
dialog = 'Vrei sa pescuiesti?',							
coordinates = vector3(1320.9957275391,4314.5830078125,37.146671295166), 			
heading = 90.65231323242,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 1, 								
options = {											
	{'Ce trebuie sa fac aici?', 'fpt-pescar:client:munca', 'c'},		
	{'Cum trebuie sa ma imbrac?', 'fpt-pescar:client:uniforma', 'c'},
	{"Vreau sa ma angajez.", 'fpt-pescar:client:addGroup', 'c'}, 
	{"Nu mai vreau sa lucrez.", 'fpt-pescar:client:removeGroup', 'c'}, 
},
scenario = "WORLD_HUMAN_AA_COFFEE",
jobs = {},
},
  { -- JOB Postas 
  npc = 's_m_m_postal_01', 										
  header = 'Postas', 									
  name = '[ JOB ] Sofer la Posta Romana',							
  uiText = "Mitica Postasul",									
  dialog = 'Doresti sa lucrezi?',							
  coordinates = vector3(134.12384033204,95.53279876709,82.507537841796), 			
  heading = 121.62894439697,										
  camOffset = vector3(0.0, 0.0, 0.0), 						
  camRotation = vector3(0.0, 0.0, 0.0),					
  interactionRange = 1, 								
  options = {													
	  {'In ce consta aceasta munca?', 'fpt-posta:client:munca', 'c'},		
	  {'Trebuie sa imi iau o uniforma?', 'fpt-posta:client:uniforma', 'c'},
	  {'Vreau sa-mi iau uniforma.', 'fpt-posta:client:addUniforma', 'c'},
	  {'Imi vreau hainele inapoi.', 'fpt-posta:client:removeUniforma', 'c'},
	  {"Vreau sa ma angajez.", 'fpt-posta:client:addGroup', 'c'}, 
	  {"Nu mai vreau sa lucrez.", 'fpt-posta:client:removeGroup', 'c'}, 
  },
  scenario = "WORLD_HUMAN_CLIPBOARD",
 },
 -------------------------------------------------------------------------------------------------------------------------------------------------------		
 { -- JOB Sofer Autobuz
 npc = 'ig_popov', 										
 header = 'Autobuz - R.A.T.S.', 									
 name = '[ JOB ] Sofer Autobuz R.A.T.S.',							
 uiText = "Gica Soferul de Autobuz",									
 dialog = 'Vrei sa te angajezi?',							
 coordinates = vector3(436.17395019532,-645.83703613282,27.740352630616), 			
 heading = 83.292098999023,										
 camOffset = vector3(0.0, 0.0, 0.0), 						
 camRotation = vector3(0.0, 0.0, 0.0),					
 interactionRange = 1, 								
 options = {													
	 {'In ce consta aceasta munca?', 'fpt-autobuz:client:munca', 'c'},		
	 {'Trebuie sa imi iau o uniforma?', 'fpt-autobuz:client:uniforma', 'c'},
	 {'Vreau sa-mi iau uniforma.', 'fpt-autobuz:client:addUniforma', 'c'},
	 {'Imi vreau hainele inapoi.', 'fpt-autobuz:client:removeUniforma', 'c'},
	 {"Vreau sa ma angajez.", 'fpt-autobuz:client:addGroup', 'c'}, 
	 {"Nu mai vreau sa lucrez.", 'fpt-autobuz:client:removeGroup', 'c'}, 
 },
 scenario = "WORLD_HUMAN_CLIPBOARD",
},

{ -- JOB Sofer la Urgent Cargus
npc = 's_m_m_postal_02', 										
header = 'Manager', 									
name = '[ JOB ] Sofer la Urgent Cargus',							
uiText = "Daniel Managerul",									
dialog = 'Doresti sa lucrezi?',							
coordinates = vector3(-428.89440917968,-2788.5339355468,5.5369272232056), 			
heading = 216.73028564453,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 2, 								
options = {													
	{'In ce consta aceasta munca?', 'fpt-ups:client:munca', 'c'},		
	{'Trebuie sa imi iau o uniforma?', 'fpt-ups:client:uniforma', 'c'},
	{'Vreau sa-mi iau uniforma.', 'fpt-ups:client:addUniforma', 'c'},
	{'Imi vreau hainele inapoi.', 'fpt-ups:client:removeUniforma', 'c'},
	{"Vreau sa ma angajez.", 'fpt-ups:client:addGroup', 'c'}, 
	{"Nu mai vreau sa lucrez.", 'fpt-ups:client:removeGroup', 'c'}, 
},
scenario = "WORLD_HUMAN_CLIPBOARD",
jobs = {},
}, 

-------------------------------------------------------------------------------------------------------------------------------------------------------		
{ -- JOB Sofer Autobuz Avansat
 npc = 'ig_oneil', 										
 header = 'Autobuz - Sofer Avansat', 									
 name = '[ JOB ] Sofer Autobuz Avansat',							
 uiText = "Ghita Soferul de Autobuz",									
 dialog = 'Vrei sa te angajezi?',							
 coordinates = vector3(438.1728515625,-624.40051269532,27.708665847778), 			
 heading = 83.292098999023,										
 camOffset = vector3(0.0, 0.0, 0.0), 						
 camRotation = vector3(0.0, 0.0, 0.0),					
 interactionRange = 1, 								
 options = {													
	 {'In ce consta aceasta munca?', 'fpt-autobuzavansat:client:munca', 'c'},		
	 {'Trebuie sa imi iau o uniforma?', 'fpt-autobuzavansat:client:uniforma', 'c'},
	 {'Vreau sa-mi iau uniforma.', 'fpt-autobuzavansat:client:addUniforma', 'c'},
	 {'Imi vreau hainele inapoi.', 'fpt-autobuzavansat:client:removeUniforma', 'c'},
	 {"Vreau sa ma angajez.", 'fpt-autobuzavansat:client:addGroup', 'c'}, 
	 {"Nu mai vreau sa lucrez.", 'fpt-autobuzavansat:client:removeGroup', 'c'}, 
 },
 scenario = "WORLD_HUMAN_AA_SMOKE",

},
-------------------------------------------------------------------------------------------------------------------------------------------------------		
{ -- JOB Mecanic
npc = 's_m_m_lathandy_01', 										
header = 'Mecanic', 									
name = '[ JOB ] Mecanic',							
uiText = "Piulita Mecanicul",									
dialog = 'Vrei sa lucrezi ca Mecanic?',							
coordinates = vector3(1776.4910888672,3322.0939941406,40.433391571044), 			
heading = 32.712265014648,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 2, 								
options = {													
	{'In ce consta aceasta munca?', 'fpt-mecanic:client:munca', 'c'},		
	{'Trebuie sa imi iau o uniforma?', 'fpt-mecanic:client:uniforma', 'c'},
	{'Vreau sa-mi iau uniforma.', 'fpt-mecanic:client:addUniforma', 'c'},
	{'Imi vreau hainele inapoi.', 'fpt-mecanic:client:removeUniforma', 'c'},
	{"Vreau sa ma angajez.", 'fpt-mecanic:client:addGroup', 'c'}, 
	{"Nu mai vreau sa lucrez.", 'fpt-mecanic:client:removeGroup', 'c'},
	{'Am nevoie de Licenta?', 'fpt-mecanic:client:licenta', 'c'},
	{'Ce masini ai voie sa tractez?', 'fpt-mecanic:client:munca2', 'c'}
},
scenario = "WORLD_HUMAN_CLIPBOARD",

},
-- { -- JOB Gunoier 
-- npc = 's_m_y_garbage', 										
-- header = 'Polaris', 									
-- name = '[ JOB ] Gunoier',							
-- uiText = "Azey Gunoierul",									
-- dialog = 'Vrei sa te angajezi?',							
-- coordinates = vector3(-484.6681213379,-1730.8748779296,18.549253463746), 			
-- heading = 152.24160766602,										
-- camOffset = vector3(0.0, 0.0, 0.0), 						
-- camRotation = vector3(0.0, 0.0, 0.0),					
-- interactionRange = 1, 								
-- options = {													
-- 	{'In ce consta aceasta munca?', 'fpt-gunoier:client:munca', 'c'},		
-- 	{'Trebuie sa imi iau o uniforma?', 'fpt-gunoier:client:uniforma', 'c'},
-- 	{'Vreau sa-mi iau uniforma.', 'fpt-gunoier:client:addUniforma', 'c'},
-- 	{'Imi vreau hainele inapoi.', 'fpt-gunoier:client:removeUniforma', 'c'},
-- 	{"Vreau sa ma angajez.", 'fpt-gunoier:client:addGroup', 'c'}, 
-- 	{"Nu mai vreau sa lucrez.", 'fpt-gunoier:client:removeGroup', 'c'}, 
-- },
-- scenario = "WORLD_HUMAN_CLIPBOARD", 
--  },
 {  -- JOB Santierist
		npc = 's_m_y_airworker', 										
		header = 'Sef de Santier', 									
		name = '[ JOB ] Santierist',							
		uiText = "Ninel Santieristul",									
		dialog = 'Vrei sa lucrezi?',							
		coordinates = vector3(894.52319335938,3572.4328613281,32.578590393066), 			
		heading = 344.8798828125,										
		camOffset = vector3(0.0, 0.0, 0.0), 						
		camRotation = vector3(0.0, 0.0, 0.0),					
		interactionRange = 1, 								
		options = {													
			{'In ce consta aceasta munca?', 'fpt-santierist:client:munca', 'c'},		
			{'Trebuie sa imi iau o uniforma?', 'fpt-santierist:client:uniforma', 'c'},
			{'Vreau sa-mi iau uniforma.', 'fpt-santierist:client:addUniforma', 'c'},
			{'Imi vreau hainele inapoi.', 'fpt-santierist:client:removeUniforma', 'c'},
			{"Vreau sa ma angajez.", 'fpt-santierist:client:addGroup', 'c'}, 
			{"Nu mai vreau sa lucrez.", 'fpt-santierist:client:removeGroup', 'c'}, 
			{"Vreau sa cumpar picamere.", 'fpt-santierist:client:picamere', 'c'}
		},
		scenario = "WORLD_HUMAN_CLIPBOARD",
	},
	{ -- JOB Constructor Penitenciar 
		npc = 's_m_y_construct_01', 										
		header = 'Constructor', 									
		name = '[ JOB ] Constructor Penitenciar',							
		uiText = "Dorel Constructorul",									
		dialog = 'Vrei sa-mi dai o mana de ajutor?',							
		coordinates = vector3(1714.6986083984,2520.7897949218,44.564884185792), 			
		heading = 119.54510498047,										
		camOffset = vector3(0.0, 0.0, 0.0), 						
		camRotation = vector3(0.0, 0.0, 0.0),					
		interactionRange = 1, 								
		options = {													
			{'Ce trebuie sa fac?', 'fpt-constructor:client:munca', 'c'},		
			{'Trebuie sa imi iau alta uniforma?', 'fpt-constructor:client:uniforma', 'c'},
			{'Vreau sa-mi iau uniforma.', 'fpt-constructor:client:addUniforma', 'c'},
			{'Imi vreau hainele inapoi.', 'fpt-constructor:client:removeUniforma', 'c'},
			{"Vreau sa te ajut cu munca.", 'fpt-constructor:client:addGroup', 'c'}, 
			{"Nu mai vreau sa te ajut.", 'fpt-constructor:client:removeGroup', 'c'}, 
			{"Am nevoie de ciocane.", 'fpt-constructor:client:ciocane', 'c'}
		},
		scenario = "WORLD_HUMAN_TOURIST_MAP",
	}, 

{ -- JOB Spalator Penitenciar
	npc = 's_m_m_migrant_01', 										
	header = 'Ingrijitor', 									
	name = '[ JOB ] Spalator Penitenciar',							
	uiText = "Jean Ingrijitorul",									
	dialog = 'Vrei sa-mi dai o mana de ajutor?',							
	coordinates = vector3(1761.9505615234,2593.5070800782,44.797821044922), 			
	heading = 270.23315429688,										
	camOffset = vector3(0.0, 0.0, 0.0), 						
	camRotation = vector3(0.0, 0.0, 0.0),					
	interactionRange = 2, 								
	options = {													
		{'Ce trebuie sa fac?', 'fpt-spalator:client:munca', 'c'},		
		{'Trebuie sa imi iau o uniforma?', 'fpt-spalator:client:uniforma', 'c'},
		{"Vreau sa te ajut cu munca.", 'fpt-spalator:client:addGroup', 'c'}, 
		{"Nu mai vreau sa te ajut.", 'fpt-spalator:client:removeGroup', 'c'}, 
		{"Am nevoie de carpe.", 'fpt-spalator:client:carpe', 'c'}
	},
	scenario = "WORLD_HUMAN_JANITOR",
  },
	-------------------------------------------------------------------------------------------------------------------------------------------------------		
	{ -- JOB Sofer pe Tir
		npc = 'ig_cletus', 										
		header = 'Sofer pe Tir', 									
		name = '[ JOB ] Sofer pe Tir',							
		uiText = "Ionut Tiristul",									
		dialog = 'Vrei sa te angajezi?',							
		coordinates = vector3(-52.10629272461,-2522.9514160156,6.4011750221252), 			
		heading = 80.484031677246,										
		camOffset = vector3(0.0, 0.0, 0.0), 						
		camRotation = vector3(0.0, 0.0, 0.0),					
		interactionRange = 2, 								
		options = {													
			{'In ce consta aceasta munca?', 'fpt-tirist:client:munca', 'c'},		
			{'Trebuie sa imi iau o uniforma?', 'fpt-tirist:client:uniforma', 'c'},
			{"Vreau sa ma angajez.", 'fpt-tirist:client:addGroup', 'c'}, 
			{"Nu mai vreau sa lucrez.", 'fpt-tirist:client:removeGroup', 'c'}, 
			{"Am nevoie de Atestat?", 'fpt-tirist:client:atestat', 'c'}
		},
		scenario = "WORLD_HUMAN_PARTYING",
	},
	{ -- JOB Taximetrist
		npc = 'a_m_y_latino_01', 										
		header = 'Taxi', 									
		name = '[ JOB ] Taximetrist',							
		uiText = "Puiu Taximetristul",									
		dialog = 'Vrei sa te bagi pe Taxi?',							
		coordinates = vector3(896.46374511718,-144.09239196778,75.819519042968), 			
		heading = 326.07830810547,										
		camOffset = vector3(0.0, 0.0, 0.0), 						
		camRotation = vector3(0.0, 0.0, 0.0),					
		interactionRange = 1, 								
		options = {													
			{'In ce consta aceasta munca?', 'fpt-taxi:client:munca', 'c'},		
			{'Trebuie sa imi iau o uniforma?', 'fpt-taxi:client:uniforma', 'c'},
			{"Vreau sa ma angajez.", 'fpt-taxi:client:addGroup', 'c'}, 
			{"Nu mai vreau sa lucrez.", 'fpt-taxi:client:removeGroup', 'c'}, 
		},
		scenario = "WORLD_HUMAN_AA_SMOKE",
	},
	-------------------------------------------------------------------------------------------------------------------------------------------------------		
	{ -- Hacker
		npc = 'g_m_m_chigoon_02', 										
		header = 'Hacker', 									
		name = '[ JOB ] Hacker',							
		uiText = "Chinezu",									
		dialog = 'Vrei sa lucrezi?',							
		coordinates = vector3(5058.068359375,-4596.1538085938,1.8748788833618), 			
		heading = 337.52243041992,										
		camOffset = vector3(0.0, 0.0, 0.0), 						
		camRotation = vector3(0.0, 0.0, 0.0),					
		interactionRange = 2, 								
		options = {													
			{'Ce trebuie sa fac?', 'fpt-hacker:client:info', 'c'},  -- " Ai nevoie de hard drive data, adaptor ethernet si stick ethernet sa poti sa falsifici carduri. "
			{"De unde iau materialele?", 'fpt-hacker:client:gps', 'c'}, -- " O sa primesti o locatie pe GPS. "
			{"Este locatia ta?", 'fpt-hacker:client:locatie', 'c'}, -- " Nu, saptamanal se inchiriaza la niste baieti smecheri care au bani la care trebuie sa platesti taxe. "
			{"Cine esti?", 'fpt-hacker:client:alexia', 'c'}, -- " Mi se spune Chinezu, ma ocup de locatia asta. Mai ai multe intrebari?"
			{"Vreau sa lucrez!", 'fpt-hacker:client:addGroup', 'c'}, -- " Foarte bine, treci la treaba. "
			{"Nu mai vreau sa lucrez!", 'fpt-hacker:client:removeGroup', 'c'} -- " Pacat... Sa inteleg ca nu iti plac banii? "
		},
		anim = {
			dict = "amb@world_human_leaning@male@wall@back@foot_up@idle_a",
			anim = "idle_a"
		},
	},
	{ -- Imbracaminte Politie
	npc = 'u_m_m_fibarchitect', 										
	header = 'Politist', 									
	name = 'Politist',							
	uiText = "Politist",									
	dialog = 'Vrei sa-ti iei hainele?',							
	coordinates = vector3(5071.5556640625,-4599.8862304688,1.8586118221282), 			
	heading = 337.52243041992,										
	camOffset = vector3(0.0, 0.0, 0.0), 						
	camRotation = vector3(0.0, 0.0, 0.0),					
	interactionRange = 2, 								
	options = {													
		{'Vreau sa-mi iau hainele de poltie!', 'fpt-npc:hainepolitie', 'c'},
		{'Vreau sa-mi iau hainele normale!', 'fpt-npc:haineinapoipolitie', 'c'},
	},
	anim = {
		dict = "amb@world_human_leaning@male@wall@back@foot_up@idle_a",
		anim = "idle_a"
	},
},
{ -- LICENTE
npc = 'ig_andreas', 										
header = 'Los Santos', 									
name = 'Licente',							
uiText = "Angajat Licente",									
dialog = 'Cu ce te pot ajuta?',							
coordinates = vector3(-31.183416366578,-1106.54296875,25.42243385315), 			
heading = 336.10076904297,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 2, 								
options = {													
	{'Doresc o Licenta de Pescar! (30000$)', 'fpt-licente:client:licentapescar', 'c'},
	{'Doresc o Licenta de Miner! (35000$)', 'fpt-licente:client:licentaminer', 'c'},
	{'Doresc o Licenta de Petrolist! (0$)', 'fpt-licente:client:licentapetrolist', 'c'},
	{'Doresc o Licenta de Taiat Lemne! (25000$)', 'fpt-licente:client:licentalemne', 'c'},
	{'Doresc o Licenta de Scafandru! (45000$)', 'fpt-licente:client:licentascafandru', 'c'}
},
scenario = "WORLD_HUMAN_CLIPBOARD",
jobs = {},
},
{ -- ATESTATE
npc = 'a_m_y_business_02', 										
header = 'Los Santos', 									
name = 'Atestate',							
uiText = "Angajat Atestate",									
dialog = 'Cu ce te pot ajuta?',							
coordinates = vector3(-57.015991210938,-1098.922241211,25.42248916626), 			
heading = 30.60856628418,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 2, 								
options = {													
	{'Doresc Atestat Marfuri Periculoase! (0$)', 'fpt-atestate:client:atestatmarfuripericuloase', 'c'},	
	{'Doresc Atestat Transport Lemne! (30000$)', 'fpt-atestate:client:atestatlemne', 'c'},
	{'Doresc Atestat Transport Minereu! (40000$)', 'fpt-atestate:client:atestatminereuri', 'c'},
	{'Doresc Atestat Transport Agabaritic! (20000$)', 'fpt-atestate:client:atestatagabaritic', 'c'}
},
scenario = "WORLD_HUMAN_CLIPBOARD",
jobs = {},
},
-- ============================================================================================================================================== --
-- =====================================================> JOB-URI ILEGALE <====================================================================== --
-- ============================================================================================================================================== --
{ -- Traficant Tobacco
npc = 'csb_helmsmanpavel', 										
header = 'Traficant Tobacco', 									
name = '[ JOB ] Traficant Tobacco',							
uiText = "Ursoi",									
dialog = 'Vrei sa lucrezi?',							
coordinates = vector3(4916.5034179688,-5231.1274414062,1.5212411880494), 			
heading = 97.440299987793,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 1.5, 								
options = {													
	{'Ce trebuie sa fac?', 'fpt-tabacco:client:info', 'c'},  -- " Ai nevoie de tutun, filtre si foite sa poti sa faci tigari. "
	{"De unde iau frunze de tutun?", 'fpt-tabacco:client:gps', 'c'}, -- " O sa primesti o locatie pe GPS. "
	{"Este locatia ta?", 'fpt-tabacco:client:locatie', 'c'}, -- " Nu, saptamanal se inchiriaza la niste baieti smecheri care au bani la care trebuie sa platesti taxe. "
	{"Cine esti?", 'fpt-tabacco:client:alexia', 'c'}, -- " Sunt Ursoi puiu, ma ocup de locatia asta. Mai ai multe intrebari?"
	{"Vreau sa lucrez!", 'fpt-tabacco:client:addGroup', 'c'}, -- " Foarte bine puiu, treci la treaba. "
	{"Nu mai vreau sa lucrez!", 'fpt-tabacco:client:removeGroup', 'c'} -- " Gata puisor? Ne parasesti deja? "
},
anim = {
	dict = "timetable@reunited@ig_10",
	anim = "base_amanda"
},
jobs = {},
},
-------------------------------------------------------------------------------------------------------------------------------------------------------	
{ -- Traficant de Etnobotanice
npc = 'ig_chef', 										
header = 'Traficant de Etnobotanice', 									
name = '[ JOB ] Traficant de Etnobotanice',							
uiText = "Mustata",									
dialog = 'Vrei sa lucrezi?',							
coordinates = vector3(5157.3828125,-4670.1547851562,0.4399996995926), 			
heading = 84.209625244141,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 2, 								
options = {													
	{'Ce trebuie sa fac?', 'fpt-etno:client:info', 'c'},  -- " Ai nevoie de ingrasamant chimic, acetona si otrava de sobolani sa poti sa faci etnobotanice. "
	{"De unde iau materialele?", 'fpt-etno:client:gps', 'c'}, -- " O sa primesti o locatie pe GPS. "
	{"Este locatia ta?", 'fpt-etno:client:locatie', 'c'}, -- " Nu, saptamanal se inchiriaza la niste baieti smecheri care au bani la care trebuie sa platesti taxe. "
	{"Cine esti?", 'fpt-etno:client:alexia', 'c'}, -- " Mi se spune Mustata, ma ocup de locatia asta. Mai ai multe intrebari?"
	{"Vreau sa lucrez!", 'fpt-etno:client:addGroup', 'c'}, -- " Foarte bine, treci la treaba. "
	{"Nu mai vreau sa lucrez!", 'fpt-etno:client:removeGroup', 'c'} -- " Pacat... Sa inteleg ca nu iti plac banii? "
},
scenario = "WORLD_HUMAN_SMOKING",
jobs = {},
},
-------------------------------------------------------------------------------------------------------------------------------------------------------		
{ -- Hacker
npc = 'g_m_m_chigoon_02', 										
header = 'Hacker', 									
name = '[ JOB ] Hacker',							
uiText = "Chinezu",									
dialog = 'Vrei sa lucrezi?',							
coordinates = vector3(5071.5556640625,-4599.8862304688,1.8586118221282), 			
heading = 337.52243041992,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 2, 								
options = {													
	{'Ce trebuie sa fac?', 'fpt-hacker:client:info', 'c'},  -- " Ai nevoie de hard drive data, adaptor ethernet si stick ethernet sa poti sa falsifici carduri. "
	{"De unde iau materialele?", 'fpt-hacker:client:gps', 'c'}, -- " O sa primesti o locatie pe GPS. "
	{"Este locatia ta?", 'fpt-hacker:client:locatie', 'c'}, -- " Nu, saptamanal se inchiriaza la niste baieti smecheri care au bani la care trebuie sa platesti taxe. "
	{"Cine esti?", 'fpt-hacker:client:alexia', 'c'}, -- " Mi se spune Chinezu, ma ocup de locatia asta. Mai ai multe intrebari?"
	{"Vreau sa lucrez!", 'fpt-hacker:client:addGroup', 'c'}, -- " Foarte bine, treci la treaba. "
	{"Nu mai vreau sa lucrez!", 'fpt-hacker:client:removeGroup', 'c'} -- " Pacat... Sa inteleg ca nu iti plac banii? "
},
anim = {
	dict = "amb@world_human_leaning@male@wall@back@foot_up@idle_a",
	anim = "idle_a"
},
jobs = {},
},
-------------------------------------------------------------------------------------------------------------------------------------------------------		
{ -- Traficant de Marijuana
npc = 'a_m_m_genfat_01', 										
header = 'Traficant de Marijuana', 									
name = '[ JOB ] Traficant de Marijuana',							
uiText = "Grasu",									
dialog = 'Vrei sa lucrezi?',							
coordinates = vector3(5121.966796875,-5182.4028320312,-5.075071811676), 			
heading = 207.38543701172,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 2, 								
options = {													
	{'Ce trebuie sa fac?', 'fpt-marijuana:client:info', 'c'},  
	{"De unde iau planta de marijuana?", 'fpt-marijuana:client:gps', 'c'}, 
	{"Este locatia ta?", 'fpt-marijuana:client:locatie', 'c'}, 
	{"Cine esti?", 'fpt-marijuana:client:alexia', 'c'}, 
	{"Vreau sa lucrez!", 'fpt-marijuana:client:addGroup', 'c'}, 
	{"Nu mai vreau sa lucrez!", 'fpt-marijuana:client:removeGroup', 'c'}
},
scenario = "WORLD_HUMAN_DRUG_DEALER",
jobs = {},
},

{ -- Angajat Marijuana
npc = 'mp_f_weed_01', 										
header = 'Traficant de Marijuana', 									
name = 'Angajat',							
uiText = "Hallu",									
dialog = 'Ce doresti?',							
coordinates = vector3(5130.3486328125,-5186.6376953125,-5.6696901321411), 			
heading = 331.46264648438,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 3, 								
options = {															
	{"Ce faci aici?", 'fpt-marijuana:client:angajat1', 'c'}, 
	{"Unde pot afla mai multe informatii?", 'fpt-marijuana:client:angajat2', 'c'}, 
},
scenario = "WORLD_HUMAN_GARDENER_PLANT",
jobs = {},
},
-------------------------------------------------------------------------------------------------------------------------------------------------------
{ -- Angajat Spalat Bani
npc = 's_m_m_migrant_01', 										
header = 'Spalare Bani', 									
name = 'Angajat',							
uiText = "Strugurel",									
dialog = 'Ce doresti?',							
coordinates = vector3(4913.9995117188,-5284.552734375,-2.3757553100586), 			
heading = 358.88455200195,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 3, 								
options = {															
	{"Ce faci aici?", 'fpt-banimurdari:client:angajatc', 'c'}, -- Ma ocup de masinariile astea pentru marcarea banilor.
	{"Unde pot afla mai multe informatii?", 'fpt-banimurdari:client:angajati', 'c'}, -- Te duci la sefu care sta acolo la geam si se uita sa nu fur ceva.
	{"Vreau sa ma angajez!", 'fpt-banimurdari:client:anajeazate', 'c'},
},
anim = {
	dict = "anim@heists@prison_heiststation@cop_reactions",
	anim = "cop_b_idle"
},
jobs = {},
},

{ -- Sef Spalat Bani
npc = 'mp_m_g_vagfun_01', 										
header = 'Spalare Bani', 									
name = 'Sef',							
uiText = "Mexicanu",									
dialog = 'Ce vrei?',							
coordinates = vector3(4921.9755859375,-5284.3598632812,-1.78113675117493), 			
heading = 88.444152832031,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 3, 								
options = {															
	{"Vreau sa marchez o suma de bani.", 'fpt-banimurdari:client:info1', 'c'}, -- Daca lucrezi cu Sindicatul te pot ajuta, daca nu cauta pe cineva care colaboreaza cu ei.
	{"Cum as putea marca o suma de bani?", 'fpt-banimurdari:client:info2', 'c'}, -- Te folosesti de masinariile noastre pentru a marca o suma de bani.
	{"Imi iei taxa?", 'fpt-banimurdari:client:info3', 'c'}, -- Da, taxa daca colaborezi cu Sindicatul este de 5%, iar la colaboratorii Sindicatului este 10%.
	{"Care este suma minima pe care pot sa o marchez?", 'fpt-banimurdari:client:info4', 'c'}, -- Suma minima este de 50.000$.
},
scenario = "WORLD_HUMAN_DRUG_DEALER",
jobs = {},
},
-------------------------------------------------------------------------------------------------------------------------------------------------------
{ -- Traficant de Cocaina
npc = 's_m_m_doctor_01', 										
header = 'Traficant de Cocaina', 									
name = '[ JOB ] Traficant de Cocaina',							
uiText = "Doctorul",									
dialog = 'Vrei sa lucrezi?',							
coordinates = vector3(4988.9560546875,-5122.94921875,-4.8789649009705), 			
heading = 182.72926330566,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 2, 								
options = {													
	{'Ce trebuie sa fac?', 'fpt-cocaina:client:info', 'c'},  
	{"De unde iau frunzele de coca?", 'fpt-cocaina:client:gps', 'c'}, 
	{"Este locatia ta?", 'fpt-cocaina:client:locatie', 'c'}, 
	{"Cine esti?", 'fpt-cocaina:client:alexia', 'c'}, 
	{"Vreau sa lucrez!", 'fpt-cocaina:client:addGroup', 'c'}, 
	{"Nu mai vreau sa lucrez!", 'fpt-cocaina:client:removeGroup', 'c'}
},
scenario = "WORLD_HUMAN_DRUG_DEALER",
jobs = {},
},

{ -- Angajat Cocaina
npc = 'u_m_y_corpse_01', 										
header = 'Traficant de Cocaina', 									
name = 'Angajat',							
uiText = "Ernest",									
dialog = 'Ce doresti?',							
coordinates = vector3(4987.130859375,-5141.8569335938,-5.4735836982727), 			
heading = 126.48009490967,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 3, 								
options = {															
	{"Ce faci aici?", 'fpt-cocaina:client:angajat1', 'c'}, 
	{"Unde pot afla mai multe informatii?", 'fpt-cocaina:client:angajat2', 'c'}, 
},
scenario = "WORLD_HUMAN_CLIPBOARD",
jobs = {},
},

-------------------------------------------------------------------------------------------------------------------------------------------------------	
{ -- Traficant de Metamfetamina
npc = 'ig_solomon', 										
header = 'Traficant de Metamfetamina', 									
name = '[ JOB ] Traficant de Metamfetamina',							
uiText = "Solomon",									
dialog = 'Vrei sa lucrezi?',							
coordinates = vector3(5140.2709960938,-4622.087890625,-5.0709710121155), 			
heading = 344.88446044922,										
camOffset = vector3(0.0, 0.0, 0.0), 						
camRotation = vector3(0.0, 0.0, 0.0),					
interactionRange = 3, 								
options = {		
	{'Ce trebuie sa fac?', 'fpt-metamfetamina:client:info', 'c'},  
	{"Este locatia ta?", 'fpt-metamfetamina:client:locatie', 'c'}, 
	{"De unde iau materialele necesare?", 'fpt-metamfetamina:client:gps', 'c'},
	{"Cine esti?", 'fpt-metamfetamina:client:alexia', 'c'},
	{'Vreau sa-mi iau uniforma.', 'fpt-metamfetamina:client:addUniforma', 'c'}, 
	{'Imi vreau hainele inapoi.', 'fpt-metamfetamina:client:removeUniforma', 'c'}, 
	{"Vreau sa lucrez!", 'fpt-metamfetamina:client:addGroup', 'c'}, 
	{"Nu mai vreau sa lucrez!", 'fpt-metamfetamina:client:removeGroup', 'c'}, 													
},
scenario = "WORLD_HUMAN_CLIPBOARD",
jobs = {},
},	

{ -- Angajat Metamfetamina
	npc = 'g_m_m_chemwork_01',
	header = 'Traficant de Metamfetamina',
	name = 'Angajat',
	uiText = "Savantul",
	dialog = 'Ce doresti?',
	coordinates = vector3(5129.9936523438,-4612.4169921875,-5.6655941009522),
	heading = 256.37008666992,
	camOffset = vector3(0.0, 0.0, 0.0),
	camRotation = vector3(0.0, 0.0, 0.0),
	interactionRange = 2,
	options = {
		{"Ce faci aici?", 'fpt-metamfetamina:client:angajat1', 'c'},
		{"Unde pot afla mai multe informatii?", 'fpt-metamfetamina:client:angajat2', 'c'},
	},
	anim = {
		dict = "anim@amb@nightclub@peds@",
		anim = "rcmme_amanda1_stand_loop_cop"
	},
	jobs = {},
},
}