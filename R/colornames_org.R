#' Get color name from colornames.org API
#'
#' Return best color name of an hex color from the colornames API
#' <https://colornames.org/download/>. If no color name exists, it returns NULL`.
#' You can give a color name and vote for best color names at:
#' <https://colornames.org/color/YOUR-HEX-CODE>.
#'
#' @param hex Hex color code
#' @param return_name_only if FALSE returns color name only
#'
#' @return A character string.
#'
#' @examples
#' \dontrun{
#' get_color_colornames(hex = "#0047AB")
#' }
#'
#' @export
get_color_colornames <- function(hex, return_name_only = TRUE) {

  if(!is.logical(return_name_only)) stop("'return_name_only' argument should be `TRUE` or `FALSE`", call. = FALSE)

  #remove '#' symbol if exists in hex argument
  hexCode <- sub("#", "", hex)

  if(nchar(hexCode) != 6) {
    stop("Hex code ", hexCode, " has ", nchar(hexCode), " characters.\nHex code should have 6 characters.\n", call. = FALSE)
  }

  resp <- httr2::request("https://colornames.org") |>
    httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
    httr2::req_url_path("/search/json/?") |>
    httr2::req_url_query(`hex` = hexCode) |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if(is.null(resp$name)) {
    resp$name <- NA_character_
  }

  if(isTRUE(return_name_only)) {
    resp <- resp$name
  }

  if(isFALSE(return_name_only)) {
    resp <- as.data.frame(resp)
  }

  resp
}

#' Get a random color name from colornames.org API
#'
#' @param return_name_only if TRUE returns color name only
#'
#' @rdname get_color_name_random
#'
#' @return A character string.
#'
#' @examples
#' \dontrun{
#' get_color_colornames_random()
#' }
#'
#' @export
get_color_colornames_random <- function(return_name_only = TRUE) {
  if(!is.logical(return_name_only)) stop("'return_name_only' argument should be `TRUE` or `FALSE`", call. = FALSE)

  resp <- httr2::request("https://colornames.org") |>
    httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
    httr2::req_url_path("/random/json/") |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if(is.null(resp$name)) {
    resp$name <- NA_character_
  }

  if(isTRUE(return_name_only)) {
    resp <- resp$name
  }

  if(isFALSE(return_name_only)) {
    resp <- as.data.frame(resp)
  }

  resp
}

#' Get 100 latest color submissions from colornames.org API
#'
#' @param return_name_only if TRUE returns color name only
#'
#' @rdname get_color_name_latest
#'
#' @return A character vector.
#'
#' @examples
#' \dontrun{
#' get_color_colornames_latest()
#' }
#'
#' @export
get_color_colornames_latest <- function(return_name_only = TRUE) {

  resp <- httr2::request("https://colornames.org") |>
    httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
    httr2::req_url_path("/fresh/json/") |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE)

  if(isTRUE(return_name_only)) {
    resp <- resp$name
  }

  resp
}
