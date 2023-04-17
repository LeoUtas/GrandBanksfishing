

# --------------------- FUNCTION make_landmark_point() ---------------------- #
make_landmark_point = function(coords, title) {
  
  coords = coords
  landmark = data.frame("lat" = coords[1], "long" = coords[2], "title" = title)
  
  return(landmark)
  
}


# --------------------- FUNCTION make_legend_piece() for making the graphic --------------------- #
render_2Dgraphic_pieces = function(V_ls,
                                   n_loop, 
                                   effort_data,
                                   range,
                                   n_breaks,
                                   selected_region,
                                   legend_title = "Fishing hour",
                                   plot_title = "",
                                   texture = texture,
                                   pooled_scale = FALSE,
                                   height = 4290,
                                   text_color,
                                   landmark,
                                   path = "viz/2D/"
                                   ) {
  
  {
    V_ls = V_ls
    n_loop = n_loop
    effort_data = effort_data
    n_breaks = n_breaks
    selected_region = selected_region
    legend_title = legend_title
    plot_title = plot_title
    texture = texture
    pooled_scale = pooled_scale
  }
  
  
  # -----------------  SET UP FOR 2D PLOTS ------------------ #
  # call the function make_tri_map()
  Tri_plot_ls = make_tri_map(data = V_ls,
                             n_loop = n_loop,
                             effort_data = effort_data,
                             n_breaks = 3,
                             selected_region = selected_region,
                             gear_type = gear_type,
                             legend_title = "Fishing hour",
                             plot_title = "",
                             texture = texture,
                             pooled_scale = FALSE
                             )  
  
  # Create plot1 as side plot of the visualization
  {
    landmark = landmark
    plot1 = list()
    plot1.1 = list()
    legend = list()
    text_color = text_color
    height = height
  }
  
  
  check_path(path = path, folder_name = folder_name)
  
  
  for (i in 1:length(range)) {
    
    plot1[[i]] = Tri_plot_ls[[i]] + 
      
      geom_point(data = landmark, aes(x = lat,
                                      y = long),
                 size = 1.5,
                 color = text_color
      ) +
      
      geom_text(data = landmark, aes(x = lat, 
                                     y = long, 
                                     label = title),
                size = 12,
                color = text_color,
                nudge_x = 0.01, 
                nudge_y = .28) +
      
      labs(title = NULL) +
      theme(axis.title.x = element_blank(), 
            axis.title.y = element_blank(),
            plot.background = element_rect(fill = "white"),
            legend.direction = "vertical",
            legend.position = "right",
            legend.box = "vertical",
            legend.margin = margin(t = 10, r = 10, b = 10, l = 10),
            legend.text.align = 0,
            legend.title.align = 0,
            legend.text = element_text(size = 18, colour = text_color),
            legend.box.background = element_rect(fill = "white", color = "white"),
            legend.title = element_text(size = 22, color = text_color)
      )
    
    legend[[i]] <- get_legend(plot1[[i]])
    
    plot1.1[[i]] = plot1[[i]] + theme(legend.position = "none")
    
    # handle image dimensions
    ratio = handle_dimensions(plot = plot1.1[[i]])
    width = height / ratio
    
    ggsave(paste(path, folder_name, "/plot1_", gear_type, "_", colnames(effort_data)[i], "_.png", sep = ""), 
           plot = plot1.1[[i]], 
           width = width/(300*1.2), 
           height = height/300, 
           dpi = 300,
           bg = "white")
    
    ggsave(paste(path, folder_name, "/legend_plot1_", gear_type, "_", colnames(effort_data)[i], "_.png", sep = ""), 
           plot = legend[[i]], 
           width = width/(300*5), 
           height = height/(300*5), 
           dpi = 300,
           bg = "white")
  }
  
  cat(crayon::cyan(paste("2D plots were successfully rendered and saved to pieces folder \n", sep = "")))
  
}

