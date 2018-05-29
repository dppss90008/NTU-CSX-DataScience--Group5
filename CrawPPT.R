library(rvest)
library(magrittr)
library(httr)

data =read_html("https://www.ptt.cc/bbs/Gossiping/index.html") %>% html_text(trim = T)

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

result <- FindURL("https://www.ptt.cc/bbs/Gossiping/index.html")
View(result)


