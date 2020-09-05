#' Get the temperature of a sensor instance.
#'
#' Reads the temperature of a given sensor instance.
#'
#' @param x A sensor instance.
#' @param ... further arguments passed to or from other methods.
#'
#' @return A numeric of length one with the read temperature in the selected
#'   `scale`. In case of error, it will return `NA`.
#'
#' @examples
#' \dontrun{
#' # Get a DHT11 sensor instance connected at GPIO 14.
#' sensor <- get_dht11_sensor(14)
#' # Read the temperature in Celsius and in Fahrenheit.
#' get_temperature(sensor)
#' get_temperature(sensor, "fahrenheit")
#' }
#'
#' @export
#'
setGeneric("get_temperature", function(x, ...) standardGeneric("get_temperature"))

#' @describeIn get_temperature
#'
#' @param max_retries A numeric of length one indicating how many times it
#'   should retry in case of issues.
#' @param scale One of `"celsius"`, `"fahrenheit"` or `"kelvin"`, indicating
#'   the desired return scale.
#'
#' @export
#'
setMethod("get_temperature", "DHT11", function(x, scale = "celsius", max_retries = 10, ...) {
  # Read the sensor.
  res <- read_sensor(x, max_retries = max_retries)
  # If the sensor could not be read, return NA.
  if (is.na(res))
    return(NA)
  # Transform the scale.
  res <- res$temperature
  switch (
    scale,
    celsius = temp,
    fahrenheit = temp * (9 / 5) + 32.0,
    kelvin = temp + 273.15,
    {
      warning('`scale` must be one of "celsius", "fahrenheit", "kelvin"')
      NA
    }
  )
})
