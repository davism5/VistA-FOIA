SROALC ;BIR/MAM - COMPLETE ASSESSMENTS ;01/18/06
 ;;3.0; Surgery ;**38,50,142,153,160**;24 Jun 93;Build 7
 I $E(IOST)="P" D ^SROALCP Q
 S SRSOUT=0 D HDR
 F  S SRSD=$O(^SRF("AC",SRSD)) Q:'SRSD!(SRSD>SRED)!SRSOUT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSD,SRTN)) Q:'SRTN!SRSOUT  S SR("RA")=$G(^SRF(SRTN,"RA")) I $P(SR("RA"),"^")="C",$D(^SRF(SRTN,0)),$$MANDIV^SROUTL0(SRINSTP,SRTN) D SET
 Q
SET ; print assessments
 K SRCPTT S SRCPTT="NOT ENTERED"
 I $P(SR("RA"),"^",6)="N" Q
 I $Y+5>IOSL D PAGE I SRSOUT Q
 S SRA(0)=^SRF(SRTN,0),DFN=$P(SRA(0),"^") N I D DEM^VADPT S SRANM=VADM(1),SRASSN=VA("PID") K VADM
 I $L(SRANM)>19 S SRANM=$P(SRANM,",")_","_$E($P(SRANM,",",2))_"."
 S SROPER=$P(^SRF(SRTN,"OP"),"^") I $O(^SRF(SRTN,13,0)) S SROTHER=0 F I=0:0 S SROTHER=$O(^SRF(SRTN,13,SROTHER)) Q:'SROTHER  D OTHER
 S X=$P($G(^SRF(SRTN,"RA")),"^",2) I X="C" S SROPER="* "_SROPER
 K SROPS,MM,MMM S:$L(SROPER)<34 SROPS(1)=SROPER I $L(SROPER)>33 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S SRSS=$P(SRA(0),"^",4),SRSS=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^"),1:"SPECIALTY NOT ENTERED")
 D TECH^SROPRIN
 S Y=$P(SRA(0),"^",9) D D^DIQ S SRDT=$P(Y,"@")
 W !,SRTN,?20,SRANM_" "_VA("PID"),?55,$P(SRSS,"("),!,SRDT,?20,SROPS(1),?55,SRTECH I $D(SROPS(2)) W !,?20,SROPS(2) I $D(SROPS(3)) W !,?20,SROPS(3)
 N I,SRPROC,SRL S SRL=48 D CPTS^SROAUTL0 W !,?20,"CPT Codes: "
 F I=1:1 Q:'$D(SRPROC(I))  W:I=1 ?31,SRPROC(I) W:I'=1 !,?31,SRPROC(I)
 W ! F LINE=1:1:80 W "-"
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,SROTHER,0),"^"))>125 S SRLONG=0,SROTHER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,SROTHER,0),"^")
 S SROPER=SROPER_$S(SROPERS'=" ...":", "_SROPERS,1:SROPERS)
 Q
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<34  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
PAGE W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X["?" W !!,"If you want to continue listing incomplete assessments, enter <RET>.  Enter",!,"'^' to return to the menu." G PAGE
HDR W @IOF,!,?27,"COMPLETED RISK ASSESSMENTS",!,?(80-$L(SRFRTO)\2),SRFRTO,!!,"ASSESSMENT #",?20,"PATIENT",?55,"SURGICAL SPECIALTY",!,"OPERATION DATE",?20,"OPERATION(S)",?55,"ANESTHESIA TECHNIQUE",! F LINE=1:1:80 W "="
 Q