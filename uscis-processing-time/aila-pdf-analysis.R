library(data.table)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

pdf.times <- data.table(read.csv('aila-pdf-times.csv'))

pdf.counts <- pdf.times[, .(lines=sum(.N)), by=file]

pdf.counts[lines <= 15,]
pdf.times[file=='nbc_17-02-17',][order(form)]

hist(pdf.times$capture_size, breaks=500, xlim=c(0,1000))
?hist
