library(recommenderlab)
library(Matrix)

ratings = read.csv(
  'data/ratings.dat',
  sep = ':',
  colClasses = c('integer', 'NULL'),
  header = FALSE
)
colnames(ratings) = c('UserID', 'MovieID', 'Rating', 'Timestamp')
ratings$Timestamp = NULL

# Create rating matrix
i = paste0('u', ratings$UserID)
j = paste0('m', ratings$MovieID)
x = ratings$Rating
tmp = data.frame(i, j, x, stringsAsFactors = T)
Rmat = sparseMatrix(as.integer(tmp$i), as.integer(tmp$j), x = tmp$x)
rownames(Rmat) = levels(tmp$i)
colnames(Rmat) = levels(tmp$j)
Rmat = new('realRatingMatrix', data = Rmat)

rec_IBCF = readRDS("data/production_IBCF.rds")

movieIDs = colnames(Rmat)
n.item = ncol(Rmat)
