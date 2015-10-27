createPhyActTable <- function(data){
  m <- matrix(nrow = 3, ncol = 2)
  colnames(m) <- c("val","Freq")
  #rownames(m) <- c(0, 8.75, 17.5)
  #cat(sum(data < 8.75), " : ",
  #    sum(data >= 8.75), " : ",
  #    sum(data >= 17.5), "\n")
  
  m[1,1] = 0
  m[1,2] = nrow(data[data$total_mmet < 8.75,]) # sum(data < 8.75)
  m[2,1] = 8.75
  m[2,2] = nrow(data[data$total_mmet >= 8.75,]) # sum(data >= 8.75)
  m[3,1] = 17.5
  m[3,2] = nrow(data[data$total_mmet >= 17.5,]) # sum(data >= 17.5)
  #todel <- m
  m <- as.data.frame(m)
  m
}