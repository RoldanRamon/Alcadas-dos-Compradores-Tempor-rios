rm(list = ls())
library(dplyr)
library(purrr)
library(readxl)
library(janitor)
library(tidyr)

#Carrega Bases
filiais <- read_excel(path = 'NOME DOS GRUPOS SOS TELECOM_EMPRESA_FILIAL.xlsx') %>% clean_names()
usuarios <- read_excel(path = 'filiais.xlsx',sheet = 'lista') %>% clean_names()

#filiais
filiais_1 <- filiais %>% filter(nomedogrupo == "OC -SOS TELECOM – SUPRIMENTOS 1 R$ 0,01 A R$ 1.000,0")
filiais_2 <- filiais %>% filter(nomedogrupo == "OC -SOS TELECOM – SUPRIMENTOS 2 R$ 1.000,01 A R$ 30.000,00")
filiais_3 <- filiais %>% filter(nomedogrupo == "OC -SOS TELECOM – SUPRIMENTOS 3 R$ 30.000,01 A R$ 2.000.000,00")
filiais_4 <- filiais %>% filter(nomedogrupo == "OC -SOS TELECOM – SUPRIMENTOS 4 ACIMA DE R$ 2.000.000,01")

#usuarios
usuarios_1 <- usuarios %>% filter(grupo == "OC -SOS TELECOM – SUPRIMENTOS 1 R$ 0,01 A R$ 1.000,0")
usuarios_2 <- usuarios %>% filter(grupo == "OC -SOS TELECOM – SUPRIMENTOS 2 R$ 1.000,01 A R$ 30.000,00")
usuarios_3 <- usuarios %>% filter(grupo == "OC -SOS TELECOM – SUPRIMENTOS 3 R$ 30.000,01 A R$ 2.000.000,00")
usuarios_4 <- usuarios %>% filter(grupo == "OC -SOS TELECOM – SUPRIMENTOS 4 ACIMA DE R$ 2.000.000,01")


#Tratamento da Base
base <- bind_rows(filiais_1 %>% mutate(teste = map(.x = handle,.f = ~ bind_cols(usuarios_1))) %>% unnest(cols = teste),
                  filiais_2 %>% mutate(teste = map(.x = handle,.f = ~ bind_cols(usuarios_2))) %>% unnest(cols = teste),
                  filiais_3 %>% mutate(teste = map(.x = handle,.f = ~ bind_cols(usuarios_3))) %>% unnest(cols = teste),
                  filiais_4 %>% mutate(teste = map(.x = handle,.f = ~ bind_cols(usuarios_4))) %>% unnest(cols = teste)
                  )

#Exportar base
writexl::write_xlsx(base,'arquivo_final.xlsx')
