
#=====================================================
#  课程名称：生物统计                            
#  作者：戎可                                         
#  知识点编号: C01S3L1.2R
#  相关知识点编号：C01S3L1.2T
#  知识点内容：：分层抽样的R语言实现
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
# 使用sampling包中的strata函数
# strata(data, stratanames=NULL, size, method=c(“srswor”,“srswr”,“poisson”,
# “systematic”), pik,description=FALSE)
# stratanames为分层抽样要使用的变量
# size为各层抽取个数
# method指的是抽样方法，“srswor”、“srswr”、“poisson”、"systematic"
#    分别指不重置简单抽样、重置简单抽样、泊松抽样、系统抽样
# pik指的是各数据包含在样本中的概率
# description默认为FALSE,若设置为TRUE则输出样本个数和总体个数。
# 返回值ID_unit(被选单元的标志符)、Stratum(单元层)、Prob(包含单元的概率)

# 从iris数据集的三个品种分别抽取2，3，4个样本的抽样结果：
library(sampling)

sg.info <- strata(stratanames = "Species",           # 获取抽样信息
                  size = c(2,3,4),
                  method = "srswor",
                  pik = c(0.3,0.3,0.3),
                  description = FALSE,               # 改成TRUE试试
                  data = iris)

iris.sc <- iris[sg.info$ID_unit,]
