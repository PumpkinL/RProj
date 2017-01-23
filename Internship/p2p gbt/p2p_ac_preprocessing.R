library(s.PP)
library(s.FS)
library(s.ME)
library(s.FE)
p2p<-rawdata
p2p<-data.frame(p2p[,-1],row.names=p2p[,1])

###################find strange sign
find_strange_sign(p2p,100)
###################no strange sign
###################define missing value
temp<-select(p2p,starts_with("ac"))
temp<-names(temp)
p2p[,temp]=trans2miss(p2p[,temp],99,"missing")
####################################��ȥ����ȫû�еı���
miss<-missing_count(p2p)
wm<-which(miss<0.95)
useful<-names(miss)[wm]
p2p<-p2p[,useful]

miss<-single_value_count(p2p,"def")
wm<-which(miss<0.95)
useful<-names(miss)[wm]
useful<-unique(c(useful,"def"))
p2p<-p2p[,useful]
############################################################��������
temp<-count_distinct_value(p2p,names(p2p))
d.l<-NA
p2p<-define_types(p2p,d.l,5)
summary(p2p)
############################################################�Է�����������������쳣ֵ��ȱʧֵ����
p2p.model<-miss_handle(p2p,-1)
############################################################���е�����ɸѡ

useful<-rpart_filter(p2p.model, "def", controls = rpart.control(minsplit = 30, cp = 0.001,
                                                        maxcompete = 1, maxsurrogate = 1, usesurrogate = 1, xval = 4, surrogatestyle =
                                                          1, maxdepth = 8))
############################################################���ж��������ɸѡ
set.seed(12323)
best.para <- list(max.depth =2, eta = 0.1,objective="binary:logistic")
trees<-200
ss<-SBS(p2p.model,useful,"def",0.003,xg_cv)