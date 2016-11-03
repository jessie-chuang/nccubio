######################################
# the reference code of program2 
######################################

######################################
# initial
######################################
# read parameters
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("USAGE: Rscript pro2_ref.R --input test.fasta --score pam250.txt --aln global --gap_open -10 --gap_extend -2 --output result.fasta", call.=FALSE)
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
#read line 2 and 4
out <- readLines(hw2)
out[2]
out[4]
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
a

