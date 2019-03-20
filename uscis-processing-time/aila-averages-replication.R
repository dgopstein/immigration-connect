# replicating the results of https://www.aila.org/infonet/aila-policy-brief-uscis-processing-delays
# Using data from:
#  - https://www.aila.org/infonet/processing-time-reports/historical-average-processing-times/uscis-national-average-processing-times-9-30-18
#  - https://egov.uscis.gov/processing-times/historic-pt

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Values copy-pasted from https://egov.uscis.gov/processing-times/historic-pt on 2019-03-20
# Also joined with 2014 data from https://www.aila.org/infonet/processing-time-reports/historical-average-processing-times/uscis-national-average-processing-times-9-30-18
proc.times <- data.table(read.csv('uscis-historical-processing-averages.tsv', sep='\t'))

proc.times[, mean(FY.2018)/mean(FY.2016)] # 1.457875

proc.times[, mean(FY.2018)/mean(FY.2014, na.rm = TRUE)] # 1.909026

proc.times[, sum(FY.2018 > FY.2014, na.rm=TRUE)/sum(!is.na(FY.2014))] # 0.9444444
