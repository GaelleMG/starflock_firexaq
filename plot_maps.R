nasa_data <- read.csv("/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2022/data/WWW-AIR_1664426457975/FIREXAQ-AMS_DC8_all_data_df.csv", head = TRUE)

PM1_AMS <- c("OA_PM1_AMS", "Sulfate_PM1_AMS", "Nitrate_PM1_AMS", "Ammonium_PM1_AMS", "NR_Chloride_PM1_AMS", "Potassium_PM1_AMS", "MSA_PM1_AMS", "ClO4_PM1_AMS", "Iodine_PM1_AMS", "Bromine_PM1_AMS", "Seasalt_PM1_AMS", "AmmBalance_PM1_AMS", "OtoC_Ratio_PM1_AMS", "HtoC_Ratio_PM1_AMS", "OAtoOC_PM1_AMS", "OSc_PM1_AMS", "OrgNitrFraction_PM1_AMS", "f43_PM1_AMS", "f44_PM1_AMS", "f57_PM1_AMS", "f60_PM1_AMS", "f82_PM1_AMS", "f91_PM1_AMS", "fC2H3O_PM1_AMS", "fCO2_PM1_AMS", "fC4H9_PM1_AMS", "fC2H4O2_PM1_AMS", "fC5H6O_PM1_AMS", "fC7H7_PM1_AMS")

nasa_data <- nasa_data %>% filter(across(where(is.numeric), ~ .x != -9999)) %>% filter(across(where(is.numeric), ~ .x != -8888))

nasa_data_per_OAden <- nasa_data %>% mutate(across(all_of(PM1_AMS), ~ . / OADensity_PM1_AMS, .names = "{col}_per_OAden"))

nasa_data_per_OAden_gather <- nasa_data_per_OAden %>% gather(key = "component", value = "measurement", -c(Time_Start, Time_Stop, Time_Mid, ALT_AMS, LAT_AMS, LON_AMS, mission, Density_PM1_AMS, OADensity_PM1_AMS)) 



plot_maps <- function(aerosol){
	
	aerosol_per_OAden = paste(aerosol,"_per_OAden", sep = "")
	aerosol_legend = paste(aerosol_per_OAden, " (log)")
	
	ggplot(data = world) + geom_sf(lwd = 0.2, color = rgb(156, 156, 156, maxColorValue = 255), alpha = 0.6) + coord_sf(xlim = c(-123, -69), ylim = c(26, 49)) + geom_point(data = subset(nasa_data_per_OAden_gather, component == aerosol_per_OAden), aes(x = LON_AMS, y = LAT_AMS, color = measurement), size = 0.1, alpha = 0.5) + scale_color_viridis_c(option = "plasma") + labs(title = "FIREX-AQ: DC8 Flight Tracks", y = "Latitude (degrees)", x = "Longitude (degrees)", color = aerosol_legend)
	
	ggsave(paste(aerosol,".png", sep = ""), device = "png", dpi = "retina", width = 3000, height = 2000, units = "px", path = "/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2022/plots/")



}





for(PM1_AMS_measurement in PM1_AMS){
	plot_maps(PM1_AMS_measurement)
}