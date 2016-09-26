#讀取pam1
pam1<-read.table("pam1.txt")   
dim(pam1)
str(pam1)
#矩陣
b<-as.matrix(pam1)
c<-as.matrix(pam1)
#數字太大，先除10000
b<-b/10000
c<-c/10000
#pam1的250次方
for (x in c(1:249)){c <-b %*% c}  

c <-c*100

write.table(c, file = "pam250.txt")