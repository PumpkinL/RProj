#############################################按iv值进行筛选
set.seed(123)
temp<-sepe_var(p2p,"def")
dis.var<-temp[[1]]
con.var<-temp[[2]]
iv.dis<-get_var_info(p2p,dis.var,"def",get_IV)
iv.con<-get_var_info(p2p,con.var,"def",get_IV)
use.dis<-names(iv.dis[iv.dis>0.02])
use.con<-names(iv.con[iv.con>0.06])
useless<-cor_test(p2p.model,use.con,0.7,iv.list)
useful<-c(use.dis,use.con)
useful<-useful[useful%in%useless]
###############################################