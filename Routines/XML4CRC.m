XML4CRC ;(WASH ISC)/RFJ-Block Mode Protocol ;03/27/2002  15:47
 ;;8.0;MailMan;;Jun 28, 2002
SEND ;Sender
 S %=1 D PROG G SEND^XML4CRC1:'$D(XMBLOCK)!'$D(J),SEND^XML4CRC1:J<1
 S:'$D(XMLBTSUM) XMLBTSUM=0,XML4S(0)=0 I '$D(XML4S)!'$D(XMLBCHR) D SINIT Q:ER  S XMLBER=0
 I XMSG'?.ANP S X=XMSG,XMSG="" F %=1:1:$L(X) S:$E(X,%)'?1C!($A(X,%)=9) XMSG=XMSG_$E(X,%)
 S XMSG=XMSG_XMLBCHR,X=XMSG D SUM,BUFLUSH
 W XMSG,$C(13)
 S XMLBTSUM=XMLBTSUM+XMSUM,XMLINE=XMLINE+1,XMLCC=XMLCC+$L(XMSG)
 I XMLINE#4=0 H 1
 D PAUSE S %=1,XML4S(0)=XML4S(0)+1 I $S(XML4S(0)#XML4S=0:1,'$D(XML4END):0,XMS0AJ'<XML4END:1,1:0) S %=1 D STAT,SCHECK S XMLBTSUM=0,XML4S(0)=0 Q
 I '$D(XML4END) S XMLBVAR=$O(^XMB(3.9,XMZ,2,XMS0AJ)) I XMLBVAR<1 D SCHECK S XMLBTSUM=0,XML4S(0)=0
 Q
SINIT ;
 D BLSIZE,LAST I '$D(XMLCC) S XMLCC=0
 S XMLBPAUS=1,XMLBNAK="NAK",XMLBACK="ACK",XMLBCHR=$C(42),XMLBCHR1=$C(42)_$C(126),XMLBMER=4,XMLBTIME=90,XMLBTSUM=0,ER=0,XMLBER=0,XMLBCHR2=$C(126)_$C(42)_$C(126),XMLBSTRT="0^0",X="HELO BMP"_U_XMLBMER D SUM
SBLSZ S XMLINE=XMLINE+1 W X,XMLBCHR1,XMSUM,$C(13) R %:XMLBTIME
 I %[XMLBACK S X=% Q
 D SBERROR S XMLBPAUS=XMLBPAUS+10 G SBLSZ:XMLBPAUS<1000 S X=% G ER
SCHECK ;Sender check block sum
 S XMLINE=XMLINE+1,XMTRAN="Sent Checksum" D T W XMLBCHR2,U,J,U,XMLBTSUM,U,XMLINE,$C(13) R X:XMLBTIME E  G ER
 I X[XMLBACK S XMLBER=0,XMLBSTRT=XMS0AJ_U_J D BLSIZE Q
 I X[XMLBNAK D ERROR Q:ER  S XMS0AJ=+XMLBSTRT,J=+$P(XMLBSTRT,U,2),XMTRAN="Rec'd NAK" D T S:XML4S>2 XML4S=XML4S\2 Q
ER D ER1 Q
ER1 N % S %=0
ER2 S XMTRAN="Rec'd "_$G(X) D T R X:9 I $T S %=$G(%)+1 I %<99 G ER2:$T
 S ER=1 K XMBLOCK Q
SBERROR ;
 N X D ERROR Q
REC ;Receiver
 I '$D(XMLBMER) D RINIT S XMLIN=0 Q
 I XMLBCHR2_"^"=$E(XMRG,1,4) S %=2 D STAT,RCHECK S XMLBTSUM=0 Q
 S X=XMRG D SUM S XMLBTSUM=XMLBTSUM+XMSUM,XMRG=$E(XMRG,1,($L(XMRG)-1)),XMLBMSG=XMRG Q
RINIT ;
 S XMLBPAUS=0,XMLBER=0,XMLBMER=4,XMLBTIME=15,XMLBNAK="NAK",XMLBACK="ACK",XMLBCHR=$C(42),XMLBCHR1=$C(42)_$C(126),XMLBCHR2=$C(126)_$C(42)_$C(126),XMLBLINE=XMLIN,XMLBTSUM=0,XMLBMSG="",XMLBSTRT=XMLIN-1,XML4S(0)=0,XML4S=0
 S X=$P(XMRG,XMLBCHR1,1) D SUM I XMSUM=$P(XMRG,XMLBCHR1,2) S XMLBMER=$P(X,U,2),XMLBER=0 W XMLBACK,$C(13) Q
 W XMLBNAK,$C(13) D ERROR K XMLBMER Q
RCHECK ;Check block sum
 I XMLBTSUM=0,XML4S(0)=0 G REC^XML4CRC1
 S XMLINE=$P(XMRG,U,4),XMLIN=XMLIN-1,XMRG=$P(XMRG,U,2,3),X=XMLIN_U_XMLBTSUM I XMRG=X W XMLBACK,$C(13) S XMLBER=0,XMRG=XMLBMSG,XMLBSTRT=XMLIN Q
 W XMLBNAK,$C(13) S XMLIN=XMLBSTRT,XMRG=$S($D(^XMB(3.9,XMZ,2,XMLIN,0)):^(0),1:""),XMTRAN="NAK'd block" D ERROR,T Q
ERROR ;Log error, new delay factor
 D BUFLUSH S XMLBER=XMLBER+1,XMTLER=XMTLER+1 S:XMTLER#XMLBMER=0 XMLBPAUS=XMLBPAUS*2 D:XMLBPAUS>1000 END Q
BUFLUSH ;Flush any characters out of the buffer
 Q:'$D(XMBFLUSH)
 X ^%ZOSF("TRMON") S X=$P($H,",",2) F %=1:1 R %:0 Q:'$T  S %=$P($H,",",2) S:%<X %=%+86400 Q:%-X>15
 X ^%ZOSF("TRMOFF") Q
PAUSE ;Delay
 F %=1:1:XMLBPAUS
 Q
PROG ;Statistics
 S %1=$S(%=1:$S('$D(XMSG):0,1:$L(XMSG)),1:$S($D(XMRG):$L(XMRG),1:0)),XMLCT=$S($D(XMLCT):XMLCT+%1,1:%1)
 Q
STAT Q:$S('$D(XMINST):1,'$L(XMINST):1,1:0)
 S %1=$H_U_$S($D(XMZ):XMZ,1:"")_U_XMLINE_U_$S($D(XMTLER):XMTLER+XMLER-1,1:XMLER-1)_U_$J(XMLCC/($H-XMLBTST*86400+($P($H,",",2)-$P(XMLBTST,",",2))),0,2)_U_IO_" "_XMPROT
 S %0=$S($D(^XMBS(4.2999,XMINST,3))#10:^(3),1:""),$P(%0,U,1,6)=%1,^(3)=%0,XMLCT=0,XMLL=XMLINE,XMLT=$P($H,",",2)
 K %,%1,%0 Q
BLSIZE ;block size
 S XML4S=$S($D(XML4S)#10=0:100,XML4S*2<100:XML4S*2,1:100),XML4S(0)=0 Q
LAST ;FIND LAST LINE
 K XML4END S %=$P(^XMB(3.9,XMZ,2,0),U,3) I '% S %=^(0,0,99999999),%=$P(%,U,$L(%,U)-1)
 Q:'$D(^XMB(3.9,XMZ,2,%))  F %=%-1:0 S Y=$O(^(%)) Q:Y=""  S %=Y
 S XML4END=% Q
SUM ;Calculate Checksum
 I '$D(XMOS) D LPC^XMLSWP0
 I $D(XMOS(0)) X XMOS(0) Q
 I XMOS["VAX DSM" S XMSUM=$ZC(%LPC,X)+$L(X)*$L(X) Q
 I XMOS["DSM" S XMSUM=$ZC(LPC,X)+$L(X)*$L(X) Q
 I XMOS["M/11"!(XMOS["M/VX") S XMSUM=$ZC(X)+$L(X)*$L(X) Q
 S XMSUM=0 Q
KILL ;Kill variables
 K XMBLOCK,XMLBTSUM,XML4S,XMLBER,XMLBCHR,XMLBCHR1,XMLBCHR2,XMLBVAR,XMLBPAUS,XMLBNAK,XMLBACK,XMLBMER,XMLBTIME,XMLBSTRT,XMLBLINE,XMLBMSG Q
END ;Errors/Quit.
 G ER
T D TRAN^XMC1 Q