#' Get a DHT11 sensor instance.
#'
#' Returns a DHT11 sensor instance ready to be read.
#'
#' @param pin An integer of length one with the GPIO pin that the sensor is
#'   connected to.
#'
#' @return A DHT11 S4 object, this object will be set to work with the selected
#'   sensor.
#'
#' @examples
#' \dontrun{
#' # Get a DHT11 instance connected at GPIO 14.
#' dht11_14 <- get_dht11_sensor(14)
#' # Get a DHT11 instance connected at GPIO 18.
#' dht11_18 <- get_dht11_sensor(18)
#' }
#'
#' @importFrom methods new
#'
#' @export
#'
get_dht11_sensor <- function(pin) {
  if (!is.numeric(pin))
    stop("`pin` should be an integer of length one")
  # Return the structure.
  # Create our representation class of a DHT11 sensor.
  new("DHT11", pin = pin, dht11 = config_dht11(as.integer(pin)))
}

# @param pin An integer of length one with the GPIO pin that the sensor is
#   connected to.
config_dht11 <- function(pin) {
  # Try to load the Python libraries.
  libs <- try_load(c("RPi.GPIO", "dht11"))

  # Configure the initial GPIO status.
  libs$gpio$setwarnings(FALSE)
  libs$gpio$setmode(gpio$BCM)
  # libs$gpio$cleanup()

  # Create the DHT11 sensor Python instance.
  libs$dht11$DHT11(pin = pin)
}

# Tries to load the desired Python libraries.
#
# It tries to load the desired Python libraries, if they are not installed, it
# will ask to do so.
#
# @param py_libs A vector of Python packages names to install.
#
#' @importFrom reticulate import py_install
#
try_load <- function(py_libs) {
  imports_error <- try({
    libs <- lapply(py_libs, import)
    names(libs) <- py_libs
  })
  # If there was an error, then prompt to install the libraries.
  if (inherits(imports_error, "try-error")) {
    install_libs <- readline(paste0(
      "This package requires the ",
      py_libs,
      " Python libraries to be installed.\n",
      "Would you like to install them? Input 'y' for true, other for false: "
    ))
    if (install_libs != "y")
      stop("Required libraries not installed.")
    py_install(py_libs)
    libs <- lapply(py_libs, import)
    names(libs) <- py_libs
  }
  libs
}
