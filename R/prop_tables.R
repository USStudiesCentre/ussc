## Functions for survey analysis at the US Studies Centre
## Zoe Meers
## The United States Studies Centre at the University of Sydney

#' Grouped proportional tables for USSC cross-country surveys
#' @description
#' Calculates the weighted proportion for the specified questions and groups, both in the US and Australia.
#' @usage
#' prop_grouped_survey_question()
#' @examples
#' survey_data %>% 
#' prop_grouped_survey_question(questions = starts_with("sexual_harrassment"), partyid, gender)
#' @author
#' Zoe Meers
#' @export



prop_grouped_survey_question <-  function (.data, questions, ...){
    quos <- rlang::enquos(...)
    .data %>% dplyr::select(..., questions, weight, sample) %>% 
        tidyr::gather("question", "answer", 
                      -c(!!!(quos), weight, sample), na.rm = TRUE) %>% 
      dplyr::left_join(variables_in_long_file %>% 
                         select(description_us, description_au, value), 
                       by = c(question = "value")) %>% 
        dplyr::mutate(answer = factor(answer)) %>% 
      tidyr::drop_na(..., answer) %>% 
      dplyr::count(sample, ..., 
                   description_au, 
                   description_us, 
                   answer, 
                   wt = as.numeric(as.character(weight))) %>% 
        dplyr::group_by(sample, ..., description_us, description_au) %>% 
        dplyr::mutate(proportion = round(n/sum(n) * 100, 0)) %>% 
        dplyr::select(-n) %>% 
      dplyr::ungroup() %>% 
      tidyr::unite(subgroup, 
        c(sample, !!!(quos)), sep = "_") %>% 
      tidyr::spread(subgroup, proportion)
}

#' Prop tables for USSC cross-country surveys
#' @description
#' Calculates the weighted proportion for the specified questions in the US and Australia.
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
    dplyr::select(sample, weight, questions)  %>% 
    tidyr::gather("question", "answer", -sample, -weight, 
                  na.rm = TRUE) %>% 
    dplyr::left_join(variables_in_long_file %>% 
                    select(description_us, description_au, value),
              by = c("question" = "value")) %>%
    dplyr::mutate(answer = factor(answer)) %>% 
    dplyr::count(sample, description_us, description_au, 
                 answer, wt = as.numeric(as.character(weight))) %>% 
    dplyr::group_by(sample, description_us, description_au) %>%
    dplyr::mutate(proportion = round(n/sum(n)*100, 0)) %>% 
    dplyr::select(-n) %>% 
    dplyr::ungroup() %>% 
    tidyr::spread(sample, proportion) %>% 
    dplyr::mutate(Difference = `United States` - `Australia`)
}

#' Relevel answer column as factors
#' @usage
#' relevel_survey_answer()
#' @examples
#' survey_data %>% 
#' prop_survey_question(questions = starts_with("importance_of")) %>% 
#' relevel_survey_answer(levels)
#' @author
#' Zoe Meers
#' @export


relevel_survey_answer <- function(.data, levels) {
  .data %>% 
    dplyr::mutate(answer = forcats::fct_relevel(answer, levels)) %>% 
    dplyr::arrange(description_us, answer)
}

