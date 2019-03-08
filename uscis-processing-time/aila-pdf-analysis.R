library(data.table)
library(ggplot2)
library(viridis)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

pdf.times <- data.table(read.csv('aila-pdf-times.csv'))
pdf.times[, form := gsub('-', '', form)]
pdf.times[, posted_date := as.Date(posted_date)]
pdf.times <- pdf.times[wait_days>=0]

# Count the lines in each pdf file
pdf.counts <- pdf.times[, .(lines=sum(.N)), by=file]
pdf.counts[lines <= 15,]
pdf.times[file=='nbc_17-02-17',][order(form)]
hist(pdf.times$capture_size, breaks=500, xlim=c(0,1000))
?hist

# Where are the N400s?
# Why are the ahead_of_schedule days sometimes longer than the behind schedule days -- pdf.times[form=='I600']
pdf.times[, .N, by=form][order(N)]

# Individual form/office plot
ggplot(pdf.times[form=='I485' & office=='tsc'], aes(posted_date, wait_days)) +
  geom_point() +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

pdf.times[, posted.month := as.Date(paste0(format(posted_date, '%Y-%m'), '-01'))]

avg.wait <- pdf.times[, .(.N, med.wait = median(wait_days), mean.wait = mean(wait_days), sd.wait = sd(wait_days)), by=posted.month]
ggplot(avg.wait[N>100], aes(posted.month, med.wait)) +
  geom_point(aes(size = N^2)) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(pdf.times, aes(posted_date, wait_days)) +
  stat_density_2d(n = 200, geom = "raster", aes(fill = stat(density)), contour = FALSE) +
  ylim(0, 300) +
  scale_fill_viridis_c()

