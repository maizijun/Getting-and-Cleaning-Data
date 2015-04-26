#### import the data ####
setwd("C:/Users/maizijun-ext/Desktop/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train")
train=read.table("X_train.txt")
sub_train=read.table("subject_train.txt")
act_train=read.table("y_train.txt")
names(sub_train)="sub"
names(act_train)="act"

setwd("C:/Users/maizijun-ext/Desktop/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test")
test=read.table("X_test.txt")
sub_test=read.table("subject_test.txt")
act_test=read.table("y_test.txt")
names(sub_test)="sub"
names(act_test)="act"

setwd("C:/Users/maizijun-ext/Desktop/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
fe=read.table("features.txt")
fe=fe[,2]
colnames(train)=fe
colnames(test)=fe
com=rbind(cbind(act_train,sub_train,train),cbind(act_test,sub_test,test))

unique(com$act)
unique(com$sub)

#### calculate the mean and sd of each subject and activity
sp=split(com,com$sub)
l=lapply(sp,function(x){
  sp1=split(x,x$act)
  lapply(sp1,function(y){
    
    n=vector(mode="numeric")
    m=vector(mode="numeric")
    m=apply(y,2,mean)
    n=apply(y,2,sd)
    return(data.frame(m,n))
  })
})

########

fun1=function(x){
  sp1=split(x,x$act)
  lapply(sp1,fun2)
}

fun2=function(y)
    n=vector(mode="numeric")
    m=vector(mode="numeric")
    m=apply(y,2,mean)
    n=apply(y,2,sd)
    return(data.frame(m,n))
}

#### rename the descriptive variables ####
re=data.frame(rep(0,563))
for (a in 1:30){
  for (b in 1:6)
  { temp=l[[a]][[b]]
    colnames(temp)=c(paste("mean:","sub_",a,"act_",b),
                     paste("sd:","sub_",a,"act_",b))
    re=cbind(re,temp)
  }
}
re=re[-1]

#### output the dataset ####
write.table(re,"data.txt",row.names=F)
