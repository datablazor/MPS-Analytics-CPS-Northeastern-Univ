# Import Libraries
from datetime import date
from joblib import dump, load
import math
import matplotlib.pyplot as plt
import numpy as np
import os
import pandas as pd
import plotly.graph_objects as go
import plotly.express as px
from plotly.subplots import make_subplots
from scipy import stats
import seaborn as sns
import sklearn
import statsmodels.api as sm
import tensorflow as tf
import tensorflow_addons as tfa
import xgboost

from keras import callbacks
from keras.models import Sequential
from keras.layers import Dense, Dropout
from keras.regularizers import L1, L2
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.compose import ColumnTransformer
from sklearn.datasets import make_classification
from sklearn.decomposition import PCA
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.linear_model import LinearRegression, LogisticRegression
from sklearn.metrics import log_loss, f1_score, confusion_matrix
from sklearn.model_selection import train_test_split, cross_val_predict, cross_validate, cross_val_score, KFold
from sklearn.multioutput import MultiOutputClassifier
from sklearn.neighbors import NearestNeighbors
from sklearn.pipeline import make_pipeline, Pipeline
from sklearn.preprocessing import StandardScaler, StandardScaler, MinMaxScaler, OneHotEncoder, QuantileTransformer
from sklearn.svm import SVC
from sklearn.tree import DecisionTreeClassifier, DecisionTreeRegressor
from skmultilearn.model_selection import iterative_train_test_split
from tensorflow import keras
from tensorflow.keras.callbacks import EarlyStopping
from xgboost import XGBClassifier

drug = pd.read_csv(
    'C:/Users/hp/Desktop/EAI 6000 Project/lish-moa/train_features.csv')
target = pd.read_csv(
    'C:/Users/hp/Desktop/EAI 6000 Project/lish-moa/train_targets_scored.csv')
# setting the sig_id column as index
drug.set_index('sig_id', inplace=True)
target.set_index('sig_id', inplace=True)

treat_drug = drug.query('cp_type == "trt_cp"')
treat_target = target.loc[treat_drug.index]

# Getting list of columns names for categorical features, numerical features, gene epxression related features and cell vialbility related features
cat_cols = drug.select_dtypes(include='O').columns.tolist()
num_cols = drug.select_dtypes(exclude='O').columns.tolist()
gene_features = [i for i in num_cols if i.startswith('g-')]
cell_viability = [i for i in num_cols if i.startswith('c-')]
cat_cols2 = cat_cols + ['cp_time']
num_cols2 = num_cols
num_cols.remove('cp_time')

# Data prepocesing i.e label encoding 'cp_dose', 'cp_time' and 'cp_type', or whether to drop vehicle/control treated sample rows
qt = QuantileTransformer()

def data_preprocessing(dataframe, only_treatment=True, fit=False, transform=False):
    df = dataframe.copy()
    if fit:
        df[num_cols] = qt.fit_transform(df[num_cols])
    if transform:
        df[num_cols] = qt.transform(df[num_cols])
    df["cp_dose"] = df.cp_dose.map({"D1": 0, "D2": 1})
    df["cp_time"] = df.cp_time.map({24: 0, 48: 1, 72: 2})
    if only_treatment:
        df = df.drop("cp_type", 1)
    else:
        df["cp_type"] = df.cp_type.map({"trt_cp": 1, "ctl_vehicle": 0})
    return df

drug_cleaned = data_preprocessing(
    dataframe=drug, only_treatment=False, fit=True, transform=False)
drug_treatment = data_preprocessing(
    dataframe=drug, only_treatment=True, fit=True, transform=False)

# Defining NN model to be optimized using Optuna hyperparameter optimization:
def for_bayes_optimization2(dimension):
    [dl1, dl2, dl3, dl4, dp1, dp2, dp3, dp4, regu,
        regu_val, activation, learning_rate] = dimension
    if (regu == 'l2'):
        act_reg = keras.regularizers.l2(regu_val)
    if (regu == 'l1'):
        act_reg = keras.regularizers.l1(regu_val)
    lr = callbacks.ReduceLROnPlateau(
        monitor='val_loss', factor=0.2, patience=5, verbose=0)

    #x_train,x_val, y_train, y_val = train_test_split(drug_cleaned, target, test_size = 0.3, random_state = 42)
    es = callbacks.EarlyStopping(monitor='val_loss', min_delta=1e-4, mode='min', baseline=0.3,
                                 restore_best_weights=False, patience=30, verbose=0)

    adam = keras.optimizers.Adam(learning_rate=learning_rate)

    model = Sequential()
    model.add(Dense(
        dl1, input_dim=x_train.shape[1], activation=activation, activity_regularizer=act_reg))
    model.add(Dropout(dp1))
    model.add(Dense(dl2, activation=activation))
    model.add(Dropout(dp2))
    model.add(Dense(dl3, activation=activation))
    model.add(Dropout(dp3))
    model.add(Dense(dl4, activation=activation))
    model.add(Dropout(dp4))
    model.add(Dense(y_train.shape[1], activation='sigmoid'))

    model.compile(optimizer=adam, loss='binary_crossentropy', metrics=['AUC'])
    model.fit(x=x_train, y=y_train, validation_data=(x_val, y_val),
              epochs=200, batch_size=128, callbacks=[es], verbose=0)

    log_loss_data = log_loss(np.ravel(y_val), np.ravel(
        model.predict_proba(x_val)), eps=1e-7)

    return model  # or return log_loss_data (for optuna optimization)


best_set_from_baysian_optimization = [2048, 1982, 708, 470, 0.6067766671093088,
                                      0.1, 0.4973213653064633, 0.5950996340056243, 'l1', 1e-05, 'swish', 0.0001]
# Prepartion of sample submission file
submission_test = pd.read_csv(
    'C:/Users/hp/Desktop/EAI 6000 Project/lish-moa/test_features.csv')
submission_test_prob = pd.read_csv(
    'C:/Users/hp/Desktop/EAI 6000 Project/lish-moa/sample_submission.csv')
submission_test_cleaned = data_preprocessing(
    dataframe=submission_test, only_treatment=False, fit=False, transform=True)
submission_test_prob.set_index('sig_id', inplace=True)
submission_test_cleaned.set_index('sig_id', inplace=True)
submission_test_cleaned

# setting initial prediction for all to zeros
submission_test_prob[:] = np.zeros(submission_test_prob.shape)
submission_test_prob

# setting initial prediction for all to zeros
submission_test_prob[:] = np.zeros(submission_test_prob.shape)
submission_test_prob

# For submission_File_prediction
n_splits = 5
sub_file = submission_test_cleaned
sub_file_all_predict = np.zeros(submission_test_prob.shape)
nn_loss = []  # neural network loss
xgb_loss = []  # xgb loss
combined_loss = []  # loss of ensembel of NN and XGB
for seed in [10, 20, 30]:  # trying three dfiferent seeds
    for e, (train, val) in enumerate(KFold(n_splits=n_splits, shuffle=True, random_state=seed).split(drug_cleaned, target)):
        x_train, y_train = drug_cleaned.iloc[train], target.iloc[train]
        x_val, y_val = drug_cleaned.iloc[val], target.iloc[val]

        model = for_bayes_optimization2(best_set_from_baysian_optimization)
        nn_predict = model.predict_proba(x_val)

        sub_file_nn_predict = model.predict_proba(sub_file)
        nn_loss_temp = log_loss(
            np.ravel(y_val), np.ravel(nn_predict), eps=1e-7)
        nn_loss.append(nn_loss_temp)
        print(f"NN_log_loss fold {e}, seed {seed}: ", nn_loss_temp)

        xgb = MultiOutputClassifier(XGBClassifier(tree_method='gpu_hist', n_estimators=130, max_depth=3, reg_alpha=2, min_child_weight=2,
                                                  gamma=3, learning_rate=0.0580666601841646, colsample_bytree=0.58))  # Parameters obtained after optimization with Optuna
        xgb.fit(x_train, y_train)
        xgb_predict = np.array(xgb.predict_proba(x_val))[:, :, 1].T
        xgb_loss_temp = log_loss(
            np.ravel(y_val), np.ravel(xgb_predict), eps=1e-7)
        xgb_loss.append(xgb_loss_temp)

        sub_file_xgb_predict = np.array(xgb.predict_proba(sub_file))[:, :, 1].T
        avg_sub_file_predict = (sub_file_nn_predict + sub_file_xgb_predict)/2
        sub_file_all_predict = sub_file_all_predict + avg_sub_file_predict

        combined_loss_temp = log_loss(np.ravel(y_val), np.ravel(
            (nn_predict + xgb_predict)/2), eps=1e-7)
        combined_loss.append(combined_loss_temp)

        print(f"xgb_log_loss fold {e}, seed {seed}: ", xgb_loss_temp)
        print(f"combined_loss fold {e}, seed {seed}: ", combined_loss_temp)

print('Hello World!')
