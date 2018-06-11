library(rvest)
library(magrittr)
library(httr)

data =read_html("https://www.ptt.cc/bbs/Gossiping/search?page=1&q=%E6%9F%AF%E6%96%87%E5%93%B2") %>% html_text(trim = T)
prefix <- "https://www.ptt.cc/bbs/Gossiping/search?page="
FindURL <- function(URL){
  session = rvest::html_session(url = URL)
  form = session %>%
    html_node("form") %>%
    html_form()
  session_redirected = rvest::submit_form(session = session, form = form )
  URLlink <- session_redirected %>%
    html_nodes(".title a") %>% html_attr(.,"href")
  
  title <- session_redirected %>%
    html_nodes(".title a") %>% html_text

  Date <- session_redirected %>%
    html_nodes(".date") %>% html_text
  output <- cbind(title,URLlink,Date)
  
  return(output)
}
drko <- data.frame()
for(i in c(1:10))
{
  x <- paste0(prefix, i , "&q=%E6%9F%AF%E6%96%87%E5%93%B2")
  drko <- rbind(drko, FindURL(x))
}
result <- FindURL("https://www.ptt.cc/bbs/Gossiping/search?page=1&q=%E6%9F%AF%E6%96%87%E5%93%B2")
View(result)


