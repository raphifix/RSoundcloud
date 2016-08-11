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

### Test commit ###
