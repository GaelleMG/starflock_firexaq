filenames = c("FIREXAQ-AMS_DC8_20190724_R2", "FIREXAQ-AMS_DC8_20190725_R2", "FIREXAQ-AMS_DC8_20190729_R3", "FIREXAQ-AMS_DC8_20190730_R2", "FIREXAQ-AMS_DC8_20190802_R3", "FIREXAQ-AMS_DC8_20190803_R2", "FIREXAQ-AMS_DC8_20190806_R3", "FIREXAQ-AMS_DC8_20190807_R3", "FIREXAQ-AMS_DC8_20190808_R2", "FIREXAQ-AMS_DC8_20190812_R2", "FIREXAQ-AMS_DC8_20190813_R2", "FIREXAQ-AMS_DC8_20190815_R2", "FIREXAQ-AMS_DC8_20190816_R3", "FIREXAQ-AMS_DC8_20190819_R2", "FIREXAQ-AMS_DC8_20190821_R3", "FIREXAQ-AMS_DC8_20190823_R3", "FIREXAQ-AMS_DC8_20190826_R3", "FIREXAQ-AMS_DC8_20190829_R3", "FIREXAQ-AMS_DC8_20190830_R3", "FIREXAQ-AMS_DC8_20190831_R3", "FIREXAQ-AMS_DC8_20190903_R3", "FIREXAQ-AMS_DC8_20190905_R2")
filename = ""

FIREXAQ_AMS_DC8_all_data = read.csv("/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2022/data/WWW-AIR_1664426457975/FIREXAQ-AMS_DC8_20190722_R2_df.csv", head = TRUE)
FIREXAQ_AMS_DC8_all_data <- FIREXAQ_AMS_DC8_all_data %>% mutate(mission = "FIREXAQ-AMS_DC8_20190722_R2")


print("above combine_data fn")


combine_data <- function(filename){
	filename = filename
	filename_csv = paste(filename, "_df.csv", sep = "")

	FIREXAQ_AMS_DC8_temp = read.csv(paste("/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2022/data/WWW-AIR_1664426457975/",filename_csv, sep = ""), head = TRUE)

	FIREXAQ_AMS_DC8_temp <- FIREXAQ_AMS_DC8_temp %>% mutate(mission = filename)
	print(filename)

	FIREXAQ_AMS_DC8_all_data = rbind(FIREXAQ_AMS_DC8_all_data, FIREXAQ_AMS_DC8_temp)
	
	return (FIREXAQ_AMS_DC8_all_data)

}



for(filename in filenames){
	FIREXAQ_AMS_DC8_all_data <- combine_data(filename)
	print(dim(FIREXAQ_AMS_DC8_all_data))
}

# print(dim(FIREXAQ_AMS_DC8_all_data))