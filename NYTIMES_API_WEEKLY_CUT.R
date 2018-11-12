
#NYTIMES API 접속
Sys.setenv(NYTIMES_AS_KEY = "INTER_YOUR_KEY")
Sys.getenv("NYTIMES_AS_KEY")

install.packages("rtimes")
library('rtimes')

#NYTIMES API 데이터 요청
NYNK_6month <- as_search(q ="North Korea", 
                         begin_date = "20180601",
                         end_date = "20180731", 
                         all_results = TRUE)
#pub_date Y_M_D 변환
NYNK_6month_DF <- data.frame(NYNK_6month$data)
NYNK_6month_DF$pub_date <- as.Date(NYNK_6month_DF$pub_date, "%Y-%m-%d")

#주별로 나누기
NYNK_6month_DF$week <- cut(NYNK_6month_DF$pub_date, breaks = "week", start.on.monday = F)

#합계 계산 할 수 있게 카운트 입력
NYNK_6month_DF$count <- 1

#주별로 합계 구하기
install.packages("reshape2")
library(reshape2)

(y <- dcast(NYNK_6month_DF, week ~ ., value.var = "count", sum))
