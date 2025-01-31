% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/myfun.R
\name{active_cases}
\alias{active_cases}
\title{Returns a dataframe of active Covid-19 cases in desired province of Canada}
\usage{
active_cases(provinceName = "Canada")
}
\arguments{
\item{provinceName}{a character/string depicting the name of the province}
}
\value{
Data frame for the Covid-19 active cases  corresponding to a particular province
}
\description{
Perform data wrangling and cleaning using the API for the Covid-19 cases in Canada.
It processes the API and returns the data corresponding to one province which is passed on as the argument. If user passes empty argument, so by default Canada is used which returns the data of whole Canada as a  whole.
The returned data is a data frame and contains the columns including the date, province name, active cases, change is active cases,
cumulative cases, cumulative deaths and cumulative recovered.
}
\examples{
active_cases("Alberta")
}
