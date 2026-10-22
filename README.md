# Alzheimer's Disease Classification from Handwriting Data

### Machine Learning and Statistical Analysis in MATLAB

## Overview

This repository contains an academic machine learning project investigating Alzheimer's disease classification using handwriting-derived features from the **DARWIN dataset**.

The analysis was developed in MATLAB and explores how traditional machine learning methods can be applied to a biomedical classification problem.

The project covers the full exploratory workflow, from data inspection and preprocessing to dimensionality reduction, classification, regression, and statistical analysis.

**Main techniques:**
- Exploratory data analysis and visualization
- Missing-value and outlier handling
- Correlation-based feature selection
- Principal Component Analysis (PCA)
- Naive Bayes, Decision Tree, and Support Vector Machine (SVM) classification
- Support Vector Regression (SVR)
- Non-parametric statistical testing

This is an academic research and learning project, **not a clinically validated diagnostic system**.

---

## Dataset

The project uses the **DARWIN (Diagnosis AlzheimeR WIth haNdwriting)** dataset, introduced by Cilia et al. (2022).

The dataset contains handwriting-derived measurements from **174 participants**:
- 89 individuals with Alzheimer's disease
- 85 healthy controls

Participants performed 25 handwriting and drawing tasks. Each task is represented by 18 extracted features, giving a total of 450 numerical features per participant.

The MATLAB dataset used in this project is stored as a table with 174 rows and 452 columns, including the participant identifier and class label.

**Official dataset:**  
[DARWIN — UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/732/darwin)

### Data availability

The local file `Alzheimer.mat` is **not included** in this repository.

The original MATLAB script expects a file named `Alzheimer.mat` containing a table variable named `Dataset`.

To reproduce the analysis, obtain the DARWIN dataset from the official source and prepare a MATLAB table matching the structure expected by the script.

The conversion procedure from the publicly distributed dataset to this project's MATLAB format has not yet been independently verified and documented.

---

## Methodology

### 1. Data exploration

The analysis begins with:
- Dataset summary and inspection
- Conversion of the class label to a categorical variable
- Removal of the participant identifier
- Detection and removal of observations containing missing numerical values
- Histograms and exploratory visualization of handwriting features

### 2. Data preprocessing

The original implementation applies different outlier-detection approaches depending on the inspected feature distributions:

- Grubbs-based outlier detection for features treated as approximately Gaussian
- Quartile-based detection for non-Gaussian features
- Removal of observations exceeding selected feature-specific thresholds
- Winsorization of remaining extreme numerical values using interquartile-range limits

These preprocessing choices were developed as part of the original academic analysis.

### 3. Dimensionality reduction

Two PCA-based approaches are investigated.

**Approach A — Correlation-based feature selection followed by PCA**

- Explore correlations between features within individual handwriting tasks.
- Remove selected correlated features.
- Normalize the reduced feature matrix.
- Apply PCA to the reduced representation.
- Retain the first **56 principal components** for classification, corresponding to approximately 85% cumulative explained variance according to the original analysis.

**Approach B — Task-wise PCA**

- Divide the original numerical features into 25 groups, one per handwriting task.
- Apply PCA separately to each task.
- Retain the first **four principal components per task**.
- Combine the resulting components into a new feature representation.

This produces a 100-component representation for classification.

### 4. Classification

Three supervised classification algorithms are evaluated:

- **Naive Bayes**
- **Decision Tree**
- **Support Vector Machine (SVM)**

The original analysis compares these models using three feature representations:

1. Original preprocessed features
2. Correlation-reduced features represented by 56 principal components
3. Task-wise PCA features represented by 100 principal components

The code uses a reproducible random seed and a **70% training / 30% testing holdout split**.

Classification assessment includes confusion matrices and supporting evaluation functions. Decision Tree hyperparameter optimization is also explored.

### 5. Regression analysis

In addition to Alzheimer's disease classification, the project investigates prediction of selected handwriting measurements using **Support Vector Regression (SVR)**.

The regression experiments compare different predictor groups, including:
- Features from individual handwriting tasks
- Features combined across multiple tasks
- Measurements from tasks belonging to related handwriting categories

Custom regression metrics are used to assess predictions.

### 6. Statistical analysis

The project also includes exploratory statistical testing:

- Anderson–Darling normality testing
- Discretization of selected continuous handwriting variables
- Kruskal–Wallis non-parametric tests
- Multiple-comparison procedures

These analyses explore relationships between selected handwriting features.

---

## Repository Structure

```text
.
├── Alzheimer.m
├── Alzheimer.mlx
├── StructCorrMatrix.mat
├── README.md
├── .gitignore
├── Rsq.m
├── accuracy_to_do.m
├── cMetrics.m
├── f1_to_do.m
├── fallout_to_do.m
├── mae.m
├── mse.m
├── precision_to_do.m
├── predictiveTotals_to_do.m
├── rMetrics.m
├── recall_to_do.m
├── rmse.m
└── specificity_to_do.m
```

**Main files**

- `Alzheimer.m` — Main MATLAB analysis script.
- `Alzheimer.mlx` — Original MATLAB Live Script.
- `StructCorrMatrix.mat` — Precomputed correlation matrices stored in a MATLAB structure. These were saved to avoid repeating the correlation calculations during subsequent runs.
- `cMetrics.m` — Supporting classification evaluation function.
- `rMetrics.m` — Supporting regression evaluation function.
- Other `.m` files — Additional supporting metric functions.
- `.gitignore` — Excludes the local dataset and temporary development files.

---

## Requirements

- MATLAB R2023a (version used for local execution)
- MATLAB toolboxes providing the statistical and machine learning functions used by the script, including functions such as `pca`, `fitcnb`, `fitctree`, `fitcsvm`, `fitrsvm`, and `kruskalwallis`

The complete toolbox dependency list has not yet been independently verified.

---

## How to Run

1. Clone or download this repository.
2. Obtain the DARWIN dataset from the official source.
3. Prepare a MATLAB file named `Alzheimer.mat` containing a compatible table variable named `Dataset`.
4. Place `Alzheimer.mat` in the project directory.
5. Open MATLAB and set the current working folder to the project directory.
6. Open and run `Alzheimer.m`.

The script loads both `Alzheimer.mat` and `StructCorrMatrix.mat` from the current working directory.

**Reproducibility note:** The original MATLAB script has been executed successfully in MATLAB R2023a in its development environment. Reproduction from a fresh download of the public dataset has not yet been verified.

Some sections generate multiple figures and may require additional execution time.

---

## Methodological Limitations

This repository preserves the original academic implementation. Several aspects should be considered when interpreting its results.

### Potential data leakage

In the original workflow, outlier handling, normalization, feature selection, and PCA are performed before the training/test split.

As a result, information from the eventual test observations may influence preprocessing and feature extraction.

This can lead to **optimistic performance estimates** and should be addressed in a more rigorous evaluation pipeline.

### Model validation

The original experiments primarily use a single 70/30 holdout split. A more robust assessment would include appropriate cross-validation and independent model evaluation.

Hyperparameter selection should also be performed without using the final test set.

### Dataset size

The dataset contains 174 participants and a relatively large number of features. This creates a risk of overfitting and limits the conclusions that can be drawn about generalization.

### Clinical interpretation

The project is an educational machine learning investigation. Its predictions must not be interpreted as clinical diagnoses or evidence of real-world diagnostic reliability.

---

## Future Development

A Python redevelopment is planned to improve reproducibility and strengthen the machine learning methodology.

Potential improvements include:

- Reimplementing the workflow with NumPy, pandas, and scikit-learn
- Separating training and test data before fitting preprocessing transformations
- Using scikit-learn pipelines to reduce the risk of data leakage
- Introducing stratified cross-validation and more systematic hyperparameter tuning
- Comparing classification models using clearly documented evaluation metrics
- Improving code organization and reproducibility

**Status:** Planned. The Python redevelopment has not yet started.

---

## Reference

Cilia, N. D., et al. (2022). *Diagnosing Alzheimer's disease from on-line handwriting: A novel dataset and performance benchmarking*. **Engineering Applications of Artificial Intelligence, 111**, 104822.

DOI: https://doi.org/10.1016/j.engappai.2022.104822

Dataset: https://archive.ics.uci.edu/dataset/732/darwin

The dataset and the original research belong to their respective authors. This repository presents a separate academic analysis using the published dataset.

---

## Disclaimer

This project is provided for educational and portfolio purposes only. It is not a medical device, a clinical decision-support system, or a validated diagnostic tool.