
#=====================================================
#  课程名称：生物统计                            
#  作者：戎可                                         
#  知识点编号: C01S3L1.3R
#  相关知识点编号：C01S3L1.3T
#  知识点内容：：整群抽样的R语言实现
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
# C01S3L1.3-agpop.csv数据文件是美国政府每五年做一次有关农业的普查，
# 收集50个州的所有农场的有关数据, 共3078个美国县级或与县级规模相当
# 的农场数据.数据说明及完整和更新的数据见：
# https://www.nass.usda.gov/AgCensus/
# 抽样要求：以state为分群变量，不放回简单随机抽样方法抽五个群

ca.data <- read.csv("C01S3L1.3-agpop.csv", header = TRUE)

library(sampling)
cl.info <- cluster(ca.data,                           # 获得抽样信息
                     clustername = "state",           # 分群变量
                     size = 5,                        # 样本容量
                     method = "srswor",               # 抽样方法
                     description = TRUE)              # 是否显示抽样信息
ca.sc <- ca.data[cl.info$ID_unit,]                    # 根据抽样信息抽取样本
summary(ca.sc)

# 抽样方法method
# “srswor” 不重置简单抽样
# “srswr” 重置简单抽样
# “poisson” 泊松抽样
# "systematic" 系统抽样

