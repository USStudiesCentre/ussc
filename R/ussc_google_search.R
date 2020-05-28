
# This function concatenates and defines the custom query from separate columns 
# i.e. let's say you want Simon Jackman AND USSC, create a data frame called df with two columns
# df <- tribble(~name, ~place, "Simon Jackman", "USSC")
# Run the function like so:
# ussc_google_create_custom_query(df, "name", "place") OR 
# df %>% ussc_google_create_custom_query("name", "place") 

# Function arguments: 
# data refers to the newly-created data frame or tibble
# ... - a list of columns that you want to convert into a Google query (this can be a singular column)


#' Creates custom Google Search query
#' @description
#' Defines the query needed for Google Search to grab the right data.
#' @param .data The data frame containing the strings you want to turn into a query.
#' @param ... A list of columns to convert -- this can just be one column.
#' @usage
#' ussc_google_create_custom_query()
#' @examples
#' df <- tibble::tribble(~name, ~place, "Simon Jackman", "USSC")
#' ussc::ussc_google_create_custom_query(data = df, "name", "place") 
#' @author
#' Zoe Meers
#' @export
#' 

ussc_google_create_custom_query <- function(.data, ...){
  .data %>% 
    tidyr::unite(col = custom_query, ...,
          sep = "%22+%22", remove = FALSE) %>%
    dplyr::mutate(custom_query= gsub("\\s", "+", custom_query),
           custom_query = paste0('%22', custom_query, '%22'))
}


# Grabs total results from Google Search API.
# Data is the pre-defined data frame (see above)
# api_key is the Google Search API -- follow the instructions here https://developers.google.com/custom-search/v1/overview#api_key
# Paste the API key in your .renviron file under GOOGLE_SEARCH_API_KEY

# Once you have an api_key, create a Custom Search Engine
# Follow the instructions here https://developers.google.com/custom-search/docs/tutorial/creatingcse#defining_a_custom_search_engine_in_control_panel
# In the form, for the website field type in www.google.com
# Remember to give the Custom Search Engine an informative name
# Now you need to edit the CSE to search for all links (not just www.google.com)
# Go here: https://cse.google.com/create/new. On the left, click edit search engine, 
# click on the CSE that you just created and scroll down to "Search the entire web". Click Yes.
# Scroll up, copy Search engine ID, paste in your .renviron file under GOOGLE_SEARCH_CX_ID

# Function arguments: 
# data refers to the newly-created data frame or tibble
# api_key - API key needed to access the Google Search API
# cx_id - Custom Search Engine ID
# query - Custom query column



# NOTE: to double check the total results in the data frame, go https://cse.google.com/cse?cx= , pasting your GOOGLE_SEARCH_CX_ID at the end.
# Type in whatever your query is, the number of total results should match the one in the data frame.

#' Grabs data from Google Search API
#' @description
#' Uses the google search query to grab total search numbers from Google Search.
#' @param .data data frame with custom queries
#' @param query Google Search query from ussc::ussc_google_create_custom_query
#' @param cx_id Custom Search Engine ID
#' Once you have an api_key, create a Custom Search Engine. 
#' Follow the instructions here https://developers.google.com/custom-search/docs/tutorial/creatingcse#defining_a_custom_search_engine_in_control_panel. 
#' In the form, for the website field type in www.google.com. 
#' Remember to give the Custom Search Engine an informative name. 
#' Now you need to edit the CSE to search for all links (not just www.google.com). 
#' Go here: https://cse.google.com/create/new. On the left, click edit search engine, 
#' click on the CSE that you just created and scroll down to "Search the entire web". Click Yes. 
#' Scroll up, copy Search engine ID, paste in your .renviron file under GOOGLE_SEARCH_CX_ID. 
#' @param api_key Google Search API -- follow the instructions here https://developers.google.com/custom-search/v1/overview#api_key. 
#' @usage
#' ussc_google_total_results()
#' @examples
#' \dontrun{
#' df <- tibble::tribble(~name, ~place, "Simon Jackman", "USSC")
#' custom_query <- ussc::ussc_google_create_custom_query(df, "name", "place") 
#' results <- ussc::ussc_google_total_results(query = custom_query)
#' }
#' @author
#' Zoe Meers
#' @export
#' 

ussc_google_total_results <- function(.data, 
                                      api_key = Sys.getenv("GOOGLE_SEARCH_API_KEY"), 
                                      cx_id = Sys.getenv("GOOGLE_SEARCH_CX_ID"), 
                                      query){
  tmp <- .data %>%
    dplyr::mutate(api_key = api_key,
           cx_id = cx_id) %>% 
    dplyr::mutate(url = paste0("https://www.googleapis.com/customsearch/v1?key=", api_key,
                        "&cx=", cx_id, "&q=", custom_query, "&fields=queries(request(totalResults))")) %>% 
    dplyr::mutate(total_results = purrr::map(url, ~httr::GET(.x) %>%
                                 jsonlite::parse_json() %>%
                                 dplyr::as_tibble() %>% 
                                 tidyr::unnest(cols = c(queries)) %>%
                                 tidyr::unnest(cols = c(queries)) %>% 
                                 tidyr::unnest(cols = c(queries)) ))  %>%
    dplyr::mutate(total_results = purrr::flatten(total_results) %>% 
             as.numeric(total_results)) %>% 
    dplyr::mutate(custom_query = gsub("%22+%22", ") AND (", custom_query, fixed = TRUE),
           custom_query = gsub("%22", "", custom_query, fixed = TRUE),
           custom_query = gsub("+", " ", custom_query, fixed = TRUE),
           custom_query = paste0("(", custom_query, ")")) %>% 
    dplyr::select(-url, -cx_id, -api_key)
  return(tmp)
}
