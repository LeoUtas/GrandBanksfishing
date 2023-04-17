#rm(list = ls())

# call the get_rasters() to retrieve fishing effort data from GFW API
data = get_rasters(begin = begin, end = end,
                   selected_region = selected_regions,
                   gear_type = gear_type,
                   key = GFW_TOKEN)

if (nrow(data) != 0) {
  
  sumdata = make_sumdata(data = data)
  # save the data
  save(data,
       sumdata,
       file = paste("data/effort_", gear_type, "_", begin, end, "_.RData", sep = ""))
  #load(file = paste("data/effort_", gear_type, "_", begin, end, "_.RData", sep = ""))
  
  
  # set up for calling make_tri_mesh()
  { 
    convex = convex #0.25
    cutoff = cutoff #0.2 0.1 0.05 0.02 0.01
    lok_center = lok_center #1000 2000
  }
  
  # call the make_tri_mesh function to create TriList and update the sumdata
  # this process is expected to take a huge of time, depending on the number of data points and the number of triangles
  TriList_ls = make_tri_mesh(convex = convex, cutoff = cutoff, lok_center = lok_center, data = sumdata)
  
  
  # set up for calling make_tri_map()
  {
    updated_sumdata = TriList_ls[[1]]
    TriList = TriList_ls[[2]]
    
    V_ls = list(TriList$V0,
                TriList$V1,
                TriList$V2)
    
    n_loop = length(TriList$Tri_Area)
    n_breaks = 3
    effort_data = as.matrix(make_effortdens_rt(data = updated_sumdata, Tri_Area = TriList$Tri_Area))
    texture <- grDevices::colorRampPalette(color, bias = 2)(256)
    # swatchplot(texture)  # plot texture
  }
  
  # save the data
  save(updated_sumdata,
       TriList,
       V_ls,
       TriList_ls,
       n_loop,
       n_breaks,
       effort_data,
       texture,
       cutoff,
       convex,
       lok_center,
       file = paste("data/TriList_ls_", gear_type, "_", begin, end, "_.RData", sep = ""))
  #load(file = paste("data/TriList_ls_", gear_type, "_", begin, end, "_.RData", sep = ""))
  
  # call the function make_tri_map()
  Tri_plot_ls = make_tri_map(data = V_ls,
                             n_loop = n_loop,
                             effort_data = effort_data,
                             n_breaks = n_breaks,
                             selected_region = selected_regions,
                             gear_type = gear_type,
                             legend_title = "Fishing hour\n",
                             plot_title = "Commercial fishing effort in",
                             texture = texture,
                             pooled_scale = FALSE
  )
  
} else {
  cat(crayon::cyan(paste("\n", gear_type, " is not valid for either the selected regions or the time range"), sep = ""))
}


# --------------------- CHECK EXECUTION DONE ----------------------- #
file.create("log/dataprep_execution_done.txt")
cat(paste(gear_type, "\n"), file = "log/dataprep_execution_done.txt", append = TRUE)
