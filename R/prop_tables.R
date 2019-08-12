## Functions for survey analysis at the US Studies Centre
## Zoe Meers
## The United States Studies Centre at the University of Sydney

#' Grouped prop tables for USSC cross-country surveys
#' @description
#' Calculates the proportion for the specified questions and groups, both in the US and Australia.
#' @usage
#' prop_grouped_survey_question()
#' @examples
#' survey_data %>% 
#' prop_grouped_survey_question(questions = starts_with("sexual_harrassment"), 
#' sample, partyid, gender)
#' @author
#' Zoe Meers
#' @export



prop_grouped_survey_question <- function(.data, questions, ...) {
  quos <- rlang::enquos(...)
  
  .data %>%
    dplyr::select(..., questions)  %>% 
    tidyr::gather("question", "answer", .dots =  -c(!!!(quos))) %>% 
    dplyr::left_join(variables_in_long_file %>% select(description_us, description_au, value),
              by = c("question" = "value")) %>%
    tidyr::drop_na(...) %>% 
    dplyr::count(..., description_au, description_us, answer) %>% 
    dplyr::group_by(..., description_us,  description_au) %>%
    dplyr::mutate(proportion = round(n/sum(n)*100, 0)) %>% 
    dplyr::select(-n) %>% 
    dplyr::ungroup() %>%
    tidyr::unite(subgroup, c(!!!(quos)), sep = "_") %>% 
    tidyr::spread(subgroup, proportion)
}

#' Prop tables for USSC cross-country surveys
#' @description
#' Calculates the proportion for the specified questions in the US and Australia.
#' @usage
#' prop_survey_question()
#' @examples
#' survey_data %>% 
#' prop_survey_question(questions = starts_with("importance_of"))
#' @author
#' Zoe Meers
#' @export

prop_survey_question <- function(.data, questions) {
  .data %>%
    dplyr::select(sample, questions)  %>% 
    tidyr::gather("question", "answer", .dots =  -sample) %>% 
    dplyr::left_join(variables_in_long_file %>% select(description_us, description_au, value),
              by = c("question" = "value")) %>%
    dplyr::count(sample, description_us, description_au, answer) %>% 
    dplyr::group_by(sample, description_us, description_au) %>%
    dplyr::mutate(proportion = round(n/sum(n)*100, 0)) %>% 
    dplyr::select(-n) %>% 
    dplyr::ungroup() %>% 
    tidyr::spread(sample, proportion)
}

