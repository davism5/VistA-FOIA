SCMCDD1 ;ALB/REW - DD Calls used by PCMM ; 6 November 1995
 ;;5.3;Scheduling;**41,89,107**;AUG 13, 1993
 ;1
WRITETP(SCTP) ;used by write node of 404.57
 N SCCL
 S SCCL=$P($G(^SCTM(404.57,+$G(SCTP),0)),U,9)
 Q $P($$GETPRTP^SCAPMCU2(SCTP,DT),U,2)_"  "_$P($G(^SC(+$G(SCCL),0)),U,1)
 ;
SETPTTM(SCPTTMA) ;delete
 Q
 ;
KILLPTTM(SCPTTMA) ;delete
 Q
 ;
AFTERTM(SCPTTM) ;called after update of 404.42
 N SCPTTMB4,SCPCTMB4,SCTMB4,SCTMNDB4,SCPTTMAF,SCPCTMAF,SCTMAF,X,SCFLD,SCX,SCTMNDAF,SCTMNMB4,Y
 Q:'$G(SCPTTM)
 S SCPTTMAF=$G(^SCPT(404.42,SCPTTM,0))
 S SCPCTMAF=$S(($P(SCPTTMAF,U,8)=1):1,1:0)
 S SCTMAF=$P(SCPTTMAF,U,3)
 S:SCTMAF SCTMNDAF=$G(^SCTM(404.51,SCTMAF,0))
 F X="SCPTTMB4","SCPCTMB4","SCTMB4","SCTMNMB4" S @X=$G(^TMP($J,"SCTMCHG",SCPTTM,X))
 F SCFLD=1:1:14 S SCX=$P(SCPTTMAF,U,SCFLD) S:SCX'="" ^TMP($J,"SCTMCHG",SCPTTM,"AF",(SCFLD*.01))=SCX
 S X=+$O(^ORD(101,"B","SCMC PATIENT TEAM CHANGES",0))_";ORD(101,"
 D:SCPTTMAF'=SCPTTMB4 EN^XQOR
 K ^TMP($J,"SCTMCHG",SCPTTM)
 Q
 ;
BEFORETM(SCPTTM) ;called before update of 404.42
 N SCPTTMB4,SCPCTMB4,SCTMB4,SCTMNDB4,X,SCFLD,SCX,SCY,DR,DIC,DA,DIQ
 Q:'$G(SCPTTM)
 S SCPTTMB4=$G(^SCPT(404.42,SCPTTM,0))
 S SCPCTMB4=$S(($P(SCPTTMB4,U,8)=1):1,1:0)
 S SCTMB4=$P(SCPTTMB4,U,3)
 S:SCTMB4 SCTMNDB4=$G(^SCTM(404.51,SCTMB4,0))
 F X="SCPTTMB4","SCPCTMB4","SCTMB4","SCTMNDB4" S ^TMP($J,"SCTMCHG",SCPTTM,X)=$G(@X)
 F SCY=1:1:14 S SCX=$P(SCPTTMB4,U,SCY) IF SCX'="" D
 .S SCFLD=SCY*.01
 .S ^TMP($J,"SCTMCHG",SCPTTM,"B4",SCFLD)=SCX
 Q
 ;
SETPC(SC1,SC2,SC3,SC4,DA)  ;APCPOS xref for 404.43
 ;DFN = Pointer to Patient File
 ;SC1 = pointer to 404.42
 ;SC2 = ROLE (1=pc practitioner,2=pc attending)
 ;SC3 = Activation Date
 ;SC4 = Team Position
 N DFN
 S DFN=$P($G(^SCPT(404.42,SC1,0)),U,1)
 S:DFN&SC1&SC2&SC3&SC4&DA ^SCPT(404.43,"APCPOS",DFN,SC2,SC3,SC4,DA)=""
 Q
KILLPC(SC1,SC2,SC3,SC4,DA) ;APCPOS xref for 404.43
 ;DFN = Pointer to Patient File
 ;SC1 = pointer to 404.42
 ;SC2 = ROLE (1=pc practitioner,2=pc attending)
 ;SC3 = Activation Date
 ;SC4 = Team Position
 N DFN
 S DFN=$P($G(^SCPT(404.42,SC1,0)),U,1)
 K:DFN&SC1&SC2&SC3&SC4&DA ^SCPT(404.43,"APCPOS",DFN,SC2,SC3,SC4,DA)
 Q
 ;
MAKEMANY(DFNA,SCOLDASS,SCBADASS,SCNEWASS) ;Not supported for use by PCMM Only - sets PC field to YES
 ;   DFNA    - DFN ARRAY
 ;   SCOLDASS - Subset of DFNA that were previously assigned
 ;   SCBADASS - Subset of DFNA that could not be assigned
 ;   SCNEWASS - Subset of DFNA that were newly assigned
 ;   Returned: total^new^old^bad
 ; Note: No input error checking!!
 N DFN,SCX,SCOUTFLD,SCBADOUT,SCOLDCNT,SCBADCNT,SCNEWCNT
 S (SCBADCNT,SCOLDCNT,SCNEWCNT)=0
 S DFN=0
 F  S DFN=$O(@DFNA@(DFN)) Q:'DFN  D
 .S SCOUTFLD(.04)=1
 .S SCX=$$ACOUTPT^SCAPMC20(DFN,"SCOUTFLD","SCBADOUT")
 .;SCX=OK?^p404.41^new?
 .IF 'SCX D
 ..S SCBADCNT=SCBADCNT+1
 ..S @SCBADASS@(DFN)=""
 .ELSE  D
 ..IF $P(SCX,U,3) D
 ...S SCNEWCNT=SCNEWCNT+1
 ...S @SCNEWASS@(DFN)=""
 ..ELSE  D
 ...S SCOLDCNT=SCOLDCNT+1
 ...S @SCOLDASS@(DFN)=""
 Q (SCOLDCNT+SCNEWCNT)_U_SCNEWCNT_U_SCOLDCNT_U_SCBADCNT
 ;
MAKEOUT(DA) ;used by 404.42 to create an outpatient profile entry (if there wasn't one) and set the PRIMARY CARE?(.04) field to YES
 ;  Returned (for de-bugging): ok?^ien of404.41^new?
 N SCNODE,SCX,DFN,SCOUTFLD
 S SCNODE=$G(^SCPT(404.42,+$G(DA),0))
 S DFN=$P(SCNODE,U,1)
 IF $P(SCNODE,U,8)=1 D  ;if assignment was to primary care
 .S SCOUTFLD(.04)=1
 .S SCX=$$ACOUTPT^SCAPMC20(DFN,"SCOUTFLD","SCBADOUT")
 Q $G(SCX)
 ;
AFTERTP(SCPTTP) ;called after update of 404.43
 N SCPTTPB4,SCPCTPB4,SCTPB4,SCTPNDB4,SCPTTPAF,SCPCTPAF,SCTPAF,X,SCFLD,SCX,SCTMB4,SCTMNDB4,SCTMNDAF,SCTMAF,SCPTNM,SCTPNDAF,SCTPNMB4,Y
 Q:'$G(SCPTTP)
 S SCPTTPAF=$G(^SCPT(404.43,SCPTTP,0))
 S SCPCTPAF=+$P(SCPTTPAF,U,5)
 S SCTPAF=$P(SCPTTPAF,U,2)
 S:SCTPAF SCTPNDAF=$G(^SCTM(404.57,SCTPAF,0))
 S:SCTPAF SCTMAF=$P(SCTPNDAF,U,2)
 S:SCTMAF SCTMNDAF=$G(^SCTM(404.51,SCTMAF,0))
 F X="SCPTTPB4","SCPCTPB4","SCTPB4","SCTPNMB4","SCTMB4","SCTMNDB4" S @X=$G(^TMP($J,"SCTPCHG",SCPTTP,X))
 F SCFLD=1:1:9 S SCX=$P(SCPTTPAF,U,SCFLD) S:SCX'="" ^TMP($J,"SCTPCHG",SCPTTP,"AF",(SCFLD*.01))=SCX
 S X=+$O(^ORD(101,"B","SCMC PATIENT TEAM POSITION CHANGES",0))_";ORD(101,"
 D:SCPTTPAF'=SCPTTPB4 EN^XQOR
 K ^TMP($J,"SCTPCHG",SCPTTP)
 Q
 ;
BEFORETP(SCPTTP) ;called before update of 404.43
 N SCPTTPB4,SCPCTPB4,SCTPB4,SCTPNDB4,X,SCFLD,SCX,SCY,DR,DIC,DA,DIQ,SCTMB4,SCTMNDAF,SCTMNDB4,SCTMNMB4
 Q:'$G(SCPTTP)
 S SCPTTPB4=$G(^SCPT(404.43,SCPTTP,0))
 Q:'SCPTTPB4
 S SCPCTPB4=+$P(SCPTTPB4,U,5)
 S SCTPB4=$P(SCPTTPB4,U,2)
 S:SCTPB4 SCTPNDB4=$G(^SCTM(404.57,SCTPB4,0))
 S:SCTPB4 SCTMB4=$P(SCTPNDB4,U,2)
 S:SCTMB4 SCTMNDB4=$G(^SCTM(404.51,SCTMB4,0))
 F X="SCPTTPB4","SCPCTPB4","SCTPB4","SCTPNDB4","SCTMNDB4","SCTMB4" S ^TMP($J,"SCTPCHG",SCPTTP,X)=$G(@X)
 F SCY=1:1:9 S SCX=$P(SCPTTPB4,U,SCY) IF SCX'="" D
 .S SCFLD=SCY*.01
 .S ^TMP($J,"SCTPCHG",SCPTTP,"B4",SCFLD)=SCX
 Q
