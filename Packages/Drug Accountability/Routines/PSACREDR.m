PSACREDR ;BIR/JMB-Credit Resolution ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,64**; 10/24/97;Build 4
 ;This routine allows the user to apply credit memos to invoices.
 ;
 I '$D(^XUSEC("PSA ORDERS",DUZ)) W !,"You do not hold the key to enter the option." Q
 I '$D(^XUSEC("PSAMGR",DUZ)) W !,"You do not hold the key to enter the option." Q
 I '$O(^PSD(58.811,"AC",1,0)) W !!,"There are no outstanding credit memos." Q
 S PSASLN="",$P(PSASLN,"-",80)=""
START W ! S DIC="^PSD(58.811,",DIC(0)="AEQM",DIC("S")="I $D(^PSD(58.811,""AC"",1,+Y))" D ^DIC K DIE G:Y<0 EXIT
 G:'$D(^PSD(58.811,+Y,0)) START
 S PSAIEN=+Y,(PSAIEN1,PSAOUT)=0
 F  S PSAIEN1=$O(^PSD(58.811,"AC",1,PSAIEN,PSAIEN1)) Q:'PSAIEN1  D
 .Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,0))
 .S (PSACRED,PSAAECST,PSAIECST)=0
 .S PSAIEN2=0 F  S PSAIEN2=+$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAIEN2)) Q:'PSAIEN2!(PSAOUT)  D LINE Q:PSAOUT
 .D CREDITS
 D LIST
 G:PSAOUT EXIT G START
 ;
EXIT ;Kills printing variables only
 K DA,DIC,DIE,DIR,DIRUT,DR,PSA,PSAAECST,PSACIEN,PSACNT,PSACRED,PSADATA,PSADIF,PSADJ,PSADJD,PSADJDA,PSADJP,PSADJQ,PSADJSUP
 K PSAIECST,PSAIEN,PSAIEN1,PSAIEN2,PSAINV,PSALEN,PSAMENU,PSANODE,PSAOUT,PSAPC,PSAPRICE,PSASEL,PSASLN,Y
 Q
 ;
LINE ;Get line item data
 Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAIEN2,0))
 K PSADJQ,PSADJP,PSADJD
 S PSADATA=^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAIEN2,0),PSADJSUP=0
 ;Next line added 4dec97 to bypass checking drug name change
 G DAVE
DRUG S PSADJ=+$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAIEN2,1,"B","D",0))
 I $G(PSADJ) D  Q:'PSADJSUP
 .S PSANODE=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAIEN2,1,PSADJ,0))
 .S PSADJD=$S($P(PSANODE,"^",6)'="":$P(PSANODE,"^",6),1:$P(PSANODE,"^",2))
 .Q:$G(PSADJD)&($L(PSADJD)=+$L(PSADJD))
 .S PSADJSUP=1
DAVE S PSAIECST=PSAIECST+($P(PSADATA,"^",3)*$P(PSADATA,"^",5))
PRICE S PSADJP=0,PSADJ=+$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAIEN2,1,"B","P",0))
 I $G(PSADJ) S PSANODE=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAIEN2,1,PSADJ,0)),PSAPRICE=$S($P(PSANODE,"^",6)'="":$P(PSANODE,"^",6),1:+$P(PSANODE,"^",2))
 I '+PSADJ S PSAPRICE=$P(PSADATA,"^",5)
QTY S PSADJQ=0,PSADJ=+$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAIEN2,1,"B","Q",0))
 I $G(PSADJ) S PSANODE=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAIEN2,1,PSADJ,0)),PSADJQ=$S($P(PSANODE,"^",6)'="":+$P(PSANODE,"^",6),1:$P(PSANODE,"^",2))
 I $G(PSADJQ) S PSAAECST=PSAAECST+(PSADJQ*PSAPRICE)
 I '$G(PSADJQ) S PSAAECST=PSAAECST+($P(PSADATA,"^",3)*PSAPRICE)
 Q
 ;
CREDITS ;Adds existing credits to adjusted extended cost.
 S PSACIEN=0 F  S PSACIEN=$O(^PSD(58.811,PSAIEN,1,PSAIEN1,2,PSACIEN)) Q:'PSACIEN  D
 .Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,2,PSACIEN,0))
 .S PSACRED=PSACRED+$P(^PSD(58.811,PSAIEN,1,PSAIEN1,2,PSACIEN,0),"^",3)
 S:PSAAECST'=PSAIECST PSA(PSAIEN1)=PSAIECST_"^"_$J(PSAAECST,$L($P(PSAAECST,".")),2)_"^"_PSACRED
 Q
 ;
LIST ;Displays the invoices with outstanding credits
 W @IOF,!,"Order#: "_$P($G(^PSD(58.811,PSAIEN,0)),"^")
 W !?28,"Invoice",?42,"Adjusted",?56,"Received",!?4,"Invoice#",?31,"Cost",?46,"Cost",?57,"Credits",?69,"Difference",!,PSASLN
 S (PSACNT,PSAIEN1)=0 F  S PSAIEN1=+$O(PSA(PSAIEN1)) Q:'PSAIEN1  D
 .S PSAIECST=+$P(PSA(PSAIEN1),"^"),PSAAECST=+$P(PSA(PSAIEN1),"^",2),PSACRED=+$P(PSA(PSAIEN1),"^",3)
 .S PSACNT=PSACNT+1,PSAMENU(PSACNT,PSAIEN1)=PSA(PSAIEN1)
 .W !,($J(PSACNT,2)),".",?4,$P($G(^PSD(58.811,PSAIEN,1,PSAIEN1,0)),"^"),?26,$J(PSAIECST,9,2),?41,$J(PSAAECST,9,2)
 .W ?55,$J(PSACRED,9,2)
 .S PSADIF=PSAIECST-(PSAAECST+PSACRED)
 .W ?70,$J(PSADIF,9,2)
 I PSACNT'>0 W !!!,?10,"NO INVOICES ON THIS ORDER # FOR CREDITING PURPOSES",! Q  ;Dave Blocker 3Dec97
 W ! K DIR S DIR(0)="LO^1:"_PSACNT,DIR("A")="Select invoices",DIR("?")="Select the invoices to which you want to apply credit memos.",DIR("??")="^D CREDHELP^PSACREDR"
 D ^DIR K DIR Q:Y=""  I $G(DIRUT) S PSAOUT=1 Q
 S PSASEL=Y
 ;
SELECT ;Selects invoices for credit memos
 F PSAPC=1:1 S PSACNT=+$P(PSASEL,",",PSAPC) Q:'PSACNT  D  Q:PSAOUT
 .S PSAINV=$O(PSAMENU(PSACNT,0)),PSAIECST=$P(PSAMENU(PSACNT,PSAINV),"^"),PSAAECST=$P(PSAMENU(PSACNT,PSAINV),"^",2),PSACRED=$P(PSAMENU(PSACNT,PSAINV),"^",3)
 .W !!,"Invoice: "_$P($G(^PSD(58.811,PSAIEN,1,PSAINV,0)),"^"),!
 .S DA(2)=PSAIEN,DA(1)=PSAINV,DA=PSAIEN2
 .S:'$D(^PSD(58.811,PSAIEN,1,PSAINV,2,0)) DIC("P")=$P(^DD(58.8112,6,0),"^",2)
 .S DIC="^PSD(58.811,"_DA(2)_",1,"_DA(1)_",2,",DIC(0)="AEMQL",DIC("A")="CREDIT MEMO: ",DR=.01,DLAYGO=58.811
 .F  L +^PSD(58.811,PSAIEN,1,PSAINV,2,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .D ^DIC K DLAYGO I Y<0 S PSAOUT=1 K DIC Q
 .S DIE=DIC,DR="1;2;3",(PSADJDA,DA)=+Y D ^DIE K DA,DIE,DIC L -^PSD(58.811,PSAIEN,1,PSAINV,2,0)
 .S PSACRED=PSACRED+$P($G(^PSD(58.811,PSAIEN,1,PSAINV,2,PSADJDA,0)),"^",3)
 .I PSAIECST=$J((PSAAECST+PSACRED),2) S DA(1)=PSAIEN,DA=PSAINV,DIE="^PSD(58.811,"_DA(1)_",1,",DR="10////0" D ^DIE K DIE
 .W !!,"Invoice: "_$P($G(^PSD(58.811,PSAIEN,1,PSAINV,0)),"^") S PSALEN=$L($P($G(^PSD(58.811,PSAIEN,1,PSAINV,0)),"^"))+11
 .W ?PSALEN,"Total Invoiced Cost: "_$J(PSAIECST,9,2),!?PSALEN,"Total Adjusted Cost: "_$J(PSAAECST,9,2)
 .W !?PSALEN,"Total Credits      : "_$J(PSACRED,9,2)
 .W !?PSALEN,"Difference         : "_$J((PSAIECST-(PSAAECST+PSACRED)),9,2),!
 Q
 ;
CREDHELP ;Extended help to 'Select invoices'
 W !?5,"Enter the numbers to the left of the invoices for which you want to",!?5,"enter credit memos. To select more than one invoice number, enter"
 W !?5,"the numbers to the left of the invoices separated by a comma or a dash.",!!?5,"For example: Enter 1,2,3,5 or 1-3,5"
 Q
