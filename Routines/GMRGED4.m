GMRGED4 ;CISC/RM-PATIENT DATA EDIT (cont.) ;3/16/89
 ;;3.0;Text Generator;;Jan 24, 1996
PRTDEF ; PRINT TERM DEFINITION OF ALL TERMS ON THIS SCREEN
 W ! S GMRG02=0 F GMRG00=GMRGSTAR(0,GMRGSTAR(2)):0 S GMRG00=$O(GMRGSEL(GMRG00)) Q:GMRG00'>0!(GMRG00>GMRGSTAR(1))  S GMRG01=$P(GMRGSEL(GMRG00),"^") D PRTD1 Q:GMRGOUT
 I GMRGOUT S:GMRGOUT=1 GMRGOUT=0 Q
 W !,"Press return to continue " R X:DTIME I X="^"!(X="^^")!'$T S GMRGOUT=1
 Q
PRTD1 ;
 I GMRG02>(IOSL-3) S GMRG02=0 W !,"Press return to continue " R X:DTIME S:X="^^"!(X="^")!'$T GMRGOUT=$S(X="^":1,1:2) Q:GMRGOUT
 W !,"'" S GMRGXPRT=$P(GMRGSEL(GMRG00),"^",2),GMRGXPRT(0)=$S($D(GMRGSEL(GMRG00,1)):$P(GMRGSEL(GMRG00,1),"^",2),1:"") D EN1^GMRGRUT2 W "'" S GMRG02=GMRG02+2
 K ^UTILITY($J,"W") F GMRG03=0:0 S GMRG03=$O(^GMRD(124.2,GMRG01,"TD",GMRG03)) Q:GMRG03'>0  S X=$S($D(^(GMRG03,0)):^(0),1:""),DIWL=5,DIWR=IOM,DIWF="W",GMRG02=GMRG02+1 D ^DIWP
 D ^DIWW S GMRG02=GMRG02+1 K DIWL,DIWR,DIWF,^UTILITY($J,"W")
 Q
PRAD ; PRINT ADDITIONAL TEXT
 S GMRGPLN=$S(+$P(GMRGTERM,"^",3)'>0:"",$D(^GMR(124.3,GMRGPDA,1,$P(GMRGTERM,"^",3),"ADD")):^("ADD"),1:""),GMRGL=IOM-22,GMRGLEN=GMRGL,GMRGLIN=GMRGLIN+1 D FITLINE^GMRGRUT1 W GMRGPLN(0)
 F GMRG1=0:0 Q:GMRGPLN(1)=""  S GMRGLEN=GMRGL,GMRGPLN=GMRGPLN(1) D FITLINE^GMRGRUT1 W !?22,GMRGPLN(0) S GMRGLIN=GMRGLIN+1 I GMRGLIN>(IOSL-4) S GMRGLIN=0 W !,"'^' TO STOP: " R X:DTIME S GMRGOUT=$S(X="^":1,X="^^"!'$T:2,1:GMRGOUT) Q:GMRGOUT
 Q
SETSEL ; SET GMRGSEL ARRAY
 F GMRG1=0:0 S GMRG1=$O(^GMR(124.3,GMRGPDA,1,"ALIST",$P(GMRGTERM,"^"),GMRG1)) Q:GMRG1'>0  S GMRGPAT(GMRG1)=^(GMRG1)
 K GMRGSEL S GMRGUP=0,GMRGCNT=1,GMRG2="" F GMRG2(0)=0:0 S GMRG2=$O(^GMRD(124.2,$P(GMRGTERM,"^"),1,"AC",GMRG2)) Q:GMRG2=""  F GMRG1=0:0 S GMRG1=$O(^GMRD(124.2,$P(GMRGTERM,"^"),1,"AC",GMRG2,GMRG1)) Q:GMRG1'>0  D PRTSEL
 I $P(GMRGTERM(0),"^",10) D EN1^GMRGED8 ; save for split screen
 I $P(GMRGTERM(0),"^",11) D EN2^GMRGED9
 Q
PRTSEL ; SET UP THE GMRGSEL ARRAY OF SELECTIONS OF THIS TERM.
 S GMRGSEL=$S($D(^GMRD(124.2,$P(GMRGTERM,"^"),1,GMRG1,0)):$P(^(0),"^",1,2),1:""),GMRGND=$P(GMRGSEL,"^") Q:GMRGND=""  D PATDAT^GMRGRUT2 S GMRGSEL(GMRGCNT)=GMRGSEL_"^"_GMRGPRT S:GMRGPRT GMRGSEL(GMRGCNT,1)=GMRGPRT(0) S GMRGCNT=GMRGCNT+1
 Q
REPRT ;
 S GMRGPRT=$P(GMRGSEL(GMRG1),"^",3),GMRGSEL=GMRGSEL(GMRG1),GMRGPRT(0)=$S($D(GMRGSEL(GMRG1,1)):GMRGSEL(GMRG1,1),1:""),GMRGSTAR=GMRG1-1 Q:GMRGOUT  I GMRGLIN>(IOSL-4) S GMRGLIN=0 D PARSEL Q
 S GMRGLIN=GMRGLIN+1 W !,$S(GMRGPRT:"**",1:""),?4,$S('$D(^GMRD(124.2,"ATY",3,$P(GMRGSEL,"^"))):"+",1:" "),$J((GMRG1),2),". "
 S GMRGXPRT=$P(GMRGSEL,"^",2),GMRGXPRT(0)=$P(GMRGPRT(0),"^",2),GMRGXPRT(1)="9^"_IOM_"^1^"_$S(GMRGPRT&GMRGIO("S")&'$P(GMRGSITE(0),"^",2):1,1:0)_"^" D EN1^GMRGRUT2
 S GMRGTLC=$Y
 K GMRGHPRT I $D(^GMRD(124.2,$P(GMRGSEL,"^"),10)) X ^(10)
 F X=0:0 S X=$O(GMRGHPRT(X)) Q:X'>0  W ?(+GMRGHPRT(X)),$P(GMRGHPRT(X),"^",2)
 S GMRGTLC=$Y-GMRGTLC I GMRGTLC>0 S GMRGLIN=GMRGLIN+GMRGTLC
 Q
PARSEL ;
 W !!,"Please make the appropriate selections from this screen before continuing onto",!,"the next screen.  " D PROMPT^GMRGED3 R GMRGS:DTIME
 S:GMRGS="^"!(GMRGS="^^")!'$T GMRGOUT=1 Q:GMRGOUT  S GMRGSTAR(1)=GMRG1,GMRGPSEL=1 D PSEL^GMRGED1 I 'GMRGOOD G:GMRGMSR PARSEL Q
 S GMRGSTAR(2)=GMRGSTAR(2)+1,GMRGSTAR=GMRGSTAR(1)-1
 Q