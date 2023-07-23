# Machine Learning

## Types
 - Supervised Learning - Supervised learning is the machine learning task of learning a function that maps an input to an output based on example input-output pairs.
 - Unsupervised Learning - uses unlabelled data to learn about patterns
 - Reinformcement Learning - Agent learning in interactive environment based on reward and punishment


## Terms

* False Positive - A false positive is an outcome where the model incorrectly predicts the positive class.
* True Positive - A true positive is an outcome where the model correctly predicts the positive class.
* Features - The input variables used to predict the output variable.
* One Hot Encoding - A representation of categorical variables as binary vectors.
* Qualitative Variables - A variable that is not numerical in nature.
* Ordinal Data - A categorical variable that has an order.
* Quantitative Variables - A variable that is numerical in nature. (Discrete, Continuous)
* Classification - A supervised learning problem where the output variable is categorical.
* Binary Classification - A classification task with two possible outcomes.
* Multi-Class Classification - A classification task with more than two possible outcomes.
* Regression - A supervised learning problem where the output variable is continuous.
* Training dataset - The dataset used to fit the model.
* Validation dataset - The dataset used to provide an unbiased evaluation of a model fit on the training dataset while tuning model hyperparameters.
* Testing dataset - The dataset used to provide an unbiased evaluation of a final model fit on the training dataset.
* Loss function - A function that maps an event or values of one or more variables onto a real number intuitively representing some "cost" associated with the event.
  ```
  L1 Loss:
    loss = sum(|yreal - ypred|)

  L2 Loss:
    loss = sum((yreal - ypred)^2)
  
  Binary Cross Entropy Loss:
    loss = -1/(N*(yreal*log(ypred) + (1-yreal)*log(1-ypred)))
    loss decreases as ypred approaches yreal
  ```
* Accuracy - The number of correct predictions made as a ratio of all predictions made.
* Scale - A scale defines the possible values that a feature can take on.
* Oversampling - The process of randomly duplicating observations from the minority class in order to achieve approximate class balance.
* Sampling - The process of selecting a subset of observations from a dataset.
* Sample - A subset of observations from a dataset.
* Precision - The number of true positives divided by the number of true positives plus the number of false positives.
* Recall - The number of true positives divided by the number of true positives plus the number of false negatives.
* f1-score - The harmonic mean of precision and recall.
* class label
* residual - Error between the predicted value and the actual value
* fit - The process of training a machine learning model.





# Algorithms

## K-Nearest Neighbors

K-Nearest Neighbors (KNN) is a supervised machine learning algorithm that can be used for either classification or regression. It is a non-parametric, lazy learning algorithm that learns a function f(x) = y, where y is the predicted class label for a given x.

* Eucledian Distance - The distance between two points in Euclidean space is the length of a line segment between the two points.
  d = sqrt((x1-x2)^2 + (y1-y2)^2)
  
  Knn uses this distance to find the nearest neighbors

## Naive Bayes

Naive Bayes is a supervised machine learning algorithm that can be used for either classification or regression. It is a probabilistic classifier that makes classifications using the Maximum A Posteriori decision rule in a Bayesian setting. It is called naive because it assumes that the features in a dataset are mutually independent.

```
P(A|B) = P(B|A) * P(A) / P(B) <!-- Bayes -->

posterier = likelihood * prior / marginal likelihood

p( ck | x1, x2, ..., xn ) Proportional to p( ck ) * pi(i=1 to n)(p(xi | ck))

```

y = argmax (p(ck) * pi(i=1 to n)(p(xi | ck)))
    k belongs to {1,k}

argmax - returns the argument that maximizes the function
Choose k that maximizes the posterior probability.
posterior probability = p(ck | x1, x2, ..., xn)
where:
* y is the class label assigned to the instance x = (x1, x2, ..., xn).
* ck is the class label of the kth class in the dataset.
* xi is the value of the ith feature in the instance x.

class label - the output variable that we are trying to predict



## Logistic Regression

Logistic Regression is a supervised machine learning algorithm that can be used for either classification or regression. It is a parametric, probabilistic classifier that makes classifications using the Maximum A Posteriori decision rule in a Bayesian setting. It is called logistic regression because it uses the logistic function as the cumulative distribution function.

sigmoid function - S shaped curve that can take any real-valued number and map it into a value between the range of 0 and 1, but never exactly at those limits.

```python
def sigmoid(x):
  return 1 / (1 + math.exp(-x))
```
0 <= sigmoid <= 1


* Single logistic regression - A logistic regression model with one feature.
* Multiple logistic regression - A logistic regression model with more than one feature.



## Support Vector Machines

Support Vector Machines (SVM) is a supervised machine learning algorithm that can be used for either classification or regression. It is a non-probabilistic, parametric, linear classifier that makes classifications using the Maximum Margin decision rule. It is called support vector machines because it uses support vectors to define the decision boundary.

* Support vector - A vector that defines the decision boundary between the classes in a dataset.
* Margin - The distance between the support vectors and the decision boundary.
* kernel trick - A method of using a linear classifier to solve a non-linear problem by mapping the original non-linear observations into a higher-dimensional space where they can be linearly separated. x -> x**2



## Neutral Networks

Neural Networks (NN) is a supervised machine learning algorithm that can be used for either classification or regression. It is a non-probabilistic, parametric, non-linear classifier that makes classifications using the Maximum A Posteriori decision rule in a Bayesian setting. It is called neural networks because it is inspired by the structure of the brain.

The input data is assigned weights and biases and then passed through an activation function to determine the output of the neuron.

* Perceptron - A single-layer neural network.
* Multi-layer perceptron - A neural network with more than one layer.
* Hidden layer - A layer of neurons that is not an input or output layer.
* Activation function - A function that determines the output of a neuron.
* Backpropagation - A method of training a neural network by updating the weights of the neurons in the network from the output layer to the input layer.
* Gradient descent - A method of finding the minimum of a function by taking steps proportional to the negative of the gradient of the function.


* sigmoid function - S shaped curve that can take any real-valued number and map it into a value between the range of 0 and 1, but never exactly at those limits.
* Tanh - A function that can take any real-valued number and map it into a value between the range of -1 and 1, but never exactly at those limits.
* RELU - A function that can take any real-valued number and map it into a value between the range of 0 and infinity, but never exactly at those limits.


W0,new = W0,old + a*




## Linear regression

* Normality - The assumption that the data follows a normal distribution.
* Homoskedasticity - The assumption that the variance of the error term is constant for all values of the independent variables.

### Evaluating linear regression models

1. Mean absolute error (MAE) - The average of the absolute values of the errors between the predicted values and the actual values.
   sum i to n(|(yreal)i - (ypred)i|) / N
2. Mean squared error (MSE) - The average of the squared errors between the predicted values and the actual values.
   sum i to n((yreal)i - (ypred)i)^2 / N

3. Root mean squared error (RMSE) - The square root of the average of the squared errors between the predicted values and the actual values.
    sqrt(sum i to n((yreal)i - (ypred)i)^2 / N)

4. R-squared - The proportion of the variance in the dependent variable that is predictable from the independent variables.




## K-means clustering

Procedure:
1. Choose 3 random points to be centroid
2. calculate distance b/w points and centroid, assigning points to closest centroid
3. compute new centroids

* expectation-maximization algorithm - An iterative method for finding maximum likelihood or maximum a posteriori estimates of parameters in statistical models, where the model depends on unobserved latent variables.
* Principal Component Analysis (PCA) - A method of dimensionality reduction that uses linear combinations of features to reduce the dimensionality of a dataset.