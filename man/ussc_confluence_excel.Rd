% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ussc_confluence.R
\name{ussc_confluence_excel}
\alias{ussc_confluence_excel}
\title{USSC Confluence Excel Files}
\usage{
ussc_confluence_excel(
  id = id,
  username = Sys.getenv("CONFLUENCE_USERNAME"),
  password = Sys.getenv("CONFLUENCE_PASSWORD")
)
}
\arguments{
\item{id}{Page ID - a number found in the confluence URL}

\item{username}{Your Confluence username which should be identical to your email. Defaults to an entry in .renviron file called CONFLUENCE_USERNAME.}

\item{password}{Your Confluence API key (Get from https://confluence.atlassian.com/cloud/api-tokens-938839638.html). Defaults to an entry in .renviron file called CONFLUENCE_PASSWORD.}
}
\description{
USSC Confluence Excel Files
}
\examples{
\dontrun{ussc_confluence_excel(id = "950239621", username = Sys.getenv("CONFLUENCE_USERNAME"), password = Sys.getenv("CONFLUENCE_PASSWORD"))}
}
\author{
Zoe Meers
}
