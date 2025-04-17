library("DT")
library("tidyverse")
library(teal.modules.general)
library(teal.modules.clinical)
library(sparkline)
library(dplyr)

alc<-read_csv("./england_ks5final.csv", na = c('*','','na')) %>% 
  select('REGION','ESTAB','SCHNAME','TALLPPE_ALEV_1618','TALLPUP_ALEV_1618','NFTYPE/FESITYPE','TOWN','PCON_NAME')%>%
  rename(SCHOOLTYPE = 'NFTYPE/FESITYPE')%>% 
  filter (
    !TALLPPE_ALEV_1618 %in% c('NE','SUPP',NA)
    ,ESTAB != 'NA'
    ,!SCHOOLTYPE %in% c('SS','3066905','3104027','AC1619','Agriculture and Horticulture College'
                        ,'Art, Design and Performing Arts College','CTC','MODFC',NA))%>%
  mutate_at(c('TALLPPE_ALEV_1618', 'TALLPUP_ALEV_1618'), as.numeric) %>% 
  select('SCHNAME','TALLPPE_ALEV_1618','TALLPUP_ALEV_1618','SCHOOLTYPE','TOWN')
  

app <- teal::init(
  data = teal_data(
    Dataset = alc
  ),
  modules = teal::modules(
    tm_data_table(
      label = "Table"
    ),
    tm_variable_browser()
  )
)
shinyApp(app$ui, app$server)
