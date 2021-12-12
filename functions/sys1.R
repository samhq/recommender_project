library(dplyr)

# read in data
movies = readLines('data/movies.dat')
movies = strsplit(movies,
                  split = "::",
                  fixed = TRUE,
                  useBytes = TRUE)
movies = matrix(unlist(movies), ncol = 3, byrow = TRUE)
movies = data.frame(movies, stringsAsFactors = FALSE)
colnames(movies) = c('MovieID', 'Title', 'Genres')
movies$MovieID = as.integer(movies$MovieID)
movies$Title = iconv(movies$Title, "latin1", "UTF-8")

movies$image_url = sapply(movies$MovieID,
                          function(x)
                            paste0("images/", x, '.jpg'))

ratings = read.csv(
  'data/ratings.dat',
  sep = ':',
  colClasses = c('integer', 'NULL'),
  header = FALSE
)
colnames(ratings) = c('UserID', 'MovieID', 'Rating', 'Timestamp')

# extract year
movies$Year = as.numeric(unlist(lapply(movies$Title, function(x)
  substr(x, nchar(x) - 4, nchar(x) - 1))))

# create aggregate columns
movie_sum = ratings %>%
  group_by(MovieID) %>%
  summarize(ratings_per_movie = n(),
            ave_ratings = round(mean(Rating), dig = 2)) %>%
  inner_join(movies, by = 'MovieID')

g = strsplit(movies$Genres,
             split = "|",
             fixed = TRUE,
             useBytes = TRUE)
genres = unique(Reduce(c, g))

sys1 = list()

for (i in 1:length(genres)) {
  lst = list(
    name = genres[i],
    df = movie_sum %>%
      filter(grepl(genres[i], Genres)) %>%
      filter(ratings_per_movie > 100) %>%
      top_n(25, ave_ratings) %>%
      arrange(desc(ave_ratings))
  )
  sys1 = append(sys1, list(lst))
}

top_movie_sum = ratings %>% 
  group_by(MovieID) %>% 
  summarize(ratings_per_movie = n(), ave_ratings = round(mean(Rating), dig=2)) %>%
  inner_join(movies, by = 'MovieID') %>%
  filter(ratings_per_movie > 100) %>%
  top_n(10, ave_ratings) %>%
  arrange(desc(ave_ratings))

topmovies = top_movie_sum$MovieID

