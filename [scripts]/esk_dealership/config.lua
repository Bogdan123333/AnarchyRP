config = {}

config.defaultWaitTime = 500
config.TestTime = 60 -- it's multiplied by x1000 (ex: 10 =  10 seconds!)
config.TestDrivePrice = 500 -- means vehicle price / this value

config.dealerships = {
    [1] = {
        name = "Dealership",
        ped = "cs_siemonyetarian",
        heading = 120.0,
        headingVehicle = 355.0,
        type = "car",
        blipid = 523,

        coordsPed = vector3(-796.4522, -167.1749, 37.2995-1.0),
        coordsVehicle = vector3(-75.250999450684,-819.07354736328,326.17520141602), 
        coordsCam = vector3(-70.520553588867,-812.06304931641,328.25637817383+1.0),

        testVehicleSpawn = vector3(-764.87658691406,-245.27288818359,37.241195678711),
        testVehicleSpawnHeading = 60.0,
        testVehicleTime = 60, -- seconds
        vehicles = {
            ["Clasa A"] = {
            ---------------------CLASA A--------------------------------------------------------------------
            ['Bugatti Veyron'] = {
                vehID = 2,
                price        = 125000000,
                spawncode    = "bugatti",
                speed        = {barsize = 60, text = "288KM/h"}, 
                acceleration = {barsize = 20, text = "6/10"}, 
                brakes       = {barsize = 50, text = "4/10"}, 
                seats        = {barsize = 25, text = "2/8"}, 
            },

            ['Bugatti Divo'] = {
                vehID = 4,
                price        = 150000000,
                spawncode    = "divo",
                speed        = {barsize = 60, text = "288KM/h"}, 
                acceleration = {barsize = 20, text = "6/10"}, 
                brakes       = {barsize = 50, text = "4/10"}, 
                seats        = {barsize = 25, text = "2/8"}, 
            },

            ['Bugatti Atlantic'] = {
                vehID = 5,
                price        = 100000000,
                spawncode    = "wycalt",
                speed        = {barsize = 60, text = "288KM/h"}, 
                acceleration = {barsize = 20, text = "6/10"}, 
                brakes       = {barsize = 50, text = "4/10"}, 
                seats        = {barsize = 25, text = "2/8"}, 
            },

            ['Bentley SuperSport'] = {
                vehID = 6,
                price        = 100000000,
                spawncode    = "ben17",
                speed        = {barsize = 60, text = "288KM/h"}, 
                acceleration = {barsize = 20, text = "6/10"}, 
                brakes       = {barsize = 50, text = "4/10"}, 
                seats        = {barsize = 25, text = "2/8"}, 
            },

            ['Bentley Continental'] = {
                vehID = 7,
                price        = 120000000,
                spawncode    = "rmodbacalar",
                speed        = {barsize = 60, text = "288KM/h"}, 
                acceleration = {barsize = 20, text = "6/10"}, 
                brakes       = {barsize = 50, text = "4/10"}, 
                seats        = {barsize = 25, text = "2/8"}, 
            },

            ['Bugatti SuperSport 300'] = {
                vehID = 8,
                price        = 250000000,
                spawncode    = "bug300ss",
                speed        = {barsize = 60, text = "288KM/h"}, 
                acceleration = {barsize = 20, text = "6/10"}, 
                brakes       = {barsize = 50, text = "4/10"}, 
                seats        = {barsize = 25, text = "2/8"}, 
            },

                    },

            ["Clasa B"] = {    
                ['Porsche Macan Turbo'] = { 
                vehID = 9, 
                price        = 5000000,
                spawncode    = "18macan",
                speed        = {barsize = 60, text = "164KM/h"}, 
                acceleration = {barsize = 20, text = "6/10"}, 
                brakes       = {barsize = 50, text = "4/10"}, 
                seats        = {barsize = 25, text = "2/8"}, 
            },
                    ['Aston Martin Vanquish'] = { 
                        vehID = 10, 
                        price        = 25000000,
                        spawncode    = "ast",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}, 
                        },
                        
                        ['Audi R8'] = { 
                            vehID = 11, 
                            price        = 35000000,
                            spawncode    = "r820",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}, 
                            },
                                ['Audi RS7'] = { 
                                    vehID = 13, 
                                    price        = 15000000,
                                    spawncode    = "rs7",
                                    speed        = {barsize = 60, text = "164KM/h"}, 
                                    acceleration = {barsize = 20, text = "6/10"}, 
                                    brakes       = {barsize = 50, text = "4/10"}, 
                                    seats        = {barsize = 25, text = "2/8"}, 
                                    },

                           ['Audi RS7 SportBack'] = { 
                            vehID = 14, 
                            price        = 45000000,
                            spawncode    = "rs7c8",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}, 
                            },      
                                
                         ['Audi RS6'] = { 
                            vehID = 16, 
                            price        = 10000000,
                            spawncode    = "audirs6tk",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}, 
                            },         
                            ['Audi RS6 2021'] = { 
                            vehID = 17, 
                            price        = 10000000,
                            spawncode    = "rmodrs6",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}, 
                            }, 
                            ['BMW M760i'] = { 
                                vehID = 18, 
                                price        = 25000000,
                                spawncode    = "17m760i",
                                speed        = {barsize = 60, text = "164KM/h"}, 
                                acceleration = {barsize = 20, text = "6/10"}, 
                                brakes       = {barsize = 50, text = "4/10"}, 
                                seats        = {barsize = 25, text = "2/8"}, 
                                }, 
                          ['BMW 745le'] = { 
                            vehID = 19, 
                            price        = 30000000,
                            spawncode    = "745le",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}, 
                            },    
                         ['BMW X3M'] = { 
                        vehID = 20, 
                        price        = 45000000,
                        spawncode    = "gcmx3m2022",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}, 
                        }, 
                        ['BMW X750i'] = { 
                            vehID = 21, 
                            price        = 50000000,
                            spawncode    = "bmwx7",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}, 
                            },
                         ['Ford GT'] = { 
                        vehID = 22, 
                        price        = 60000000,
                        spawncode    = "gt17",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}, 
                        }, 
                        ['Porsche 918 Spider'] = { 
                            vehID = 23, 
                            price        = 45000000,
                            spawncode    = "918",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}, 
                            },                  

                                    ['Porsche 911 Targa 4S'] = { 
                                        vehID = 24, 
                                        price        = 50000000,
                                        spawncode    = "911t4s2",
                                        speed        = {barsize = 60, text = "164KM/h"}, 
                                        acceleration = {barsize = 20, text = "6/10"}, 
                                        brakes       = {barsize = 50, text = "4/10"}, 
                                        seats        = {barsize = 25, text = "2/8"}, 
                                        }, 

                                        ['Mercedes C63SAMG'] = { 
                                            vehID = 25, 
                                            price        = 45000000,
                                            spawncode    = "c63s",
                                            speed        = {barsize = 60, text = "164KM/h"}, 
                                            acceleration = {barsize = 20, text = "6/10"}, 
                                            brakes       = {barsize = 50, text = "4/10"}, 
                                            seats        = {barsize = 25, text = "2/8"}, 
                                            }, 

                },

                ["Clasa C"] = {    
                    ['Audi A8 2005'] = { 
                        vehID = 26, 
                        price        = 1500000,
                        spawncode    = "a8audi",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}
                    },
                    ['Audi A6 2003'] = { 
                        vehID = 27, 
                        price        = 1000000,
                        spawncode    = "c5rs6",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}, 
                    },

                        ['Audi S4'] = { 
                            vehID = 28, 
                            price        = 500000,
                            spawncode    = "b5s4",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}, 
                        },

                    ['BMW 850csi'] = { 
                        vehID = 29, 
                        price        = 1500000,
                        spawncode    = "850csi",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}    
                    },

                    ['BMW M5e28'] = { 
                    vehID = 30, 
                    price        = 250000,
                    spawncode    = "m5e28",
                    speed        = {barsize = 60, text = "164KM/h"}, 
                    acceleration = {barsize = 20, text = "6/10"}, 
                    brakes       = {barsize = 50, text = "4/10"}, 
                    seats        = {barsize = 25, text = "2/8"}
                    },
                    ['Mercedes-Benz C32'] = { 
                        vehID = 31, 
                        price        = 2000000,
                        spawncode    = "benzc32",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}, 
                    },
                    ['Mercedes-Benz E55'] = { 
                        vehID = 32, 
                        price        = 1500000,
                        spawncode    = "w210amg",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}, 
                    },

                        ['Dacia Sandero Stepway'] = { 
                            vehID = 33, 
                            price        = 500000,
                            spawncode    = "sanderos2",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}, 
                        },

                    ['Dacia Sandero'] = { 
                        vehID = 34, 
                        price        = 2500000,
                        spawncode    = "sandero",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}
                    },
                    },

                ["Motociclete"] = {
                    ----------------------MOTOCICLETE-----------------------------------------------------------
                    ['Aprilia RSV4'] = { 
                        vehID = 71, 
                        price        = 15000000,
                        spawncode    = "rsv4",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}, 
                    },
                    
                    ['BMW S1000RR'] = { 
                        vehID = 73, 
                        price        = 30000000,
                        spawncode    = "bmws",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}, 
                    },

                ['Ducati Diavel'] = { 
                    vehID = 74, 
                    price        = 12000000,
                    spawncode    = "diavel",
                    speed        = {barsize = 60, text = "164KM/h"}, 
                    acceleration = {barsize = 20, text = "6/10"}, 
                    brakes       = {barsize = 50, text = "4/10"}, 
                    seats        = {barsize = 25, text = "2/8"}
                },
                    ['Honda Bros'] = { 
                        vehID = 75, 
                        price        =  10000000,
                        spawncode    = "bros60",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}, 
                    },

                        ['Harley-Davidson SoftAil'] = { 
                            vehID = 76, 
                            price        = 5000000,
                            spawncode    = "foxharley1",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}, 
                        },

                    ['Kawasaki H2'] = { 
                        vehID = 77, 
                        price        = 45000000,
                        spawncode    = "h2carb",
                        speed        = {barsize = 60, text = "164KM/h"}, 
                        acceleration = {barsize = 20, text = "6/10"}, 
                        brakes       = {barsize = 50, text = "4/10"}, 
                        seats        = {barsize = 25, text = "2/8"}
                    },
    
                        ['TMF450'] = { 
                            vehID = 78, 
                            price        = 20000000,
                            spawncode    = "tmsm",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}
                        },
    
                        ['Yamaha R1-2020'] = { 
                            vehID = 79, 
                            price        = 25000000,
                            spawncode    = "20r1",
                            speed        = {barsize = 60, text = "164KM/h"}, 
                            acceleration = {barsize = 20, text = "6/10"}, 
                            brakes       = {barsize = 50, text = "4/10"}, 
                            seats        = {barsize = 25, text = "2/8"}, 
                        },
                        },

                        ["Dube"] = {
                            ----------------------Dube-----------------------------------------------------------
                            ['Duba Speedo'] = { 
                                vehID = 82, 
                                price        = 25000000,
                                spawncode    = "nspeedo",
                                speed        = {barsize = 60, text = "164KM/h"}, 
                                acceleration = {barsize = 20, text = "6/10"}, 
                                brakes       = {barsize = 50, text = "4/10"}, 
                                seats        = {barsize = 25, text = "2/8"}, 
                            },

                            ['Youga'] = { 
                                vehID = 83, 
                                price        = 35000000,
                                spawncode    = "youga2",
                                speed        = {barsize = 60, text = "164KM/h"}, 
                                acceleration = {barsize = 20, text = "6/10"}, 
                                brakes       = {barsize = 50, text = "4/10"}, 
                                seats        = {barsize = 25, text = "2/8"}, 
                            },
        
                                },

                                ["Cayo"] = {
                                    ----------------------Dube-----------------------------------------------------------
                                    ['Hellion'] = { 
                                        vehID = 84, 
                                        price        = 500000,
                                        spawncode    = "hellion",
                                        speed        = {barsize = 60, text = "164KM/h"}, 
                                        acceleration = {barsize = 20, text = "6/10"}, 
                                        brakes       = {barsize = 50, text = "4/10"}, 
                                        seats        = {barsize = 25, text = "2/8"}, 
                                    },
                                    
                                    ['Cheburek'] = { 
                                        vehID = 85, 
                                        price        = 5000000,
                                        spawncode    = "cheburek",
                                        speed        = {barsize = 60, text = "164KM/h"}, 
                                        acceleration = {barsize = 20, text = "6/10"}, 
                                        brakes       = {barsize = 50, text = "4/10"}, 
                                        seats        = {barsize = 25, text = "2/8"}, 
                                    },

                                    
                                    ['Manchez'] = { 
                                        vehID = 86, 
                                        price        = 10000000,
                                        spawncode    = "manchez2",
                                        speed        = {barsize = 60, text = "164KM/h"}, 
                                        acceleration = {barsize = 20, text = "6/10"}, 
                                        brakes       = {barsize = 50, text = "4/10"}, 
                                        seats        = {barsize = 25, text = "2/8"}, 
                                    },

                                    
                                    ['Trophy Truck'] = { 
                                        vehID = 87, 
                                        price        = 25000000,
                                        spawncode    = "trophytruck",
                                        speed        = {barsize = 60, text = "164KM/h"}, 
                                        acceleration = {barsize = 20, text = "6/10"}, 
                                        brakes       = {barsize = 50, text = "4/10"}, 
                                        seats        = {barsize = 25, text = "2/8"}, 
                                    },

                                    
                                    ['Duba Squaddie'] = { 
                                        vehID = 166, 
                                        price        = 20000000,
                                        spawncode    = "squaddie",
                                        speed        = {barsize = 60, text = "164KM/h"}, 
                                        acceleration = {barsize = 20, text = "6/10"}, 
                                        brakes       = {barsize = 50, text = "4/10"}, 
                                        seats        = {barsize = 25, text = "2/8"}, 
                                    },

                                    
                                    ['Duba Surfer'] = { 
                                        vehID = 88, 
                                        price        = 2500000,
                                        spawncode    = "surfer2",
                                        speed        = {barsize = 60, text = "164KM/h"}, 
                                        acceleration = {barsize = 20, text = "6/10"}, 
                                        brakes       = {barsize = 50, text = "4/10"}, 
                                        seats        = {barsize = 25, text = "2/8"}, 
                                    },

                                    
                                    ['Duba Rumpo'] = { 
                                        vehID = 89, 
                                        price        = 1000000,
                                        spawncode    = "rumpo3",
                                        speed        = {barsize = 60, text = "164KM/h"}, 
                                        acceleration = {barsize = 20, text = "6/10"}, 
                                        brakes       = {barsize = 50, text = "4/10"}, 
                                        seats        = {barsize = 25, text = "2/8"}, 
                                    },

                                    ['Duba Youga'] = { 
                                        vehID = 90, 
                                        price        = 1500000,
                                        spawncode    = "youga3",
                                        speed        = {barsize = 60, text = "164KM/h"}, 
                                        acceleration = {barsize = 20, text = "6/10"}, 
                                        brakes       = {barsize = 50, text = "4/10"}, 
                                        seats        = {barsize = 25, text = "2/8"}, 
                                    },
                
                                },
                    }
    },
    [2] = {
        name = "Barci",
        ped = "a_f_m_bodybuild_01",
        heading = 45.0,
        headingVehicle = 230.0,
        type = "boats",
        blipid = 427,

        coordsPed = vector3(-799.64465332031,-1341.8182373047,5.1502614021301-1.0),
        coordsVehicle = vector3(-727.57434082031,-1326.1058349609,0.11955368518829), 
        coordsCam = vector3(-720.69635009766,-1326.5217285156,1.5962905883789 +1.5),

        testVehicleSpawn = vector3(-716.78112792969,-1344.66015625,0.10917834937572),
        testVehicleSpawnHeading = 137.0,
        testVehicleTime = 60, -- seconds
        vehicles = {
            ["Barci"] = {
                ['SkyJey'] = {
                    vehID = 1,
                    vip = false,
                    price        = 5000000,
                    spawncode    = "Seashark",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['Gonflabila'] = {
                    vehID = 2,
                    vip = false,
                    price        = 2500000,
                    spawncode    = "Dinghy",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['Speeder Lux'] = {
                    vehID = 3,
                    vip = false,
                    price        = 15000000,
                    spawncode    = "Speeder",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['JetMax'] = {
                    vehID = 5,
                    vip = false,
                    price        = 5000000,
                    spawncode    = "jetmax",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['Lampadati Toro Lux'] = {
                    vehID = 6,
                    vip = false,
                    price        = 10000000,
                    spawncode    = "toro",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['Squalo'] = {
                    vehID = 8,
                    vip = false,
                    price        = 2500000,
                    spawncode    = "Squalo",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['Vapor Transport'] = {
                    vehID = 9,
                    vip = false,
                    price        = 50000000,
                    spawncode    = "tug",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['Tropic'] = {
                    vehID = 10,
                    vip = false,
                    price        = 1000000,
                    spawncode    = "Tropic",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['Submarin Kraken'] = {
                    vehID = 11,
                    vip = false,
                    price        = 15000000,
                    spawncode    = "submersible",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['Submarin Submersible'] = {
                    vehID = 12,
                    vip = false,
                    price        = 15000000,
                    spawncode    = "submersible2",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
            },
        }
    },
    [3] = {
        name = "Elicoptere",
        ped = "mp_m_waremech_01",
        heading = 145.0,
        headingVehicle = 61.0,
        type = "airplane",
        blipid = 579,
        coordsPed = vector3(-941.04498291016,-2954.15234375,13.945067405701-1.0),
        coordsVehicle = vector3(-964.12225341797,-2984.2023925781,13.945058822632), 
        coordsCam = vector3(-975.99261474609,-2985.05859375,13.945074081421 +1.5),

        testVehicleSpawn = vector3(-716.78112792969,-1344.66015625,0.10917834937572),
        testVehicleSpawnHeading = 60.0,
        testVehicleTime = 60, -- seconds
        vehicles = {
            ["Elicoptere"] = {
                ['Frogger'] = {
                    vehID = 1,
                    vip = false,
                    price        = 15000000,
                    spawncode    = "frogger",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['Maverick'] = {
                    vehID = 2,
                    vip = false,
                    price        = 15000000,
                    spawncode    = "maverick",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['Supervolito'] = {
                    vehID = 3,
                    vip = false,
                    price        = 25000000,
                    spawncode    = "supervolito2",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                }, --facut
                ['Volatus'] = {
                    vehID = 4,
                    vip = false,
                    price        = 35000000,
                    spawncode    = "volatus",
                    speed        = {barsize = 75, text = "220KM/h"}, 
                    acceleration = {barsize = 50, text = "5/10"}, 
                    brakes       = {barsize = 30, text = "3/10"}, 
                    seats        = {barsize = 25, text = "2/8"}, 
                },
            },
        }
    },
}