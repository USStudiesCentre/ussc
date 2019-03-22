## Functions to pull data from the USSC's confluence page
## Zoe Meers
## The United States Studies Centre at the University of Sydney


#' USSC Confluence HTML Tables
#'
#' @param id Page ID - a number found in the confluence URL
#' @param username Your Confluence username which should be identical to your email. Defaults to an entry in .renviron file called CONFLUENCE_USERNAME.
#' @param password Your Confluence API key (Get from https://confluence.atlassian.com/cloud/api-tokens-938839638.html). Defaults to an entry in .renviron file called CONFLUENCE_PASSWORD.
#' @examples ussc_confluence_table(id = "950239240")
#' @author
#' Zoe Meers

ussc_confluence_table <- function(id = id,
                                  username = Sys.getenv("CONFLUENCE_USERNAME"),
                                  password = Sys.getenv("CONFLUENCE_PASSWORD"),
                                  expand = expand) {
    req <- httr::GET(
        url = glue::glue("https://usscsydney.atlassian.net/wiki/rest/api/content/{id}?expand={expand}"),
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

ussc_confluence_excel <- function(id = id,
                                  username = Sys.getenv("CONFLUENCE_USERNAME"),
                                  password = Sys.getenv("CONFLUENCE_PASSWORD")) {
    req <- httr::GET(
        url = glue::glue("https://usscsydney.atlassian.net/wiki/rest/api/content/{id}/child/attachment"),
        httr::accept_json(),
        httr::authenticate(username, password),
        config <- httr::config(ssl_verifypeer = FALSE)
    )
    
    out <- httr::content(req)
    
    # grab links from content info
    links <- sapply(out[[1]], function(x) x$`_links`$download)
    prefix <- out$`_links`$base
    titles <- sapply(out[[1]], function(x) x$title)
    
    # Fix links
    links <- glue::glue("{prefix}{links}&download=TRUE")
    
    # Run browseURL (to account for JS load time)
    # Note: I've set my browser (Firefox) to automatically download Excel files from the pop up option.
    
    if (!fs::file_exists(glue::glue("~/Downloads/{titles}"))) {
        if (!fs::file_exists(here::here(glue::glue("{titles}")))) {
            map(links, ~browseURL(as.character(.x)))
            Sys.sleep(3)
        }
    }
    
    # Move the downloaded file from Downloads to current folder (if not already in folder)
    # Note: delay set to 2 seconds to account for download time from the browser
    
    
    if (file.exists(glue::glue("~/Downloads/{titles}"))) {
        purrr::map(links, ~file_move(glue::glue("~/Downloads/{titles}"), here::here(glue::glue("{titles}"))))
        Sys.sleep(0.5)
    }
    
    # grab sheetnames from Excel workbook, map data to list
    dat <- purrr::map(here::here(glue::glue("{titles}")), ~.x %>%
                          readxl::excel_sheets() %>%
                          purrr::set_names() %>%
                          purrr::map(readxl::read_excel, path = .x) %>%
                          purrr::map(janitor::clean_names))
    
    
    if (length(dat) == 1) {
        return(dat[[1]])
    } else {
        return(dat)
    }
    
}