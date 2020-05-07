import delimited "C:\Users\Alberto\Desktop\COVID\19_04_20\200419COVID19MEXICO.csv"

*VARIABLES
*Variable origen
label define origen  1 "USMER" 2 "FUERA DE USMER" 99 "NO ESPECIFICADO"
label values origen origen

*Variable resultado
label define resultado  1 "Positivo SARS-CoV-2" 2 "No positivo SARS-CoV-2" 3 "Resultado pendiente"
label values resultado resultado


*Variable sector
label define sector  1 "CRUZ ROJA" 2 "DIF" 3 "ESTATAL" 4 "IMSS" 5 "IMSS-BIENESTAR" 6 "ISSSTE" 7 "MUNICIPAL" 8 "PEMEX" 9 "PRIVADA" 10 "SEDENA" 11 "SEMAR" 12 "SSA" 13 "UNIVERSITARIO" 99 "NO ESPECIFICADO"
label values sector sector

*Variable sexo
label define sexo  1 "MUJER" 2 "HOMBRE" 99 "NO ESPECIFICADO"
label values sexo sexo

*Variable tipo_paciente
label define tipo_paciente  1 "AMBULATORIO" 2 "HOSPITALIZADO" 99 "NO ESPECIFICADO"
label values tipo_paciente tipo_paciente


*Variable nacionalidad
label define nacionalidad  1 "MEXICANA" 2 "EXTRANJERA" 99 "NO ESPECIFICADO"
label values nacionalidad nacionalidad


*Variable entidad

label define entidad_um  01 "AS" 02 "BC" 03 "BS" 04 "CC" 05 "CL" 06 "CM" 07 "CS" 08 "CH" 09 "DF" 10 "DG" 11 "GT" 12 "GR" 13 "HG" 14 "JC" 15 "MC" 16 "MN" 17 "MS" 18 "NT" 19 "NL" 20 "OC" 21 "PL" 22 "QT" 23 "QR" 24 "SP" 24 "SP" 25 "SL" 26 "SR" 27 "TC" 28 "TS" 29 "TL" 30 "VZ" 31 "YN" 32 "ZS" 36 "EUM" 97 "NA" 98 "SI" 99 "NE"

label values entidad_um entidad_um

label values entidad_res entidad_um 

label values entidad_nac entidad_um 

*Si_no
label define si_no  1 "SI " 2 "NO " 97 "NO APLICA" 98 "SE IGNORA" 99 "NO ESPECIFICADO"
label values intubado si_no
label values neumonia si_no
label values embarazo si_no
label values habla_lengua_indi si_no
label values diabetes si_no
label values epoc si_no
label values asma si_no
label values inmusupr si_no
label values hipertension si_no
label values otra_com  si_no
label values cardiovascular  si_no
label values obesidad si_no
label values renal_cronica si_no
label values tabaquismo si_no
label values otro_caso si_no
label values migrante si_no
label values uci si_no

            

*RECODIFICACÓN DE VARIABLES 
#delimit;
recode edad
min/0=0
1/4=1
5/9=2
10/14=3
15/19=4
20/24=5
25/29=6
30/34=7
35/39=8
40/44=9
45/49=10
50/54=11
55/59=12
60/64=13
65/69=14
70/74=15
75/79=16
80/84=17
85/89=18
90/94=19
95/max=20,
gen(edad_cat)
;

#delimit;
label define edad_cat
0 "<1"
1 "1 a 4"
2 "5 a 9"
3 "10 a 4"
4 "15 a 19"
5 "20 a 24"
6 "25 a 29"
7 "30 a 34"
8 "35 a 39"
9 "40 a 44"
10 "45 a 49"
11 "50 a 54"
12 "55 a 59"
13 "60 a 64"
14 "65 a 69"
15 "70 a 74"
16 "75 a 79"
17 "80 a 84"
18 "85 a 89"
19 "90 a 94"
20 ">95"
;

label values edad_cat edad_cat