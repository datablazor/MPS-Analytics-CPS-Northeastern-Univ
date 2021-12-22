#!/usr/bin/env python
# coding: utf-8

# In[24]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns


# In[2]:


airdf = pd.read_csv('annual_conc_by_monitor_2020.csv')


# In[3]:


airdf


# In[4]:


airdf.info()


# In[5]:


airdf.describe()


# In[163]:


airdf.isnull().sum()


# In[ ]:


airdf = airdf.drop(['Pollutant Standard','Primary Exceedance Count','Secondary Exceedance Count','1st Max Non Overlapping Value','1st NO Max DateTime','2nd Max Non Overlapping Value','2nd NO Max DateTime','Method Name','Date of Last Change','Local Site Name','Address'], axis=1)


# In[180]:


airdf = airdf.drop(['Local Site Name'], axis=1)


# In[168]:


airdf.isnull().sum()


# In[169]:


airdf = airdf.dropna()


# In[181]:


airdf.isnull().sum()


# In[182]:


airdf = pd.get_dummies(airdf, drop_first = True)


# In[183]:



X = np.array(airdf).astype('float32')
y = np.array(airdf['Valid Day Count']).astype('float32')


# In[184]:


from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.25)
X_test, X_val, y_test, y_val = train_test_split(X_test, y_test, test_size = 0.5)


# In[185]:


from sklearn.linear_model import LinearRegression


# In[186]:


lr_model = LinearRegression()
# Train the model
lr_model.fit(X_train, y_train)


# In[187]:


result = lr_model.score(X_test, y_test)

print("Accuracy : {}".format(result))


# In[188]:


# make predictions on the test data

y_predict = lr_model.predict(X_test)


# In[189]:


from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
from math import sqrt
k = X_test.shape[1]
n = len(X_test)
RMSE = float(format(np.sqrt(mean_squared_error(y_test, y_predict)),'.3f'))
MSE = mean_squared_error(y_test, y_predict)
MAE = mean_absolute_error(y_test, y_predict)
r2 = r2_score(y_test, y_predict)
adj_r2 = 1-(1-r2)*(n-1)/(n-k-1)

print('RMSE =',RMSE, '\nMSE =',MSE, '\nMAE =',MAE, '\nR2 =', r2, '\nAdjusted R2 =', adj_r2)


# In[190]:


from sklearn.tree import DecisionTreeRegressor


# In[191]:


dt_model = DecisionTreeRegressor()
# Train the model
dt_model.fit(X_train, y_train)


# In[192]:


result = dt_model.score(X_test, y_test)

print("Accuracy : {}".format(result))


# In[193]:


# make predictions on the test data

y_predict = dt_model.predict(X_test)


# In[194]:


from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
from math import sqrt
k = X_test.shape[1]
n = len(X_test)
RMSE = float(format(np.sqrt(mean_squared_error(y_test, y_predict)),'.3f'))
MSE = mean_squared_error(y_test, y_predict)
MAE = mean_absolute_error(y_test, y_predict)
r2 = r2_score(y_test, y_predict)
adj_r2 = 1-(1-r2)*(n-1)/(n-k-1)

print('RMSE =',RMSE, '\nMSE =',MSE, '\nMAE =',MAE, '\nR2 =', r2, '\nAdjusted R2 =', adj_r2)


# In[195]:


from sklearn.ensemble import RandomForestRegressor


# In[ ]:


# Create a model 
rf_model = RandomForestRegressor()

# Train the model
rf_model.fit(X_train, y_train)


# In[ ]:


result = rf_model.score(X_test, y_test)

print("Accuracy : {}".format(result))


# In[ ]:


# make predictions on the test data

y_predict = rf_model.predict(X_test)


# In[ ]:


from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
from math import sqrt
k = X_test.shape[1]
n = len(X_test)
RMSE = float(format(np.sqrt(mean_squared_error(y_test, y_predict)),'.3f'))
MSE = mean_squared_error(y_test, y_predict)
MAE = mean_absolute_error(y_test, y_predict)
r2 = r2_score(y_test, y_predict)
adj_r2 = 1-(1-r2)*(n-1)/(n-k-1)

print('RMSE =',RMSE, '\nMSE =',MSE, '\nMAE =',MAE, '\nR2 =', r2, '\nAdjusted R2 =', adj_r2)


# In[ ]:


import xgboost as xgb


model = xgb.XGBRegressor(objective ='reg:squarederror', learning_rate = 0.1, max_depth = 5, n_estimators = 100)

model.fit(X_train, y_train)


# In[ ]:



# predict the score of the trained model using the testing dataset

result = model.score(X_test, y_test)

print("Accuracy : {}".format(result))


# In[ ]:


# make predictions on the test data

y_predict = model.predict(X_test)


# In[ ]:



from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
from math import sqrt
k = X_test.shape[1]
n = len(X_test)
RMSE = float(format(np.sqrt(mean_squared_error(y_test, y_predict)),'.3f'))
MSE = mean_squared_error(y_test, y_predict)
MAE = mean_absolute_error(y_test, y_predict)
r2 = r2_score(y_test, y_predict)
adj_r2 = 1-(1-r2)*(n-1)/(n-k-1)

print('RMSE =',RMSE, '\nMSE =',MSE, '\nMAE =',MAE, '\nR2 =', r2, '\nAdjusted R2 =', adj_r2)


# In[10]:


ervisitsdf = pd.read_excel('ER_Visits_Data.xls')
ervisitsdf

#predict number of ed visits so as to improve health infrastructure and estimate for those


# In[18]:


ervisitsdf.describe()


# In[19]:


ervisitsdf.info()


# In[21]:


ervisitsdf['STRATA'].unique()


# In[22]:


ervisitsdf['STRATA NAME'].unique()


# In[23]:


ervisitsdf.hist(bins = 30, figsize = (20,20), color = 'r')


# In[25]:


sns.pairplot(ervisitsdf)


# In[28]:


get_ipython().system('pip3 install xgboost')


# In[31]:


from autoviz.AutoViz_Class import AutoViz_Class

AV = AutoViz_Class()


# In[32]:


filename = "ER_Visits_Data.xls"
sep = ","
dft = AV.AutoViz(
    filename,
    sep=",",
    depVar="",
    dfte=None,
    header=0,
    verbose=0,
    lowess=False,
    chart_format="svg",
    max_rows_analyzed=150000,
    max_cols_analyzed=30,
)


# In[36]:


ervisitsdf.isnull().sum()


# In[42]:


ervisitsdf = ervisitsdf.fillna(0)


# In[43]:


ervisitsdf.isnull().sum()


# In[44]:


ervisitsdf


# In[45]:


corr_matrix = ervisitsdf.corr()
sns.heatmap(corr_matrix, annot = True)
plt.show()


# In[96]:


ervisitsdf['Avg_AGE'] =  ervisitsdf['AGE GROUP'].apply(lambda x: (int(x.split('-')[0].strip()) + int(x.split('-')[1].split(' Ye')[0].strip()))/2 if '-' in x else x.split('+')[0])
ervisitsdf['Avg_AGE']


# In[71]:


ervisitsdf['MAX_AGE'] =  ervisitsdf['AGE GROUP'].apply(lambda x: x.split('-')[1].split(' Ye')[0] if '-' in x else x)


# In[63]:


ervisitsdf['MAX_AGE'] 


# In[101]:


ervisitsdf.drop(['AGE GROUP'], axis=1, inplace=True)


# In[108]:


ervisitsdf


# In[103]:


ervisitsdf = pd.get_dummies(ervisitsdf, drop_first = True)


# In[110]:


finaldf = ervisitsdf.drop(['NUMBER OF ED VISITS'], axis=1)


# In[111]:



X = np.array(finaldf).astype('float32')
y = np.array(ervisitsdf['NUMBER OF ED VISITS']).astype('float32')


# In[117]:


from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.25)
X_test, X_val, y_test, y_val = train_test_split(X_test, y_test, test_size = 0.5)


# In[139]:


from sklearn.linear_model import LinearRegression


# In[141]:


lr_model = LinearRegression()
# Train the model
lr_model.fit(X_train, y_train)


# In[148]:


result = lr_model.score(X_test, y_test)

print("Accuracy : {}".format(result))


# In[149]:


# make predictions on the test data

y_predict = lr_model.predict(X_test)


# In[150]:


from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
from math import sqrt
k = X_test.shape[1]
n = len(X_test)
RMSE = float(format(np.sqrt(mean_squared_error(y_test, y_predict)),'.3f'))
MSE = mean_squared_error(y_test, y_predict)
MAE = mean_absolute_error(y_test, y_predict)
r2 = r2_score(y_test, y_predict)
adj_r2 = 1-(1-r2)*(n-1)/(n-k-1)

print('RMSE =',RMSE, '\nMSE =',MSE, '\nMAE =',MAE, '\nR2 =', r2, '\nAdjusted R2 =', adj_r2)


# In[135]:


from sklearn.tree import DecisionTreeRegressor


# In[151]:


dt_model = DecisionTreeRegressor()
# Train the model
dt_model.fit(X_train, y_train)


# In[152]:


result = dt_model.score(X_test, y_test)

print("Accuracy : {}".format(result))


# In[155]:


# make predictions on the test data

y_predict = dt_model.predict(X_test)


# In[156]:


from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
from math import sqrt
k = X_test.shape[1]
n = len(X_test)
RMSE = float(format(np.sqrt(mean_squared_error(y_test, y_predict)),'.3f'))
MSE = mean_squared_error(y_test, y_predict)
MAE = mean_absolute_error(y_test, y_predict)
r2 = r2_score(y_test, y_predict)
adj_r2 = 1-(1-r2)*(n-1)/(n-k-1)

print('RMSE =',RMSE, '\nMSE =',MSE, '\nMAE =',MAE, '\nR2 =', r2, '\nAdjusted R2 =', adj_r2)


# In[132]:


from sklearn.ensemble import RandomForestRegressor


# In[157]:


# Create a model 
rf_model = RandomForestRegressor()

# Train the model
rf_model.fit(X_train, y_train)


# In[158]:


result = rf_model.score(X_test, y_test)

print("Accuracy : {}".format(result))


# In[160]:


# make predictions on the test data

y_predict = rf_model.predict(X_test)


# In[161]:


from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
from math import sqrt
k = X_test.shape[1]
n = len(X_test)
RMSE = float(format(np.sqrt(mean_squared_error(y_test, y_predict)),'.3f'))
MSE = mean_squared_error(y_test, y_predict)
MAE = mean_absolute_error(y_test, y_predict)
r2 = r2_score(y_test, y_predict)
adj_r2 = 1-(1-r2)*(n-1)/(n-k-1)

print('RMSE =',RMSE, '\nMSE =',MSE, '\nMAE =',MAE, '\nR2 =', r2, '\nAdjusted R2 =', adj_r2)


# In[118]:


import xgboost as xgb


model = xgb.XGBRegressor(objective ='reg:squarederror', learning_rate = 0.1, max_depth = 5, n_estimators = 100)

model.fit(X_train, y_train)


# In[125]:


ervisitsdf


# In[119]:



# predict the score of the trained model using the testing dataset

result = model.score(X_test, y_test)

print("Accuracy : {}".format(result))


# In[120]:


# make predictions on the test data

y_predict = model.predict(X_test)


# In[121]:



from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
from math import sqrt
k = X_test.shape[1]
n = len(X_test)
RMSE = float(format(np.sqrt(mean_squared_error(y_test, y_predict)),'.3f'))
MSE = mean_squared_error(y_test, y_predict)
MAE = mean_absolute_error(y_test, y_predict)
r2 = r2_score(y_test, y_predict)
adj_r2 = 1-(1-r2)*(n-1)/(n-k-1)

print('RMSE =',RMSE, '\nMSE =',MSE, '\nMAE =',MAE, '\nR2 =', r2, '\nAdjusted R2 =', adj_r2)


# In[126]:


y_predict1 = model.predict(X_train)


# r2

# In[128]:


r2


# In[130]:





# In[33]:


filename = "annual_conc_by_monitor_2020.csv"
sep = ","
dft = AV.AutoViz(
    filename,
    sep=",",
    depVar="",
    dfte=None,
    header=0,
    verbose=0,
    lowess=False,
    chart_format="svg",
    max_rows_analyzed=1500000,
    max_cols_analyzed=60,
)


# In[34]:


filename = "hourly_44201_2021.csv"
sep = ","
dft = AV.AutoViz(
    filename,
    sep=",",
    depVar="",
    dfte=None,
    header=0,
    verbose=0,
    lowess=False,
    chart_format="svg",
    max_rows_analyzed=1500000,
    max_cols_analyzed=60,
)


# In[35]:


filename = "daily_aqi_by_county_2021.csv"
sep = ","
dft = AV.AutoViz(
    filename,
    sep=",",
    depVar="",
    dfte=None,
    header=0,
    verbose=0,
    lowess=False,
    chart_format="svg",
    max_rows_analyzed=1500000,
    max_cols_analyzed=60,
)


# In[11]:


pd.read_csv('hourly_44201_2021.csv')


# In[16]:


dailyaqidf = pd.read_csv('daily_aqi_by_county_2021.csv')
dailyaqidf


# In[17]:


dailyaqidf['County Code'].unique()


# In[73]:


pd.read_csv('annual_aqi_by_cbsa_2021.csv')


# In[74]:


pd.read_csv('annual_aqi_by_county_2021.csv')


# In[78]:


pd.read_csv('daily_42101_2021.csv')


# In[79]:


pd.read_csv('daily_42602_2021.csv')

