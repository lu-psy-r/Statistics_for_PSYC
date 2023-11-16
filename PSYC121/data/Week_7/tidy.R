library(tidyverse)
library(janitor)

data_col_names <- names(read_csv("PSYC121_survey_data_08_11_2021.csv", n_max = 0))

data_raw_np <-
  read_csv("PSYC121_survey_data_08_11_2021.csv",
           col_names = data_col_names, col_types = NULL, skip = 3) %>%
  clean_names()

data <-
  data_raw_np %>%
  select(random_id,
         start_date,
         status,
         duration_in_seconds,
         "age" = q2,
         "birth_month" = q3,
         "gender_identity" = q4,
         "height" = q5,
         "sibling_order" = q6,
         "home_location" = q7,
         "home_location_in_UK" = q8,
         "maths_qualification" = q9,
         "countries_visited" = q10,
         "maths_skills" = q11,
         "conv_skills" = q12,
         "uk_salary" = q13,
         "hospital_sampling" = q14,
         "music_swift" = q15_1,
         "music_beyonce" = q15_2,
         "music_sheeran" = q15_3,
         "music_drake" = q15_4,
         "music_coldplay" = q15_5,
         "music_linkin" = q15_6,
         "music_nirvana" = q15_7,
         "music_rhcp" = q15_8,
         "gamble_gain" = q16,
         "gamble_lose" = q17,
         "cow_weight" = q18,
         "GAD_q1" = q19_1,
         "GAD_q2" = q19_2,
         "GAD_q3" = q19_3,
         "GAD_q4" = q19_4,
         "GAD_q5" = q19_5,
         "GAD_q6" = q19_6,
         "stroop_control" = q23,
         "stroop_compatible" = q24,
         "stroop_incompatible" = q25,
         "facebook_days" = q26_number_1_1,
         "instagram_days" = q26_number_1_2,
         "twitter_days" = q26_number_1_3,
         "facebook_friends" = q27,
         "instagram_followers" = q28,
         "instagram_follow" = q29,
         "twitter_followers" = q30,
         "twitter_follow" = q31,
         "phone_type"= q32,
         "screen_time_estimate_h" = q33_number_1_1,
         "screen_time_estimate_m" = q33_number_2_1,
         "screen_time_actual_iphone_h" = q34_number_1_1,
         "screen_time_actual_iphone_m" = q34_number_2_1,
         "screen_time_actual_android_h" = q35_number_1_1,
         "screen_time_actual_android_m" = q35_number_2_1,
         "MDFA_q1" = q36_1,
         "MDFA_q2" = q36_2,
         "MDFA_q3" = q36_3,
         "MDFA_q4" = q36_4,
         "MDFA_q5" = q36_5,
         "moral_prof" = q38_1,
         "moral_soccer" = q39_1,
         "moral_self_esteem" = q40_1,
         "conspiracy_q1" = q48_1,
         "conspiracy_q2" = q48_2,
         "conspiracy_q3" = q48_3,
         "conspiracy_q4" = q48_4,
         "conspiracy_q5" = q48_5,
         "economics_q1" = q50_1,
         "economics_q2" = q50_2,
         "economics_q3" = q50_3,
         "economics_q4" = q50_4,
         "economics_q5" = q50_5,
         "climate_estimate" = q52_57)

# set music ratings as numeric to make "no opinion" NA values
data <- data %>%
  mutate(across(starts_with("music"), as.numeric))

# parse the stroop data to make consistent numerical data
data <- data %>%
  mutate(across(starts_with("stroop"), ~str_replace_all(., ",", ".")),
         across(starts_with("stroop"), parse_number))

# write to csv
write_csv(data, "survey_data_tidy_08_11_2021.csv")

save(data, file = "tidy_data.RData")
