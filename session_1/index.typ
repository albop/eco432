#import "@preview/touying:0.5.3": *
#import "@preview/fontawesome:0.3.0": *
#import "quarto_theme.typ": *

#show: clean-theme.with(
  aspect-ratio: "16-9",
  font-size: 16pt
)

#title-slide(
  title: [Solving DSGE models],
  subtitle: [ECO432 - Macroéconomie],
  authors: (
    (name: [Pablo Winant], affiliation: [], email: [], orcid: []),
  ),
  date: [2026/02/12],
)

==

#align(center)[
#image("assets/warning.png")
]

= Introduction
<introduction>
== 
<section>


What is the main specificity of economic modeling?

#pause

In (macro)economics, we #emph[model] the behaviour of economic agents by specifying:

- their objective $ max_(c_t) E_t sum_(s >= t) beta^s U (c_s) $ $ max pi_t $ $ dots $
- their constraints (budget constraint, econ. environment…)

#pause

This has important implications:

- macro models are #emph[forward looking]
  - rely on expectations
- macro models need to be #strong[solved]

In many cases, there is no closed form for the solution -\> we need #emph[numerical techniques]

== Dynare
<dynare>

#columns(2,[
  
- 1996: Michel Juillard created an opensource software to solve DSGE models
  - DSGE: Dynamic Stochastic General Equilibrium
  - usually solved around a steady-state
- Now about 10 contributors.
  - $+$ power users who have contributed to the code

- It has been widely adopted:
  - early version in Gauss
  - then Matlab/Octave/Scilab
  - latest version in Julia
  - … and Python (checkout #link("https://github.com/econforge/dyno.py")[dyno 🦖] with its simplified notations)

#colbreak()

#figure([
#box(image("assets/michel.jpeg"))
], caption: figure.caption(
position: bottom, 
[
Michel Juillard
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)
])

== DSGE Models in institutions
<dsge-models-in-institutions>
Nowadays most DSGE models built in institutions have a Dynare version (IMF/GIMF, EC/Quest, ECB/, NYFed/FRBNY)

- they are usually based on the #emph[midsize model] from Smets & Wouters (10 equations)
- but have grown up a lot (\>\>100 equations)

#pause

Institutions, led by researchers are diversifying their model

- Semi-Structural Models
- Computational General Equilibrium Models
- Network Models
- Agent-based Models
- Heterogenous Agents Models


= Solving a model
<solving-a-model>
== Model
<model>
A very concise representation of a model

$ bb(E)_t [f (y_(t + 1) \, y_t \, y_(t - 1) \, epsilon_t)] = 0 $

#block[
#block[
#block[
The #strong[problem];:

- $y_t in bb(R)^n$: the vector of endogenous variables
- $epsilon_t in bb(R)^(n_e)$: the vector of exogenous variables
  - we assume that $epsilon_t$ is a zero-mean gaussian process
- $f : bb(R)^n -> bb(R)^n$: the model equations

]
]
#block[
#block[
The #strong[solution];:

- $g$ such that $ forall t \, y_t = g (y_(t - 1) \, epsilon_t) $

]
]
]
#block[
The situation is different when one is making a perfect foresight simulation.

]
== The timing of the equations
<the-timing-of-the-equations>
#block[
#callout(
body: 
[
In a dynare modefile the model equations are coded in the `model; ... ; end;` block.

Variable $v_t$ (resp $v_(t - 1)$, $v_(t + 1)$) is denoted by `v` or `v(0)` (resp `v(-1)`, `v(+1)`).

In dyno, it is `v[t],v[t-1],v[t+1]`.


]
, 
title: 
[
Tip
]
, 
background_color: 
rgb("#ccf1e3")
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()

)
]
#strong[General Timing Convention]

New information arrives with the innovations $epsilon_t$.

At date $t$, the information set is spanned by $cal(F)_t = cal(F) (dots \, epsilon_(t - 3) \, epsilon_(t - 2) \, epsilon_(t - 1) \, epsilon_t)$

By convention #emph[an endogenous variable has a subscript $t$ if it is known first at date $t$];.

#pause

Several #strong[variable types] depending on how they appear in the model:

- jump variable: appear $t$ or $t + 1$
- predetermined variable: appear in $t - 1$ and $t$ (possibly $t + 1$)
- static variables: appear in $t$ only
  - can be expressed as a function of other variables


== Steady-state
<steady-state>
The deterministic steady-state satisfies:

$ f (overline(y) \, overline(y) \, overline(y) \, 0) = 0 $

Often, there is a closed-form solution.

Otherwise, one must resort to a numerical solver to solve

$ overline(y) -> f (overline(y) \, overline(y) \, overline(y) \, 0) $

#block[
#callout(
body: 
[
In dynare the steady-state values are provided in the `steadystate_model; ... ; end;` block. One can check they are correct using the `check;` statement.

To find numerically the steady-state: `steady;`.

]
, 
title: 
[
Tip
]
, 
background_color: 
rgb("#ccf1e3")
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()

)
]
== The implicit system
<the-implicit-system>
Replacing the solution $ y_t = g (y_(t - 1) \, epsilon_t) $ in the system $ bb(E)_t [f (y_(t + 1) \, y_t \, y_(t - 1) \, epsilon_t)] = 0 $

we obtain:

$ bb(E)_t [f (g (g (y_(t - 1) \, epsilon_t) \, epsilon_(t + 1)) \, g (y_(t - 1) \, epsilon_t) \, y_(t - 1) \, epsilon_t)] = 0 $

It is an equation defining implicitly the function $g ()$

== The state-space
<the-state-space>
$ bb(E)_t [f (g (g (y_(t - 1) \, epsilon_t) \, epsilon_(t + 1)) \, g (y_(t - 1) \, epsilon_t) \, y_(t - 1) \, epsilon_t)] = 0 $

In this expression, $y_(t - 1) \, epsilon_t$ is the state-space:

- it contains all information available at $t$ to predict the future evolution of $(y_s)_(s >= t)$

#pause

Dropping the time subscripts, the equation must be satisfied for any realization of $(y \, epsilon)$ $ forall (y \, epsilon) mid Phi (g) (y \, epsilon) = bb(E)_(epsilon') [f (g (g (y \, epsilon) \, epsilon ') \, g (y \, epsilon) \, y \, epsilon)] = 0 $

It is a functional equation $Phi (g) = 0$

== Expected shocks
<expected-shocks>
First order approximation:

- Assume $lr(|epsilon|) << 1$,$lr(|epsilon '|) << 1$

Perform a Taylor expansion with respect to future shock:

#pause

This uses the fact that $bb(E) [epsilon^(')] = 0$.

At first order, expected shocks play no role.

To capture precautionary behaviour (like risk premia), we would need to increase the approximation order.

== First order perturbation
<first-order-perturbation>
We are left with the system:

$ F (y \, epsilon) = f (g (g (y \, epsilon) \, 0) \, g (y \, epsilon) \, y \, epsilon) = 0 $

A variant of the #emph[implicit function theorem] then yields the existence of a first approximation of $g$:

$ g (y \, epsilon) = overline(y) + g_y^(') (y - overline(y)) + g_e^(') epsilon_t $

#pause

Unknown quantities $g_y^(')$, and $g_e^(')$ are obtained using the #emph[method of undetermined coefficients];. Plug the first approximation into the system and write the conditions $ F_y^(') (overline(y) \, 0) = 0 $ $ F_epsilon^(') (overline(y) \, 0) = 0 $

== Computing $g_y^(')$
<computing-gprime_y>
Recall the system: $ F (y \, epsilon) = f (g (g (y \, epsilon) \, 0) \, g (y \, epsilon) \, y \, epsilon) = 0 $

We have $ F_y^(') (overline(y) \, 0) = f_(y_(t + 1))^(') g_y^(') g_y^(') + f_(y_t)^(') g_y^(') + f_(y_(t - 1))^(') = 0 $

#pause

$g_y^(')$ is the solution of a specific Riccati equation $ A X^2 + B X + C $ where $A \, B \, C$ and $X = g_y^(')$ are square matrices $in bb(R)^n times bb(R)^n$

== First Order Deterministic Model
<first-order-deterministic-model>
Let's pause a minute to observe the first order deterministic model: $ A X^2 + B X + C $

From our intuition in dimension 1, we know there must be multiple solutions

- how do we find them?
- how do we select the right ones?

I the absence of shocks the dynamics of the model are given by $ y_t = X y_(t - 1) $

What is the condition for the model to be stationary?

#pause

\-\> the biggest eigenvalue of $X$ should be smaller than 1

#block[
Develop intuition in dimension 1.

]
== Multiplicity of solution
<multiplicity-of-solution>
It is possible to show that the system is associated with $2 n$ generalized eigenvalues:

$ lr(|lambda_1|) <= dots <= lr(|lambda_(2 n)|) $

For each choice $C$ of $n$ eigenvalues ($lr(|C|) = n$), a specific recursive solution $X_C$ can be #emph[constructed];. It has eigenvalues $C$.

#pause

This yields at least $vec(2 n, n)$ different combinations.

#pause

A model is well defined when there is #strong[exactly one solution that is non divergent];.

This is equivalent to:

$ lr(|lambda_1|) <= dots <= lr(|lambda_n|) <= 1 < lr(|lambda_(n + 1)|) <= dots <= lr(|lambda_(2 n)|) $

== Example 1
<example-1>
Forward looking inflation:

$ pi_t = alpha pi_(t + 1) $ with $alpha < 1$.

Is it well defined?

#pause

We can rewrite the system as:

$ alpha pi_(t + 1) - pi_t + 0 pi_(t - 1) = 0 $

or

$ pi_(t + 1) - (1 / alpha + 0) pi_t + (1 / alpha 0) pi_(t - 1) = 0 $

#pause

The generalized eigenvalues are $0 <= 1 < 1 / alpha$.

#pause

The unique stable solution is $pi_t = 0 pi_(t - 1)$

== Example 2
<example-2>
Debt accumulation equation by a rational agent:

$ b_(t + 1) - (1 + 1 / beta) b_t + 1 / beta b_(t - 1) = 0 $

Is it well-defined?

#pause

Two generalized eigenvalues $lambda_1 = 1 < lambda_2 = 1 / beta$

#pause

The unique non-diverging solution is $b_t = b_(t - 1)$.

- it is a #emph[unit-root];: any initial deviation in $b_(t - 1)$ has persistent effects

== Example 3
<example-3>
Productivity process: $ z_t = rho z_(t - 1) $ with $rho < 1$: well defined

#pause

In that case there is a hidden infinite eigenvalue $oo$ associated to $z_(t + 1)$.

#pause

To see why consider the system associated with eigenvalues $m$ and $rho$: $ z_(t + 1) - (m + rho) z_t + m rho z_(t - 1) = 0 $

$ 1 / m z_(t + 1) - (1 + rho / m) z_t + rho z_(t - 1) = 0 $

Which corresponds to the initial model when $m = oo$

#pause

The generalized eigenvalues are $lambda_1 = rho <= 1 < lambda_2 = oo$

More generally, any variable that does not appear in $t + 1$ creates one infinite generalized eigenvalue.

== A criterium for well-definedness
<a-criterium-for-well-definedness>
Looking again at the list of eigenvalues we set aside the infinite ones.

The model is well specified iff we can sort the eigenvalues as:

$ lr(|lambda_1|) <= dots <= lr(|lambda_n|) <= 1 < lr(|lambda_(n + 1)|) <= dots lr(|lambda_(n + k)|) <= underbrace(lr(|lambda_(n + k + 1)|) dots <= lr(|lambda_(2 n)|), upright("infinite eigenvalues")) $

#block[
#callout(
body: 
[
The model satisfies the Blanchard-Kahn criterium if the number of eigenvalues greater than one, is exactly equal to the number of variables #emph[appearing] in $t + 1$.

In that case the model is well-defined.

]
, 
title: 
[
Blanchard-Kahn criterium
]
, 
background_color: 
rgb("#dae6fb")
, 
icon_color: 
rgb("#0758E5")
, 
icon: 
fa-info()

)
]
== Computing the solution
<computing-the-solution>
There are several classical methods to compute the solution to the algebraic Riccati equation: $ A X^2 + B X + C = 0 $

- qz decomposition
  - traditionnally used in the DSGE literature since Chris Sims
  - a little bit unintuitive
- cyclic reduction
  - new default in dynare, more adequate for big models
- Bernouilli iteration (see section "Linear time iteration")
  - conceptually very simple

== Computing $g_e^(')$
<computing-gprime_e>
Now we have $g_y^(')$, how do we get $g_e^(')$?

Recall: $ F (y \, epsilon) = f (g (g (y \, epsilon) \, 0) \, g (y \, epsilon) \, y \, epsilon) = 0 $

We have $ F_e^(') (overline(y) \, 0) = f_(y_(t + 1))^(') g_y^(') g_e^(') + f_(y_t)^(') g_e^(') + f_(epsilon_t)^(') = 0 $

Now this is easy:

$ g_e^(') = - (f_(y_(t + 1))^(') g_y^(') + f_(y_t)^('))^(- 1) f_(epsilon_t)^(') = 0 $

== The model solution
<the-model-solution>
The result of the model solution: $ y_t = g_y y_(t - 1) + g_e epsilon_t $

It is an AR(1), driven by exogenous shock $epsilon_t$.

#pause

Because it is a well known structure, one can investigate the model with

- impulse response functions
- stochastic simulations

#pause

Then to compare the model to the data we compute

- implied moments:
  - covariances, autocorrelation
- likelihood

Optimizing the fit to the data is called #emph[model] estimation

= Conclusion
<sec-conclusion>
== What can you do with the solution
<what-can-you-do-with-the-solution>
The solution of a model found by Dynare has an especially simple form: an AR(1)

- $y_t = X y_(t - 1) + Y epsilon_t$
- where the covariances $Sigma$ of $epsilon_t$ can be chosen by the modeler

#pause

With this solution we can

- compute (conditional and unconditional) moments
- perform stochastic simulations, impulse response function

#pause

== Going Further
<going-further>
Taking the model to the data with Dynare

- "estimate" the model: compute the likelihood of a solution and maximize it by choosing the right parameters
- "identify" shocks in the data

Other functions

- higher order approximation
- (noninear) perfect foresight simulations
- ramsey plan
- discretionary policy
- …

= Appendix: Linear Time Iteration
<sec:linear_time_iteration>
== Linear Time Iteration
<linear-time-iteration>
Recall the system to solve: $ F (y \, epsilon) = f (g (g (y \, epsilon) \, 0) \, g (y \, epsilon) \, y \, epsilon) = 0 $

but now assume the decision rules today and tomorrow are different:

- today: $y_t = g (y_(t - 1) \, epsilon_t) = overline(y) + X y_(t - 1) + g_y epsilon_t$
- tomorrow: $y_(t + 1) = tilde(g) (y_t \, epsilon_(t + 1)) = overline(y) + tilde(X) y_(t - 1) + tilde(g)_y epsilon_t$

Then the Ricatti equation is written:

$ A tilde(X) X + B X + C = 0 $

== Linear Time Iteration (2)
<linear-time-iteration-2>
The linear time iteration algorithm consists in solving the decision rule $X$ today as a function of decision rule tomorrow $tilde(X)$.

This corresponds to the simple formula:

$ X = - (A tilde(X) + B)^(- 1) C $

And the full algorithm can be described as:

- choose $X_0$
- for any $X_n$, compute $X_(n + 1) = T (X_n) = - (A X_n + B)^(- 1) C$
  - repeat until convergence

== Linear Time Iteration (3)
<linear-time-iteration-3>
It can be shown that, starting from a random initial guess, the linear time-iteration algorithm converges to the solution $X$ with the smallest modulus:

$ underbrace(lr(|lambda_1|) <= dots <= lr(|lambda_n|), upright("Selected eigenvalues")) <= lr(|lambda_(n + 1)|) dots <= lr(|lambda_(2 n)|) $

In other words, it finds the right solution when the model is well specified.

How do you check it is well specified?

- $lambda_n$ is the biggest eigenvalue of solution $X$
- what about $lambda_(n + 1)$?
  - $1 / lambda_(n + 1)$ is the biggest eigenvalue of $(A X + B)^(- 1) A$

== Linear Time Iteration (4)
<linear-time-iteration-4>
Define $ M (lambda) = A lambda^2 + B lambda + C $

For any solution $X$, $M (lambda)$ can be factorized as: #footnote[Special case of Bezout theorem. Easy to check in that case]

$ M (lambda) = (lambda A + A X + B) (lambda I - X) $

and

$ det(M(lambda)) = underbrace(det(lambda A + A X + B), Q(lambda)) det(lambda I - X) $

By construction $Q(lambda)$ is a polynomial whose roots are those that are not selected by the solution, i.e. $Lambda in "Sp"(X)$.

== Linear Time Iteration (5)
<linear-time-iteration-5>
For $lambda != 0$ we have:

$ lambda in "Sp"((A X + B)^(-1) A) $

$ <=> det((A X + B)^(-1) A - I lambda) = 0 $

$ <=> det(1 / lambda A - I (A X + B)) = 0 $

$ <=> Q(1 / lambda) = 0 $

$ <=> 1 / lambda in Lambda in "Sp"(X) $

In words, $(A X + B)^(- 1)$ contains all the eigenvalues that have been rejected by the selection of $X$.

In particular, $rho((A X + B)^(-1) A) = 1 / min(Lambda in "Sp"(X))$.
