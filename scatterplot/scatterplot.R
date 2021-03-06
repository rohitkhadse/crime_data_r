#Package to Access Database
if("RMySQL" %in% rownames(installed.packages()) == FALSE) 
{install.packages("RMySQL")}

library(RMySQL)


#Connect to Database 
con <- dbConnect(MySQL(),
                 user = 'rohitsaurabh',
                 password = 'rohit1991',
                 host = '50.62.209.88',
                 dbname='rkhadse')

#Query
tmp <- sprintf("
SELECT 
SUM(
WEAPON10 
+ DRUG10
+ LIQUOR10
+ WEAPON11
+ DRUG11
+ LIQUOR11
+ WEAPON12
+ DRUG12
+ LIQUOR12) as TotalArrests,
SUM(Total)/1000 AS TotalPeople
FROM rkhadse.OnCampusArrest 
GROUP BY ID ")

#sqlquery<-dbEscapeStrings(con, tmp)

result <- dbGetQuery(con, tmp)
head(result)

#On Campus Scatterplot
plot(
    x = result$TotalPeople, 
    y = result$TotalArrests,
    main = "Total Arrests vs. Total People for On Campus (Scatter-Plot)",
    xlab = "Total People (in Thousands)",
    ylab = "Total Arrests")

tmp <- sprintf("
SELECT 
               SUM(
               WEAPON10 
               + DRUG10
               + LIQUOR10
               + WEAPON11
               + DRUG11
               + LIQUOR11
               + WEAPON12
               + DRUG12
               + LIQUOR12) as TotalArrests,
               SUM(Total)/1000 AS TotalPeople
               FROM rkhadse.NonCampusArrest
               GROUP BY ID ")

sqlquery<-dbEscapeStrings(con, tmp)

result <- dbGetQuery(con, tmp)
dbDisconnect(con)
head(result)

plot(
  x = result$TotalPeople, 
  y = result$TotalArrests,
  main = "Total Arrests vs. Total People for Non Campus  (Scatter-Plot) ",
  xlab = "Total People (in Thousands)",
  ylab = "Total Arrests")

