rm(list = ls())
library(dplyr)
library(purrr)
library(readxl)
library(janitor)
library(tidyr)

#Carrega Bases
filiais <- read_excel(path = 'filiais.xlsx',sheet = 'filiais') %>% clean_names()
usuarios <- read_excel(path = 'filiais.xlsx',sheet = 'usuarios') %>% clean_names()

#Tratamento da Base
base <- filiais %>%
  mutate(teste = map(.x = handle,.f = ~ bind_cols(usuarios))) %>% unnest(cols = teste)

#Exportar base
writexl::write_xlsx(base,'arquivo_final.xlsx')