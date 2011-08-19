PRCHAMY4 ;WISC/DJM-PRINT AMENDMENT,ROUTINE #4 ;12/13/95  2:44 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
E31 ;Change VENDOR
 N CHANGE,OLD,VEN,LCNT,DATA
 S CHANGE=0 D LCNT^PRCHPAM5(.LCNT)
 F  S CHANGE=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND,5,CHANGE)) Q:CHANGE'>0  D
 .S OLD=$G(^PRC(442,PRCHPO,6,PRCHAM,3,CHANGE,1,1,0)),OLD=$P($G(^PRC(440,OLD,0)),U)
 .S VEN=$P($G(^PRC(442,PRCHPO,1)),U),VEN=$P($G(^PRC(440,VEN,0)),U)
 .D LINE^PRCHPAM5(.LCNT,2) S DATA="Vendor "_OLD_" has been changed to "_VEN
 .D DATA^PRCHPAM5(.LCNT,DATA),LCNT1^PRCHPAM5(LCNT)
 Q
 ;
E32 ;REPLACE P.O. NUMBER
 N CHANGE,NPO,OPO,LCNT,DATA
 S CHANGE=0 D LCNT^PRCHPAM5(.LCNT)
 F  S CHANGE=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND,28,CHANGE)) Q:CHANGE'>0  D
 .S NPO=$P($G(^PRC(442,PRCHPO,23)),U,4),NPO=$P($G(^PRC(442,NPO,0)),U)
 .S OPO=$P($G(^PRC(442,PRCHPO,0)),U)
 .D LINE^PRCHPAM5(.LCNT,2) S DATA="Purchase Order number "_OPO_" has been changed to "_NPO
 .D DATA^PRCHPAM5(.LCNT,DATA),LCNT1^PRCHPAM5(LCNT)
 Q
 ;
E34 ;AUTHORITY Edit PRINT
 N CHANGE,CHANGES,OLD,NEW,LCNT,DATA,DT2,I
 S CHANGE=0 D LCNT^PRCHPAM5(.LCNT)
 F  S CHANGE=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND,3,CHANGE)) Q:CHANGE'>0  D
 .S CHANGES=^PRC(442,PRCHPO,6,PRCHAM,3,CHANGE,0),OLD=^PRC(442,PRCHPO,6,PRCHAM,3,CHANGE,1,1,0)
 .S NEW=$P(^PRC(442,PRCHPO,6,PRCHAM,0),U,4)
 .D LINE^PRCHPAM5(.LCNT,2)
 .I OLD=0 S DATA=" *ADDED THROUGH AMENDMENT*" D DATA^PRCHPAM5(.LCNT,DATA) D
 ..S DATA="Authority Edit is",DT2=$P(^PRCD(442.2,NEW,0),U,2) D  D DATA^PRCHPAM5(.LCNT,DATA)
 ...I $L(DATA)+$L(DT2)>239 S DATA=DATA_":" D DATA^PRCHPAM5(.LCNT,DATA) S DATA=DT2 Q
 ...S DATA=DATA_" "_DT2
 .I OLD>0 S DATA="Authority Edit " D  D DATA^PRCHPAM5(.LCNT,DATA)
 ..F I=1:1:3 S DT2=$S(I=1:$P(^PRCD(442.2,OLD,0),U,2),I=2:" has been changed to ",I=3:$P(^PRCD(442.2,NEW,0),U,2)) D CHK(.DATA,DT2)
 .D LCNT1^PRCHPAM5(LCNT)
 .Q
 Q
CHK(DATA,DT2) ;
 I $L(DATA)+$L(DT2)<241 S DATA=DATA_DT2 Q
 D DATA^PRCHPAM5(.LCNT,DATA) S DATA=DT2
 Q