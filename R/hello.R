# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

get_user <- function(client_id, user_id, by_username = TRUE){
  if(by_username == TRUE){
    username_lookup <- httr::GET(paste0("http://api.soundcloud.com/resolve?url=http://soundcloud.com/",user_id,"&client_id=",client_id))
    user_id <- httr::content(username_lookup, as = 'parsed')$id
  }
  resp <- httr::GET(paste0("http://api.soundcloud.com/users/",user_id,"?client_id=",client_id))
  resp <- httr::content(resp, as = 'parsed')
  if(length(resp$errors[[1]]$error_message)){
    print('404. User not found.')
  }else if(is.null(resp)){
    print('Empty Response. Check your client ID.')
  }else{
    resp <- as.data.frame(unlist(resp))
    names(resp) <- 'User'
    return(resp)
  }
}

get_track_info <- function(client_id, artist_track){
  track_info_lookup <- httr::GET(paste0("http://api.soundcloud.com/resolve?url=http://soundcloud.com/",artist_track,"&client_id=",client_id))
  track_info_content <- content(track_info_lookup, as = "parsed")
  if(track_info_lookup$status_code == 403){
    print('Sorry, information for this track could not be retrieved. Access forbidden.')
  }else{
    track_info_content <- as.data.frame(unlist(track_info_content))
    names(track_info_content) <- 'track'
    return(track_info_content)
  }
}

### Test commit ###
