#' Get color name from color.pizza API
#'
#' Rest API that returns a bunch of color names for a given color-value.
#'
#' @param hex character. Hex color code
#' @param list character. An available Color Name List.
#' @param noduplicates boolean. if TRUE remove duplicates
#' @param return_name_only boolean. if TRUE returns color name only
#'
#' @source \url{https://github.com/meodai/color-name-api}
#'
#' @return A character string.
#'
#' @examples
#' \dontrun{
#' get_color_colorpizza(
#'   hex = c("#3D290C","#1c2f11","#2e3f24"),
#'   list = "wikipedia",
#'   noduplicates = TRUE)
#' }
#'
#' @export
get_color_colorpizza <- function(hex, list = NULL, noduplicates = FALSE, return_name_only = TRUE) {

  #remove '#' symbol if exists in hex argument
  hexCode <- sub("#", "", hex)

  resp <- httr2::request("https://api.color.pizza/v1/") |>
    httr2::req_user_agent("colornames R package (https://github.com/lgnbhl/colornames)") |>
    httr2::req_url_query(`values` = paste(hexCode, collapse = ","), `list` = list, `noduplicates` = noduplicates) |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE)

  resp <- resp$colors

  if(isTRUE(return_name_only)) {
    resp <- resp$name
  }
  resp
}
