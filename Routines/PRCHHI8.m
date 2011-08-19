PRCHHI8 ;WISC/TGH-IFCAP SEGMENT DH ;10/2/92  4:08 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
DH(A,A1,A2,VAR1,CNTR,NUM) ;Prism Delivery Order Header - Contracting & Procurement
 ;S A12=$G(^PRC(442,VAR1,4,##,0))
 N X,STRNG,PRCHNET,PRCHAMT,PRCHSTA,PRCHBL,PRCHLOOP,PRCHTRID,PRCHTRLE,SPFILL,PRCHITFI,PRCHDEFI,LINEITEM
 S PRCHA0=A
 S PRCHA1=A1
 S PRCHDE=0 ;Fine for RC1's - for PO1's need actual DE line count
 S PRCHITM=1 S:A2="PO1" PRCHITM=$P(PRCHA0,U,14)
 ;
 ;#DL SEGEMENT (LINE COUNT) FORMATTED UPTO 3 CHARS. W LEADING ZEROS
 S PRCHITFI="00"_PRCHITM
 I $D(PRCHITFI) S PRCHITFI=$E(PRCHITFI,$L(PRCHITFI)-2,99)
 ;
 S PRCHTP(1,CNTR+1)="S X=""|DH"";540"
 ;
 ;TRANSACTION ID FORMATTED UPTO 15 CHARS W TRAILING SPACES, DASH REMOVED
 S PRCHTRID=$TR($P(PRCHA0,U),"-")
 I $D(PRCHTRID) S PRCHTRID=PRCHTRID_"               ",PRCHTRID=$E(PRCHTRID,1,15)
 ;
 S PRCHTP(1,CNTR+2)="S X=$P(PRCHA0,U,12);533"
 ;**S PRCHTP(1,CNTR+3)="S X=$P(PRCH(MOD),U);535" ;MOD #
 S PRCHTP(1,CNTR+4)="S X=$P(PRCHA0,U,16);577" ;OBLIG
 S PRCHREQ=$P(PRCHA1,U,2),PRCHREQ=$P($G(^DIC(49,PRCHREQ,0)),U)
 S PRCHTP(1,CNTR+5)="S X=$P(PRCHREQ,U,4);533.2"
 ;S PRCHTP(1,CNTR+6)="S X=$P(PRCHPHN,U,5);533.4"
 S PRCHTP(1,CNTR+6)="S X=""999-999-9999"";533.4"
 S PRCHTP(1,CNTR+7)="S X=$P(PRCHA1,U,3);514.1" ;SHIP TO
 S PRCHTP(1,CNTR+8)="S X=901;534.6" ;OFF CODE
 ;VENDOR
 S X=+PRCHA1 I X]"" S X=$P($G(^PRC(440,X,0)),"^"),X=$E(X,1,25)
 S PRCHVEN=X,PRCHVEN=PRCHVEN_"                         "
 S PRCHVEN=$E(PRCHVEN,1,25)
 ;
 S PRCHTP(1,CNTR+9)="S X=PRCHVEN;515.2" ;VENDOR
 ;** STAPELTON - S PRCHTP(1,CNTR+10)="S X=$P(PRCHNUM,U,7);534.8"
 S PRCHTP(1,CNTR+11)="S X=$P(PRCHA0,U,10);543"
 ;** STAPELTONS - PRCHTP(1,CNTR+12)="S X=$P(PRCHLIM,U,7) ;LIMITATION
 S PRCHTP(1,CNTR+13)="S X=PRCHDE;546"
 S PRCHTP(1,CNTR+14)="S X=PRCHITM;520"
 S X=$P(PRCHA0,U,10) D JD^PRCFDLN S DAT=$E(X,1,3)+1700_$E(Y,1,3)
 ;
 ;OBLIG. AMT(NET AMT) UPTO 10 CHARS. W LEADING ZEROS 2 & DECIMALS IMPLIED
 S PRCHNET=$TR($J($P(PRCHA0,U,16),0,2),".")
 S PRCHAMT="0000000000"_PRCHNET
 S PRCHAMT=$E(PRCHAMT,$L(PRCHAMT)-9,99)
 ;
 ;STATION NO IS REQUIRED FOR SHIP TO FIELD
 S PRCHSTA=+$P(PRCHA0,U)
 ;
 ;VENDOR NAME FORMATTED UPTO 25 CHARS. W TRAILING SPACES
 ;I $D(PRCHVEN) S PRCHVEN=PRCHVEN_"                         ",PRCHVEN=$E(PRCHVEN,1,25)
 ;
 S STRNG="DH"_"^"_PRCHTRID_"^^^^^^^^^^"_PRCHAMT_"^"_$P(PRCHREQ,U,4)_"^"_$P(PRCHREQ,U,5)_"^"_PRCHSTA_"^"_901_"^"
 S STRNG=STRNG_PRCHVEN_"^^"_DAT_"^^"_PRCHDE_"^"_PRCHITFI_"^|"
 S NUM=NUM+1,^TMP($J,"STRING",NUM)=STRNG
 Q