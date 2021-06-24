import pandas as pd
data= pd.read_csv('data.tsv',sep='\t',encoding='utf-8')
data.head()
data[['review_headline','review_body']].describe()
data.shape
data_review_body=data['review_body']
data_review_body.shape
data_star_rating=data['star_rating']
data_star_rating.shape
from sklearn.feature_extraction.text import TfidfVectorizer
tf = TfidfVectorizer(
    analyzer='word',
    ngram_range=(1,4),
    max_features=20000
)
isNA=data.isnull()
data_review_body[isNA.any(axis=1)]
tf.fit(data_review_body)
from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test = train_test_split(data_review_body,data_star_rating,random_state=1234)
x_train = tf.transform(x_train)
x_test = tf.transform(x_test)
x_train[1]
from sklearn.linear_model import LogisticRegression
lg1 = LogisticRegression()
lg1.fit(x_train,y_train)
print('TF-IDF method for text feature engineering, using sklearn's default logistic regression model, to verify the accuracy of the prediction of the star rating given by the user:',lg1.score(x_test,y_test))
from sklearn.naive_bayes import MultinomialNB
classifier = MultinomialNB()
classifier.fit(x_train,y_train)
print('TF-IDF method for text feature engineering, using sklearn's default polynomial naive Bayes classifier, to verify the accuracy of the prediction of the star rating given by the user:',classifier.score(x_test,y_test))
lg2 = LogisticRegression(C=3, dual=True)
lg2.fit(x_train,y_train)
print('The TF-IDF method is used for text feature engineering. The logistic regression model with two parameters is added to verify the accuracy of the prediction of the star rating given by users:',lg2.score(x_test,y_test))
from sklearn.model_selection import GridSearchCV
param_grid = {'C':range(1,10),
             'dual':[True,False]
              }
lgGS = LogisticRegression()
grid = GridSearchCV(lgGS, param_grid=param_grid,cv=3,n_jobs=-1)
grid.fit(x_train,y_train)
grid.best_params_
lg_final = LogisticRegression(C=6, dual=True)
lg_final.fit(x_train,y_train)
lg_final = grid.best_estimator_
print('Use grid search to find the logistic regression model corresponding to the optimal combination of hyperparameters and verify the accuracy of the prediction of the star rating given by the user:',lg_final.score(x_test,y_test))
test_X = tf.transform(data_review_body)
predictions = lg_final.predict(test_X)
Predictions
predictions.shape
data.loc[:,'predictions_stars'] = predictions
data.head()
final_data=data.loc[:,['star_rating','helpful_votes','total_votes','vine','verified_purchase','predictions_stars']]
final_hair_dryer_data.head
final_hair_dryer_data.to_csv('final_hair_dryer_data.csv',index=None)