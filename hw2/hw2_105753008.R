######################################
# the reference code of program2 
######################################

######################################
# initial
######################################
# read parameters
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("USAGE: Rscript hw2_105753008.R --input test.fasta --score pam250.txt --aln global --gap_open -10 --gap_extend -2 --output result.fasta", call.=FALSE)
}

# parse parameters
i<-1 
while(i < length(args))
{
  if(args[i] == "--input"){
    i_f<-args[i+1]
    i<-i+1
  }else if(args[i] == "--score"){
    s_f<-args[i+1]
    i<-i+1
  }else if(args[i] == "--aln"){
    aln_mode <- args[i+1]
    i<-i+1
  }else if(args[i] == "--gap_open"){
    g_o<-args[i+1]
    i<-i+1
  }else if(args[i] == "--gap_extend"){
    g_e<-args[i+1]
    i<-i+1    
  }else if(args[i] == "--output"){
    o_f<-args[i+1]
    i<-i+1
  }else{
    stop(paste("Unknown flag", args[i]), call.=FALSE)
  }
  i<-i+1
}

print("PARAMETERS")
print(paste("input file         :", i_f))
print(paste("output file        :", o_f))
print(paste("score file         :", s_f))
print(paste("gap open penalty   :", g_o))
print(paste("gap extend penalty :", g_e))

######################################
# main
######################################
# your code
	#read file test.fasta
hw2 <- file(i_f)

	#read pam
pam <- read.table(s_f)

	#read line 2 and 4
out <- readLines(hw2)

	#insert gap
chara <- union("-",out[2])
charb <- union("-",out[4])

	#string change to char
char1 <- unlist(strsplit(chara,""))
char2 <- unlist(strsplit(charb,""))

	#count length char1 amd char2 
i <- length(char1)
j <- length(char2)

	#matrix
a <- matrix(NA,nrow=i,ncol=j)
rownames(a)=c(char1)
colnames(a)=c(char2)

	#put  score
for (x in (2:i))
{ 
	a[x,1]= as.numeric(g_o)+ (as.numeric(g_e)*(x-2))
}
for (y in c(2:j))
{
	a[1,y]= as.numeric(g_o)+(as.numeric(g_e)*(y-2))
}
a[1,1]=0

	#count score

for(x in (2:i))
{ for(y in 2:j)
  {
  	mat <- pam[char1[x],char2[y]] + a[x-1,y-1]
 	gapup <-  as.numeric(g_o) + a[x-1,y]
  	gapleft <- as.numeric(g_o) + a[x,y-1]
  	a[x,y] <- max(mat,gapup,gapleft)
  }
}
	#trace back
final_a <- 2
final_b <- 2
ans_a <- char1[2]
ans_b <- char2[2]
while (final_a < i || final_b < j )
 {
	final <- max(a[final_a+1,final_b+1],a[final_a,final_b+1],a[final_a+1,final_b])
	if(final == a[final_a+1,final_b+1] )
	{  
	   ans_a <- paste(ans_a,char1[final_a+1],sep="")
         ans_b <- paste(ans_b,char2[final_b+1],sep="")
	   final_a <- final_a+1
	   final_b <- final_b+1
  
	}
	else if(final ==a[final_a,final_b+1])
	{
	   ans_a <- paste(ans_a,"-",sep="")
         ans_b <- paste(ans_b,char2[final_b+1],sep="")
	   final_b <- final_b+1

	}
	else if(final ==a[final_a+1,final_b])
	{
	   ans_a <- paste(ans_a,char1[final_a+1],sep="")
         ans_b <- paste(ans_b,"-",sep="")
	   final_a <- final_a+1 

	}
 }

write(ans_a,file=o_f,append=FALSE)
write(ans_b,file=o_f,append=TRUE) 
print(ans_a)
print(ans_b)

