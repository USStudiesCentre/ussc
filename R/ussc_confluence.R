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
#' @export

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
#' @export

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
    links <- links[grepl("(xlsx)|(xls)", links)]
    prefix <- out$`_links`$base
    titles <- sapply(out[[1]], function(x) x$title)
    titles <- titles[grepl("(xlsx)|(xls)", titles)]
    
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


#' USSC Key Performance Indicator HTML Tables
#'
#' @param id Page ID - a number found in the confluence URL
#' @param username Your Confluence username which should be identical to your email. Defaults to an entry in .renviron file called CONFLUENCE_USERNAME.
#' @param password Your Confluence API key (Get from https://confluence.atlassian.com/cloud/api-tokens-938839638.html). Defaults to an entry in .renviron file called CONFLUENCE_PASSWORD.
#' @examples ussc_confluence_kpi_table(id = "950239240")
#' @author
#' Zoe Meers
#' @export

ussc_confluence_kpi_table <- function(id = id,
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
    purrr::map(janitor::clean_names) %>%
    .[[1]] %>% 
    tidyr::separate(x, c('publication_date', 'report_title', 'report_type', 'report_authors'), sep = '(split)|(by)')
  
  # split other columns and clean data
  f <- function(x) {pubs_kpi %>% dplyr::select(c('publication_date', 'report_title', 'report_type', 'report_authors'),  x) %>% tidyr::separate(x, paste0(x, c(".page_views", ".unique_page_views",".avg_time", ".downloads")), sep = "(split)|(/)") }
  
  return(names(pubs_kpi)[-c(1:4)] %>%            
           purrr::map(f) %>%                  
           purrr::reduce(dplyr::left_join) %>% 
           dplyr::mutate_all(~stringr::str_trim(.)) %>% 
           dplyr::mutate_all(~stringr::str_remove(., "\\*")) %>% 
           tidyr::gather(key, value,  -c('publication_date', 'report_title', 'report_type', 'report_authors')) %>% 
           tidyr::separate(key, c('tracking_date', 'metric'), sep = '[.]') %>% 
           dplyr::mutate(metric = gsub("_", " ", metric),
                  tracking_date = gsub("_", " ", tracking_date),
                  value = gsub(",", "", value),
                  report_type = gsub("Polling", "Poll", report_type)) %>% 
           dplyr::arrange(report_title, tracking_date) %>% 
           dplyr::mutate_if(is.character, list(~dplyr::na_if(., "NA"))) %>% 
           dplyr::mutate_if(is.character, list(~dplyr::na_if(., ""))) %>% 
           tidyr::drop_na(value) %>% 
           dplyr::filter(!stringr::str_detect(publication_date, "^Report"))
  )
}



#' USSC Confluence Word Files & Tables
#'
#' @param id Page ID - a number found in the confluence URL
#' @param username Your Confluence username which should be identical to your email. Defaults to an entry in .renviron file called CONFLUENCE_USERNAME.
#' @param password Your Confluence API key (Get from https://confluence.atlassian.com/cloud/api-tokens-938839638.html). Defaults to an entry in .renviron file called CONFLUENCE_PASSWORD.
#' @examples ussc_confluence_word_tables(id = "30441548")
#' @author
#' Zoe Meers
#' @export

ussc_confluence_word_tables <- function(id = id,
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
  links <- links[grepl(".docx", links)]
  prefix <- out$`_links`$base
  titles <- sapply(out[[1]], function(x) x$title)
  titles <- titles[grepl(".docx", titles)]
  
  # Fix links
  links <- glue::glue("{prefix}{links}&download=TRUE")
  
  # Run browseURL (to account for JS load time)
  # Note: I've set my browser (Firefox) to automatically download Excel files from the pop up option.
  
  if (!fs::file_exists(glue::glue("~/Downloads/{titles}"))) {
    if (!fs::file_exists(here::here(glue::glue("{titles}")))) {
      purrr::map(links, ~utils::browseURL(as.character(.x)))
      Sys.sleep(3)
    }
  }
  
  # Move the downloaded file from Downloads to current folder (if not already in folder)
  # Note: delay set to 2 seconds to account for download time from the browser
  
  
  if (file.exists(glue::glue("~/Downloads/{titles}"))) {
    purrr::map(links, ~fs::file_move(glue::glue("~/Downloads/{titles}"), here::here(glue::glue("{titles}"))))
    Sys.sleep(0.5)
  }
  
  
  # grab word doc, map data to list
  # dat <- purrr::map(.x = here::here(glue::glue("{titles}")), ~docxtractr::read_docx(.x)) %>% 
  #   purrr::map(docxtractr::docx_extract_all_tbls)
  
  
  dat <- tibble::tibble(file =  here::here(glue::glue("{titles}"))) %>% 
    dplyr::mutate(doc = purrr::map(here::here(glue::glue("{titles}")), docxtractr::read_docx),
           file = basename(file),
           file = tools::file_path_sans_ext(file),
           tables = purrr::map(doc, docxtractr::docx_extract_all_tbls),
           date = gsub(".*-", "", file),
           date = paste0("01", date),
           date = lubridate::as_date(lubridate::dmy(date), "%Y-%m-%d")) %>% 
    tidyr::unnest(cols = c(tables))
  
  return(dat)
}




#' USSC Confluence Version History and Log
#'
#' @param id Page ID - a number found in the confluence URL
#' @param username Your Confluence username which should be identical to your email. Defaults to an entry in .renviron file called CONFLUENCE_USERNAME.
#' @param password Your Confluence API key (Get from https://confluence.atlassian.com/cloud/api-tokens-938839638.html). Defaults to an entry in .renviron file called CONFLUENCE_PASSWORD.
#' @examples ussc_confluence_version_history(id = "942637057")
#' @author
#' Zoe Meers
#' @export

ussc_confluence_version_history  <- function (id = id, username = Sys.getenv("CONFLUENCE_USERNAME"), 
                                              password = Sys.getenv("CONFLUENCE_PASSWORD")) 
{
  cat("Please note: depending on how many edits have been made to the page, scraping the version history will take a while (~2 - 4 mins)... \n \n")
  req <- httr::GET(
    url = glue::glue("https://usscsydney.atlassian.net/wiki/rest/api/content/{id}/version?expand=body.storage"),
    httr::accept_json(), httr::authenticate(username, password),
    config <- httr::config(ssl_verifypeer = FALSE)
  )
  
  
  out <- httr::content(req)
  links <- sapply(out[[1]], function(x) x$`_expandable`$content)
  
  pub_cal_current <- out[["results"]] %>% {
    tibble::tibble(
      date = purrr::map_chr(., "when"), version_history = purrr::map_int(
        .,
        "number"
      ), message = purrr::map_chr(., "message"),
      email = as.character(purrr::map(., ~ purrr::pluck(.x$by$email))),
      name = as.character(purrr::map(., ~ purrr::pluck(.x$by$displayName))),
      link = paste0(
        "https://usscsydney.atlassian.net/wiki",
        links, "&expand=body.storage"
      )
    )
  }
  
  current_version <- httr::GET(
    url = glue::glue("https://usscsydney.atlassian.net/wiki/rest/api/content/{id}"),
    httr::accept_json(), httr::authenticate(
      username,
      password
    ), config <- httr::config(ssl_verifypeer = FALSE)
  )
  current_version_content <- httr::content(current_version)
  
  
  current_version_tibble <- current_version_content %>% {
    tibble::tibble(
      date = purrr::pluck(.$version$when), version_history = purrr::pluck(.$version$number),
      message = purrr::pluck(.$version$message), email = as.character(purrr::pluck(.$version$by$email)),
      name = as.character(purrr::pluck(.$version$by$displayName)),
      link = paste0(purrr::pluck(.$`_links`$self), "?expand=body.storage")
    )
  }
  
  pub_cal_current <- dplyr::bind_rows(pub_cal_current, current_version_tibble)
  
  
  vh <- purrr::map(pub_cal_current$link, ~ httr::GET(
    url = ., httr::accept_json(),
    httr::authenticate(username, password), 
    config <- httr::config(ssl_verifypeer = FALSE)
  )) %>%
    purrr::map(., ~ httr::content(.x)) %>%
    purrr::compact() %>%
    purrr::map(., ~ .x$body$storage$value) %>%
    purrr::map(
      .,
      xml2::read_html
    ) %>%
    purrr::map(., ~ rvest::html_nodes(
      .x,
      "table"
    )) %>%
    purrr::map(., ~ rvest::html_table(.x, fill = TRUE)
    )
  
  if(id == "942637057"){
    vh_id <- vh %>%
      purrr::map_dfr(dplyr::bind_rows, .id = "version_history" ) %>%
      dplyr::rename("empty" = "") %>%
      dplyr::select(-empty) %>%
      dplyr::mutate(version_history = rev(as.numeric(version_history))) %>%
      dplyr::arrange(Title, version_history)
  } else{
    vh_id <- vh %>%
      purrr::map_dfr(dplyr::bind_rows, .id = "version_history" ) %>%
      dplyr::mutate(version_history = rev(as.numeric(version_history))) %>%
      dplyr::arrange(Title, version_history)
  }
  
  
  
  return(dplyr::left_join(pub_cal_current, vh_id) %>% 
           dplyr::select(-link) %>%
           dplyr::arrange(Title, version_history) %>% 
           dplyr::mutate(
             email = as.character(as.list(email)),
             name = as.character(as.list(name))
           ) %>% 
           dplyr::group_by(
             Title, Program, Status, `Original publication date`, 
             `New publication date`,
             Author, 
             Approver, Type
           ) %>%
           dplyr::slice(1) %>% 
           dplyr::ungroup() %>% 
           dplyr::filter(Title != "") %>% 
           janitor::clean_names() %>% 
           dplyr::mutate(date = as.Date(gsub( "T.*","", date))
           ) %>% 
           dplyr::group_by(title) %>% 
           dplyr::arrange(
             title,
             date
           ) %>% dplyr::ungroup()
  )
  
  
}
