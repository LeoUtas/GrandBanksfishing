rm(list = ls())

{
  #load required packages
  if(!require(pacman)) install.packages("pacman")
  pacman::p_load(fishingvizr, 
                 MetBrewer, 
                 colorspace, 
                 INLA, 
                 magrittr, 
                 dplyr, 
                 raster, 
                 sf, 
                 stars,
                 rayshader,
                 ggplot2,
                 magick,
                 cowplot,
                 glue,
                 stringr)
  source("handyfuncs.R") # load the handy functions
}

get_backto_WD()


# set up 
{
  begin = 2012
  end = 2022
  range = c(begin : end)
  selected_regions = c("21.3.L", "21.3.N", "21.3.O")
  gear_type_code = read.csv("gear_type_code.txt")
  
  gear_type = gear_type_code[1,1] ###
  
  GFW_TOKEN = readLines("GFW_TOKEN.txt", n = 1)
  
  folder_name = gear_type
  
  color <- met.brewer("OKeeffe2")
  text_color = darken(color[7], .5)
  #swatchplot(text_color)  # view the color
}

# set up for calling make_tri_mesh()/ read the documentation for details
# the three variables define the number of triangles
{ 
  convex = 0.25 #0.25
  cutoff = 0.2 #0.2 0.1 0.05 0.02 0.01
  lok_center = 2000 #1000 2000
}

# execute files
source("dataprep.R") # to prepare required data for rendering the plots

# set up for rendering 3D plot
{
  lightcolor = color[2] 
  lightdirection = 315
  lightaltitude = c(20, 80)
  lightintensity = c(600, 100)
  samples = 550
  width = 6000
  height = 6000
  
  load(file = paste("data/effort_", gear_type, "_", begin, end, "_.RData", sep = ""))
  load(file = paste("data/TriList_ls_", gear_type, "_", begin, end, "_.RData", sep = ""))
}
# to render all the plot pieces for making the final graphic
# WARNING: rendering 3d graphics is expected to take a huge amount of time
source("dataviz.R") 







source("markup.R") 




