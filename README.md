# High-Dimensional-Classification-Using-R

## BACKGROUND
The primary objective of this project is to execute high-dimensional classification, specifically addressing scenarios where the number of variables (p) significantly surpasses the data size (n). The dataset utilized for this endeavor was sourced from [Kaggle](https://www.kaggle.com/c/dont-overfit-ii/). <p align="justify"> The training dataset comprises 250 rows and 302 columns, encompassing identifiers (id), a binary target variable of undisclosed origin (target), and 299 continuous variables. On the other hand, the test dataset comprises 19,750 rows and 301 columns, featuring sample identifiers (id) and 299 continuous variables. </p>

## GOAL
To predict the binary target associated with each row, without overfitting to the minimal set of training examples provided.

## Methods
### Random Forest
<p align="justify"> Random Forest is a powerful and versatile supervised machine learning algorithm that grows and combines multiple decision trees to create a “forest.” It can be used for both classification and regression problems in R and Python. One of the major advantages is its avoids overfitting. The random forest can deal with a large number of features and it helps to identify the important attributes. The random forest contains two user-friendly parameters ntree and mtry.</p>

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/d0f49ea6-59bf-4a05-9df2-083ceb00b5a2)

## Steps and Results
<p align="justify"> The data set was split 70:30 into training and testing set respectively. Initially, random forest with default number of trees (i.e. 500) and default number of predictors in each tree, also called, mtry (√p = √300 ≈ 17) was performed. Both happen to be important hyperparameters for Random Forest. The figure below shows the errors as a function of the number of trees. An accuracy of 73% was obtained on the testing set. We also observe that 18 size tree has the highest node.</p>

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/f295ba2f-cd98-4959-bd0a-2acb172a5b69)

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/9179a962-0838-4d15-8446-353687721db3)

Now, we observe that after ntree = 100, there isn’t much change in any of the errors. Hence, the random forest was tuned to find the optimal hyperparameters by the following command:

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/9413a407-d655-4c3c-87d4-20795442c037)

We found that mtry = 100 gives the minimum out-of-bag error. Hence, random forest was performed again but with ntree = 100, mtry = 100 and as a result, we get 69.3% test accuracy. X23 was found to be most important.

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/8e53b465-5e19-40f3-ab2a-d90881d12e8a)
![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/13321cfa-cb1e-40f6-a9c9-338fb0a745ae)
![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/bd618e1a-c66d-4ec9-bb45-cd0703d60622)

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/591042a7-53c2-4db8-8b4b-c7d8231e3dea)

### Support Vector Machine
<p align="justify"> A Support Vector Machine or SVM is a machine learning algorithm that looks at data and sorts it into one of two categories. SVM is a supervised and linear Machine Learning algorithm most used for solving classification problems and is also referred to as Support Vector Classification.</p>

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/5916b3a0-6d95-422f-ac27-5e06075fa60f)

Linear Data <br>

To explain Support Vector Machines, consider an example having two tags: red and blue and our data has two features: x and y. We want a classifier that, given a pair of (x,y) coordinates, outputs if it’s either red or blue. We plot our already labelled training data on a plane.

<img src="https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/35fcb735-2398-4746-bb8b-220e30a1fa08f" width="450" height="450" align="left">  <br clear="left"/>
<img src="https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/6a2dc331-5136-43df-a10a-06b180cca807" width="350" height="350"> <br> <br clear="left"/>

<img src="https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/1bbc1ce6-a60f-4b2b-a73b-f277ddb8be7a" width="350" height="350"> <br> <br clear="left"/>

<p align="justify"> A support vector machine takes these data points and outputs the hyperplane (which in two dimensions it’s simply a line) that best separates the tags. This line is the decision boundary anything that falls to one side of it we will classify as blue, and anything that falls to the other as red. But, what exactly is the best hyperplane?
For SVM, it’s the one that maximizes the margins from both tags. In other words: the hyperplane (remember it’s a line in this case) whose distance to the nearest element of each tag is the largest.</p>

Let’s perform SVM on this dataset <br>
• Consider the given dataset where we spit the given data into 70:30 ratio of train and test.
![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/50a09905-2162-4eeb-85f0-7362f625b30d)

• We then apply SVM model to the dataset and test it on the test data.

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/0674b371-156b-4185-92f4-be6a4000133d)

• Confusion Matrix is generated for the test data

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/15e53a16-b177-4a79-9abc-cb7c4a929d33)

• Improvement is done to the model by tuning and testing on the dataset where the best accuracy is selected in which C value = 0.01

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/e7cdc072-1615-46f0-b73f-b5383afb996e)

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/a6ec387c-20a1-4542-bcea-ddd075c0862b)

• Plotting the SVM Linear Grid values to compare the given Accuracy across cost values.

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/b109e04f-8c4b-465c-b6ef-0eb16a873ba4)

• An updated Confusion Matrix is generated after the tuning process

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/0a15c171-b371-496c-b38e-6e87256e5be4)

Here we could see that the accuracy has been increased which is equivalent to 0.69
• A new csv file as Submission.csv is generated with id and test data and submitted to Kaggle.

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/63f9e266-1ad4-4129-a200-25d50bb0f770)

• In Kaggle, the AUC evaluation gives a result of 0.502
![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/15c299c9-c48f-4af5-8fec-4b7466827c1b)

### k-Nearest Neighbors
<p align="justify"> k-Nearest Neighbors k-Nearest Neighbors (KNN) approach attempts to estimate the conditional distribution of Y given X, and then classify a given observation to the class with highest estimated probability.
Given a positive integer K and a test observation x0, the KNN classifier first identifies the K points in the training data that are closest to x0, represented by N0. It then estimates the conditional probability for class j as the fraction of points in N0 whose response values equal j: </p>

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/1c3890a2-34aa-4d30-85a9-592040ee4639)

<p align="justify"> Finally, KNN applies Bayes' rule and classifies the test observation x0 to the class with the largest probability.
The choice of K has a drastic effect on the KNN classifier obtained. For the given train data, we have split it into a 70:30 ratio of train and test. We have ignored the id column in the data as it does not contribute to the prediction of the target. We then calculated the prediction accuracies for different values of K. Below are the results: </p>

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/9eb5f1ad-1f2d-4a7f-b324-bddb05256873) 
![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/eacc5dd1-1ea9-4e8d-923d-5f00c1b89748)
![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/08a30981-ef09-4334-9e65-30896ae0e067)

We see that we get maximum accuracy for the value K=4, which is 72%. We use this value to predict the target values in the test data.

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/c1e0c011-43f7-41dc-b605-51c3b6608ad9)

When we submit these results in the Kaggle, the AUC evaluation gives a result of 0.503.

![image](https://github.com/vjbalaji2512/High-Dimensional-Classification-Using-R/assets/124394195/7cc315d6-4ab8-4dac-9416-32afccf4dee3)

