
#=====================================================
#  课程名称：生物统计                            
#  作者：戎可                                         
#  知识点编号: C01S3L1.4R
#  相关知识点编号：C01S3L1.4T
#  知识点内容：：系统抽样的R语言实现
#  文件编码格式：UTF-8
#  创建时间：2020-04-04
#  最后修改时间：2020-05-04
#=====================================================

# 安装需要的程序包
wants <- c("sampling")
has   <- wants %in% rownames(installed.packages())
options(repos = structure(                            # 根据你的位置修改下载镜像
    c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/")))
if(any(!has)) install.packages(wants[!has])

# 清理工作空间
rm(list=ls())

# 设置工作目录
setwd("修改成您存取数据的文件夹路径")



#=====================================================
# C01S3L1.4R-1
# 假设已有实验对象的信息保存在excel文件中，保存为csv文件
# 此处使用一个虚拟的实验对象文件C01S3L1.1-EOBJ.csv
# 文件中有实验对象ID：OBJID，共200个对象
# 现要从中采用系统抽样的方法随机抽取10个作为样本

library(sampling)

EOBJ <- read.csv("C01S3L1.1-EOBJ.csv",                 # 读入实验对象文件
                 header = TRUE)
n.EOBJ <- nrow(EOBJ)
s.size <- 10                                           # 样本大小 

pik <- rep(s.size/n.EOBJ,n.EOBJ)                       # 计算抽入概率
s.od <- UPsystematic(pik)                              # 系统抽样

sample.sys <- getdata(EOBJ, s.od)

