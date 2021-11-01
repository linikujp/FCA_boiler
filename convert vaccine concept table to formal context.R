
# Convert the vaccine vocabulary lookup script excel file into a formal context
# A formal context is a table with one row per item and one column per attribute

df <- readxl::read_excel("Vaccine Vocabulary Lookup.xlsx")

library(tidyverse)

df2 <- df %>% 
  filter(!str_detect(concept_class_id, "Brand")) %>%
  select(concept_name = concept_name_1, starts_with("attri")) %>% 
  pivot_longer(cols = starts_with("attr")) %>% 
  filter(value != "none") %>% 
  select(concept_name, value) %>% 
  mutate(value = str_split(value, "\\|")) %>% 
  unnest(cols = "value") %>% 
  mutate(value = str_replace_all(str_trim(value), "\\s|-", "_")) %>% 
  mutate(x = "X") %>% 
  distinct() %>% 
  pivot_wider(names_from = "value", values_from = "x", values_fill = "")

write_csv(df2, "vaccine_context.csv")
