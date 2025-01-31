#' @import httr
#' @import lubridate
#' @import jsonlite
#' @import dplyr
#' @export
request_fun <- function(){
  #' @title  request
  #'
  #' @description calls API
  #' @return json file
  url <- 'https://api.opencovid.ca/timeseries'
  request <- GET(url)
  return(request)
}
#'
#' @export
active_cases <- function(provinceName = 'Canada'){
  #' @title  Returns a dataframe of active Covid-19 cases in desired province of Canada
  #'
  #' @description Perform data wrangling and cleaning using the API for the Covid-19 cases in Canada.
  #' It processes the API and returns the data corresponding to one province which is passed on as the argument. If user passes empty argument, so by default Canada is used which returns the data of whole Canada as a  whole.
  #' The returned data is a data frame and contains the columns including the date, province name, active cases, change is active cases,
  #' cumulative cases, cumulative deaths and cumulative recovered.
  #'
  #' @param provinceName a character/string depicting the name of the province
  #'
  #' @return Data frame for the Covid-19 active cases  corresponding to a particular province
  #'
  #' @examples active_cases("Alberta")

  prov = c("Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador", "Nova Scotia", "Nunavut", "Northwest Territories", "Ontario", "Prince Edward Island", "Quebec", "Saskatchewan", "Yukon", "Canada")

  `%!in%` <- Negate(`%in%`)
  if(tolower(provinceName) %!in% tolower(prov)){
    stop("Please enter a valid province name in full form!")
  }

  request <- request_fun()
  json_data <- content(request, as  = "parse")
  all_active <- json_data$active
  active_data <- data.frame()

  for(i in 1:length(all_active)){
    active_data <- rbind(active_data, data.frame(all_active[[i]]))
  }

  active_data <- active_data %>% rename(date = date_active) %>%
    mutate(date, date = dmy(date)) %>%
    mutate(province = replace(province, province %in% c("BC"), "British Columbia"),
           province = replace(province, province %in% c("NL"), "Newfoundland and Labrador"),
           province = replace(province, province %in% c("NWT"), "Northwest Territories"),
           province = replace(province, province %in% c("PEI"), "Prince Edward Island"))


  active_data <- active_data[,c(6,7,1:5)]

  if(tolower(provinceName) == "canada"){
    return(active_data)
  } else {
    active_data <- active_data %>%
      filter(tolower(province) == tolower(provinceName))
    return(active_data)
  }
}
