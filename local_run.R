library("shiny")
library("readxl")
library("cld2")
library("data.table")
library("DT")
library("here")

Sys.setlocale("LC_ALL","Chinese")

options(shiny.maxRequestSize = -1)

# source("R/func.R")


# dt1 <- setDT(readxl::read_xlsx(here::here("data/people.xlsx"), col_types  = "text"))
# head(dt1)
# dt1[, Category:= "人名"]
# dt2 <- setDT(readxl::read_xlsx(here::here("data/location.xlsx")))
# head(dt2)
# dt2[, Category:= "地名"]
# dt12 <- rbindlist(list(dt1, dt2))

dt12 <- readRDS("data/proper_names.rds")

dt12sub <- dt12[1:1000,]

saveRDS(dt12, "data/proper_names.rds")
writexl::write_xlsx(dt12, "data/proper_names_combined.xlsx")
writexl::write_xlsx(dt12sub, "data/proper_names_combined_test.xlsx")



