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
    xml2::xml_find_all(html, ".//p") %>% xml2::xml_add_sibling("p", "\n")
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
    # filter for excel files only
    links <- links[grepl(".xlsx|xls", links)]
    prefix <- out$`_links`$base
    titles <- sapply(out[[1]], function(x) x$title)
    
    # Fix links
    links <- glue::glue("{prefix}{links}&download=TRUE")
    
    # Run browseURL (to account for JS load time)
    # Note: I've set my browser (Firefox) to automatically download Excel files from the pop up option.
    
    rate <- purrr::rate_delay(2)
    #slow_runif <- purrr::slowly(~ runif(1), rate = rate, quiet = FALSE)
    if (!fs::file_exists(glue::glue("~/Downloads/{titles}"))) {
        if (!fs::file_exists(here::here(glue::glue("{titles}")))) {
            purrr::map(links, purrr::slowly(~browseURL(as.character(.x))), 
                       rate = rate, quiet = FALSE)
        }
    }
    
    # Move the downloaded file from Downloads to current folder (if not already in folder)
    # Note: delay set to 2 seconds to account for download time from the browser
    
    
    if (file.exists(glue::glue("~/Downloads/{titles}"))) {
        purrr::map(links, purrr::slowly(~fs::file_move(glue::glue("~/Downloads/{titles}"), here::here(glue::glue("{titles}"))), 
                                        rate = rate, quiet = FALSE))
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


#' USSC Confluence HTML Tables
#'
#' @param id Page ID - a number found in the confluence URL
#' @param username Your Confluence username which should be identical to your email. Defaults to an entry in .renviron file called CONFLUENCE_USERNAME.
#' @param password Your Confluence API key (Get from https://confluence.atlassian.com/cloud/api-tokens-938839638.html). Defaults to an entry in .renviron file called CONFLUENCE_PASSWORD.
#' @examples ussc_kpi_table(id = "950239240")
#' @author
#' Zoe Meers

ussc_kpi_table <- function(id = id,
                                    username = Sys.getenv("CONFLUENCE_USERNAME"),
                                    password = Sys.getenv("CONFLUENCE_PASSWORD")) {
  
  
  #run GET call
  req <- httr::GET(
    url = glue::glue("https://usscsydney.atlassian.net/wiki/rest/api/content/{id}?expand=body.storage"),
    httr::accept_json(),
    httr::authenticate(Sys.getenv("CONFLUENCE_USERNAME"), Sys.getenv("CONFLUENCE_PASSWORD")),
    config <- httr::config(ssl_verifypeer = FALSE)
  )
  
  # grab content
  out <- httr::content(req)
  body <- out[["body"]]$storage$value
  # read html, keep the split vars
  html <- xml2::read_html(body)
  xml2::xml_find_all(html, ".//p") %>% xml2::xml_add_sibling("p", "split")
  # convert html table into machine-readable table
  tables <- rvest::html_nodes(html, "table")
  # clean, split first column
  pubs_kpi <- rvest::html_table(tables, fill = TRUE) %>%
    map(janitor::clean_names) %>%
    .[[1]] %>% 
    separate(x, c('publication_date', 'report_title', 'report_type', 'report_authors'), sep = '(split)|(by)')
  
  # split other columns and clean data
  f <- function(x) {pubs_kpi %>% select(c('publication_date', 'report_title', 'report_type', 'report_authors'),  x) %>% separate(x, paste0(x, c(".page_views", ".unique_page_views",".avg_time", ".downloads")), sep = "(split)|(/)") }
  
  return(names(pubs_kpi)[-c(1:4)] %>%            
           map(f) %>%                  
           reduce(left_join) %>% 
           mutate_all(~str_trim(.)) %>% 
           mutate_all(~str_remove(., "\\*")) %>% 
           gather(key, value,  -c('publication_date', 'report_title', 'report_type', 'report_authors')) %>% 
           separate(key, c('tracking_date', 'metric'), sep = '[.]') %>% 
           mutate(metric = gsub("_", " ", metric),
                  tracking_date = gsub("_", " ", tracking_date),
                  value = gsub(",", "", value),
                  report_type = gsub("Polling", "Poll", report_type)) %>% 
           arrange(report_title, tracking_date) %>% 
           mutate_if(is.character, list(~na_if(., "NA"))) %>% 
           mutate_if(is.character, list(~na_if(., ""))) %>% 
           drop_na(value) %>% 
           filter(!str_detect(publication_date, "^Report"))
  )
}
