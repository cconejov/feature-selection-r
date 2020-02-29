# feature-selection-r
An R package for feature selection with ML estimators

### Overview:
If you have encountered a database with so many features, that while working on it and gets messy, a good idea is to approach this problem by selecting only some of these features for your model. Feature selection will reduce complexity, reduce the time when training an algorithm, and improve the accuracy of your model (if we select them wisely). However, this is not a trivial question. 

To help you out performing this task, we have created the **featureselection** package in `R`.

If you are interested in a similar feature selection package for `python`, click [here](https://github.com/UBC-MDS/feature-selection-python).

### Feature description:
In this package, four functions are included to lead with feature selection:

#### Forward
- Function that use the forward algorithm to select the number of features in a model. This iterative algorithm starts as an empty model, and add the variable with the highest improve in the accuracy of the model. The process then is iteratively repeated selecting the variables with the best improvement in the accuracy. This procedure stops when the remaining variables doesn't enhance the accuracy of the model. 

and no better model can be obtained.

#### Backward
- TO DESCRIBE

#### Variance Thresholding  
- TO DESCRIBE

#### Simulated Annealing  
- TO DESCRIBE

### Installation:

- TODO

### Features
- TODO

### Dependencies

- TODO

### Usage

- TODO

### Documentation
The official documentation is hosted on Read the Docs: <https://feature-selection.readthedocs.io/en/latest/>

### Credits
This package was created with Cookiecutter and the UBC-MDS/cookiecutter-ubc-mds project template, modified from the [pyOpenSci/cookiecutter-pyopensci](https://github.com/pyOpenSci/cookiecutter-pyopensci) project template and the [audreyr/cookiecutter-pypackage](https://github.com/audreyr/cookiecutter-pypackage).
