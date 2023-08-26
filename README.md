
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Overview

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/colornames)](https://CRAN.R-project.org/package=colornames)
<!-- badges: end -->

The **colornames** R package aims to convert color values into color
names using various APIs:

- *[www.thecolorapi.com](https://www.thecolorapi.com)*: pass in any
  valid color and get conversion into any other format, the name of the
  color, placeholder images and a multitude of schemes.

- *[colornames.org](https://colornames.org)*: a collaborative effort to
  name every color in the RGB/web space. You can [name a random
  color](https://colornames.org/random/) or vote from some [incoming
  color names](https://colornames.org/fresh/).

- *[color.pizza](https://github.com/meodai/color-name-api)*: Rest API
  that returns a bunch of color names for a given color-value.

## Installation

``` r
install.packages("colornames")

#install.packages("devtools")
devtools::install_github("lgnbhl/colornames") # from GitHub
```

## Minimal examples

``` r
library(colornames)
```

Color name using thecolorapi’s API.

``` r
get_color_thecolorapi(hex = "#0047AB")
#> [1] "Cobalt"
```

Color name using colornames’s API.

``` r
get_color_colornames(hex = "#0047AB")
#> [1] "Cobalt Blue"
```

Color name using color.pizza’s API.

``` r
get_color_colorpizza(hex = "#0047AB")
#> [1] "Soulstone Blue"
```

## thecolorapi.com API

Call `get_color_thecolorapi()` to get the closest color name available
of a hex code.

``` r
get_color_thecolorapi(hex = "#0047AB")
#> [1] "Cobalt"
```

The “thecolorapi.com” API return a list of variables about a given color
name, by using `return_name_only = FALSE`.

``` r
col1 <- get_color_thecolorapi(hex = "#0047AB", return_name_only = FALSE)

str(col1, max.level = 1)
#> List of 11
#>  $ hex      :List of 2
#>  $ rgb      :List of 5
#>  $ hsl      :List of 5
#>  $ hsv      :List of 5
#>  $ name     :List of 4
#>  $ cmyk     :List of 6
#>  $ XYZ      :List of 5
#>  $ image    :List of 2
#>  $ contrast :List of 1
#>  $ _links   :List of 1
#>  $ _embedded: Named list()
```

You can create a data.frame from this list.

``` r
as.data.frame(col1[1:9])
#>   hex.value hex.clean rgb.fraction.r rgb.fraction.g rgb.fraction.b rgb.r rgb.g
#> 1   #0047AB    0047AB              0      0.2784314      0.6705882     0    71
#>   rgb.b       rgb.value hsl.fraction.h hsl.fraction.s hsl.fraction.l hsl.h
#> 1   171 rgb(0, 71, 171)      0.5974659              1      0.3352941   215
#>   hsl.s hsl.l           hsl.value hsv.fraction.h hsv.fraction.s hsv.fraction.v
#> 1   100    34 hsl(215, 100%, 34%)      0.5974659              1      0.6705882
#>             hsv.value hsv.h hsv.s hsv.v name.value name.closest_named_hex
#> 1 hsv(215, 100%, 67%)   215   100    67     Cobalt                #0047AB
#>   name.exact_match_name name.distance cmyk.fraction.c cmyk.fraction.m
#> 1                  TRUE             0               1       0.5847953
#>   cmyk.fraction.y cmyk.fraction.k           cmyk.value cmyk.c cmyk.m cmyk.y
#> 1               0       0.3294118 cmyk(100, 58, 0, 33)    100     58      0
#>   cmyk.k XYZ.fraction.X XYZ.fraction.Y XYZ.fraction.Z       XYZ.value XYZ.X
#> 1     33      0.2206082      0.2475506      0.6705831 XYZ(22, 25, 67)    22
#>   XYZ.Y XYZ.Z                                                       image.bare
#> 1    25    67 https://www.thecolorapi.com/id?format=svg&named=false&hex=0047AB
#>                                            image.named   value
#> 1 https://www.thecolorapi.com/id?format=svg&hex=0047AB #ffffff
```

You can get color names from different color convention, i.e. `rgb`,
`hsl` or `cmyk`.

``` r
get_color_thecolorapi(rgb = paste(3,60,71, sep = ","))
#> [1] "Blue Whale"
get_color_thecolorapi(hsl = paste("100","100%","34%", sep = ","))
#> [1] "Limeade"
get_color_thecolorapi(cmyk = paste(50,58,0,33, sep = ","))
#> [1] "Plump Purple"
```

You can get color names from an existing list of colors using the
closest named hex available.

``` r
library(scales)
library(purrr)

pal_hue <- scales::brewer_pal()(6)

pal_names <- purrr::map_chr(.x = pal_hue, .f = get_color_thecolorapi)

data.frame(
  hex = pal_hue,
  name = pal_names
)
#>       hex           name
#> 1 #EFF3FF         Zircon
#> 2 #C6DBEF        Spindle
#> 3 #9ECAE1 Regent St Blue
#> 4 #6BAED6     Aqua Pearl
#> 5 #3182BD          Denim
#> 6 #08519C    Venice Blue
```

You can also get a color scheme (color palette) from any color.

``` r
pal <- get_color_thecolorapi_scheme(
  hex = "0047AB", 
  count = 5, 
  mode = "monochrome", 
  return_name_only = FALSE)

#get closed color name available
# data.frame(
#   hex = pal$colors$hex$value,
#   name = pal$colors$name$value
# )

pal$colors$hex
#>     value  clean
#> 1 #01122A 01122A
#> 2 #02285D 02285D
#> 3 #023D8F 023D8F
#> 4 #0252C3 0252C3
#> 5 #0167F6 0167F6
```

**Note that when an invalid color name is used, the API return
“\#000000” (black color).**

``` r
get_color_thecolorapi(hex = "InvalidColorReturnsBlack")
#> [1] "Black"
```

## colornames.org API

``` r
get_color_colornames(hex = "3D290C")
#> [1] "Swiss Dark Chocolate"
```

The function `get_color_colornames()` can also return a dataframe using
`return_name_only = FALSE`.

**Note that the API returns hex codes as pure numbers, without a
starting hashtag “\#”**

``` r
df <- get_color_colornames(hex = "3D290C", return_name_only = FALSE)
#add "#" back in beginning of each hex code
df$hex <- paste0("#", df$hex)
df
#>   hexCode                 name     hex
#> 1  3d290c Swiss Dark Chocolate #3d290c
```

Hex codes should **always** have 6 characters:

``` r
get_color_colornames(hex = "440154FF")
```

    # Error: Hex code 440154FF has 8 characters. 
    # Hex code should have 6 characters.

You an also get an random color name:

``` r
get_color_colornames_random(return_name_only = FALSE)
#>   hexCode                 name
#> 1  92f861 Green Alien Number B
```

You can explore the latest 100 submissions:

``` r
latest_100 <- get_color_colornames_latest(return_name_only = FALSE)

head(latest_100)
#>    nameId hexCode            name
#> 1 5192739  7a0113      Jude's Red
#> 2 5192738  896446      Dirt Brown
#> 3 5192737  94c0ce    Blueish Gray
#> 4 5192736  f30e83 Neon Bight Pink
#> 5 5192735  b3ab7d    Coffee Badge
#> 6 5192734  6475bc  Discord Attire
```

You can loop to get color names of a given palette:

``` r
library(scales)
library(purrr)

pal_hue <- scales::brewer_pal()(6)
pal_names <- purrr::map_chr(.x = pal_hue, .f = get_color_colornames)

data.frame(
  hex = pal_hue,
  name = pal_names
)
#>       hex                name
#> 1 #EFF3FF When I Remember You
#> 2 #C6DBEF    Cloud Initiation
#> 3 #9ECAE1                <NA>
#> 4 #6BAED6                <NA>
#> 5 #3182BD                <NA>
#> 6 #08519C                <NA>
```

If color names are missing (like above), you can choose to [give them a
name](https://colornames.org/random/).

If for some reason you want to use this color names database into
production, you should be aware that the color names are potentially
changing as [anyone can vote](https://colornames.org/fresh/) anytime to
change any color name. Therefore you should download a copy of the
colornames database at a given time.

You can download the complete data and use it locally.

``` r
url_data <- "https://colornames.org/download/colornames.zip"
your_file_path <- paste0(getwd(), "/colornames-", Sys.Date(), ".zip")
download.file(url = url_data, destfile = your_file_path)
colornames_df <- readr::read_csv(your_file_path)

# Joke with hex codes 00000 to 00003
colornames_df
```

    # # A tibble: 3,157,757 × 3
    #    hex bestName                     votes
    #    <chr>   <chr>                        <dbl>
    #  1 000000  Dude Turn The Lights Back On  5351
    #  2 000001  It's Still Basically Black     729
    #  3 000002  Still Black                    121
    #  4 000003  So Close To Black It Hurts     145
    #  5 000004  Blackerererer                   27
    #  6 000005  Jet Black Heart                 16
    #  7 000006  Abaddon                         16
    #  8 000007  Double O Seven                  56
    #  9 000008  Closed Eyes                     26
    # 10 000009  Really Dark Blue                29
    # # ℹ 3,157,747 more rows

This [downloadable data](https://colornames.org/download/) is totally
free of rights, under [CC0
1.0](https://creativecommons.org/publicdomain/zero/1.0/).

## color.pizza API

The color.pizza database is more stable as it is modified only by its
core contributors.

You can get the name of of the closest color name with
`get_color_colorpizza()`.

``` r
get_color_colorpizza(hex = "#3D290C")
#> [1] "Black Swan"
```

You can access different information about a given color using
`return_name_only = FALSE`.

``` r
get_color_colorpizza(hex = "#3D290C", return_name_only = FALSE)
#>         name     hex rgb.r rgb.g rgb.b hsl.h hsl.s hsl.l   lab.l   lab.a
#> 1 Black Swan #332200    51    34     0    40   100    10 14.8627 5.70118
#>      lab.b luminance luminanceWCAG bestContrast
#> 1 21.82334   25.1168       0.01848        white
#>                           swatchImg.svgNamed            swatchImg.svg
#> 1 /v1/swatch/?color=3d290c&name=Black%20Swan /v1/swatch/?color=3d290c
#>   requestedHex distance
#> 1      #3d290c  2.90889
```

You can get the color names from a unique source with “list” argument
and avoid duplicated colors with “noduplicates”.

``` r
get_color_colorpizza(
  hex = c("#3D290C","#1c2f11","#2e3f24"),
  list = "wikipedia",
  noduplicates = TRUE,
  return_name_only = FALSE)
#>            name     hex
#> 1     Café Noir #4b3621
#> 2 Phthalo Green #123524
#> 3   Kombu Green #354230
#>                                                           link rgb.r rgb.g
#> 1  https://en.wikipedia.org/wiki/Coffee_(color)#Caf%C3%A9_Noir    75    54
#> 2         https://en.wikipedia.org/wiki/Phthalocyanine_Green_G    18    53
#> 3 https://en.wikipedia.org/wiki/Chartreuse_(color)#Kombu_green    53    66
#>   rgb.b hsl.h    hsl.s    hsl.l    lab.l     lab.a    lab.b luminance
#> 1    33    30 38.88889 21.17647 24.64653   7.52734 17.00318  39.01021
#> 2    36   151 49.29577 13.92157 19.19804 -16.97218  6.79941  31.83870
#> 3    48   103 15.78947 22.35294 26.38109  -8.54020  9.18584  42.21389
#>   luminanceWCAG bestContrast                             swatchImg.svgNamed
#> 1       0.04244        white /v1/swatch/?color=3d290c&name=Caf%C3%A9%20Noir
#> 2       0.02802        white  /v1/swatch/?color=1c2f11&name=Phthalo%20Green
#> 3       0.04867        white    /v1/swatch/?color=2e3f24&name=Kombu%20Green
#>              swatchImg.svg requestedHex distance
#> 1 /v1/swatch/?color=3d290c      #3d290c  5.21463
#> 2 /v1/swatch/?color=1c2f11      #1c2f11  7.07137
#> 3 /v1/swatch/?color=2e3f24      #2e3f24  4.03246
```

You can get color names from an existing list of colors using the
closest named hex available.

``` r
library(purrr)
library(scales)

pal_hue <- scales::brewer_pal()(6)
pal_hue_names <- get_color_colorpizza(hex = pal_hue)

data.frame(
  hex = pal_hue,
  name = pal_hue_names
)
#>       hex                 name
#> 1 #EFF3FF        Coconut White
#> 2 #C6DBEF          Arctic Rain
#> 3 #9ECAE1          Legacy Blue
#> 4 #6BAED6 Broom Butterfly Blue
#> 5 #3182BD          King Triton
#> 6 #08519C           USAFA Blue
```
