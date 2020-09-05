#' DHT11 Class Representation.
#'
#' @slot pin The DHT11's assigned pin.
#' @slot dht11 The internal representation of the DHT11 sensor.
#'
#' @importFrom methods setClass
#'
setClass(
  "DHT11",
  slots = c(
    # integer or character
    pin = "ANY",
    # Python's DHT11 class
    dht11 = "ANY"
  )
)
