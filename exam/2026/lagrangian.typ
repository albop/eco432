#let show_correction = true

#let correction(content) = {
  if show_correction {
    block(
      fill: luma(240),
      stroke: (left: 2pt +  luma(100)),
      inset: 1em,
      radius: 4pt,
      width: 100%,
      content
    )
  }
}

#set text(font: "New Computer Modern", size: 12pt)
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  numbering: "1"
)
#set par(justify: true)
#set heading(numbering: (..nums) => "Exercice " + numbering("1.", ..nums))
 
#align(center)[
  #text(14pt, weight: "bold")[ECO432 - Macroéconomie]\
  #v(0.5em)
  #text(12pt)[Examen - Mars 2026]\
  \
  #text(style: "italic")[Durée: 2h. Documents autorisés: dictionnaire papier et une feuille A4 manuscrite.]
]

#v(1cm)




= Indice des Prix et Demande

On considère une économie composée d'un nombre fini $N$ de variétés de biens, indexées par $i = 1, ..., N$. Le panier de consommation final est un agrégat $C_t$ de ces variétés selon la fonction CES (Dixit-Stiglitz) discrète :
$ C_t = (sum_(i=1)^N C_t(i)^((epsilon-1)/epsilon))^(epsilon/(epsilon-1)) $
où $epsilon > 1$ est l'élasticité de substitution entre les biens.

Le consommateur cherche à minimiser sa dépense totale $ E_t = sum_(i=1)^N P_t(i) C_t(i) $ pour atteindre un niveau donné de consommation agrégée $C_t$.

1. Écrivez le lagrangien du problème de minimisation de la dépense sous contrainte.
2. Dérivez la condition de premier ordre pour chaque bien $i$.
2. Montrez que la demande optimale pour chaque variété est donnée par :
   $ C_t(i) = (P_t(i) / P_t)^(-epsilon) C_t $
   où $P_t$ est l'indice des prix idéal définie par $P_t = (sum_(i=1)^N P_t(i)^(1-epsilon))^(1/(1-epsilon))$.
3. Vérifiez que pour ces demandes optimales, la dépense totale est bien égale à $P_t C_t$.

#correction[
   1. Le lagrangien s'écrit :
      $ cal(L) = sum_(i=1)^N P_t(i) C_t(i) - lambda_t [ (sum_(i=1)^N C_t(i)^((epsilon-1)/epsilon))^(epsilon/(epsilon-1)) - C_t ] $
   
   2. La CPO par rapport à $C_t(i)$ donne :
      $ P_t(i) = lambda_t ((epsilon)/(epsilon-1)) C_t^(1/epsilon) ((epsilon-1)/(epsilon)) C_t(i)^(-1/epsilon) $
      $ P_t(i) = lambda_t (C_t / C_t(i) )^(1/epsilon) $
   
   3. On inverse la relation pour obtenir $C_t(i)$ :
      $ C_t(i) = (P_t(i)/lambda_t)^(-epsilon) C_t $
      Pour trouver $lambda_t$, on substitue ces demandes dans la contrainte agrégatrice :
      $ C_t = (sum_(i=1)^N [(P_t(i)/lambda_t)^(-epsilon) C_t]^((epsilon-1)/epsilon))^(epsilon/(epsilon-1)) $
      $ 1 = lambda_t^epsilon (sum P_t(i)^(1-epsilon))^(epsilon/(epsilon-1)) $
      Cela implique que $lambda_t = (sum P_t(i)^(1-epsilon))^(1/(1-epsilon))$, ce qui correspond à la définition de l'indice $P_t$.
      Donc $C_t(i) = (P_t(i)/P_t)^(-epsilon) C_t$.
      
   4. La dépense totale est :
      $ sum_(i=1)^N P_t(i) C_t(i) = sum P_t(i) (P_t(i)/P_t)^(-epsilon) C_t = C_t P_t^epsilon sum P_t(i)^(1-epsilon) $
      Or, par définition, $P_t^(1-epsilon) = sum P_t(i)^(1-epsilon)$.
      Donc $E_t = C_t P_t^epsilon P_t^(1-epsilon) = P_t C_t$.
]

= La courbe de Phillips Néo-Keynésienne (Dérivation)

On considère maintenant une économie avec un grand nombre de firmes.

On suppose une rigidité des prix à la Calvo : à chaque période, une firme a une probabilité $1-theta$ de pouvoir réoptimiser son prix (elle fixe alors $P_t^*$). Avec une probabilité $theta$, elle doit garder son prix inchangé ($P_t(i) = P_(t-1)(i)$).

1. Écrivez la loi d'évolution de l'indice des prix agrégés $P_t$ (supposé être un agrégateur CES standard) en fonction de $P_t^*$ et $P_(t-1)$.
En effectuant une approximation log-linéaire autour d'un état stationnaire à inflation nulle, montrez que l'inflation $pi_t = p_t - p_(t-1)$ est proportionnelle à l'écart entre le prix optimal et le niveau moyen des prix :
$ pi_t = (1-theta)/theta (p_t^* - p_t) $

#correction[
  L'indice des prix évolue selon :
  $ P_t^(1-epsilon) = (1-theta) (P_t^*)^(1-epsilon) + theta P_(t-1)^(1-epsilon) $
  En divisant par $P_(t-1)^(1-epsilon)$ et en log-linéarisant autour de l'état stationnaire où $P_t/P_(t-1) = 1$ et $P_t^* / P_(t-1) = 1$ :
  $ (1-epsilon) pi_t approx (1-theta) (1-epsilon) (p_t^* - p_(t-1)) $
  $ pi_t = (1-theta) (p_t^* - p_t + pi_t) $
  $ theta pi_t = (1-theta) (p_t^* - p_t) $
  D'où le résultat : $pi_t = (1-theta)/theta (p_t^* - p_t)$.
]

2. Une firme qui a l'opportunité de changer son prix au temps $t$ choisit $P_t^*$ pour maximiser la somme actualisée de ses profits futurs attendus, sachant que ce prix restera effectif avec probabilité $theta^k$ à la période $t+k$.
La condition de premier ordre (simplifiée) s'écrit :
$ E_t sum_(k=0)^infinity (beta theta)^k Q_(t, t+k) Y_(t+k|t) (P_t^* - cal(M) P_(t+k) M C_(t+k)) = 0 $
où $M C_t$ est le coût marginal réel.
Expliquez intuitivement pourquoi le prix optimal $P_t^*$ est une moyenne pondérée des coûts marginaux nominaux futurs attendus.

#correction[
  La firme sait que son prix $P_t^*$ risque d'être bloqué pour plusieurs périodes. Elle ne doit pas seulement couvrir son coût marginal actuel, mais aussi anticiper l'évolution future de ses coûts. Si elle anticipe une hausse future des coûts marginaux (inflation des coûts), elle fixe un prix plus élevé dès aujourd'hui ("Front-loading"). Le prix optimal est donc un *markup* constant $cal(M)$ sur une "moyenne" des coûts marginaux nominaux futurs ($P_(t+k) M C_(t+k)$) durant la période de validité du prix.
]

3. On admet que la log-linéarisation de la condition de prix optimal conduit à la relation suivante :
$ p_t^* - p_t = (1 - beta theta) sum_(k=0)^infinity (beta theta)^k E_t [ m c_(t+k) + p_(t+k) - p_t ] $
où $m c_t$ est la log-déviation du coût marginal réel.
Montrez que cette équation peut se réécrire sous la forme :
$ p_t^* - p_t = (1 - beta theta) m c_t + beta theta E_t [ p_(t+1)^* - p_(t+1) + pi_(t+1) ] $
(Indice : séparez le terme $k=0$ et utilisez les propriétés de la somme infinie).

#correction[
  On décompose la somme : terme $k=0$ + reste de la somme.
  $ p_t^* - p_t = (1 - beta theta) m c_t + (1 - beta theta) sum_(k=1)^infinity (beta theta)^k E_t [ m c_(t+k) + p_(t+k) - p_t ] $
  On peut faire apparaître les termes futur en $t+1$. En notant $Q_t = p_t^* - p_t$, on exploite la structure récursive "Forward Looking".
  Le terme de somme décalé correspond à $beta theta E_t [ p_(t+1)^* - p_(t+1) ]$ ajusté de l'inflation pour passer de $p_t$ à $p_(t+1)$.
  $ p_t^* - p_t = (1 - beta theta) m c_t + beta theta E_t [ p_(t+1)^* - p_(t+1) + pi_(t+1) ] $
]

4. En combinant le résultat de la question 2 ($p_t^* - p_t = theta/(1-theta) pi_t$) et celui de la question 4, dérivez la courbe de Phillips Néo-Keynésienne (NKPC) reliant l'inflation à ses anticipations et au coût marginal réel :
$ pi_t = beta E_t pi_(t+1) + lambda m c_t $
Donnez l'expression du paramètre $lambda$ en fonction de $beta$ et $theta$.

#correction[
  On remplace $p_t^* - p_t$ par $theta/(1-theta) pi_t$ :
  $ theta/(1-theta) pi_t = (1 - beta theta) m c_t + beta theta E_t [ theta/(1-theta) pi_(t+1) + pi_(t+1) ] $
  
  Le terme entre crochets se simplifie :
  $ theta/(1-theta) pi_(t+1) + pi_(t+1) = pi_(t+1) ( theta/(1-theta) + 1 ) = pi_(t+1) ( (theta + 1 - theta)/(1-theta) ) = 1/(1-theta) pi_(t+1) $
  
  Donc :
  $ theta/(1-theta) pi_t = (1 - beta theta) m c_t + beta theta/(1-theta) E_t pi_(t+1) $
  
  En multipliant tout par $(1-theta)/theta$ :
  $ pi_t = (1-theta)(1-beta theta)/theta m c_t + beta E_t pi_(t+1) $
  
  On obtient la NKPC standard avec la pente :
  $ lambda = ((1-theta)(1-beta theta))/theta $
]

5. Pour passer de la relation en coûts marginaux ($m c_t$) à la relation en écart de production ($y_t$), on utilise généralement une relation de la forme $m c_t = (sigma + phi) y_t$.
   Récrivez l'équation finale (Courbe de Phillips Néo-Keynésienne) en fonction de l'output gap.
   Commentez : Selon ce modèle, l'inflation est-elle un phénomène purement rétrospectif (inertie) ou prospectif (anticipations) ?

#correction[
  En substituant $m c_t$ :
  $ pi_t = beta E_t pi_(t+1) + kappa y_t $
  avec $kappa = lambda (sigma + phi) = ((1-theta)(1-beta theta))/theta (sigma + phi)$.
  
  Selon ce modèle (NKPC pure), l'inflation est un phénomène purement *prospectif* (forward-looking). L'inflation d'aujourd'hui dépend de la demande présente ($y_t$) et de toute la séquence future d'écarts de production anticipés (via le terme $E_t pi_(t+1)$ itéré). Il n'y a pas d'inertie intrinsèque dans ce modèle de base (pas de terme $pi_(t-1)$), ce qui est souvent critiqué car l'inflation réelle montre de la persistance.
]

= Politique Monétaire et Déterminations

On considère un modèle Néo-Keynésien standard décrit par les deux équations log-linéarisées suivantes, représentant respectivement la courbe IS dynamique et la courbe de Phillips (PC) :

$ y_t &= E_t y_(t+1) - 1/sigma (i_t - E_t pi_(t+1) - r_t^n) quad &"(IS)" \
pi_t &= beta E_t pi_(t+1) + kappa y_t quad &"(PC)" $

où $y_t$ est l'écart de production (output gap), $pi_t$ l'inflation, $i_t$ le taux d'intérêt nominal, et $r_t^n$ le taux d'intérêt naturel (exogène). Les paramètres $sigma, kappa > 0$ et $0 < beta < 1$ sont strictement positifs.

On cherche à analyser la stabilité du système sous différentes règles de politique monétaire.

1. *Règle de taux d'intérêt statique (Peg)*
   
   Supposons que la Banque Centrale fixe le taux d'intérêt nominal à une valeur constante, indépendante des conditions économiques (par exemple $i_t = overline(i)$).
   
   a. Réécrivez le système sous la forme matricielle :
   $ mat(E_t y_(t+1); E_t pi_(t+1)) = A mat(y_t; pi_t) + B_t $
   où $A$ est une matrice $2 times 2$ que vous déterminerez.

#correction[
   On part de la PC : $pi_t = beta E_t pi_(t+1) + kappa y_t => E_t pi_(t+1) = 1/beta pi_t - kappa/beta y_t$.
   
   On injecte dans la IS :
   $ E_t y_(t+1) = y_t + 1/sigma (i_t - E_t pi_(t+1) - r_t^n) $
   $ E_t y_(t+1) = y_t + 1/sigma (i_t - (1/beta pi_t - kappa/beta y_t) - r_t^n) $
   $ E_t y_(t+1) = (1 + kappa/(sigma beta)) y_t - 1/(sigma beta) pi_t + 1/sigma (i_t - r_t^n) $
   
   La matrice $A$ est donc :
   $ A = mat(1 + kappa/(sigma beta), -1/(sigma beta); -kappa/beta, 1/beta) $
]

   b. Calculez la trace et le déterminant de la matrice $A$.

#correction[
   - $det(A) = (1 + kappa/(sigma beta)) dot 1/beta - (-1/(sigma beta)) dot (-kappa/beta) = 1/beta + kappa/(sigma beta^2) - kappa/(sigma beta^2) = 1/beta$.
   - $op("Trace")(A) = 1 + kappa/(sigma beta) + 1/beta = 1 + 1/beta (1 + kappa/sigma)$.
]
   
   c. En utilisant les conditions de Blanchard-Kahn, discutez de la stabilité du système (déterminacy). Rappel : pour qu'il existe un unique chemin d'équilibre stable (déterminé) dans un modèle avec deux variables "forward-looking" ($y_t$ et $pi_t$), combien de valeurs propres de la matrice $A$ doivent être de module supérieur à 1 ? Le système est-il déterminé sous cette règle stricte ?

#correction[
   Nous avons deux variables forward-looking : $pi_t$ et $y_t$ (ce sont des variables de saut, non prédéterminées).
   La condition de Blanchard-Kahn pour l'existence d'équilibre unique (déterminé) est que les *deux* valeurs propres de la matrice $A$ doivent être de module supérieur à 1.
   
   On a :
   $det(A) = lambda_1 lambda_2 = 1/beta > 1$ (car $beta < 1$).
   $op("Trace")(A) = lambda_1 + lambda_2 = 1 + 1/beta + kappa/(sigma beta) > 2$.
   
   Le polynôme caractéristique est $P(lambda) = lambda^2 - op("Trace")(A) lambda + det(A)$.
   $P(1) = 1 - (1 + 1/beta + kappa/(sigma beta)) + 1/beta = - kappa/(sigma beta) < 0$.
   Puisque $P(1) < 0$ et que la parabole est ouverte vers le haut ($lambda^2$), les racines sont de part et d'autre de 1. L'une est inférieure à 1, l'autre supérieure à 1.
   
   Conclusion : Il n'y a qu'une seule valeur propre instable ($>1$). La condition de Blanchard-Kahn n'est pas remplie (il en faudrait deux). Le système est donc *indéterminé* : il existe une infinité de trajectoires d'équilibre (sunspots). Une règle de taux fixe ne permet pas d'ancrer les anticipations.
]

2. *Règle prospective (Forward-Looking Rule)*

   La Banque Centrale adopte désormais une règle de Taylor prospective, où le taux d'intérêt réagit à l'inflation anticipée :
   $ i_t = r_t^n + phi_pi E_t pi_(t+1) $
   avec $phi_pi > 0$.

   a. Substituez cette règle dans l'équation (IS). Montrez que le système se simplifie considérablement.
   
#correction[
   On remplace $i_t$ dans la IS :
   $ y_t = E_t y_(t+1) - 1/sigma (r_t^n + phi_pi E_t pi_(t+1) - E_t pi_(t+1) - r_t^n) $
   Les termes $r_t^n$ s'annulent.
   $ y_t = E_t y_(t+1) - 1/sigma (phi_pi - 1) E_t pi_(t+1) $
]

   b. Exprimez $E_t y_(t+1)$ en fonction de $y_t$ et des autres variables.
   
#correction[
   De l'équation précédente :
   $ E_t y_(t+1) = y_t + (phi_pi - 1)/sigma E_t pi_(t+1) $
   En utilisant la PC ($E_t pi_(t+1) = 1/beta pi_t - kappa/beta y_t$), on peut exprimer $E_t y_(t+1)$ en fonction de $y_t$ et $pi_t$.
]

   c. Analysez à nouveau les conditions de stabilité (déterminacy). Quelle condition le paramètre $phi_pi$ doit-il respecter pour assurer l'existence d'un équilibre unique (principe de Taylor) ?
   
#correction[
   Le système dynamique devient :
   $ mat(E_t y_(t+1); E_t pi_(t+1)) = A' mat(y_t; pi_t) $
   avec $A' = mat(1 + kappa(phi_pi-1)/(sigma beta), (phi_pi-1)/(sigma beta); -kappa/beta, 1/beta)$.
   
   On peut montrer que pour avoir deux valeurs propres de module supérieur à 1 (détermination), il faut que *$phi_pi > 1$*.
   C'est le *Principe de Taylor* : la banque centrale doit augmenter le taux d'intérêt nominal plus que proportionnellement à l'augmentation de l'inflation anticipée pour augmenter le taux réel et refroidir l'économie.
]
   
   d. Interprétez économiquement ce résultat. Pourquoi une réaction trop faible de la Banque Centrale aux anticipations d'inflation ($phi_pi < 1$) peut-elle conduire à une instabilité (spirales inflationnistes ou déflationnistes) ?

#correction[
   Si $phi_pi < 1$, une hausse des anticipations d'inflation entraîne une hausse du taux nominal plus faible que l'inflation. Le taux d'intérêt réel ($i_t - E_t pi_(t+1)$) *baisse*. Une baisse du taux réel stimule la demande (IS), ce qui augmente l'écart de production et donc l'inflation via la courbe de Phillips. Cela valide et renforce les anticipations d'inflation initiales : c'est une spirale inflationniste auto-réalisatrice. L'équilibre est indéterminé.
]

3. *Discussion*

   Comparez les résultats obtenus dans les questions 1 et 2. En quoi l'adoption d'une règle active (réactive) est-elle supérieure à une fixation rigide des taux d'intérêt pour la stabilité macroéconomique ?

#correction[
   Le résultat montre qu'une règle passive (comme un "peg" de taux d'intérêt, $phi_pi = 0$) laisse l'économie sujette à l'indétermination et aux fluctuations purement spéculatives (sunspots). Pour garantir un équilibre unique et stable, la Banque Centrale doit adopter une règle *active* ($phi_pi > 1$) qui réagit vigoureusement à l'inflation. Cela permet d'ancrer les anticipations des agents privés.
]

