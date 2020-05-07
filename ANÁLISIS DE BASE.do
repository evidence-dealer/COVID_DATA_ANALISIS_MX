*************************************************
*Análisis por sexo: Gráfico de pastel
*********************************************
by resultado, sort: tab sexo

tab sexo if resultado ==1

#delimit;
graph pie if resultado==1, over(sexo) plabel(_all percent)
pie(1, color(cranberry)) pie(2, color(navy)) 
title("Casos confirmados de COVID-19 en México (n=13,842)")
subtitle("distribución por sexo al 25/04/2020")
note("Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral")
;

graph export "C:\Users\Alberto\Desktop\COVID_POR_SEXO.png", as(png) name("Graph")

*********************************************
*Análisis por grupo de edad: Gráfico de barras
*********************************************
gen tipo_paciente2=tipo_paciente

#delimit;
graph bar (count) tipo_paciente if resultado==1,
over(tipo_paciente2)
legend( label(1 "Ambulatorio") label(2 "Hospitalizado"))
ascategory asyvars bar(1, fcolor(gold)) bar(2, fcolor(green)) bargap(0)
over(edad_cat, label(labsize(vsmall)angle(45)))
ylabel(,labsize(tiny))ytitle("Número de casos")
title("Casos confirmados de COVID-19 en México (n=8261)")
subtitle("distribución de hospotalizados por grupo de edad al 19/04/2020")
note("Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral")
blabel(bar, position(outside) format(%9.0f) color(black) size(tiny) angle(vertical))
;

graph export "C:\Users\Alberto\Desktop\COVID_AMBUL_HOSPIT.png", as(png) name("Graph")

*********************************************
*Análisis por grupo de edad: Gráfico de barras
*********************************************
gen intubado2=intubado

#delimit;
graph bar (count) intubado if resultado==1 & intubado!=99 & intubado!=97,
over(intubado2)
legend( label(1 "Intubado") label(2 "No intubado"))
ascategory asyvars bar(1, fcolor(gold)) bar(2, fcolor(green)) bargap(0)
over(edad_cat, label(labsize(vsmall)angle(45)))
ylabel(,labsize(small))ytitle("Número de casos")
title("Casos confirmados de COVID-19 en México (n=8261)")
subtitle("distribución de intubados por grupo de edad al 19/04/2020")
note("Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral")
blabel(bar, position(outside) format(%9.0f) color(black) size(tiny) angle(vertical))
;

graph export "C:\Users\Alberto\Desktop\COVID_INTUBADO_NOINTUBADO.png", as(png) name("Graph")

*********************************************
*Análisis por edad: Gráfico de barras
*********************************************
gen def_01= 0 if fecha_def=="9999-99-99"
replace def_01=1 if def_01==.

tab def_01, nolabel

label drop def_01

label define def_01  0 "Vivo"  1 "Finado"

label values def_01 def_01

tab def_01 if resultado==1

gen finado=def_01

#delimit;
graph bar (count) finado if resultado==1,
over(def_01)
legend( label(1 "Vivo") label(2 "Defunción"))
ascategory asyvars bar(1, fcolor(gold)) bar(2, fcolor(green)) bargap(0)
over(edad_cat, label(labsize(vsmall)angle(45)))
ylabel(,labsize(small))ytitle("Número de casos")
title("Casos confirmados de COVID-19 en México (n=8261)")
subtitle("distribución de defunciones por grupo de edad al 19/04/2020")
note("Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral")
blabel(bar, position(outside) format(%9.0f) color(black) size(tiny) angle(vertical))
;

graph export "C:\Users\Alberto\Desktop\COVID_VIVO_DEFUNCION.png", as(png) name("Graph")


*********************************************
*Análisis por entidad federativa: Gráfico de barras
*********************************************
gen entidad_res1=entidad_res 

 
#delimit;
graph bar (count) entidad_res1 if resultado==1,
over(entidad_res, sort(1) descending label(labsize(vsmall)angle(45)))
ylabel(,labsize(vsmall) )
ytitle("Número de casos") 
title("Casos confirmados de COVID-19 en México (n=8261)")
subtitle("distribución por estado de la república al 19/04/2020")
note("Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral")
blabel(bar, position(outside) format(%9.0f) color(black) size(tiny) angle(vertical))
;

graph export "C:\Users\Alberto\Desktop\COVID_CASOS_ESTADO.png", as(png) name("Graph")

*********************************************
*Análisis por entidad federativa: Gráfico de barras
*********************************************
 
#delimit;
graph bar (count) entidad_res1 if def_01==1 & resultado==1,
over(entidad_res, sort(1) descending label(labsize(vsmall)angle(45)))
ylabel(,labsize(vsmall) )
ytitle("Número de casos") 
title("Defunciones por COVID-19 en México (n=8261)")
subtitle("distribución por estado de la república al 19/04/2020")
note("Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral")
blabel(bar, position(outside) format(%9.0f) color(black) size(tiny) angle(vertical))
;
graph export "C:\Users\Alberto\Desktop\COVID_DEFUNCIONES_ESTADO.png", as(png) name("Graph")


*********************************************
*Análisis por entidad federativa: Gráfico de barras
*********************************************
*HOSPITALIZADO INTUBADO
tab intubado  if neumonia ==1 & tipo_paciente ==2 & resultado ==1

*HOSPITALIZADOS GRAVES
 tab neumonia if resultado ==1 & tipo_paciente ==2 & intubado==2
 
*HOSPITALIZADOS ESTABLES
 tab neumonia if resultado ==1 & tipo_paciente ==2 & intubado==2 

*AMBULATORIOS
tab tipo_paciente if resultado ==1

gen gravedad=.
replace gravedad=0 if tipo_paciente ==2 & resultado ==1 & intubado==1
replace gravedad=1 if neumonia==1 & tipo_paciente ==2 & resultado ==1 & intubado==2
replace gravedad=2 if neumonia==2 & tipo_paciente ==2 & resultado ==1 & intubado==2
replace gravedad=3 if resultado==1 & tipo_paciente ==1

tab gravedad

label define gravedad 0 "Hospitalizado intubado" 1 "Hospitalizado grave" 2 " Hospitalizado estable" 3 "Ambulatorio"

label values gravedad gravedad


#delimit;
graph pie , over(gravedad) plabel(_all percent, format(%9.0f) color(black) size(small))
pie(1, color(cranberry)) pie(2, color(yellow)) pie(3,color(blue)) pie(4,color(green)) 
title("Casos confirmados de COVID-19 en México (n=8261)")
subtitle("distribución por gravedad al 19/04/2020")
note("Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral")
;

gen gravedad1=gravedad

#delimit;
graph bar (percent) gravedad1,
over(gravedad, sort(1) descending label(labsize(vsmall)))
ylabel(,labsize(vsmall) )
ytitle("Porcentaje") 
title("Casos confirmados de COVID-19 en México (n=8261)")
subtitle("distribución por gravedad al 19/04/2020")
note("Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral")
blabel(bar, position(outside) format(%9.0f) color(black) size(small) angle(vertical))
;

graph export "C:\Users\Alberto\Desktop\COVID_GRAVEDAD.png", as(png) name("Graph")

*********************************************
*EPI GRAPHS
********************************************

gen date_actualizacion = date(fecha_actualizacion , "YMD")
format date_actualizacion %td

gen date_ingreso = date(fecha_ingreso , "YMD")
format date_ingreso %td

gen date_sintomas = date(fecha_sintomas , "YMD")
format date_sintomas %td

gen date_def = date(fecha_def , "YMD")
format date_def %td
*****


cumul date_def if resultado==1, gen(cumul_date_def) freq
cumul date_sintomas if resultado==1, gen(cumul_date_sintomas) freq
cumul date_ingreso if resultado==1, gen(cumul_date_ingreso) freq


#delimit;
graph bar cumul_date_ingreso if resultado ==1,
over(fecha_ingreso, sort(1) label(labsize(tiny)angle(45)format(%td)))
ylabel(,labsize(vsmall) )
ytitle("Número de casos") 
title("Casos acumulados de COVID-19(n=8261)")
subtitle("por fecha al 19/04/2020")
note("Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral")
blabel(bar, position(outside) format(%9.0f) color(black) size(tiny) angle(180) gap(2))
;

graph export "C:\Users\Alberto\Desktop\COVID_CASOS_ACUMULADOS.png", as(png) name("Graph")


*********************************************
*MUERTES ACUMULADAS
*********************************************


#delimit;
graph bar cumul_date_def if resultado ==1,
over(fecha_def, sort(1) label(labsize(tiny)angle(45)format(%td)))
ylabel(,labsize(vsmall) )
ytitle("Número de casos") 
title("Muertes acumuladas por COVID-19(n=686)")
subtitle("por fecha al 19/04/2020")
note("Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral")
blabel(bar, position(outside) format(%9.0f) color(black) size(tiny) angle(180) gap(2))
;

graph export "C:\Users\Alberto\Desktop\COVID_DEFUNCIONES_ACUMULADAS.png", as(png) name("Graph")

**********************************************
*GRÁFICOS COMORBILIDADES
*********************************************

tab diabetes if def_01 ==2 & resultado==1
tab epoc if def_01 ==2 & resultado==1
tab asma if def_01 ==2 & resultado==1
tab inmusupr if def_01 ==2 & resultado==1
tab hipertension if def_01 ==2 & resultado==1
tab cardiovascular if def_01 ==2 & resultado==1
tab obesidad if def_01 ==2 & resultado==1
tab tabaquismo if def_01 ==2 & resultado==1
tab renal_cronica if def_01 ==2 & resultado==1
tab otra_con if def_01 ==2 & resultado==1

tab diabetes if def_01 ==2 & resultado==1, generate(dum)
rename dum1 dum_diabetes
drop dum2 dum3

tab epoc if def_01 ==2 & resultado==1, generate(dum)
rename dum1 dum_epoc
drop dum2 dum3

tab asma if def_01 ==2 & resultado==1, generate(dum)
rename dum1 dum_asma
drop dum2 dum3

tab inmusupr if def_01 ==2 & resultado==1, generate(dum)
rename dum1 dum_inmusupr
drop dum2 dum3

tab hipertension if def_01 ==2 & resultado==1, generate(dum)
rename dum1 dum_hipertension
drop dum2 dum3

tab cardiovascular if def_01 ==2 & resultado==1, generate(dum)
rename dum1 dum_cardiovascular
drop dum2 dum3

tab obesidad if def_01 ==2 & resultado==1, generate(dum)
rename dum1 dum_obesidad
drop dum2

tab tabaquismo if def_01 ==2 & resultado==1, generate(dum)
rename dum1 dum_tabaquismo
drop dum2 dum3

tab renal_cronica if def_01 ==2 & resultado==1, generate(dum)
rename dum1 dum_renal_cronica
drop dum2 dum3

tab otra_com if def_01 ==2 & resultado==1, generate(dum)
rename dum1 dum_otra_con
drop dum2 dum3




preserve
keep dum_diabetes dum_epoc dum_asma dum_inmusupr dum_hipertension dum_cardiovascular dum_obesidad dum_tabaquismo dum_renal_cronica dum_otra_con

gen id=_n

reshape long dum, i(id) j(disease) string

drop if dum==.

by disease , sort: tab dum

#delimit;
graph hbar (mean) dum, 
over(disease, relabel(1 "Asma" 2 "Cardiovascular" 3 "Diabetes" 4 "EPOC" 5 "Hipertensión" 6 "Inmunosupresión" 7 "Obesidad" 8 "Otra condición" 9 "I.R.C." 10 "Tabaquismo") 
sort(dum) descending) 
blabel(bar, format(%3.2f)) ytitle(Porcentaje) title(Defunciones confirmadas(n=686)) 
subtitle(según comorbilidad al 19/04/2020) 
note(Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral)
;

graph export "C:\Users\Alberto\Desktop\DEFUNCION_COMORBILIDAD.png", as(png) name("Graph")



#delimit;
graph hbar (mean) dum_diabetes dum_epoc dum_asma dum_inmusupr dum_hipertension dum_cardiovascular dum_obesidad dum_tabaquismo dum_renal_cronica dum_otra_con if resultado==1, 
 yvaroptions(relabel(1 "Asma" 2 "Cardiovascular" 3 "Diabetes" 4 "EPOC" 5 "Hipertensión" 6 "Inmunosupresión" 7 "Obesidad" 8 "Otra condición" 9 "I.R.C." 10 "Tabaquismo"))
over(resultado, axis(off)) 
showyvars ylabel(#10)
blabel(bar, format(%3.2f)) ytitle(Porcentaje) title(Defunciones confirmadas(n=686)) 
subtitle(según comorbilidad al 19/04/2020) 
note(Información del Sistema de Vigilancia Epidemiológica de Enfermedades Respiratoria Viral)
;

