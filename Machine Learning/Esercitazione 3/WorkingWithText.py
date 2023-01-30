#Text data and Building Vocabulary => utilizza bag of words normale
import numpy as np
docs = np.array([
    'The sun is shining',
    'The weather is sweet',
    'The sun is shining the weather is sweet and one and one is two'])

from sklearn.feature_extraction.text import CountVectorizer
count = CountVectorizer()
count.fit(docs)
print("Vocabulary size: {}". format(len(count.vocabulary_)))    #stampa il vocabolario
print("Vocabulary content:\n {}".format(count.vocabulary_))
#To create the bag-of-words representation => stampa il vettore delle frasi
bag = count.transform(docs) #qui conta le ripetizioni per ogni frase

#Repr returns a string containing a printable representation of an object. 
print("Bag of words: {}".format(repr(bag)))
print("Dense representation of Bag of word:\n {}". format(bag.toarray()))

#Movie reviews Dataset
import pandas as pd
train = pd.read_csv('http://ailab.uniud.it/wp-content/uploads/2019/05/Train_Movie_Data.csv') #training set
print("First Elements of train set:\n {}".format(train.head(3)))
text_train = train['review'].values
y_train = train['sentiment'].values
print('Number of train samples: ', len(y_train))
print()
test = pd.read_csv('http://ailab.uniud.it/wp-content/uploads/2019/05/Test_Movie_Data.csv') #test set
print("First Elements of test set:\n {}".format(test.head(3)))
text_test = test['review'].values
y_test = test['sentiment'].values
print('Number of test samples: ', len(y_test))

# train dataset is balanced
tt=[x for x in y_train if x==1] #conta quante review sono positive 
print(len(tt))

#Building the vocabulary and the bag of words
count = CountVectorizer()
count.fit(text_train)

#To create the bag-of-words representation
X_train = count.transform(text_train)
print("X_train:\n{}".format(repr(X_train)))

#Let's look at the vocabulary in a bit more detail.
feature_names = count.get_feature_names()
print("Number of features: {}".format(len(feature_names)))
print("First 20 features:\n{}".format(feature_names[:20]))
print("Features 20400 to 20430:\n{}".format(feature_names[20400:20430]))
print("Every 2000th feature:\n{}".format(feature_names[::2000]))

from sklearn.linear_model import LogisticRegression
logreg = LogisticRegression(solver='liblinear')
#Use fit(X,y) fuction of LogisticRegression() to train your model, 
#where X is the array of your training data and y is the label (per label si intende 0/1 per dire se è positivo o negativo)
logreg.fit(X_train,y_train)

# Compute the Bag of word representation of the testing set
X_test = count.transform(text_test)

#Use score(X,y) function of LogisticRegression() to compute 
#the performance on both training and testing set 
print("Train score: {:.2f}".format(logreg.score(X_train,y_train)))
print("Test score: {:.2f}".format(logreg.score(X_test,y_test)))

from sklearn.model_selection import GridSearchCV
#param_grid = {'C': [0.001, 0.01, 0.1, 1, 10]}
#For computation issue in this laboratory we test just few cases  
param_grid = {'C': [0.01, 0.1, 1, 10]}

def grid_search(X_train,y_train,X_test,y_test,param_grid):
    grid = GridSearchCV(LogisticRegression(solver='liblinear'), param_grid, cv=5)
    grid.fit(X_train, y_train)
    print("Best cross-validation score: {:.2f}".format(grid.best_score_))
    print("Best parameters: ", grid.best_params_)
    # Test on the Testing set
    print("Test score: {:.2f}".format(grid.score(X_test, y_test)))
    return grid


grid_search(X_train, y_train, X_test, y_test, param_grid)

#1) Set minimum number of documents a token needs to appear
#Building the vocabulary and the bag of words

count = CountVectorizer(min_df=5)
count.fit(text_train)
X_train = count.transform(text_train)

print("X_train with min_df: {}".format(repr(X_train)))
feature_names = count.get_feature_names()
print("Number of features: {}".format(len(feature_names)))
print("First 50 features:\n{}".format(feature_names[:50]))

X_test = count.transform(text_test)
grid_search(X_train,y_train, X_test, y_test,param_grid)

# Here the Advanced Italian Tokenization  
from nltk.stem.snowball import SnowballStemmer
stemmer = SnowballStemmer("italian")
def tokenizer_snowballStemmer(text):
    return [stemmer.stem(word) for word in text.split()]

tokenizer_snowballStemmer("È possibile attivare la consultazione e la ricerca nei testi anche basate sulla lemmatizzazione")

# Here the Advanced English Tokenization
from nltk.stem.snowball import SnowballStemmer
stemmer = SnowballStemmer("english")
def tokenizer_snowballStemmer(text):
    return [stemmer.stem(word) for word in text.split()]

tokenizer_snowballStemmer("runners like running and thus they run")

#Classification with Tokenizer NLTK
nltk_count = CountVectorizer(tokenizer=tokenizer_snowballStemmer, min_df=5).fit(text_train)
X_train_nltk = nltk_count.transform(text_train)
print("X_train_nltk: {}".format(X_train_nltk.shape))

X_test_nltk = nltk_count.transform(text_test)
grid_search(X_train_nltk,y_train,X_test_nltk, y_test,param_grid)

docs = np.array([
        'The sun is shining',
        'The weather is sweet',
        'The sun is shining the weather is sweet and one and one is two'])

from sklearn.feature_extraction.text import TfidfVectorizer
count = TfidfVectorizer()
count.fit(docs)
print("Vocabulary size: {}". format(len(count.vocabulary_)))
print("Vocabulary content:\n {}".format(count.vocabulary_))

#To create the bag-of-words representation
bag = count.transform(docs)
print("Bag of words: {}".format(repr(bag)))
print("Dense representation of Bag of word:\n {}". format(bag.toarray()))

