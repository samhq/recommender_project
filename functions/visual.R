card = function(rank, title, rating, img) {
  HTML(
    paste0(
      '<div class="card border-info mb-3" style="max-width: 20rem;">
        <div class="card-header">Rank <strong>',
      rank,
      '</strong><span class="badge bg-info float-right">',
      rating,
      '</span>
      </div>
        <div class="card-body" style="padding: 0;">
          <img src="',
      img,
      '" style="width: 100%;"></img>
          <div style="padding: 6px;">
          <h5 class="card-title" style="margin: 0;">',
      title,
      '</h5>
          </div>
        </div>
      </div>'
    )
  )
}

system1_title = function(n = 10, genre = "Animation") {
  HTML(
    paste0(
      'Top <strong style="color: #e95420;">', n, '</strong> movies from <strong style="color: #17a2b8; font-style: italic;">', genre, '</strong> genre'
    )
  )
}

ratingCard = function(title, ratingInput, img) {
  HTML(
    paste0(
      '<div class="card border-secondary mb-3" style="max-width: 20rem;">
        <div class="card-body" style="padding: 0;">
          <img src="',
      img,
      '" style="width: 100%;"></img>
      <div style="text-align:center; padding: 5px 0 0 0;">
        <input name="',ratingInput,'" type="text" class="rating" data-start="1" data-stop="5" data-step="1"/>
      </div>
      <div style="padding: 6px; margin-top: -20px; text-align: center;">
          <h5 class="card-title" style="margin: 0;">',
      title,
      '</h5>
      <script>$("input.rating").rating({"size": "xs"})</script>
          </div>
        </div>
      </div>'
    )
  )
}

res2Card = function(rank, title, img) {
  HTML(
    paste0(
      '<div class="card border-success mb-3" style="max-width: 20rem;">
        <div class="card-header">Rank <strong>',
      rank,
      '</strong>
      </div>
        <div class="card-body" style="padding: 0;">
          <img src="',
      img,
      '" style="width: 100%;"></img>
          <div style="padding: 6px;">
          <h5 class="card-title" style="margin: 0;">',
      title,
      '</h5>
          </div>
        </div>
      </div>'
    )
  )
}
