require(bupaR)
require(tidyverse)
require(daqapo)
require(processmapR)
library(bupaR)
library(tidyverse)
library(daqapo)
library(processmapR)

# read dataset
data_event_log <- read_delim(
  "./data/event_log.csv",
  delim=';'
)

nrow(data_event_log)

# reformat dataset to fit bupar requirements
instance_id_vec <- c(1:178078)
data_event_log$ACTIVITY_INSTANCE <- instance_id_vec

data_event_log$STATUS <- "complete"

# remove logs before 2017
data_event_log <- filter(data_event_log, TIMESTAMP >= as.Date("2017-01-01"))

# define eventlog for bupar
acme_actlog <- data_event_log %>%
  eventlog(
    case_id = "CASE_ID",
    activity_id = "ACTIVITY",
    activity_instance_id = "ACTIVITY_INSTANCE",
    lifecycle_id = "STATUS",
    timestamp = "TIMESTAMP",
    resource_id = "SERVICEPOINT"
  )

# output summary
acme_actlog %>% summary

# output cases
case_summary <- acme_actlog %>% cases

# output mapping info
acme_actlog %>% mapping

# Preprocessing

# detections don't work because of missing lifecycle information, like acitivity start
# acme_actlog %>% detect_incomplete_cases(activities = c("InDelivery"))

# EDA

# process map

acme_actlog %>% process_map()

# dotted charts

acme_actlog %>% dotted_chart(x = "absolute", y = "completed")

acme_actlog %>% dotted_chart(x = "relative", y = "completed")

