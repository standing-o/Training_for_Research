install.packages('vegan')
library(vegan)

setwd("D:/Google ����̺�/Research/Stock_dynamical_model/code/Hierarchical structure")
stock_id = c('�������', '�κ��', '3M', '�ٿ�', '����', 'ĳ���ʷ�', '��������Ŀ�´����̼�', '�ý��ڽý�����',
            '��ũ', '�����ص� ����', 'ȭ����', '������Ƽ�� �ｺ', '���׸��� ���� ����̾�', '�Ƹ޸�ĭ �ͽ�������',
            'JP ��� ü�̽�', 'Ʈ��������', '��常�轺', '����ī��', 'IBM', '���̽ÿ�', '����ũ�μ���Ʈ',
            '����', '����', '��ī�ݶ�', '������ & ����', '�Ƶ�����', '��Ʈ����� ���۴�', '����Ʈ', 'Ȩ����',
            '����Ű')
orig_data <- read.csv('orig_dataset/all_close_data.csv', header = FALSE)
names(orig_data) <- stock_id

log_data <- read.csv('log_dataset/log_dataset.csv', header = FALSE) # ln(s(i+1)) - ln(s(i))
names(log_data) <- stock_id

deri_data <- read.csv('modif_dataset/deri_dataset.csv', header = FALSE) # (s(i+1)-s(i))/s(i)
names(deri_data) <- stock_id

coef.corr <- cor(deri_data)  ## create the correlation coefficients
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
plot(cl, main = "Cluster Dendrogram with modified dataset")