## server.R

# define functions
get_user_ratings = function(value_list) {
  dat = data.table(
    MovieID = sapply(strsplit(names(value_list), "_"),
                     function(x)
                       ifelse(length(x) > 1, x[[2]], NA)),
    Rating = unlist(as.character(value_list))
  )
  dat = dat[!is.null(Rating) & !is.na(MovieID)]
  dat[Rating == " ", Rating := 0]
  dat[, ':=' (MovieID = as.numeric(MovieID), Rating = as.numeric(Rating))]
  dat = dat[Rating > 0]
  as.data.frame(dat)
}

shinyServer(function(input, output, session) {
  # for system 2
  
  output$moviesToRate = renderUI({
    idsToRate = sample(1:n.item, 50)
    df = movies[idsToRate, ]
    
    args <-
      lapply(1:dim(df)[1], function(x)
        ratingCard(
          title = df[x, "Title"],
          img = df[x, "image_url"],
          ratingInput = paste0("select_", df[x, "MovieID"])
        ))
    
    do.call(shiny::flowLayout, args)
  })
  
  recom = eventReactive(input$btn, {
    value_list <- reactiveValuesToList(input)
    user_ratings <- get_user_ratings(value_list)
    
    new.ratings = rep(NA, n.item)
    for (i in 1:dim(user_ratings)[1]) {
      id = user_ratings[i, "MovieID"]
      value = user_ratings[i, "Rating"]
      new.ratings[which(movieIDs == paste0("m", id))] = value
    }
    new.user = matrix(
      new.ratings,
      nrow = 1,
      ncol = n.item,
      dimnames = list(user = paste('ags'),
                      item = movieIDs)
    )
    new.Rmat = as(new.user, 'realRatingMatrix')
    
    recom2 = predict(rec_IBCF, new.Rmat, type = 'topN', n = 10)
    recom_list = as(recom2, "list")[[1]]
    recom_list = as.integer(str_remove(recom_list,"m"))

    diff = setdiff(topmovies,recom_list)

    if(length(recom_list)<10){
      len_add_movies = 10-length(recom_list)
      pop_movies = diff[1:len_add_movies]
      recom_list = append(recom_list, pop_movies)  
    }

    recom_list
  })
  
  output$sys2Results <- renderUI({
    recom_result <- recom()
    m1 = movies[movies$MovieID == recom_result[1], ]
    df = data.frame(Title = m1$Title,
                    image_url = m1$image_url)
    for (i in 2:length(recom_result)){
      mx = movies[movies$MovieID == recom_result[i], ]
      df1 = data.frame(Title = mx$Title,
                      image_url = mx$image_url)
      df <- rbind(df, df1)
    }

    args <-
      lapply(1:dim(df)[1], function(x)
        res2Card(
          rank = x,
          title = df[x, "Title"],
          img = df[x, "image_url"]
        ))
    
    do.call(shiny::flowLayout, args)
  })
  
  # for system 1
  
  captionText = reactive({
    system1_title(input$topN, input$genre)
  })
  
  output$caption = renderUI({
    captionText()
  })
  
  tgTable = reactive({
    n = input$topN
    sys1[[unname(which(genres == input$genre))]]$df[1:n, ]
  })
  
  output$cards <- renderUI({
    df <- tgTable()
    
    # First make the cards
    args <-
      lapply(1:dim(df)[1], function(x)
        card(
          rank = x,
          title = df[x, "Title"],
          rating = df[x, "ave_ratings"],
          img = df[x, "image_url"]
        ))
    
    do.call(shiny::flowLayout, args)
  })
}) # server function
