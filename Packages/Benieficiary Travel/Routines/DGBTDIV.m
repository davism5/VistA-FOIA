DGBTDIV ;ALB/MRY - DIVISION SELECT ; 25 SEP 2001  9:37 AM
 ;;1.0;Beneficiary Travel;;September 25, 2001
 ; Routine copied from SDDIV
ERR S Y=-1 K DIC,SDALL,SDEF Q
ASK2 S (VAUTD,Y)=0 I '$D(^DG(40.8,$N(^DG(40.8,0)),0)) W !,*7,"***WARNING...MEDICAL CENTER DIVISION FILE IS NOT SET UP" G ERR
 I $D(^DG(43,1,"GL")),$P(^("GL"),U,2) G DIVISION^VAUTOMA
 S I=$N(^DG(40.8,0)) G:'$D(^DG(40.8,I,0)) ERR S VAUTD(I)=$P(^(0),U) K DIC Q