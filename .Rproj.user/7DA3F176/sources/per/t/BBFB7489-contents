
check_path(path = "viz", folder_name = "finalviz")
check_path(path = "viz/finalviz", folder_name = folder_name)

for (i in 1:length(range)) {
  
  # Load the two images to be overlaid
  img0 <- image_read(paste("viz/2D/", folder_name,"/legend_plot1_", gear_type, "_", range[i], "_.png", sep = ""))
  img1 <- image_read(paste("viz/2D/", folder_name,"/plot1_", gear_type, "_", range[i], "_.png", sep = ""))
  img2 <- image_read(paste("viz/3D/", folder_name,"/3Dplot_", gear_type, "_", range[i], "_.png", sep = ""))
  
  img0 = image_resize(img0, "80%") #80% fixed gear 75% other
  img1 = image_resize(img1, "50%")
  
  
  # composite the images as desired
  img3 <- image_composite(img2, img1, "over", offset = "+350+120")
  img4 <- image_composite(img3, img0, "over", offset = "+2000+1100")
  
  #image_write(img3, path = "viz/img3.png")
  #image_write(img4, path = "viz/img4.png")
  
  # Get the dimensions of the image
  img_width <- image_info(img4)$width
  img_height <- image_info(img4)$height
  
  # Set the crop dimensions
  crop_width <- img_width
  crop_height <- round(0.82 * img_height)
  
  # Crop the image
  img5 <- image_crop(img4, geometry = paste0("x", crop_height, "+0+0"))
  #image_write(img5, path = "viz/img5.png")
  
  img6 = img5
  
  font = "Bookman Old Style"
  anot = glue(paste("This visualization presents the fishing effort (hour) ", 
                    "by ", gear_type, " operations in The Grand Banks of Newfoundland", 
                    sep = "")) |>
    str_wrap(35)
  
  img6 |> 
    
    image_annotate(paste("Fishing effort map in Grand Banks, NL\n", 
                         sep = ""),
                   gravity = "northeast",
                   location = "+580+260",
                   color = text_color,
                   size = 180,
                   font = font,
                   weight = 500
    ) |>
    
    image_annotate(paste("Gear type: ", gear_type,"\n",
                         "Year: ", range[i], 
                         sep = ""),
                   gravity = "northeast",
                   location = "+580+580",
                   color = text_color,
                   size = 90,
                   font = font,
                   weight = 380
    ) |>
    
    image_annotate(anot,
                   gravity = "east",
                   location = "+280-280",
                   color = text_color,
                   font = font,
                   size = 80
    ) |> 
    image_annotate(glue("Graphic by Hoang Nguyen \n ",
                        "Data: globalfishingwatch.org"),
                   gravity = "southwest",
                   location = "+500+100",
                   font = font,
                   color = alpha(text_color, .5),
                   size = 69
    ) |> 
    image_write(paste("viz/finalviz/", folder_name,"/final_img_", gear_type, "_", range[i], "_.png", sep = ""))
  
}


# --------------------- CHECK EXECUTION DONE ----------------------- #
file.create("log/markup_execution_done.txt")
cat(paste(gear_type, "\n"), file = "log/markup_execution_done.txt", append = TRUE)

