print("hello world123")

pam1<-read.table("pam1.txt")
dim(pam1)
str(pam1)
b<-as.matrix(pam1)
c<-as.matrix(pam1)
b<-b/10000
c<-c/10000

for (x in c(1:249)){c <-b %*% c}  

c <-c*100
print(c)

write.table(c, file = "pam250.txt")