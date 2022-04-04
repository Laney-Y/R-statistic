
#=====================================================
#  课程名称：生物统计                            
#  作者：戎可                                         
#  知识点编号: C01S3L1.1R
#  相关知识点编号：C01S3L1.1T
#  知识点内容：：简单随机抽样的R语言实现
#  文件编码格式：UTF-8
#  创建时间：2020-04-04
#  最后修改时间：2020-05-04
#=====================================================

# 安装需要的程序包
wants <- NULL
has   <- wants %in% rownames(installed.packages())
options(repos = structure(                            # 根据你的位置修改下载镜像
    c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/")))
if(any(!has)) install.packages(wants[!has])

# 清理工作空间
rm(list=ls())

# 设置工作目录
setwd("修改成您存取数据的文件夹路径")



#=====================================================
# C01S3L1.1R-1
# 基本方法：理论课的例子，从100只猴子中抽取10个作为样本

set.seed(579)                                         # 设置随机数种子，保证结果可重现
sample.frame <- 1:100                                 # 构造抽样框
mysample <- sample(sample.frame,                      # 指定抽样框
                   replace = FALSE,                   # 无放回抽样
                   size = 10)                         # 样本大小
mysample

mysample <- sample(sample.frame,                      # 指定抽样框
                   replace = TRUE,                    # 有放回抽样
                   size = 10)                         # 样本大小
mysample

#=====================================================
# C01S3L1.1R-2
# 进阶：从iris数据集中随机抽取一个大小为10的样本
# iris是个经典数据集，很多统计软件内置这个数据集
# 详细信息可以用?iris 或 help("iris") 了解

set.seed(579)                                         # 设置随机数种子，保证结果可重现
sample.frame <- 1:nrow(iris)                          # 构造抽样框
my_iris <- iris[sample(sample.frame,                  # 指定抽样框
                       size = 10,                     # 样本大小
                       replace = FALSE)               # 无放回抽样
                ,]                                    # 注意这个逗号
my_iris



#=====================================================
# C01S3L1.1R-3
# 再进阶，设计自己的实验
# 假设已有实验对象的信息保存在excel文件中，保存为csv文件
# 此处使用一个虚拟的实验对象文件C01S3L1.1-EOBJ.csv
# 文件中有实验对象ID：OBJID，共200个对象
# 现要从中随机抽取10个作为实验组，10个作为对照组
# 注意样本容量要根据实验设计决定

EOBJ <- read.csv("C01S3L1.1-EOBJ.csv",                 # 读入实验对象文件
                 header = TRUE)
n.EOBJ <- nrow(EOBJ)                                   # 实验对象数量

# 先随机将对象分成实验和对照两组
set.seed(579)
sf.whole <- 1:n.EOBJ                                   # 构造抽样框
od.e <- sample(sf.whole,                               # 抽取实验组序号
               size = n.EOBJ/2,
               replace = FALSE)
e.group <- EOBJ$OBJID[od.e]                            # 实验组
c.group <- EOBJ$OBJID[-od.e]                           # 除实验组外就是对照组

# 分别在两组里抽取样本
sf.e <- 1:length(e.group)
sf.c <- 1:length(c.group)
s.e.group <- e.group[sample(sf.e,
                            size = 10,
                            replace = FALSE)]

s.c.group <- c.group[sample(sf.c,
                            size = 10,
                            replace = FALSE)]
# 汇总实验记录表
exp.design <- data.frame(
                 OBJID = c(s.e.group, s.c.group),      # 实验对象ID
                 GOUUP = c(rep("e",10),                # 实验组别
                           rep("c",10)),           
                 VALUE = rep(0,20))                    # 测量值

# 写入文件csv文件，可以用EXCEL打开
write.csv(exp.design,
          "ex_exp_design.csv",
          row.names = FALSE)


#=====================================================
# C01S3L1.1R-4
# C01S3L1.1R-3例子简洁地实现

EOBJ <- read.csv("C01S3L1.1-EOBJ.csv",                 # 读入实验对象文件
                 header = TRUE)
n.EOBJ <- nrow(EOBJ)                                   # 实验对象数量


# 先随机将对象分成实验和对照两组
# 定义序列ind，随机抽取1和2, 各占一半
set.seed(579)
ind <- sample(2, n.EOBJ, 
              replace = TRUE, 
              prob = c(0.5, 0.5))
e.group <- EOBJ$OBJID[ind == 1]                        # 实验组
c.group <- EOBJ$OBJID[ind == 2]                        # 除实验组外就是对照组

# 分别在两组里抽取样本
sf.e <- 1:length(e.group)
sf.c <- 1:length(c.group)
s.e.group <- e.group[sample(sf.e,
                            size = 10,
                            replace = FALSE)]

s.c.group <- c.group[sample(sf.c,
                            size = 10,
                            replace = FALSE)]
# 汇总实验记录表
exp.design <- data.frame(
  OBJID = c(s.e.group, s.c.group),      # 实验对象ID
  GROUP = c(rep("e",10),                # 实验组别
            rep("c",10)),           
  VALUE = rep(0,20))                    # 测量值
# library(dplyr)
# exp.design <- arrange(exp.design,
                      GROUP,OBJID)      # 排序便于操作

# 写入文件csv文件，可以用EXCEL打开
write.csv(exp.design,
          "ex_exp_design.csv",
          row.names = FALSE)


