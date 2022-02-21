install.packages('vegan')
install.packages('clue')
library(vegan)
library(clue)

setwd("D:/Google ����̺�/Research/Stock_dynamical_model/Hierarchical structure/minutes_dataset/modif_dataset/")
stock_id = c('�������', '�κ��', '3M', '�ٿ�', '����', 'ĳ���ʷ�', '��������Ŀ�´����̼�', '�ý��ڽý�����',
            '��ũ', '�����ص� ����', 'ȭ����', '������Ƽ�� �ｺ', '���׸��� ���� ����̾�', '�Ƹ޸�ĭ �ͽ�������',
            'JP ��� ü�̽�', 'Ʈ��������', '��常�轺', '����ī��', 'IBM', '���̽ÿ�', '����ũ�μ���Ʈ',
            '����', '����', '��ī�ݶ�', '������ & ����', '�Ƶ�����', '��Ʈ����� ���۴�', '����Ʈ', 'Ȩ����',
            '����Ű')

modif1_data <- read.csv('modif_dataset1.csv', header = FALSE) # (s(i+1)-s(i))/s(i) -> mean
names(modif1_data) <- stock_id


modif2_data <- read.csv('modif_dataset2.csv', header = FALSE) # (s(i+1)-s(i))/s(i) -> mean
names(modif2_data) <- stock_id

day = 1

coef.corr <- cor(modif2_data[day,])  ## create the correlation coefficients
coef.d <- sqrt(2*(1-coef.corr)) # compute distance

d <- as.dist(as.matrix(coef.d)) # find distance matrix 

# Function spantree finds a minimum spanning tree (MST) connecting all points, 
# but disregarding dissimilarities that are at or above the threshold or NA.

tr <- spantree(d)
## Add tree to a metric scaling 
plot(tr, cmdscale(d), type = "t")

## Find a configuration to display the tree neatly
plot(tr, type = "t")

## Depths of nodes
depths <- spandepth(tr)
plot(tr, type = "t", label = depths)

## Plot as a dendrogram
cl <- as.hclust(tr)
plot(cl, main = "MST associated with Euclidean distance")

# ---------------------------------
# ultrametric distance
uc <- hclust(d)
u <- cl_ultrametric(uc)

# Plotting.
plot(u, main = "Hierarchical tree of the subdominant ultrametric")
