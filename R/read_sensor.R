#' Read the data of a sensor instance.
#'
#' Reads the data of a given sensor instance.
#'
#' @param x A sensor instance.
#' @param ... further arguments passed to or from other methods.
#'
#' @examples
#' \dontrun{
#' # Get a DHT11 sensor instance connected at GPIO 14.
#' dht11 <- get_dht11_sensor(14)
#' # Read the sensor's data.
#' read_sensor(dht11)
#' }
#'
#' @export
#'
setGeneric("read_sensor", function(x, ...) standardGeneric("read_sensor"))

#' @describeIn read_sensor
#'
#' @param max_retries A numeric of length one indicating how many times it
#'   should retry in case of issues.
#'
#' @export
#'
setMethod("read_sensor", "DHT11", function(x, max_retries = 10, ...) {
  retries <- 1
  sensor <- x@dht11
  # Try to read the temperature from the device file.
  res <- sensor$read()
  while (!res$is_valid() && retries < max_retries) {
    # If could not read, sleep 0.2 and retry.
    Sys.sleep(0.2)
    retries <- retries + 1
    res <- sensor$read()
  }
  if (!res$is_valid())
    return(NA)
  list(temperature = res$temperature, humidity = res$humidity)
})
