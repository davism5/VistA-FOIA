FSCLDU ;SLC/STAFF-NOIS List Definition Utility ;1/3/97  16:57
 ;;1.1;NOIS;;Sep 06, 1998
 ;
BUILD(LISTNUM,OK) ; from FSCLDS, FSCLMPMS, FSCLMPS, FSCLP
 ; lock and unlock ^XTMP("FSC LIST DEF",LISTNUM) before and after this call
 S OK=1
 I '$D(^FSC("LIST",LISTNUM)) S OK=0 Q
 N COND,CONDVAL,DEF,DEFCNT,EXE,EXT,FCOND,FIELD,FIELDAB,LEVEL,NUM,OP,OPER,PAREN,TYPE,VALUE,XOP,ZERO K DEF
 S (EXE,OP)="",(DEFCNT,LEVEL)=0,PAREN="closed"
 K ^XTMP("FSC LIST DEF",LISTNUM)
 S NUM=0 F  S NUM=$O(^FSC("LIST",LISTNUM,1,NUM)) Q:NUM<1  S ZERO=^(NUM,0) D  Q:'OK
 .I $L($P(ZERO,U,2)) D STORE
 .S DEFCNT=DEFCNT+1,DEF(DEFCNT)=ZERO
 .S OP=$P(ZERO,U,2),EXT=$P(ZERO,U,3),FIELD=$P(ZERO,U,4),COND=$P(ZERO,U,5),VALUE=$P(ZERO,U,6)
 .I $L(OP) S EXE=OP_U,OPER=OP
 .I $L(EXE)>245 S OK=0,$P(EXE,U,2)=0 Q
 .S EXE=EXE_$S(EXT="A":"&",EXT="O":"!",1:"")
 .I EXT="O",$L($G(^FSC("LIST",LISTNUM,1,NUM+1,0))),$P(^(0),U,2)="",$P(^(0),U,3)="A" S EXE=EXE_"(",PAREN="open"
 .S EXE=EXE_"Q("_NUM_")"
 .I EXT="A",PAREN="open",$L($G(^FSC("LIST",LISTNUM,1,NUM+1,0))),$P(^(0),U,2)="",$P(^(0),U,3)="O" S EXE=EXE_")",PAREN="closed"
 .S FIELDAB=$P(^FSC("FLD",+FIELD,0),U,7),TYPE=$P(^(0),U,3),CONDVAL=$P(^FSC("COND",+COND,0),U,2) S:VALUE'=+VALUE VALUE=""""_VALUE_""""
 .D
 ..I CONDVAL["exist" D  Q
 ...I CONDVAL["not" S FCOND="'$L(VALUE("""_FIELDAB_"""))" Q
 ...S FCOND="$L(VALUE("""_FIELDAB_"""))"
 ..I CONDVAL["range" D  Q
 ...I CONDVAL["not" S FCOND="VALUE("""_FIELDAB_""")<"_+VALUE_"!(VALUE("""_FIELDAB_""")>"_+$P(VALUE,"-",2)_")"
 ...S FCOND="VALUE("""_FIELDAB_""")'<"_+VALUE_",VALUE("""_FIELDAB_""")'>"_+$P(VALUE,"-",2)
 ..I TYPE="W",CONDVAL["[" D  Q
 ...I CONDVAL="'[" S FCOND="$$WPNC^FSCLDU("""_$S(FIELDAB="DESC":30,FIELDAB="SUM":80,FIELDAB="STATHIST":110,1:50)_""",CALLNUM,"_VALUE_")" Q
 ...S FCOND="$$WPC^FSCLDU("""_$S(FIELDAB="DESC":30,FIELDAB="SUM":80,FIELDAB="STATHIST":110,1:50)_""",CALLNUM,"_VALUE_")" Q
 ..S FCOND="$P(VALUE("""_FIELDAB_"""),U)"_CONDVAL_VALUE
 .S ^XTMP("FSC LIST DEF",LISTNUM,"VAR",FIELD)=FIELDAB
 .S ^XTMP("FSC LIST DEF",LISTNUM,"Q",NUM)=FCOND
 D STORE
 S XOP="0" I OK S LEVEL=0 F  S LEVEL=$O(^XTMP("FSC LIST DEF",LISTNUM,"X",LEVEL)) Q:LEVEL<1  S OP=$P(^(LEVEL),U) D  I $L(XOP)>245 S OK=0,XOP="0" Q
 .S XOP=XOP_$S(OP="A":"!",OP="S":"&",1:"&'")_"X("_LEVEL_")"
 S ^XTMP("FSC LIST DEF",LISTNUM,"XOP")=XOP
 I OK D CHECK(LISTNUM,.OK)
 Q
 ;
CHECK(LISTNUM,OK) ;
 N LEVEL,X S OK=1
 S X="I "_^XTMP("FSC LIST DEF",LISTNUM,"XOP") D ^DIM I '$D(X) S OK=0
 S LEVEL=0 F  S LEVEL=$O(^XTMP("FSC LIST DEF",LISTNUM,"X",LEVEL)) Q:LEVEL<1  S X="I "_$P(^(LEVEL),U,2) D ^DIM I '$D(X) S OK=0,$P(^XTMP("FSC LIST DEF",LISTNUM,"X",LEVEL),U,2)=0
 I 'OK S ^XTMP("FSC LIST DEF",LISTNUM,"XOP")=0
 Q
 ;
STORE ;
 Q:'$L(EXE)
 I PAREN="open" S EXE=EXE_")",PAREN="closed"
 S LEVEL=LEVEL+1
 S ^XTMP("FSC LIST DEF",LISTNUM,"X",LEVEL)=EXE
 N CRITERIA K CRITERIA S FSCLNAME=$P(^FSC("LIST",LISTNUM,0),U) D QDESC^FSCLMPMQ(.DEF,,.CRITERIA)
 M ^XTMP("FSC LIST DEF",LISTNUM,"CRITERIA",LEVEL)=CRITERIA
 K DEF S DEFCNT=0
 Q
 ;
WPC(SUB,CALLNUM,VALUE) ; $$(wp subscript,call,value) -> 1 if wp entry contains value, else 0
 N CHECK,LINE S CHECK=0
 S LINE=0 F  S LINE=$O(^FSCD("CALL",CALLNUM,SUB,LINE)) Q:LINE<1  I ^(LINE,0)[VALUE S CHECK=1 Q
 Q CHECK
 ;
WPNC(SUB,CALLNUM,VALUE) ; $$(wp subscript,call,value) -> 1 if wp entry exists but does not contain value, else 0
 I '$O(^FSCD("CALL",CALLNUM,SUB,0)) Q 0
 N CHECK,LINE S CHECK=1
 S LINE=0 F  S LINE=$O(^FSCD("CALL",CALLNUM,SUB,LINE)) Q:LINE<1  I ^(LINE,0)[VALUE S CHECK=0 Q
 Q CHECK