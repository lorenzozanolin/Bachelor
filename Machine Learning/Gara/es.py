# Data loading

#logistic regression con sag e saga

#preprocessing -> trasformo i dati in numeri
#eventualmente normalizzazione sui dati se non sono tutti concentrati (ovvero hanno scale diverse) -> prima li plotto e poi se vedo che sono tanto distanti allora li normalizzo


#neural network
#svm

#per ogni modello calcolo i risultati, li confronto con i vari score e prendo quello che fa meglio


# Data loading

import pandas as pd

#!wget https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data
#!wget https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test

column_names=[
    "age",
    "workclass",
    "fnlwgt",
    "education",
    "education-num",
    "marital-status",
    "occupation",
    "relationship",
    "race",
    "sex",
    "capital-gain",
    "capital-loss",
    "hours-per-week",
    "native-country",
    "income"
]

df_train = pd.read_csv("adult.data",index_col=False, names=column_names)
df_test = pd.read_csv("adult.test", index_col=False, skiprows=1, names=column_names)
real_predictions = df_test.income   #della matrice con le varie features (age,workclass..,income) stampa la colonna income
real_predictions.to_csv("predictions.test.csv", index=False)    #si crea un file dove salva soltanto l'ultima colonna della matrice

# Compute Metrics

from sklearn.metrics import f1_score
from sklearn.metrics import accuracy_score

def compute_metrics(path_real, path_predicted):

    column_names=[
        "age",
        "workclass",
        "fnlwgt",
        "education",
        "education-num",
        "marital-status",
        "occupation",
        "relationship",
        "race",
        "sex",
        "capital-gain",
        "capital-loss",
        "hours-per-week",
        "native-country",
        "income"
    ]
    
    if "test" in path_real:
        df_real = pd.read_csv(path_real, index_col=False, skiprows=1, names=column_names)
    else:
        df_real = pd.read_csv(path_real, index_col=False, names=column_names)
    
    df_pred = pd.read_csv(path_predicted)
    y_real = df_real.income.tolist()    #si salva a parte l'ultima colonna come una lista
    y_pred = df_pred.income.tolist()    #si salva a parte l'ultima colonna come una lista

    y_real = [0 if "<=50K" in x else 1 for x in y_real]
    y_pred = [0 if "<=50K" in x else 1 for x in y_pred]
    
    #gli do in input i valori calcolati con quelli corretti e lui calcola la precisione e la f-score
    accuracy = accuracy_score(y_real, y_pred)
    f1 = f1_score(y_real, y_pred)

    print(f"Metrics comparing '{path_real}' and '{path_predicted}'")
    print(f"Accuracy: {accuracy}")
    print(f"F1: {f1}")
    
   #utilizza la funzione definita sopra per calcolare le varie metriche 
#compute_metrics("adult.test", "predictions.test.csv")   


from sklearn.preprocessing import OneHotEncoder

# Collezione di tutte le categorie del dataset, ovvero ogni riga è un tipo di categoria... ad esempio l'ultima riga è la nazione.

CLASSES = [
           [['Private'], ['Self-emp-not-inc'], ['Self-emp-inc'], ['Federal-gov'], ['Local-gov'], ['State-gov'], ['Without-pay'], ['Never-worked']],
           [['Bachelors'], ['Some-college'],['11th'], ['HS-grad'], ['Prof-school'], ['Assoc-acdm'], ['Assoc-voc'], ['9th'], ['7th-8th'], ['12th'], ['Masters'], ['1st-4th'], ['10th'], ['Doctorate'], ['5th-6th'], ['Preschool']],
           [['Married-civ-spouse'], ['Divorced'], ['Never-married'], ['Separated'], ['Widowed'], ['Married-spouse-absent'], ['Married-AF-spouse']],
           [['Tech-support'], ['Craft-repair'], ['Other-service'], ['Sales'], ['Exec-managerial'], ['Prof-specialty'], ['Handlers-cleaners'], ['Machine-op-inspct'], ['Adm-clerical'], ['Farming-fishing'], ['Transport-moving'], ['Priv-house-serv'], ['Protective-serv'], ['Armed-Forces']],
           [['Wife'], ['Own-child'], ['Husband'], ['Not-in-family'], ['Other-relative'], ['Unmarried']],
           [['White'], ['Asian-Pac-Islander'], ['Amer-Indian-Eskimo'], ['Other'], ['Black']],
           [['United-States'], ['Cambodia'], ['England'], ['Puerto-Rico'], ['Canada'], ['Germany'], ['Outlying-US(Guam-USVI-etc)'], ['India'], ['Japan'], ['Greece'], ['South'], ['China'], ['Cuba'], ['Iran'], ['Honduras'], ['Philippines'], ['Italy'], ['Poland'], ['Jamaica'], ['Vietnam'], ['Mexico'], ['Portugal'], ['Ireland'], ['France'], ['Dominican-Republic'], ['Laos'], ['Ecuador'], ['Taiwan'], ['Haiti'], ['Columbia'], ['Hungary'], ['Guatemala'], ['Nicaragua'], ['Scotland'], ['Thailand'], ['Yugoslavia'], ['El-Salvador'], ['Trinadad&Tobago'], ['Peru'], ['Hong'], ['Holand-Netherlands']]
          ]


# Trasforma un dato valore in un vettore con codifica One-Hot Encoding.
#
# oneHotEnc -> Il codificatore usato per trasformare il dato valore in un vettore one-hot
# x         -> il valore da codificare

def toOneHot(oneHotEnc, x):
  arr = oneHotEnc.transform([x]).toarray()[0]
  out = []
  for i in range(len(arr)):
    out.append(arr[i])
  return out;


# Dato an array bidimensionale di stringhe (matrice), ritorna una matrice (uguale nella forma) in cui ogni stringa è
# sostituita con la sua versione codificata attraverso l'uso della One Hot Encoding.
#
# categories -> un array 2D di categorie (espresse come stringhe. Vedi CLASSES) => sostituisce ogni valore nella matrice sopra con la codifica hot-enc.

def encodeCategory(categories):
  out = []*1
  for i in range(len(categories)):
    oneHotEncoder = OneHotEncoder()
    oneHotEncoder.fit(categories[i])
    out.append([])
    for j in range(len(categories[i])):
      out[i].append(toOneHot(oneHotEncoder,categories[i][j]))
  return out


# Vettore usato per salvare la versione One-Hot encoded di CLASSES

ONE_HOT_CLASSES = encodeCategory(CLASSES)


# Dato l'indice della colonna del training set, ritorna la classe corrispondente.
#
# i -> l'indice della colonna del training set (ad esempio 0,1,2...,k)

def getCategoryIndex(i):
  if i == 1:
    return 0
  elif i == 3:
    return 1
  elif i == 5:
    return 2
  elif i == 6:
    return 3
  elif i == 7:
    return 4
  elif i == 8:
    return 5
  elif i == 13:
    return 6
  else:
    return -1


# Data la classe e una stringa, ritorna la sua codifica One-Hot.
#
# i   -> l'indice della classe
# str -> la stringa da codificare

def getOneHotValue(i, str):
  s = str.strip()
  for j in range(len(CLASSES[i])):
    if CLASSES[i][j][0] == s:
      return ONE_HOT_CLASSES[i][j]
  return None


import numpy as np

# Dato un training set, ritorna una copia tale che:
# 1) non contenga righe con valori mancanti,
# 2) le features categoriche (con più di due classi) siano appositamente sostituite con la codifica One-Hot-Encoding,
# 3) le features categoriche (con due classi) siano sostituite con la codifica Label-Encoding.
#
# Nota che:
# 1) 'Male' e 'Female' sono sostituite, rispettivamente, con 0 e 1
# 2) <=50k è sostituito con 0 e >=50k con 1.
#
# data    -> il DataFrame contente il training set
# columns -> le colonne da riportare nel nuovo training set

def createTrainingSet(data, columns):
  out = []
  for i in range(len(data)):
    arr = []
    for l in range(len(columns)):
      j = columns[l]
      v = data.iat[i,j]
      if v == ' ?':
        arr = None
        break
      else:
        gategory_index = getCategoryIndex(j)
        if gategory_index != -1:
          oneHot = getOneHotValue(gategory_index,v)
          for k in range(len(oneHot)):
            arr.append(oneHot[k])
        elif isinstance(v, str):
          c = v.strip()
          if c == 'Male':
            arr.append(0)
          elif c == 'Female':
            arr.append(1)
          elif c == '<=50K':
            arr.append(0)
          elif c == '>50K':
            arr.append(1)
          else:
            arr.append(c)
        else:
          arr.append(v)
    if arr != None:
      out.append(arr)
  return out


# Salva il nuovo training set
TrainingSet = createTrainingSet(df_train, [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14])

import csv

# Salva un array su disco
#
# path -> il percorso del file
# data -> l'array da scrivere

def writeFile(path, data):
  f = open(path, 'w')
  writer = csv.writer(f)
  for i in range(len(data)):
    writer.writerow(data[i])


# Salva il file su disco
writeFile('Training_set.csv', TrainingSet)
#il file che crea è un dataset dove nelle righe che contenevano categorie ci sono delle one hot-encode.
#es se ho una categoria ha 8 possibilità, allora sarà una cosa del tipo (0,0,1,0,0,0,0,0)
#quando do in pasto il dataset alla rete (o svm) si occupa lei stessa di raggruppare i dati che sono della stessa categoria 

# Estrae le features
#
# data -> il dataset costituito da un array 2D

def extractX(data):
  out = []*1
  size = len(data[0]) - 1
  for i in range(len(data)):
    out.append([])
    for j in range(size):
      out[i].append(data[i][j])
  return out


# Estrare la label (ovvero la "risposta corretta")
#
# data -> il dataset costituito da un array 2D

def extractY(data):
  out = []
  j = len(data[0]) - 1
  for i in range(len(data)):
    out.append(data[i][j])
  return out


X_Train = extractX(TrainingSet) #contiene le features
Y_Train = extractY(TrainingSet) #contiene le labels (0 o 1)

print(X_Train)
#print(Y_Train)

