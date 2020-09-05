#' Get the humidity of a sensor instance.
#'
#' Reads the humidity of a given sensor instance.
#'
#' @param x A sensor instance.
#' @param ... further arguments passed to or from other methods.
#'
#' @return A numeric of length one with the read humidity. In case of error, it
#'   will return `NA`.
#'
#' @examples
#' \dontrun{
#' # Get a DHT11 sensor instance connected at GPIO 14.
#' sensor <- get_dht11_sensor(14)
#' # Read the humidity.
#' get_humidity(sensor)
#' }
#'
#' @export
#'
setGeneric("get_humidity", function(x, ...) standardGeneric("get_humidity"))

#' @describeIn get_humidity
#'
#' @param max_retries A numeric of length one indicating how many times it
#'   should retry in case of issues.
#'
#' @export
#'
setMethod("get_humidity", "DHT11", function(x, max_retries = 10, ...) {
  # Read the sensor.
  res <- read_sensor(x, max_retries = max_retries)
  # If the sensor could not be read, return NA.
  if (all(is.na(res)))
    return(NA)
  # Return the value.
  res$humidity
})
