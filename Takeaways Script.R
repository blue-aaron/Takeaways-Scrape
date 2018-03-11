library(rvest)

webpage <- read_html("https://www.sports-reference.com/cbb/seasons/2018-school-stats.html")

tbls <- html_nodes(webpage, "table")

head(tbls)

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  html_table(header = 2, fill = TRUE)

head(tbls_ls)

tbls_frame <- data.frame(tbls_ls)

tbls_table <- tbls_frame[c(2,3,31,32,33)]

tbls_clean <- tbls_table[-c(22:23,44:45,66:67,88:89,110:111,132:133,154:155,176:177,198:199,220:221,242:243,264:265,286:287,308:309,330:331,352:353,374:375),]

tbls_tkw <- tbls_clean[-c(1),]

colnames(tbls_tkw) <- c("School", "G", "STL",
                             "BLK", "TOV")

tbls_tkw$G <- as.numeric(as.character(tbls_tkw$G))
tbls_tkw$STL <- as.numeric(as.character(tbls_tkw$STL))
tbls_tkw$BLK <- as.numeric(as.character(tbls_tkw$BLK))
tbls_tkw$TOV <- as.numeric(as.character(tbls_tkw$TOV))

tbls_tkw$TKW <- (tbls_tkw$STL + tbls_tkw$BLK)
tbls_tkw$"TKW/TOV" <- (tbls_tkw$TKW / tbls_tkw$TOV)
tbls_tkw$TKWpg <- (tbls_tkw$TKW / tbls_tkw$G)

tbls_tkw$`TKW/TOV`<-round(tbls_tkw$`TKW/TOV`, 3)
tbls_tkw$TKWpg<-round(tbls_tkw$TKWpg, 2)

tbls_tkw <- tbls_tkw[order(-tbls_tkw$TKWpg),] 

tbls_tkw

library(xlsx)
write.xlsx(tbls_tkw, "C:/Users/Blue/Documents/Washington/takeaways.xlsx", row.names = FALSE)














