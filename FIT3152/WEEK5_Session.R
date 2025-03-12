# clean up the environment before starting
rm(list = ls())
library(ggplot2)

#### k-Means Clustering ####

set.seed(9999) # makes “random” method repeatable
# clone and scale numerical data
niris = iris
niris[,1:4] = scale(niris[,1:4])

ikfit = kmeans(niris[,1:2], 3, nstart = 20)
ikfit
table(actual = niris$Species, fitted = ikfit$cluster)

ikfit = kmeans(iris[,1:2], 3, nstart = 20) # create ikfit object
ikfit
table(actual = iris$Species, fitted = ikfit$cluster)

ikfit


ikfit$totss
ikfit$withinss
ikfit$tot.withinss
ikfit$betweenss

ikfit$cluster = as.factor(ikfit$cluster)
g = ggplot(iris, aes(Sepal.Length, Sepal.Width, color = ikfit$cluster)) + geom_point()
g
ggsave("kmeans sepal v petal.jpg", g, width = 14, height = 10, units = "cm")

# now use all columns

ikfit = kmeans(niris[,1:4], 3, nstart = 20)
ikfit
table(actual = niris$Species, fitted = ikfit$cluster)

ikfit$totss
ikfit$withinss
ikfit$tot.withinss
ikfit$betweenss

# now create 5 clusters arbitrarily

ikfit = kmeans(niris[,1:4], 5, nstart = 20)
ikfit
table(actual = niris$Species, fitted = ikfit$cluster)

ikfit$cluster = as.factor(ikfit$cluster)
g = ggplot(iris, aes(Sepal.Length, Sepal.Width, color = ikfit$cluster)) + geom_point()
g
ggsave("kmeans sepal v petal 5 clusters.jpg", g, width = 14, height = 10, units = "cm")


ikfit$totss
ikfit$withinss
ikfit$tot.withinss
ikfit$betweenss

# Countries data

set.seed(9999)
CD <- read.csv("CountriesData.csv")
# unscaled
# CD[,2:5] = scale(CD[,2:5])
CDkfit = kmeans(CD[,2:5], 3, nstart = 20)
CDkfit
table(actual = CD$Country, fitted = CDkfit$cluster)

# clone and scale numerical data
CDS = CD
CDS[,2:5] = scale(CD[,2:5])
CDSkfit = kmeans(CDS[,2:5], 3, nstart = 20)
CDSkfit
table(actual = CDS$Country, fitted = CDSkfit$cluster)

by(CD$Per.capita.income,CDSkfit$cluster, mean)

# Silhouette

library(cluster)
#make function to get average silhouette score 
i_silhouette_score <- function(k){
  km <- kmeans(niris[,1:4], centers = k, nstart=25)
  ss <- silhouette(km$cluster, dist(iris[,1:4]))
  mean(ss[, 3])
}

#calc and plot average silhouette for 2-10 clusters
k <- 2:10
avg_sil <- sapply(k, i_silhouette_score)
plot(k, type='b', avg_sil, xlab='Number of clusters', ylab='Average Silhouette Scores')

# Elbow method

elbowdata = data.frame()
for (k in 1:20){
  kfit = kmeans(niris[,1:4], centers = k, nstart = 10)
  print(kfit$tot.withinss)
  elbowdata = rbind(elbowdata, t(c(k,kfit$tot.withinss) ))
  }
colnames(elbowdata) = c("k", "tot.within.ss")
plot(elbowdata$k, elbowdata$tot.within.ss)

#### Hierarchical Clustering ####

set.seed(9999) # make results repeatable
niris = iris
#scale numerical data
#niris[,1:4] = scale(niris[,1:4])
ihfit = hclust(dist(niris[,1:4]), "ave")
plot(ihfit, hang = -1)

# pruning the tree into 5 clusters
cutihfit = cutree(ihfit, k = 5) #associate each iris to a cluster
rect.hclust(ihfit, k = 5, border = "red")
table(actual = niris$Species, fitted = cutihfit)

# Countries Data

# No processing
# clean up the environment before starting
rm(list = ls())
set.seed(9999)

CD <- read.csv("CountriesData.csv")
# not scaled
# CD[,2:5] = scale(CD[,2:5])
rownames(CD) = CD$Country
hfit = hclust(dist(CD[,2:5]), "average")
plot(hfit)
plot(hfit, hang = -1)
cut.hfit = cutree(hfit, k = 5) #Pruning
rect.hclust(hfit, k = 5, border = "red")

# Scaled
# clean up the environment before starting
rm(list = ls())
set.seed(9999)

CD <- read.csv("CountriesData.csv")
# scaled
CD[,2:5] = scale(CD[,2:5])
rownames(CD) = CD$Country
hfit = hclust(dist(CD[,2:5]), "average")
plot(hfit)
plot(hfit, hang = -1)
cut.hfit = cutree(hfit, k = 5) #Pruning
rect.hclust(hfit, k = 5, border = "red")

CD <- read.csv("CountriesData.csv")
as.table(by(CD$Per.capita.income, cut.hfit, mean))



#Normalised
# clean up the environment before starting
rm(list = ls())
set.seed(9999)

CD <- read.csv("CountriesData.csv")
# for loop to normalise cols 2 - 5
for (i in 2:5){
  CD[,i] = (CD[,i]-min(CD[,i]))/(max(CD[,i])-min(CD[,i]))
}
rownames(CD) = CD$Country
CDhfit = hclust(dist(CD[,2:5]), "average")
plot(CDhfit)
plot(CDhfit, hang = -1)
cut.hfit = cutree(CDhfit, k = 5) # Pruning
rect.hclust(CDhfit, k = 5, border = "red")

# to calculate means of each cluster

CD <- read.csv("CountriesData.csv")
as.table(by(CD$Per.capita.income, cut.hfit, mean))


# experiment with different cluster rules

CD <- read.csv("CountriesData.csv")
CD[,2:5] = scale(CD[,2:5]) # scaled; rownames(CD) = CD$Country
pdf("H Cluster methods.pdf", width=20, height=10)
par(mfrow = c(2, 3))
hfit = hclust(dist(CD[,2:5]), "average"); plot(hfit, hang = -1)
hfit = hclust(dist(CD[,2:5]), "median"); plot(hfit, hang = -1)
hfit = hclust(dist(CD[,2:5]), "ward.D2"); plot(hfit, hang = -1)
hfit = hclust(dist(CD[,2:5]), "centroid"); plot(hfit, hang = -1)
hfit = hclust(dist(CD[,2:5]), "single"); plot(hfit, hang = -1)
hfit = hclust(dist(CD[,2:5]), "complete"); plot(hfit, hang = -1)
dev.off()


#to make demo hclust plot
CD <- read.csv("CountriesData.csv")
# scaled
CD[,2:5] = scale(CD[,2:5])
CD = CD[1:10,]
CD$Country = 1:10
rownames(CD) = CD$Country
hfit = hclust(dist(CD[,2:5]), "average"); plot(hfit, hang = -1)
