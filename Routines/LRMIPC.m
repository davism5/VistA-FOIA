LRMIPC ;SLC/CJS/BA - MICROBIOLOGY CUMULATIVE PATIENT REPORT ;2/19/91  10:51
 ;;5.2;LAB SERVICE;**121,283**;Sep 27, 1994
 ;from option LRMIPC
BEGIN K DIC W !!?21,"MICROBIOLOGY CUMULATIVE PATIENT REPORT" D ^LRPARAM D ^LRDPA I LRDFN'=-1 D EN
END K DFN,DIC,DOB,I,J,K,LRAA,LRACC,LRAD,LRAN,LRCMNT,LRDFN,LRDPF,LREDT,LREND,LRIDT,LRLLT,LRONESPC,LRONETST,LRPG,LRSDT,PNM,POP,SSN,X,X1,Y
 Q
ALL ;from pretty print
 S LRONETST=""
EN ;from pretty print
 I $D(LRPRETTY) S LRIDT=LRSDT D DQ Q
 I '$D(LRONESPC) S LRONESPC="",DIC="^LAB(61,",DIC("A")="Select SPECIMEN/SOURCE: ANY//",DIC(0)="AEMOQ" D ^DIC Q:X[U  S:Y>0 LRONESPC=+Y
 I '$D(LRONETST) S LRONETST="",DIC="^LAB(60,",DIC("A")="Select MICROBIOLOGY TEST: ALL MICRO//",DIC(0)="AEOQ",DIC("S")="I $P(^(0),U,4)=""MI""" D ^DIC K DIC Q:$D(DTOUT)!$D(DUOUT)  I Y>0 S LRONETST=+Y
 S LREDT="T-14" D ^LRWU3 Q:LREND  S LREDT=9999999-LREDT,LRIDT=9999999-LRSDT
 S ZTRTN="DQ^LRMIPC" D IO^LRWU
 Q
DQ ;dequeued
 S:$D(ZTQUEUED) ZTREQ="@" U IO
 S LREND=0,LRPG=0 F  S LRIDT=+$O(^LR(LRDFN,"MI",LRIDT)) Q:LRIDT<1!(LRIDT>LREDT)  D EN1 Q:LREND
 Q
EN1 ;from LRRP1, LRRP2, LRRP3, LRAC1, LRACO1, LRACSUM1
 S LRLLT=^LR(LRDFN,"MI",LRIDT,0),LRACC=$P(LRLLT,U,6),LRAD=$E(LRLLT)_$P(LRACC," ",2)_"0000",X=$P(LRACC," "),DIC=68,DIC(0)="M"
 I $L(X) D ^DIC S LRAA=+Y,LRAN=+$P(LRACC," ",3),LRCMNT=$S($D(^LR(LRDFN,"MI",LRIDT,99)):^(99),1:"") D EN^LRMIPSZ1 Q:LREND
 Q