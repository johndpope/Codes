library(readr)

train <- read_csv('../input/train.csv')
test <- read_csv('../input/test.csv')
# dests <- read_csv('../input/destinations.csv')
# ss <- read_csv('../input/sample_submission.csv')

train <- train[sample(1:nrow(train), nrow(train)*0.25),]  # Script ran too long; working on 25% random sample

CompareSets <- function(test, train) {
  
  comprows <- ifelse(nrow(train) < nrow(test), nrow(train), nrow(test))
  fields <- intersect(names(train), names(test))
  fields <- setdiff(fields, 'Id')
  # fields <- setdiff(fields, names(which(sapply(train, class) =='factor')))
  
  tt_compare <- data.frame(NULL)
  for (name in sort(fields)) {
    if (class(train[[name]]) %in% c('numeric', 'integer')) {
      plot(density(na.omit(train[1:comprows,name])), col=rgb(1,0,0,0.5), main=name)
      lines(density(na.omit(test[1:comprows,name])), col=rgb(0,0,1,0.5))
      tt_compare <- rbind(tt_compare, 
                          cbind(name, ks.test(train[,name], test[,name])$stati))
    } else if(length(unique(train[,name])) < 50 && class(train[[name]]) == 'factor') {
      plot(train[,name], col=rgb(1,0,0,0.5), main=name)
      par(new=TRUE)
      plot(test[,name], col=rgb(0,0,1,0.5))
    }
  }
  tt_compare$V2 <- as.numeric(as.character(tt_compare$V2))
  return(tt_compare)
}

par( mfcol=c(3,3) )
tt_compare <- CompareSets(test, train)
print("ks-test values between train and test: higher numbers are less similar:")
tt_compare[order(tt_compare$V2),]
