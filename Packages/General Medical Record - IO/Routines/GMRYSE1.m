GMRYSE1 ;HIRMFO/YH-ITEMIZED PATIENT I/O REPORT BY SHIFT PART 2 ;3/11/97
 ;;4.0;Intake/Output;;Apr 25, 1997
BODY ;
 I '$D(^TMP($J)) W !!,?5,"NO DATA FOR THIS PERIOD",!! Q
 D INITOT^GMRYRP3,INISHFT^GMRYRP3,SHFTP,DAYP S (GRNDIP,GRNDOP)="" D SUM^GMRYSE2
 Q
FOOTER ;
 F X=1:1 W ! Q:IOSL<($Y+$S($E(IOST)="P":4,1:10))
 D FOOTER^GMRYRP3 Q
REPORT ;
 D TITLE^GMRYRP3
 S GMRDOT="",$P(GMRDOT,".",50)="",GMRX="",$P(GMRX,"-",$S(GRPT=2:53,GRPT=3:32,1:53))="" D HEADER2 S GQT=1 D BODY D:'GMROUT FOOTER I $E(IOST)'="P",'GMROUT W !,"Press return to continue " R X:DTIME I '$T!(X["^") S GMROUT=1
 K GCATH,GTOTAL,GLEFT,GREASON,GY Q
HEADER2 ;
 I GQT D FOOTER
 I GQT,'GQ,$E(IOST)'="P" W !,"Press return to continue or ""^"" to stop " R X:DTIME I '$T!(X="^") S GMROUT=1 Q
 W:'($E(IOST)'="C"&'GPC) @IOF
 S GQT=1,GPC=GPC+1,GCOL=$S(IOM>80:40,1:10) W !,?GCOL,"PATIENT INTAKE/OUTPUT REPORT BY SHIFT AND EVENT TYPE" S GCOL=$S(IOM>80:120,1:70) W ?GCOL,"PAGE: ",GPC
 S GCOL=$S(IOM>80:40,1:10) W !,?GCOL,$S(GRPT=9:$E(GMRX,1,46),1:GMRX),! S GCOL=GCOL+8 W ?GCOL,GMRDT1," - ",GMRDT2,!
 I $D(GY) W GY_"(continued)",!
 Q
NPOS ;OBTAIN NURSE POSITION
 S GNURSE=$P(GDATA,"^",3),GTEXT=$P(GDATA,"^",2) D WHR^GMRYSE3
 W ?14,$S(GIO="IN":$P($G(^GMRD(126.56,+GTYPE,0)),"^")_"       intake vol: ",GIO="OUT":$P($G(^GMRD(126.58,+GTYPE,0)),"^")_"      output vol: ",1:""),GAMOUNT_$S(GAMOUNT>0!(GAMOUNT="0"):" mls",1:"")
 I GIO="OUT",(GSUB>0&(GSUB<99)),$D(^GMRD(126.6,GSUB,0)) W "   "_$P(^GMRD(126.6,+GSUB,0),"^")
 I GIO="OUT",$P(GDATA,"^",2)'="" S GTXT(1)="- "_$P(GDATA,"^",2) D WLINE^GMRYSE3
 S GITEM=$P(GDATA,"^",4) I GITEM'="" S GTXT(1)="- "_GITEM D WLINE^GMRYSE3
 S GITEM="" G:GNURSE="" Q S GCOL=$S(IOM>80:120,1:70) W ?GCOL,$E($P($P(^VA(200,GNURSE,0),"^"),",",2)),$E($P(^(0),"^"))
 S GPOS="" I GNURSE'="",$D(^NURSF(211.8,"C",GNURSE)) S GLOC=$O(^NURSF(211.8,"C",GNURSE,0)) S:$D(^NURSF(211.8,GLOC,0)) GPOS=$P(^(0),"^",2)
 W "/"_$S(GPOS="R":"RN",GPOS="L":"LPN",GPOS="N":"NA",GPOS="C":"CL",1:"OTH")
Q W ! Q
ILABEL ;
 I II>3 S GLAB=$P(^GMRD(126.56,$O(^GMRD(126.56,"C",II-3,0)),0),"^") Q
 S GLAB=$S(II=1:"IV FLUIDS",II=2:"BLOOD/PRODUCT",II=3:"PARENTERAL NUTR.",1:"") Q
OLABEL ;
 S GLAB=$P(^GMRD(126.58,II,0),"^") Q
CHKPR ;
 I ($Y+4)>IOSL D HEADER2 Q:GMROUT
 I GIO="IN",GPRT(1)=0 W ?2,"INTAKE:",! S GPRT(1)=1 Q
 I GIO="OUT",GPRT(2)=0 W ?2,"OUTPUT:",! S GPRT(2)=1 Q
 Q
CHKTYP ;
 I ($Y+4)>IOSL D HEADER2 Q:GMROUT
 I GIO="IN" W ?4,$S(GSUB=1:"PO",GSUB=2:"NASOGASTRIC",GSUB=3:"GASTROTOMY",GSUB=4:"PHARYNGOTOMY",1:"OTHER")
 I GIO="OUT" W ?4,$P(^GMRD(126.6,+GSUB,0),"^")
 Q
SHFTP ;FIELD TO SAVE '+' CODE FOR SHIFT TOTAL
 F II=1:1:GN(1) S GSIP(II)=""
 F II=1:1:GN(2) S GSOP(II)=""
 Q
DAYP ;FIELD TO SAVE '+' CODE FOR DAY TOTAL
 F II=1:1:GN(1) S GDIP(II)=""
 F II=1:1:GN(2) S GDOP(II)=""
 Q