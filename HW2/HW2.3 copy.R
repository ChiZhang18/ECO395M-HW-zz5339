library(tidyverse)
library(mosaic)
library(class)
library(FNN)

urlfile<-'https://raw.githubusercontent.com/znzhao/ECO395M-HW-zz5339/master/HW2/online_news.csv'
OnlineNews<-read.csv(url(urlfile))

OnlineNews$viral = ifelse(OnlineNews$shares > 1400, 1, 0)
summary(OnlineNews)

  p1 <- ggplot(data = OnlineNews) + 
    geom_point(mapping = aes(y = shares, x =n_tokens_title),alpha = 0.01) +ylim(0, 15000)
  p1

### Split into training and testing sets
myfunc <- function() {
  n = nrow(OnlineNews)
  n_train = round(0.8*n)  # round to nearest integer
  n_test = n - n_train
  train_cases = sample.int(n, n_train, replace=FALSE)
  test_cases = setdiff(1:n, train_cases)
  OnlineNews_train = OnlineNews[train_cases,]
  OnlineNews_test = OnlineNews[test_cases,]
}
  
### simple LM w/o polarity

##########################################
lm_OnlineNews_1 = lm(shares ~ n_tokens_title + n_tokens_content + num_hrefs + 
                     num_self_hrefs + num_imgs + num_videos + 
                     average_token_length + num_keywords + data_channel_is_lifestyle + 
                     data_channel_is_entertainment + data_channel_is_bus + 
                     + data_channel_is_socmed + data_channel_is_tech + 
                     data_channel_is_world + self_reference_avg_sharess + 
                     weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                     weekday_is_thursday + weekday_is_friday + weekday_is_saturday, data=OnlineNews_train)

lm_OnlineNews_1inte = lm(viral ~ (n_tokens_title + n_tokens_content + num_hrefs + 
                                num_self_hrefs + num_imgs + num_videos + 
                                average_token_length + num_keywords + data_channel_is_lifestyle + 
                                data_channel_is_entertainment + data_channel_is_bus + 
                                + data_channel_is_socmed + data_channel_is_tech + 
                                data_channel_is_world + self_reference_avg_sharess + 
                                weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                                weekday_is_thursday + weekday_is_friday + weekday_is_saturday)^2, data=OnlineNews_train)

lm_OnlineNews_1poly = lm(shares ~ poly(n_tokens_title, 3) + poly(num_hrefs, 2) + poly(num_imgs, 2) + poly(num_videos, 2) + 
                      poly(average_token_length, 3) + poly(num_keywords, 2) + poly(n_tokens_content, 2) + 
                      data_channel_is_lifestyle + data_channel_is_entertainment + data_channel_is_bus + 
                      + data_channel_is_socmed + data_channel_is_tech + 
                      data_channel_is_world + poly(self_reference_avg_sharess,2) + 
                      weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                      weekday_is_thursday + weekday_is_friday + weekday_is_saturday + 
                      poly(max_positive_polarity, 3) + poly(max_negative_polarity, 3), data=OnlineNews_train)


lm_OnlineNews_1polytrans = lm(log(shares) ~ poly(n_tokens_title, 3) + poly(num_hrefs, 2) + poly(num_imgs, 2) + poly(num_videos, 2) + 
                           poly(average_token_length, 3) + poly(num_keywords, 2) + poly(n_tokens_content, 2) + 
                           data_channel_is_lifestyle + data_channel_is_entertainment + data_channel_is_bus + 
                           + data_channel_is_socmed + data_channel_is_tech + 
                           data_channel_is_world + poly(self_reference_avg_sharess,2) + 
                           weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                           weekday_is_thursday + weekday_is_friday + weekday_is_saturday + 
                           poly(max_positive_polarity, 3) + poly(max_negative_polarity, 3), data=OnlineNews_train)
#################################################

### simple binomial LM w/o polarity 
lm_OnlineNews_2 = lm(viral ~ n_tokens_title + n_tokens_content + num_hrefs + 
                       num_self_hrefs + num_imgs + num_videos + 
                       average_token_length + num_keywords + data_channel_is_lifestyle + 
                       data_channel_is_entertainment + data_channel_is_bus + 
                       + data_channel_is_socmed + data_channel_is_tech + 
                       data_channel_is_world + self_reference_avg_sharess + 
                       weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                       weekday_is_thursday + weekday_is_friday + weekday_is_saturday, data=OnlineNews_train)

lm_OnlineNews_22 = glm(viral ~ poly(n_tokens_title, 2) + log(n_tokens_content+0.1) + log(num_hrefs+0.1) + 
                       num_self_hrefs + log(num_imgs+0.1) + log(num_videos+0.1) + 
                        poly(average_token_length, 2) + log(num_keywords+0.1) + data_channel_is_lifestyle + 
                       data_channel_is_entertainment + data_channel_is_bus + 
                       + data_channel_is_socmed + data_channel_is_tech + 
                       data_channel_is_world + self_reference_avg_sharess + 
                       weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                       weekday_is_thursday + weekday_is_friday + weekday_is_saturday +
                        poly(max_positive_polarity, 2) + poly(max_negative_polarity, 2), data=OnlineNews_train, family=binomial)


### simple binomial logistic w/o polarity 
glm_OnlineNews_1 = glm(viral ~ n_tokens_title + n_tokens_content + num_hrefs + 
                       num_self_hrefs + num_imgs + num_videos + 
                       average_token_length + num_keywords + data_channel_is_lifestyle + 
                       data_channel_is_entertainment + data_channel_is_bus + 
                       + data_channel_is_socmed + data_channel_is_tech + 
                       data_channel_is_world + self_reference_avg_sharess + 
                       weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                       weekday_is_thursday + weekday_is_friday + weekday_is_saturday, data=OnlineNews_train, family=binomial)

### simple binomial logistic w/o polarity 
glm_OnlineNews_11 = lm(log(shares) ~ n_tokens_title + n_tokens_content + num_hrefs + 
                         num_self_hrefs + num_imgs + num_videos + 
                         average_token_length + num_keywords + data_channel_is_lifestyle + 
                         data_channel_is_entertainment + data_channel_is_bus + 
                         + data_channel_is_socmed + data_channel_is_tech + 
                         data_channel_is_world + self_reference_avg_sharess + 
                         weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                         weekday_is_thursday + weekday_is_friday + weekday_is_saturday, data=OnlineNews_train)

lm_OnlineNews_ = lm(viral ~ poly(n_tokens_title, 3) + poly(num_hrefs, 2) + poly(num_imgs, 2) + poly(num_videos, 2) + 
                       poly(average_token_length, 3) + poly(num_keywords, 2) + poly(n_tokens_content, 2) + 
                       data_channel_is_lifestyle + data_channel_is_entertainment + data_channel_is_bus + 
                       + data_channel_is_socmed + data_channel_is_tech + 
                       data_channel_is_world + poly(self_reference_avg_sharess,2) + 
                       weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                       weekday_is_thursday + weekday_is_friday + weekday_is_saturday + 
                       poly(max_positive_polarity, 3) + poly(max_negative_polarity, 3), data=OnlineNews_train)

### simple LM w/o polarity w/interaction
lm_OnlineNews_4 = lm(viral ~ (n_tokens_title + n_tokens_content + num_hrefs + 
                       num_self_hrefs + num_imgs + num_videos + 
                       average_token_length + num_keywords + data_channel_is_lifestyle + 
                       data_channel_is_entertainment + data_channel_is_bus + 
                       + data_channel_is_socmed + data_channel_is_tech + 
                       data_channel_is_world + self_reference_avg_sharess + 
                       weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                       weekday_is_thursday + weekday_is_friday + weekday_is_saturday)^2, data=OnlineNews_train)


lm_OnlineNews_5 = lm(viral ~ poly(n_tokens_title, 3) + poly(num_hrefs, 2) + poly(num_imgs, 2) + poly(num_videos, 2) + 
                       poly(average_token_length, 3) + poly(num_keywords, 2) + poly(n_tokens_content, 2) + 
                        data_channel_is_lifestyle + data_channel_is_entertainment + data_channel_is_bus + 
                       + data_channel_is_socmed + data_channel_is_tech + 
                       data_channel_is_world + poly(self_reference_avg_sharess,2) + 
                       weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                       weekday_is_thursday + weekday_is_friday + weekday_is_saturday + 
                       poly(max_positive_polarity, 3) + poly(max_negative_polarity, 3), data=OnlineNews_train)

coef(lm_OnlineNews_5) %>% round(3)
summary(lm_OnlineNews_22)
### Set model
lm_OnlineNews_SetModel <- lm_OnlineNews_4

### Predictions in sample
yhat_train_test1 = predict(lm_OnlineNews_SetModel, OnlineNews_train)
#summary(yhat_train_test1)
class_train_test1 = ifelse(yhat_train_test1 > 0.5, 1, 0)

###in sample performance
confusion_in = table(y = OnlineNews_train$viral, yhat = class_train_test1)
confusion_in
sum(diag(confusion_in))/sum(confusion_in)

###Benchmark in sample performance
sum(OnlineNews_test$viral)/count(OnlineNews_test)

### Predictions out of sample
yhat_test_test1 = predict(lm_OnlineNews_SetModel, OnlineNews_test)
#summary(yhat_test_test1)
class_test_test1 = ifelse(yhat_test_test1 > 0.5, 1, 0)

###out of sample performance
confusion_out = table(y = OnlineNews_test$viral, yhat = class_test_test1)
confusion_out
sum(diag(confusion_out))/sum(confusion_out)

###Benchmark out of sample performance
sum(OnlineNews_train$viral)/count(OnlineNews_train)

# # Root mean-squared prediction error
# rmse = function(y, yhat) {
#   sqrt( mean( (y - yhat)^2 ) )
# }
# rmse(OnlineNews_test$shares, yhat_test1)


#####KNN
# construct the training and test-set feature matrices
# note the "-1": this says "don't add a column of ones for the intercept"
Xtrain = model.matrix(~ n_tokens_title + n_tokens_content + num_hrefs + 
                        num_self_hrefs + num_imgs + num_videos + 
                        average_token_length + num_keywords + data_channel_is_lifestyle + 
                        data_channel_is_entertainment + data_channel_is_bus + 
                        + data_channel_is_socmed + data_channel_is_tech + 
                        data_channel_is_world + self_reference_avg_sharess + 
                        weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                        weekday_is_thursday + weekday_is_friday + weekday_is_saturday - 1, data=OnlineNews_train)

Xtest = model.matrix(~ n_tokens_title + n_tokens_content + num_hrefs + 
                       num_self_hrefs + num_imgs + num_videos + 
                       average_token_length + num_keywords + data_channel_is_lifestyle + 
                       data_channel_is_entertainment + data_channel_is_bus + 
                       + data_channel_is_socmed + data_channel_is_tech + 
                       data_channel_is_world + self_reference_avg_sharess + 
                       weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                       weekday_is_thursday + weekday_is_friday + weekday_is_saturday - 1, data=OnlineNews_test)



K = 20
run_time = 5
myList <- c(rep(0, 20))
for(i in c(1:run_time)){
  myfunc()
  # training and testing set responses
  ytrain = OnlineNews_train$viral
  ytest = OnlineNews_test$viral
  
  # now rescale:
  scale_train = apply(Xtrain, 2, sd)  # calculate std dev for each column
  Xtilde_train = scale(Xtrain, scale = scale_train)
  Xtilde_test = scale(Xtest, scale = scale_train)  # use the training set scales!
  for(j in c(1:K)){
    m = j*5
    knn_model = knn.reg(Xtilde_train, Xtilde_test, ytrain, k=m)
    KNN_train_test1 = ifelse(knn_model$pred > 0.5, 1, 0)
    
    confusion_in_KNN = table(y = OnlineNews_test$viral, yhat = KNN_train_test1)
    confusion_in_KNN
    accuracy_rate = sum(diag(confusion_in_KNN))/sum(confusion_in_KNN)
    myList[j]= myList[j] + accuracy_rate
    print(j)
  }
  # fit the model

}
myList = myList/run_time
myL <- seq(5,100, by=5)


K = 20
run_time = 5
myList <- c(rep(0, 20))
for(i in c(1:run_time)){
  n = nrow(OnlineNews)
  n_train = round(0.8*n)  # round to nearest integer
  n_test = n - n_train
  train_cases = sample.int(n, n_train, replace=FALSE)
  test_cases = setdiff(1:n, train_cases)
  OnlineNews_train = OnlineNews[train_cases,]
  OnlineNews_test = OnlineNews[test_cases,]
  # training and testing set responses
  ytrain = OnlineNews_train$shares
  ytest = OnlineNews_test$shares
  Xtrain = model.matrix(~ n_tokens_title + n_tokens_content + num_hrefs + 
                          num_self_hrefs + num_imgs + num_videos + 
                          average_token_length + num_keywords + data_channel_is_lifestyle + 
                          data_channel_is_entertainment + data_channel_is_bus + 
                          + data_channel_is_socmed + data_channel_is_tech + 
                          data_channel_is_world + self_reference_avg_sharess + 
                          weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                          weekday_is_thursday + weekday_is_friday + weekday_is_saturday - 1, data=OnlineNews_train)
  Xtest = model.matrix(~ n_tokens_title + n_tokens_content + num_hrefs + 
                         num_self_hrefs + num_imgs + num_videos + 
                         average_token_length + num_keywords + data_channel_is_lifestyle + 
                         data_channel_is_entertainment + data_channel_is_bus + 
                         + data_channel_is_socmed + data_channel_is_tech + 
                         data_channel_is_world + self_reference_avg_sharess + 
                         weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                         weekday_is_thursday + weekday_is_friday + weekday_is_saturday - 1, data=OnlineNews_test)
  # now rescale:
  scale_train = apply(Xtrain, 2, sd)  # calculate std dev for each column
  Xtilde_train = scale(Xtrain, scale = scale_train)
  Xtilde_test = scale(Xtest, scale = scale_train)  # use the training set scales!
  for(j in c(1:K)){
    m = j*5
    knn_model = knn.reg(Xtilde_train, Xtilde_test, ytrain, k=m)
    KNN_train_test1 = ifelse(knn_model$pred > 1400, 1, 0)
    
    confusion_in_KNN = table(y = OnlineNews_test$shares, yhat = KNN_train_test1)
    confusion_in_KNN
    accuracy_rate = sum(diag(confusion_in_KNN))/sum(confusion_in_KNN)
    myList[j]= myList[j] + accuracy_rate
    print(j)
  }
  # fit the model
}
myList = myList/run_time
myL <- seq(5,100, by=5)

knitr::opts_chunk$set(echo = FALSE)
library(knitr)
