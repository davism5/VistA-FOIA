PSGOECA ;BIR/CML3-CANCEL ALL OPTION ;09 JUL 94 / 11:02 AM
 ;;5.0; INPATIENT MEDICATIONS ;**29**;16 DEC 97
 ;
 ; Reference to ^PSSLOCK is supported by DBIA #2789
 ;
 D ENCV^PSGSETU I $D(XQUIT) Q
 ; get date/time, get patient, d/c, queue labels
 F  D NOW^%DTC S PSGDT=%,PSGOP=0 D ENAO^PSGGAO Q:PSGP'>0  I $$L^PSSLOCK(PSGP,1) D ENA^PSGOEC D UL^PSSLOCK(PSGP) I PSJSYSU,PSGOP,$P(PSJSYSL,"^",2)]"" D ENQL^PSGLW
 D ENKV^PSGSETU K CA,CA1,CAD,CF,D0,D1,PSGAL,PSGALR,PSGCF,PSGOP,SD,ST,T,UCF,WD,ORVP,PSGTOL,PSGTOO,PSGUOW,PSJDA,PSJS Q