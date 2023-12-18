# Correction

## Exercise 2: Intertemporal Consumption

__Question 1__

At the end of period 1, agent saves $Y_1-C_1$ which yields $(Y_1-C_1)(1+r)$ to be consumed in the second period. Note that this quantity can potentially be negative if agent can borrow.
In the second period, consumption must be lower than total available income, which yields the budget constraint:

$$C_2 \leq (Y_1-C_1)(1+r) + Y_2$$

It can be rewritten as:


$$C_1 (1+r) + C_2 \leq Y_1 (1+r) + Y_2$$


In this equation, the right hand side represents total, intertemporal, income. The left-hand side is total spending where "price" in period 1 is $1+r$. It is $1$ in period 2.

![](demand.png)

A particular indifference curve is characterized by equation 

$$log(C_1) + \beta log(C_2)=K$$

where $K$ is a constant. To compute the marginal rate of substitution $\frac{\partial C_2}{\partial C_1}$ along the curve, we can differentiate this equation to get:

$$\frac{1}{C_1}\partial C_1 + \beta \frac{1}{C_2} \partial C_2=0$$

from which we get:

$$\left. \frac{\partial C_2}{\partial C_1} \right|_{\text{indifference curve}} = -\frac{1}{\beta}\frac{C_2}{C_1}$$

$\frac{\partial C_2}{\partial C_1}$ is the slope of the indifference curve at a given point $(C_1, C_2)$. It is also called the marginal rate of substitution.

We can also provide the precise equation for an indifference curve, by using the relation above to get:

$$log(C_2) = \frac{K- log(C_1)}{\beta}$$

or

$$C_2 = exp(\frac{K}{\beta})C_1^{-\frac{1}{\beta}}$$

If the budget constraint was not binding it would be possible for the agent to consume more in both periods, which can't be optimal. Hence it must be binding and the optimal choice must be on the budget line:


$$(1+r) C_1 + C_2 = Y_1 (1+r) + Y_2$$

At the optimal choice, the budget constraint must be a tangent of the indifference curve (see micro course). In particular, it needs to have the same slope. We obtain the slope of the budget constraint by differentiating the above equation:

$$(1+r) \partial C_1 + \partial C_2 = 0$$

or 

$$\left. \frac{\partial C_2}{\partial C_1} \right|_{\text{budget constraint}}= -(1+r)$$

The identity: 

$$ \left. \frac{\partial C_2}{\partial C_1} \right|_{\text{budget constraint}} = \left. \frac{\partial C_2}{\partial C_1} \right|_{\text{indifference curve}}$$

leads to [^footnote] Euler equation:

$$\beta (1+r) \frac{1}{C_2} = \frac{1}{C_1}$$


[^footnote]: In microeconomics, when the choice is made between two goods at prices $p_1$ and $p_2$, with overall utility $U(C_1, C_2)$, the optimality condition is $\frac{U^{\prime}_{C_2}}{U^{\prime}_{C_1}}=\frac{p_2}{p_1}$. Here we can set $p_1 = (1+r)$, $p_2=1$ and we have $U(C_1, C_2)=log(C_1) + \beta log(C_2)$ so that $U^{\prime}_{C_1}=\frac{1}{C_1}$ and $U^{\prime}_{C_2}=\beta \frac{1}{C_2}$.

To get the actual consumption, we can combine the Euler equation to substitute $C_2$ in the budget line:

$$(1+r)  C_1 + \underbrace{\beta (1+r) C_1}_{C_2} = Y_1 (1+r) + Y_2$$

from which we obtain:

$$C_1 = \frac{1}{1+\beta} \left(  Y_1  + \frac{1}{1+r }Y_2 \right)$$

It is the same formula as in the course.

Using budget constraint again, we get consumption in period 2: 

$$\begin{aligned}C_2 &=& (1+r)Y_1 + Y_2 - \underbrace{(1+r) \frac{1}{1+\beta} \left(  Y_1  + \frac{1}{1+r }Y_2 \right)}_{C_2}\\ &=&\frac{\beta}{1+\beta}\left( (1+r)Y_1+Y_2\right)
\end{aligned}$$

Using the formula for $C_1$, we find that that a an increase in $Y_1$ by $\Delta Y_1$, leaving $Y_2$ unchanged, increases consumption by:

$$\Delta C_1 = \frac{1}{1+\beta} \Delta Y_1$$

so that the marginal propensity to consumer out of a temporary income shock is :

$$\frac{\Delta C_1}{\Delta Y_1} = \frac{1}{1+\beta}$$

If agent is rather patient ($\beta \approx 1$), marginal propensity to consume is about $50\%$.

To get the sensitivity with respect to an increase in the interest rate $\Delta r$, we must differentiate the expression for $C_1$ to get: 

$$\Delta C_1 = -\frac{Y_2}{(1+r)^2} \Delta r$$

Semi-elasticity is the percentage of consumption divided by the increase in interest rate (in level):


$$\frac{\frac{\Delta C_1}{C_1}}{\Delta r} = -\frac{Y_2}{C_1}\frac{1}{(1+r)^2} = - \frac{Y_2}{\frac{1}{1+\beta} \left(  Y_1  + \frac{1}{1+r }Y_2 \right)} \frac{1}{(1+r)^2}$$


__Question 2__

The borrowing constraint: 

$$C_1 - Y_1\leq \kappa Y_1$$

states that the loan to income ratio must be smaller than $\kappa$: 

$$\frac{\overbrace{C_1 - Y_1}^{\text{loan}}}{\underbrace{Y_1}_{\text{income}}}\leq \kappa$$

Assuming the agent is constrained the consumption is directly given by:

$$C_1 = (1+\kappa)Y_1$$

In the course, the no-borrowing constraint, led us to define the consumption of keynesian agents as $C_1=Y_1$.

The desired consumption was defined in question assuming agent is not constrained. The constraint will bind if desired consumption is higher than maximum consumption:

$$\underbrace{ (1+\kappa)Y_1}_{\text{maximum consumption}} \leq \underbrace{\frac{1}{1+\beta} \left(  Y_1  + \frac{1}{1+r }Y_2 \right)}_{\text{desired consumption}} $$

$$Y_1 \leq \left(\frac{1}{1+\kappa-\frac{1}{1+\beta}} \frac{1}{1+\beta} \frac{1}{1+r }\right) Y_2  $$

We find that agent is constrained if income in the first period is too small. The higher the kappa, the higher the ability to borrow, and the lower the required income in period 1.

By differentiating constrained consumption:

$$\Delta C_1 = (1+\kappa) \Delta Y_1$$

we get the marginal propensity to consume by 

$$\frac{\Delta C_1}{\Delta Y_1} = (1+\kappa)$$


We can see that the ability to borrow increases the marginal propensity to consume since additional income allows for direct spending and for additional spending fueled by borrowing.

__Question 3__

Now constrained consumption is given by:

$$C_1 = Y_1 + \nu H$$

with $H=H_0\frac{1}{r}$

Marginal propensity to consume is

$$\frac{\Delta C_1}{\Delta Y_1} = 100\%$$

as for the baseline agent.

However, a small increases $\Delta r$ in interest rate, changes the value of the house by:

$$\Delta H = - H_0 \frac{1}{r^2} \Delta r$$

Because interest rate is typically a few percents, the ratio $\frac{1}{r^2}$ is typically very high meaning that house value is very dependent on interest rate.

The change in consumption following a change in interest rate is:

$$\Delta C_1 = \nu \Delta H = - \nu H_0 \frac{1}{r^2} \Delta r$$

Looking at ratio:


$$\frac{\Delta C_1}{\Delta r} = - \nu H_0 \frac{1}{r^2} $$

we see that borrowing against the collateralized value of a house, makes consumption very dependent on interest rates. This is one of the reason for why the central banks hesitate to increase rates too fast when many consumers have collateralized mortgages.
