# installing and loading packages
# using pacman to laod and install any packages
install.packages("pacman")
install.packages("tidyverse")

# load packages
pacman::p_load(pacman, tidyverse)

# read dataset
data_event_log <- read_delim(
  "../data/event_log.csv",
  delim=';'
)

# peeking into the dataset
summary(data_event_log)
head(data_event_log, n=10)


# cleaning the data
# exclude rows containing null-values
clean_logs <- na.omit(data_event_log)
corrupted_logs <- subset(data_event_log,
                          is.na(DEVICETYPE) | 
                          is.na(SERVICEPOINT)
                         )
# peaking into the cleaned data
am_activity_types <- length(unique(clean_logs$ACTIVITY))
unique(clean_logs$SERVICEPOINT)

# basic plotting
# bar charts

# servicepoints
servicepoints <- table(clean_logs$SERVICEPOINT)
barplot(main="logs per servicepoint",servicepoints)

# rep in time
timely_repair <- table(clean_logs$REPAIR_IN_TIME_5D)
barplot(main="repair in time", timely_repair)

# activity count
activity_count <- table(clean_logs$ACTIVITY)
barplot(main="logs per activitytype", activity_count)

# logs per devicetype
devicetypes_counter <- table(clean_logs$DEVICETYPE)
barplot(main="logs per devicetype", devicetypes_counter)

# plottig the timestamps with no real goal in mind
timestamps <- table(clean_logs$TIMESTAMP)
barplot(main="timestamps", timestamps)

# histograms

hist(main="repairs in 5D", clean_logs$REPAIR_IN_TIME_5D)

hist(main="timestamps normal hist", clean_logs$TIMESTAMP, breaks=12)
hist(main="freq of timestamps (not working)", timestamps, breaks=24)

hist(main="freq of devicetypes", devicetypes_counter)


# cleaning after everything is done
p_unload(all)

