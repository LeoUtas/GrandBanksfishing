

# --------------------------- 2D PIECE RENDERING ----------------------------- #
# provide coordinates for the landmark St. John's
{
  coords = c(-52.712830, 47.560539)
  title = "St. John's"
}
# create a landmark for mapping
landmark = make_landmark_point(coords = coords, title = title)

# prepare 2D pieces for making the graphic
render_2Dgraphic_pieces(V_ls = V_ls,
                        n_loop = n_loop, 
                        effort_data = effort_data, 
                        range = range,
                        n_breaks = n_breaks,
                        selected_region = selected_regions,
                        legend_title = "Fishing hour",
                        plot_title = "",
                        texture = texture,
                        pooled_scale = FALSE,
                        height = 4290,
                        text_color = text_color,
                        landmark = landmark
)


# --------------------------- 3D PIECE RENDERING ----------------------------- #
#load(file = paste("data/effort_", gear_type, "_", begin, end, "_.RData", sep = ""))
#load(file = paste("data/TriList_ls_", gear_type, "_", begin, end, "_.RData", sep = ""))
#new_range = c(2012:2016) # length(new_range) = the number of 3D plots expected to be rendered
#range = new_range 


# prepare 3D pieces for making the graphic
render_3dplot(range = range, Tri_plot_ls2 = Tri_plot_ls, 
              lightcolor = color[2], 
              lightdirection = lightdirection,
              lightaltitude = lightaltitude,
              lightintensity = lightintensity,
              samples = samples,
              width = width, height = height,
              gear_type = gear_type
)


# --------------------- CHECK EXECUTION DONE ----------------------- #
file.create("log/dataviz_execution_done.txt")
cat(paste(gear_type, "\n"), file = "log/dataviz_execution_done.txt", append = TRUE)

