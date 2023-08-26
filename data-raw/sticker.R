## Making a hex sticker for colornames
library(hexSticker)
library(magick)
library(magrittr)
library(showtext)

font_add_google("Open Sans")
## Automatically use showtext to render text
showtext_auto()

blue_pal <- rev(scales::brewer_pal(palette = "Blues")(8))
# Function for plotting colors side-by-side
# https://www.r-bloggers.com/2013/02/the-paul-tol-21-color-salute/
pal <- function(col, border = "light gray", ...){
  n <- length(col)
  plot(0, 0, type="n", xlim = c(0, 1), ylim = c(0, 1),
       axes = FALSE, xlab = "", ylab = "", ...)
  rect(0:(n-1)/n, 0, 1:n/n, 1, col = col, border = border)
}

pal(col = blue_pal)

hexSticker::sticker("data-raw/pal-blues.png",
                    s_x = 1,
                    s_y = 0.75,
                    s_width = 0.55,
                    package = "colornames",
                    p_color = "#08519C",
                    p_family = "Open Sans",
                    p_size = 21,
                    p_y = 1.3,
                    spotlight = FALSE,
                    l_x = 1,
                    l_y = 1,
                    l_height = 4,
                    l_width = 4,
                    l_alpha = 0.3,
                    h_size = 1.5,
                    h_color = "#08519C",
                    h_fill = "white",
                    filename="man/figures/logo.png")

# MOD with Gimp: removing red borders.

logo <- magick::image_read("man/figures/logo.png")
magick::image_scale(logo, "400") |>
  magick::image_write(path = "man/figures/logo.png", format = "png")

