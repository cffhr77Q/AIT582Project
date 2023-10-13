dataset <- read.csv('~/Desktop/project/Dataset/nberces.csv')
summary(dataset)

#Check dimension (row and column) of dataset
dim(dataset)

#removing NA rows
dataset_na <- na.omit(dataset)
dim(dataset_na)

# the ratio of NA is small enough to remove na rows
(dim(dataset)[1]-dim(dataset_na)[1])/dim(dataset)[1]
(dim(dataset)[1]-dim(dataset_na)[1])

# The number of companies
library("dplyr")
n_distinct(dataset_na$naics)
t <- table(dataset_na$naics)
id <- as.data.frame(t)
#select companies with 58 records
id_data<- id[which(id$Freq == 58),]
id_selected <- id[which(id$Freq == 58),1]
#select companies not enough 58 records
id_remove <- id[!(id$Var1 %in% id_data$Var1),]
#new dataset for research
dataset_2 <- dataset_na[dataset_na$naics %in% id_selected,]

# micro, random select a company.
n <- sample(1:361,1)
id_n <- id_data[n,]
micro_random <- dataset_2[which(dataset_2$naics == id_n$Var1),]
write.csv(micro_random,'~/Desktop/project/Dataset/random_micro.csv',row.names = F)

# macro, average of each year
col <- colnames(dataset_2)
agg_macro <- dataset_2 %>% group_by(year) %>% summarise(across(everything(),list(mean=mean)))
write.csv(micro_random,'~/Desktop/project/Dataset/year_macro.csv',row.names = F)
