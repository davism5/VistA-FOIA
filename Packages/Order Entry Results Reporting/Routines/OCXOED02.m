OCXOED02 ;SLC/RJS,CLA - Rule Editor (Rule Options) ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ;
 ;
 ;
 Q
EN(OCXR0,OCXRD,OCXACT) ;
 ;
 ;
 N OCXTHLN,OCXTNLN,OCXTRLN,OCXTULN,OCXTNLN
 ;
 ;
 S OCXOPT=$$GETOPT^OCXOEDT(.OCXACT) Q:(OCXOPT=U) 1 X:$L(OCXOPT) OCXOPT
 ;
 Q:'$D(^OCXS(860.2,OCXR0)) 1
 ;
 Q 0
 ;
 ;
EDRULE(OCXR0) ;
 N X S X=$$DIE("^OCXS(860.2,",OCXR0,".01;.02")
 Q
 ;
EDRELE(OCXR0,OCXR1) ;
 D EN^OCXOED03(OCXR0,OCXR1)
 Q
 ;
EDRREL(OCXR0,OCXR1) ;
 D EN^OCXOED05(OCXR0,OCXR1)
 Q
 ;
EOPT(OCXMODE,OCXR0) ;
 ;
 I OCXMODE="ADD" D  Q
 .S:'$D(^OCXS(860.2,OCXR0,"C",0)) ^OCXS(860.2,OCXR0,"C",0)="^860.21I^^"
 .N OCXD1,OCXDA S OCXDA(1)=OCXR0,OCXD1=+$$DIC("^OCXS(860.2,"_OCXR0_",""C"",","AEMQLN","Select Element Label: ","","","",.OCXDA) Q:(OCXD1<0)
 .D EDRELE(OCXR0,OCXD1)
 I OCXMODE="DEL" D  Q
 .S:'$D(^OCXS(860.2,OCXR0,"C",0)) ^OCXS(860.2,OCXR0,"C",0)="^860.21I^^"
 .N OCXD1,DA S DA(1)=OCXR0,OCXD1=+$$DIC("^OCXS(860.2,"_OCXR0_",""C"",","AEMQN","Select Element Label: ") Q:(OCXD1<0)
 .Q:'$$READ("Y","Are you sure you want to Delete ?","YES")
 .Q:'$$DIE("^OCXS(860.2,"_(+OCXR0)_",""C"",",OCXD1,"S DA(1)="_(+OCXR0)_";.01///@")
 .W !!,"Deleted..." H 1
 Q
 ;
ROPT(OCXMODE,OCXR0) ;
 ;
 I OCXMODE="ADD" D  Q
 .S:'$D(^OCXS(860.2,OCXR0,"R",0)) ^OCXS(860.2,OCXR0,"R",0)="^860.22I^^"
 .N OCXD1 S OCXD1=$O(^OCXS(860.2,OCXR0,"R","@"),-1)+1
 .S ^OCXS(860.2,OCXR0,"R",OCXD1,0)=OCXD1,^OCXS(860.2,OCXR0,"R","B",OCXD1,OCXD1)=""
 .D EDRREL(OCXR0,OCXD1)
 I OCXMODE="DEL" D  Q
 .S:'$D(^OCXS(860.2,OCXR0,"R",0)) ^OCXS(860.2,OCXR0,"R",0)="^860.22I^^"
 .N OCXD1,DA S DA(1)=OCXR0,OCXD1=+$$DIC("^OCXS(860.2,"_OCXR0_",""R"",","AEMQN","Select Relation Expression Index Number: ") Q:(OCXD1<0)
 .Q:'$$READ("Y","Are you sure you want to Delete ?","YES")
 .Q:'$$DIE("^OCXS(860.2,"_(+OCXR0)_",""R"",",OCXD1,"S DA(1)="_(+OCXR0)_";.01///@")
 .W !!,"Deleted..." H 1
 Q
 ;
 ;
READ(OCXZ0,OCXZA,OCXZB,OCXZL) ;
 N OCXLINE,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q:'$L($G(OCXZ0)) U
 S DIR(0)=OCXZ0
 S:$L($G(OCXZA)) DIR("A")=OCXZA
 S:$L($G(OCXZB)) DIR("B")=OCXZB
 F OCXLINE=1:1:($G(OCXZL)-1) W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q U
 Q Y
 ;
DIE(DIE,DA,DR) ;
 ;
 D RM(IOM) N DUOUT,DTOUT,DIC S DIC=DIE D ^DIE D RM(0) Q:$G(DTOUT) 0 Q:$G(DUOUT) 0 Q 1
 ;
RM(X) X ^%ZOSF("RM") Q
 ;
DIC(OCXDIC,OCXDIC0,OCXDICA,OCXX,OCXDICS,OCXDR,DA) ;
 ;
 N DIC,X,Y
 S DIC=$G(OCXDIC) Q:'$L(DIC) -1
 S DIC(0)=$G(OCXDIC0) S:$L($G(OCXX)) X=OCXX
 S:$L($G(OCXDICS)) DIC("S")=OCXDICS
 S:$L($G(OCXDICA)) DIC("A")=OCXDICA
 S:$L($G(OCXDR)) DIC("DR")=OCXDR
 D ^DIC Q:(Y<1) 0 Q Y
 ;