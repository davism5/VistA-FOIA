PSDLBL4 ;BIR/JPW-CS Label Print for CS Disp Drug ; 5 Oct 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",10),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDLBL5",ZTDESC="Print Dispensing Labels for CS PHARM" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO D ^PSDLBL5
END ;kill variables and exit
 K %,%DT,%H,%I,%ZIS,ALL,ANS,C,CNT,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DRUG,DTOUT,DUOUT,JJ,JLP1,LIQ,NAOU,NAOUN,NODE,OK
 K POP,PSD,PSD1,PSD2,PSDA,PSDBAR0,PSDBAR1,PSDCNT,PSDEV,PSDG,PSDJ,PSDN,PSDPN,PSDOUT,PSDR,PSDRG,PSDPRT,PSDRN,PSDS,PSDSN,PSDT,PSDX1,PSDX2
 K SEL,STAT,TEMP,TEST,TEXT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDLBL",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save queued variables
 S:$D(ALL) ZTSAVE("ALL")=""
 S:$D(PSDS) (ZTSAVE("PSDS"),ZTSAVE("PSDSN"))=""
 S:$D(PSD1) ZTSAVE("PSD1(")="" S:$D(NAOU) ZTSAVE("NAOU(")="" S:$D(PSDG) ZTSAVE("PSDG(")="" S:$D(CNT) ZTSAVE("CNT")=""
 S (ZTSAVE("ANS"),ZTSAVE("PSDSITE"))=""
 Q
GROUP ;select group of naous
 K DA,DIC F  S DIC=58.2,DIC("A")="Select NAOU INVENTORY GROUP NAME: ",DIC(0)="QEA",DIC("S")="I $S($D(^PSI(58.2,""CS"",+Y)):1,1:0)" D ^DIC K DIC Q:Y<0  S PSDG(+Y)=""
 Q