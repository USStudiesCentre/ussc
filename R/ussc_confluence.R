## Functions to pull data from the USSC's confluence page
## Zoe Meers
## The United States Studies Centre at the University of Sydney


#' USSC Confluence HTML Tables
#'
#' @param id Page ID - a number found in the confluence URL
#' @param username Your Confluence username which should be identical to your email. Defaults to an entry in .renviron file called CONFLUENCE_USERNAME.
#' @param password Your Confluence API key (Get from https://confluence.atlassian.com/cloud/api-tokens-938839638.html). Defaults to an entry in .renviron file called CONFLUENCE_PASSWORD.
#' @examples ussc_confluence_table("950239240")
#' @author
#' Zoe Meers

ussc_confluence_table <- function(id = id,
                                  username = Sys.getenv("CONFLUENCE_USERNAME"),
                                  password = Sys.getenv("CONFLUENCE_PASSWORD")) {
    req <- httr::GET(
        url = glue::glue("https://usscsydney.atlassian.net/wiki/rest/api/content/{id}?expand=body.storage"),
        httr::accept_json(),
        httr::authenticate(username, password),
        config <- httr::config(ssl_verifypeer = FALSE)
    )
    
    out <- httr::content(req)
    body <- out[["body"]]$storage$value
    html <- xml2::read_html(body)
    tables <- rvest::html_nodes(html, "table")
    return(rvest::html_table(tables, fill = TRUE) %>%
               map(janitor::clean_names))
    
}

#' USSC Confluence Excel Files
#'
#' @param id Page ID - a number found in the confluence URL
#' @param username Your Confluence username which should be identical to your email. Defaults to an entry in .renviron file called CONFLUENCE_USERNAME.
#' @param password Your Confluence API key (Get from https://confluence.atlassian.com/cloud/api-tokens-938839638.html). Defaults to an entry in .renviron file called CONFLUENCE_PASSWORD.
#' @examples ussc_confluence_excel(id = "950239621")
#' @author
#' Zoe Meers

ussc_confluence_table <- function(id = id,
                                  username = Sys.getenv("CONFLUENCE_USERNAME"),
                                  password = Sys.getenv("CONFLUENCE_PASSWORD")) {
    req <- httr::GET(
        url = glue::glue("https://usscsydney.atlassian.net/wiki/rest/api/content/{id}?expand=body.storage"),
        httr::accept_json(),
        httr::authenticate(username, password),
        config <- httr::config(ssl_verifypeer = FALSE)
    )
    
    out <- httr::content(req)
    body <- out[["body"]]$storage$value
    html <- xml2::read_html(body)
    tables <- rvest::html_nodes(html, "table")
    return(rvest::html_table(tables, fill = TRUE) %>%
               map(janitor::clean_names))
    
}
