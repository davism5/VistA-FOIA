IBDF2H ;ALB/CJM - ENCOUNTER FORM - (prints hand print field);07/20/94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**25**;APR 24, 1997
 ;
HFLD(FIELD) ;for printing the input field=FIELD
 N BLOCK,LABEL,ROW,COL,NODE,DISP,FNAME,FID,TYPEDATA,PI,FORMAT,WIDTH,UNIT
 Q:'$G(FIELD)
 S NODE=$G(^IBE(359.94,FIELD,0))
 S BLOCK=$P(NODE,"^",8)
 ;if the input field does not belong to the right block, reindex it and quit
 I BLOCK'=IBBLK K DA S DA=FIELD,DIK="^IBE(359.94," D IX^DIK K DIK Q
 S PI=$P(NODE,"^",6)
 S COL=$P(NODE,"^",3)
 S ROW=$P(NODE,"^",4)
 S LABEL=$P(NODE,"^",2)
 S DISP=$P(NODE,"^",5)
 S TYPEDATA=$P(NODE,"^",10)
 S FNAME=$P(NODE,"^")
 S FID="H"_FIELD
 D DRWSTR^IBDFU(+ROW,+COL,LABEL,DISP)
 ;
 I TYPEDATA S NODE=$G(^IBE(359.1,TYPEDATA,0)) S FORMAT=$$FRMT^IBDF2F(NODE,$G(IBAPPT)),WIDTH=$P(NODE,"^",6),UNIT=$P(NODE,"^",11)
 D DRWHAND^IBDFM1(ROW,COL+$L(LABEL)+1,WIDTH,PI,1,FID,FNAME,LABEL,"",1,2,2,TYPEDATA)
 Q