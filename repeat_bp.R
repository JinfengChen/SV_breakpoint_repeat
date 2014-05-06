pdf("repeat_breakpoint.pdf")
read.table("SV.flank_win.bed.TRF.binlevel.sum")[,2] -> x1
read.table("SV.flank_win.bed.MITE.binlevel.sum")[,2] -> x2
read.table("SV.flank_win.bed.MUDR.binlevel.sum")[,2] -> x3
read.table("SV.flank_win.bed.CACTA.binlevel.sum")[,2] -> x4
read.table("SV.flank_win.bed.COPIA.binlevel.sum")[,2] -> x5
read.table("SV.flank_win.bed.GYPSY.binlevel.sum")[,2] -> x6

num <- c(1:51)
plot(num[1:25],x1[1:25],type="l",col="red",font.main=3,lwd=2,axes = FALSE,xlim=c(0,51),ylim=c(0,0.3),xlab="breakpoint (bp)",ylab="Density", cex.lab = 1)
points(num[26:50],x1[26:50],type="l",col="red",lwd=2)

points(num[1:25],x2[1:25],type="l",col="blue",lwd=2)
points(num[26:50],x2[26:50],type="l",col="blue",lwd=2)

points(num[1:25],x3[1:25],type="l",col="lightblue",lwd=2)
points(num[26:50],x3[26:50],type="l",col="lightblue",lwd=2)

points(num[1:25],x4[1:25],type="l",col="orange",lwd=2)
points(num[26:50],x4[26:50],type="l",col="orange",lwd=2)


points(num[1:25],x5[1:25],type="l",col="yellow",lwd=2)
points(num[26:50],x5[26:50],type="l",col="yellow",lwd=2)

points(num[1:25],x6[1:25],type="l",col="purple",lwd=2)
points(num[26:50],x6[26:50],type="l",col="purple",lwd=2)

axis(1,seq(from=0,to=25,by=5),c("-200","-150","-100","-50","0","  50"), cex.axis=1)
axis(1,seq(from=26,to=51,by=5),c("","0","-50","-100","-150","-200"), cex.axis=1)
axis(2,seq(from=0,to=0.3,by=0.1),seq(from=0,to=0.3,by=0.1), cex.axis=1)

legend(40,0.28, c('TRF', 'MITE', 'MUDR', 'CACTA', 'COPIA', 'GYPSY'), col=c("red","blue","lightblue","orange","yellow","purple"), lty=1, lwd=1.5, border=NA, bty='n', cex=1)
dev.off()

