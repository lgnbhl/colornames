#' Get color name from thecolorapi.com API
#'
#' Return available identifying information on the given color.
#'
#' @param hex string (optional), Valid hex code.
#' @param rgb string (optional), Valid rgb color.
#' @param hsl string (optional), Valid hsl color.
#' @param cmyk string (optional) Valid cmyk color.
#' @param format string (optional). Return results as JSON, SVG or HTML page. Example: "html".
#' @param w integer (optional). Height of resulting image, only applicable on SVG format. Example: 350.
#' @param named boolean (optional) Whether to print the color names on resulting image, only applicable on SVG format. Example: FALSE.
#' @param return_name_only boolean. if TRUE returns color name only
#'
#' @return A character string.
#'
#' @examples
#' \dontrun{
#' get_color_thecolorapi(hex = "0047AB")
#' get_color_thecolorapi(rgb = paste(0,71,171, sep = ","))
#' get_color_thecolorapi(hsl = paste("215","100%","34%", sep = ","))
#' get_color_thecolorapi(cmyk = paste(100,58,0,33, sep = ","))
#' }
#'
#' @export
get_color_thecolorapi <- function(hex = NULL, rgb = NULL, hsl = NULL, cmyk = NULL, format = "json", w = 100, named = TRUE, return_name_only = TRUE) {

  match.arg(arg = format, choices = c("json", "html", "svg"))

  if(!is.null(hex)) {
    resp <- httr2::request("https://www.thecolorapi.com") |>
      httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
      httr2::req_url_path("/id/?") |>
      httr2::req_url_query(`hex` = hex, `format` = format, `w` = w, `named` = named) |>
      httr2::req_perform() |>
      httr2::resp_body_json(simplifyVector = TRUE)
    resp
  }

  if(!is.null(rgb)) {
    resp <- httr2::request("https://www.thecolorapi.com") |>
      httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
      httr2::req_url_path("/id/?") |>
      httr2::req_url_query(`rgb` = rgb, `format` = format, `w` = w, `named` = named) |>
      httr2::req_perform() |>
      httr2::resp_body_json(simplifyVector = TRUE)
    resp
  }

  if(!is.null(hsl)) {
    resp <- httr2::request("https://www.thecolorapi.com") |>
      httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
      httr2::req_url_path("/id/?") |>
      httr2::req_url_query(`hsl` = hsl, `format` = format, `w` = w, `named` = named) |>
      httr2::req_perform() |>
      httr2::resp_body_json(simplifyVector = TRUE)
    resp
  }

  if(!is.null(cmyk)) {
    resp <- httr2::request("https://www.thecolorapi.com") |>
      httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
      httr2::req_url_path("/id/?") |>
      httr2::req_url_query(`cmyk` = cmyk, `format` = format, `w` = w, `named` = named) |>
      httr2::req_perform() |>
      httr2::resp_body_json(simplifyVector = TRUE)
    resp
  }

  # Warning if returns black (invalid) but different hex code
  if(identical(return_name_only, "Black")) {
    resp <- resp$colors$name$value
  }

  if(isTRUE(return_name_only)) {
    resp <- resp$name$value
  }
  resp
}

#' Get color scheme from thecolorapi.com API
#'
#' Return a generated scheme for the provided seed color and optional mode.
#' Color schemes are multi-color combinations chosen according to color-wheel relationsships.
#'
#' @param hex string (optional), Valid hex code.
#' @param rgb string (optional), Valid rgb color.
#' @param hsl string (optional), Valid hsl color.
#' @param cmyk string (optional) Valid cmyk color.
#' @param count integer (optional). Number of colors to return. Default: 5 Example: 6.
#' @param mode string (optional). Define mode by which to generate the scheme from the seed color. Example: "analogic".
#' @param format string (optional). Return results as JSON, SVG or HTML page. Example: "html".
#' @param w integer (optional). Height of resulting image, only applicable on SVG format. Example: 350.
#' @param named boolean (optional) Whether to print the color names on resulting image, only applicable on SVG format. Example: FALSE.
#' @param return_name_only boolean. if FALSE returns color name only
#'
#' @return A character vector.
#'
#' @examples
#' \dontrun{
#' get_color_thecolorapi_scheme(hex = "0047AB", count = 3, mode = "complement")
#' }
#'
#' @rdname get_color_thecolorapi_scheme
#'
#' @export
get_color_thecolorapi_scheme <- function(hex = NULL, rgb = NULL, hsl = NULL, cmyk = NULL, count = 5, mode = "monochrome", format = "json", w = 100, named = TRUE, return_name_only = TRUE) {

  match.arg(arg = format, choices = c("json", "html", "svg"))
  match.arg(arg = mode, choices = c("monochrome", "monochrome-dark", "monochrome-light", "analogic", "complement", "analogic-complement", "triad", "quad"))

  if(!is.null(hex)) {
    resp <- httr2::request("https://www.thecolorapi.com") |>
      httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
      httr2::req_url_path("/scheme/?") |>
      httr2::req_url_query(`hex` = hex, `count` = count, `mode` = mode, `format` = format, `w` = w, `named` = named) |>
      httr2::req_perform() |>
      httr2::resp_body_json(simplifyVector = TRUE)
    resp
  }

  if(!is.null(rgb)) {
    resp <- httr2::request("https://www.thecolorapi.com") |>
      httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
      httr2::req_url_path("/id/?") |>
      httr2::req_url_query(`rgb` = rgb, `count` = count, `mode` = mode, `format` = format, `w` = w, `named` = named) |>
      httr2::req_perform() |>
      httr2::resp_body_json(simplifyVector = TRUE)
    resp
  }

  if(!is.null(hsl)) {
    resp <- httr2::request("https://www.thecolorapi.com") |>
      httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
      httr2::req_url_path("/id/?") |>
      httr2::req_url_query(`hsl` = hsl, `count` = count, `mode` = mode, `format` = format, `w` = w, `named` = named) |>
      httr2::req_perform() |>
      httr2::resp_body_json(simplifyVector = TRUE)
    resp
  }

  if(!is.null(cmyk)) {
    resp <- httr2::request("https://www.thecolorapi.com") |>
      httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
      httr2::req_url_path("/id/?") |>
      httr2::req_url_query(`cmyk` = cmyk, `count` = count, `mode` = mode, `format` = format, `w` = w, `named` = named) |>
      httr2::req_perform() |>
      httr2::resp_body_json(simplifyVector = TRUE)
    resp
  }

  if(isTRUE(return_name_only)) {
    resp <- resp$colors$name$value
  }

  resp
}
