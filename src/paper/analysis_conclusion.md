---
title: "Regression: Analysis & Conclusion"

author: "team 03"
date: "2024-09-27"
output: html_document
---

## 1. Assumptions of multi-linear Regression

The assumptions of the linear regression models are checked by generating diagnostic plots.





### Multiple Linear Regression

Because of low correlation between the two independent variables, a multiple linear regression is run. `log_averageRating` is the dependent variable, `total_years` and `log_episode_count` are the independent variables and `log_numVotes` is used as the control variable.





### a. Residuals vs. Fitted Plot


<img src="figure/residuals plot model-1.png" width="2400" style="display: block; margin: auto;" />

#### Inference:
The plot shows a non-random pattern, with a slight funnel shape, indicating both heteroscedasticity and potential non-linearity.The non-linearity and heteroscedasticity in the residuals suggest that the model does not fully capture the complexity of the relationships between the variables.This limits the precision of the estimates and this limitation is being acknowledged for further research and to indicate the results of the regression might not be robust.


### b. Q-Q Plot for normality check

<img src="figure/qqplot model 2-1.png" width="2400" style="display: block; margin: auto;" />

#### Inference:
The Q-Q plot shows a deviation from the straight line, particularly at the tails, suggesting that the residuals are not perfectly normally distributed.The assumption of normality of residuals is violated.It indicates that the estimates for p-values and confidence intervals might be slightly affected, especially for extreme values.However, we proceed with the current model while acknowledging the deviation. 


### c. Scale-Location Plot for homoscedasticity check

<img src="figure/scale-loc plot 2-1.png" width="2400" style="display: block; margin: auto;" />

#### Inference:
The plot reveals an increasing spread of residuals as fitted values increase, indicating heteroscedasticity.The presence of heteroscedasticity suggests that the residuals do not have constant variance, which may reduce the efficiency of the regression coefficients. However, the overall validity of the model is still acceptable, though heteroscedasticity is acknowledged as a limitation.


### d. Residuals vs. Leverage Plot to detect influential points

<img src="figure/leverage 2-1.png" width="2400" style="display: block; margin: auto;" />


#### Inference:
Some points exhibit high leverage and fall outside the Cook’s distance line, indicating the presence of influential points that could have a disproportionate impact on the model.These influential points might be affecting the regression coefficients. Their influence, however, is acknowledged without taking further corrective action since the IQR method was already employed for removing outliers.


## 2. Regression output inference

### a. Summary:


Call:
lm(formula = log_averageRating ~ +total_years + log_episode_count + 
    log_numVotes, data = cleaned_data_model_02)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.88211 -0.09661  0.04525  0.14512  0.38177 

Coefficients:
                    Estimate Std. Error t value Pr(>|t|)    
(Intercept)        2.207e+00  4.686e-04 4709.60   <2e-16 ***
total_years        2.439e-04  2.747e-05    8.88   <2e-16 ***
log_episode_count -1.993e-02  7.378e-05 -270.18   <2e-16 ***
log_numVotes      -1.747e-02  7.950e-05 -219.70   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.2062 on 3565185 degrees of freedom
Multiple R-squared:  0.03992,	Adjusted R-squared:  0.03992 
F-statistic: 4.941e+04 on 3 and 3565185 DF,  p-value: < 2.2e-16

### b. Inference: 

### Statistical Significance: (<2.2e-16)
The very low p value of less than 0.05, shows that the model as a whole is statistically significant,and at least one of the predictors is significantly related to the dependent variable.


### Intercept: (2.208)
The intercept value of 2.208 suggests the baseline for `log_averageRating` when all other variables are zero.


### `total_years`: (0.0002457)

The value suggests that for each additional year a series is aired, there is a very small but positive increase in the `log_averageRating`


### `log_episode_count` : (-0.02009)

This suggests a slight negative relationship; as `log_episode_count` increases, the `log_averageRating` slightly decreases, implying that longer series (in terms of episodes) tend to receive slightly lower ratings.


### `log_numVotes`: (-0.01753)

This indicates that as the (log) number of votes increases , the `log_averageRating` tends to decrease slightly. More votes generally mean more popularity,maybe more exposure leads to slightly lower ratings overall, possibly due to a wider range of opinions.


### Model Fit : (R2 0.04033)

This indicates that the model explains about 4% of the variance in `log_averageRating`. This relatively low value, indicates that while the predictors (`total_years`, `log_episode_count`, and `log_numVotes`) are statistically significant,it does not explain much of the variation in `averageRating`.


## 3. Conclusion

The analysis findings suggest that both `total_years` and `episode_count` have statistical significance but small effects on the dependant varaible `averageRating`. The findings indicate that longer series in terms of episode count are associated with slightly lower ratings. This suggests that viewer engagement might decrease as the number of episodes increases, likely due to viewer fatigue.However, the number of years a series airs has a small but positive impact on ratings. This indicates that series that have longevity in terms of years tend to perform slightly better in terms of ratings, possibly due to a loyal viewer base.The number of votes (as a proxy for popularity) is negatively associated with ratings, suggesting that series with a broader reach may face more critical reviews from a diverse audience, leading to slightly lower average ratings.

Despite the statistical significance of these variables, the overall explanatory power of the model is limited, as evidenced by the low R-squared value. This suggests that there maybe other factors that play a more substantial role in determining the success of a TV series.

While the length of a series should be a consideration for content creators and producers, it is not the sole determinant of a series' success. Further research should explore additional factors that contribute to viewer satisfaction and engagement to provide a more comprehensive understanding of what drives TV series ratings.
