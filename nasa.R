filenames = c("FIREXAQ-AMS_DC8_20190722_R2", "FIREXAQ-AMS_DC8_20190724_R2", "FIREXAQ-AMS_DC8_20190725_R2", "FIREXAQ-AMS_DC8_20190729_R3", "FIREXAQ-AMS_DC8_20190730_R2", "FIREXAQ-AMS_DC8_20190802_R3", "FIREXAQ-AMS_DC8_20190803_R2", "FIREXAQ-AMS_DC8_20190806_R3", "FIREXAQ-AMS_DC8_20190807_R3", "FIREXAQ-AMS_DC8_20190808_R2", "FIREXAQ-AMS_DC8_20190812_R2", "FIREXAQ-AMS_DC8_20190813_R2", "FIREXAQ-AMS_DC8_20190815_R2", "FIREXAQ-AMS_DC8_20190816_R3", "FIREXAQ-AMS_DC8_20190819_R2", "FIREXAQ-AMS_DC8_20190821_R3", "FIREXAQ-AMS_DC8_20190823_R3", "FIREXAQ-AMS_DC8_20190826_R3", "FIREXAQ-AMS_DC8_20190829_R3", "FIREXAQ-AMS_DC8_20190830_R3", "FIREXAQ-AMS_DC8_20190831_R3", "FIREXAQ-AMS_DC8_20190903_R3", "FIREXAQ-AMS_DC8_20190905_R2")
filename = ""




plot_airborne_data <- function(filename){
filename = filename
filename_csv = paste(filename, "_df.csv", sep = "")
filename_title = paste(filename, ")", sep = "")

nasa <- read.csv(paste("/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2022/data/WWW-AIR_1664426457975/", filename_csv, sep = ""), head = TRUE)

nasa_data <- nasa %>% select(-OA_prec_PM1_AMS, -OA_DL_PM1_AMS, -Sulfate_prec_PM1_AMS, -Sulfate_DL_PM1_AMS, -Nitrate_prec_PM1_AMS, -Nitrate_DL_PM1_AMS, -Ammonium_prec_PM1_AMS, -Ammonium_DL_PM1_AMS, -NR_Chloride_prec_PM1_AMS, -NR_Chloride_DL_PM1_AMS, -Potassium_prec_PM1_AMS, -Potassium_DL_PM1_AMS, -MSA_prec_PM1_AMS, -MSA_DL_PM1_AMS, -ClO4_prec_PM1_AMS, -ClO4_DL_PM1_AMS, -Iodine_prec_PM1_AMS, -Iodine_DL_PM1_AMS, -Bromine_prec_PM1_AMS, -Bromine_DL_PM1_AMS, -Seasalt_prec_PM1_AMS, -Seasalt_DL_PM1_AMS, -SDDataFlag_AMS, -CloudFlag_AMS, -Flowrate_AMS, -StdtoVol_AMS, -InletRH_AMS)

PM1_AMS <- c("OA_PM1_AMS", "Sulfate_PM1_AMS", "Nitrate_PM1_AMS", "Ammonium_PM1_AMS", "NR_Chloride_PM1_AMS", "Potassium_PM1_AMS", "MSA_PM1_AMS", "ClO4_PM1_AMS", "Iodine_PM1_AMS", "Bromine_PM1_AMS", "Seasalt_PM1_AMS", "AmmBalance_PM1_AMS", "OtoC_Ratio_PM1_AMS", "HtoC_Ratio_PM1_AMS", "OAtoOC_PM1_AMS", "OSc_PM1_AMS", "OrgNitrFraction_PM1_AMS", "f43_PM1_AMS", "f44_PM1_AMS", "f57_PM1_AMS", "f60_PM1_AMS", "f82_PM1_AMS", "f91_PM1_AMS", "fC2H3O_PM1_AMS", "fCO2_PM1_AMS", "fC4H9_PM1_AMS", "fC2H4O2_PM1_AMS", "fC5H6O_PM1_AMS", "fC7H7_PM1_AMS")

nasa_data <- nasa_data %>% filter(across(where(is.numeric), ~ .x != -9999)) %>% filter(across(where(is.numeric), ~ .x != -8888))

nasa_data_gather <- nasa_data %>% keep(is.numeric) %>% gather(key = "component", value = "measurement", -c(Time_Start, Time_Stop, Time_Mid, ALT_AMS, LAT_AMS, LON_AMS, Density_PM1_AMS, OADensity_PM1_AMS))
 
nasa_data_per_OAden <- nasa_data %>% mutate(across(all_of(PM1_AMS), ~ . / OADensity_PM1_AMS, .names = "{col}_per_OAden"))
 
nasa_data_per_OAden_gather <- nasa_data_per_OAden %>% keep(is.numeric) %>% gather(key = "component", value = "measurement", -c(Time_Start, Time_Stop, Time_Mid, ALT_AMS, LAT_AMS, LON_AMS, Density_PM1_AMS, OADensity_PM1_AMS)) 

nasa_data_per_OAden_gather %>% filter(str_detect(component, 'per_OAden')) %>% ggplot(aes(x = ALT_AMS, y = measurement, color = OADensity_PM1_AMS)) + facet_wrap(~ component, scales = "free") + geom_point(size = 0.1) + theme_bw() + theme(strip.text.x = element_text(size = 5), axis.text = element_text(size = 5), panel.grid = element_blank()) + labs(title = paste("FIREX-AQ: Aersols by Altitude (data:WWW-AIR_1664426457975/",filename_title), y = "Units per Organic Aerosol Density (relative measure)", x = "Altitude (meters)", color = "Organic Aerosol\nDensity (g/m3)")

ggsave(paste(filename,".png", sep = ""), device = "png", dpi = "retina", width = 3000, height = 2000, units = "px", path = "/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2022/plots/WWW-AIR_1664426457975")
}

for(filename in filenames){
	plot_airborne_data(filename)
}
