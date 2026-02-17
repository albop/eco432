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
#set heading(numbering: "Exercice 1.")

#align(center)[
  #text(14pt, weight: "bold")[ECO432 - Macroéconomie]\
  #v(0.5em)
  #text(12pt)[Examen - Mars 2026]\
  \
  #text(style: "italic")[Durée: 2h. Documents autorisés: dictionnaire papier et une feuille A4 manuscrite.]
]

#v(1cm)

= La courbe d'Offre Agrégée

On s'intéresse dans cet exercice aux fondements microéconomiques de la relation d'Offre Agrégée (ou courbe de Phillips Néo-Keynésienne) qui relie l'inflation $pi_t$ à l'écart de production $y_t$.

1. Rappelez la définition de la courbe d'Offre Agrégée à court terme. Comment se distingue-t-elle de l'Offre Agrégée de long terme ? Représentez graphiquement ces deux relations dans le plan $(pi, y)$.

#correction[
  La courbe d'Offre Agrégée de court terme (SRAS) représente la relation positive entre le niveau d'inflation (ou le niveau des prix) et la production lorsque certains prix ou salaires sont rigides. À court terme, une augmentation de la demande peut stimuler la production car les prix ne s'ajustent pas instantanément.
  
  L'Offre Agrégée de long terme (LRAS) est verticale : elle correspond au niveau de production potentiel (ou naturel) déterminé par la technologie et les facteurs de production disponibles, indépendamment du niveau des prix. À long terme, tous les prix sont flexibles et l'argent est neutre.
]

2. Expliquez économiquement le mécanisme par lequel une augmentation de la demande agrégée se traduit par une hausse des prix. Votre explication devra détailler les étapes suivantes :
  - L'effet sur la demande de travail et le salaire réel.
  - La réaction des coûts marginaux des entreprises.
  - La décision de fixation des prix par les entreprises en situation de concurrence monopolistique.

#correction[
  Le mécanisme de transmission est le suivant :
  1. Une hausse de la demande agrégée conduit les entreprises à vouloir produire plus pour satisfaire cette demande.
  2. Pour augmenter la production, les entreprises accroissent leur demande de travail. Cela exerce une pression à la hausse sur les salaires réels (le coût du travail) car les travailleurs exigent une rémunération plus élevée pour travailler davantage (désutilité marginale du travail croissante).
  3. La hausse des salaires réels (et éventuellement la baisse de la productivité marginale) entraîne une augmentation des coûts marginaux de production pour toutes les entreprises.
  4. En concurrence monopolistique, les entreprises fixent leurs prix comme une marge (markup) sur leur coût marginal. Face à la hausse de leurs coûts marginaux, les entreprises qui ont l'opportunité d'ajuster leurs prix décident de les augmenter pour préserver leurs marges. Cela se traduit par une hausse du niveau général des prix (inflation).
]

3. Dans le modèle néo-classique standard (prix flexibles), l'ajustement des prix est immédiat. Quels sont les frictions réelles ou nominales qui justifient que la courbe d'Offre Agrégée soit croissante plutôt que verticale à court terme ? Citez deux mécanismes possibles.

#correction[
  Plusieurs frictions peuvent justifier une courbe d'offre croissante à court terme :
  - **Frictions Nominales** : 
    - Le modèle de Calvo (prix rigides temporellement) : les firmes ne peuvent changer leurs prix qu'aléatoirement.
    - Les coûts de menu (Menu Costs) : changer les prix est coûteux, donc les firmes ne le font que si le bénéfice dépasse ce coût.
  - **Frictions Réelles / Informationnelles** :
    - Information imparfaite (Modèle de Lucas) : les producteurs confondent hausse générale des prix et hausse de leur prix relatif, et produisent donc plus.
    - Contrats de salaires à long terme : les salaires sont fixés à l'avance, rendant le coût du travail rigide à court terme.
]

4. On suppose que la relation d'Offre Agrégée prend la forme linéaire suivante (dite de Calvo) :
$ pi_t = beta E_t pi_(t+1) + kappa y_t $
où $kappa > 0$ est un paramètre de pente. Discutez intuitivement de ce qui détermine la valeur de $kappa$. En particulier, comment $kappa$ évolue-t-il si :
  - Les prix deviennent plus flexibles (les entreprises ajustent leurs prix plus fréquemment).
  - La concurrence sur le marché des biens augmente.

#correction[
  Le paramètre $kappa$ mesure la sensibilité de l'inflation à l'activité réelle (écart de production).
  - Si les prix sont **plus flexibles** (fréquence d'ajustement plus élevée, c'est-à-dire une probabilité de Calvo $theta$ plus faible), alors les entreprises réagissent plus vite aux variations de coûts. La courbe de Phillips devient plus pentue : pour un même écart de production, l'inflation réagit plus fort on a $kappa$ qui augmente.
  - Si la **concurrence augmente** (biens plus substituables), la demande adressée à chaque firme devient plus élastique. Intuitivement, une concurrence accrue peut rendre les prix plus sensibles aux coûts, augmentant $kappa$. (Note technique : dans le modèle standard $kappa propto (1-theta)(1-beta theta)/theta times text("termes de rigidité réelle"). Une concurrence accrue réduit souvent les complémentarités stratégiques, ce qui peut aussi augmenter $kappa$).
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
   On part de la PC : $pi_t = beta E_t pi_(t+1) + kappa y_t implies E_t pi_(t+1) = 1/beta pi_t - kappa/beta y_t$.
   
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
   - $"Trace"(A) = 1 + kappa/(sigma beta) + 1/beta = 1 + 1/beta (1 + kappa/sigma)$.
]
   
   c. En utilisant les conditions de Blanchard-Kahn, discutez de la stabilité du système (déterminacy). Rappel : pour qu'il existe un unique chemin d'équilibre stable (déterminé) dans un modèle avec deux variables "forward-looking" ($y_t$ et $pi_t$), combien de valeurs propres de la matrice $A$ doivent être de module supérieur à 1 ? Le système est-il déterminé sous cette règle stricte ?

#correction[
   Nous avons deux variables forward-looking : $pi_t$ et $y_t$ (ce sont des variables de saut, non prédéterminées).
   La condition de Blanchard-Kahn pour l'existence d'équilibre unique (déterminé) est que les **deux** valeurs propres de la matrice $A$ doivent être de module supérieur à 1.
   
   On a :
   $det(A) = lambda_1 lambda_2 = 1/beta > 1$ (car $beta < 1$).
   $"Trace"(A) = lambda_1 + lambda_2 = 1 + 1/beta + kappa/(sigma beta) > 2$.
   
   Le polynôme caractéristique est $P(lambda) = lambda^2 - "Trace"(A) lambda + det(A)$.
   $P(1) = 1 - (1 + 1/beta + kappa/(sigma beta)) + 1/beta = - kappa/(sigma beta) < 0$.
   Puisque $P(1) < 0$ et que la parabole est ouverte vers le haut ($lambda^2$), les racines sont de part et d'autre de 1. L'une est inférieure à 1, l'autre supérieure à 1.
   
   Conclusion : Il n'y a qu'une seule valeur propre instable ($>1$). La condition de Blanchard-Kahn n'est pas remplie (il en faudrait deux). Le système est donc **indéterminé** : il existe une infinité de trajectoires d'équilibre (sunspots). Une règle de taux fixe ne permet pas d'ancrer les anticipations.
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
   
   On peut montrer que pour avoir deux valeurs propres de module supérieur à 1 (détermination), il faut que **$phi_pi > 1$**.
   C'est le **Principe de Taylor** : la banque centrale doit augmenter le taux d'intérêt nominal plus que proportionnellement à l'augmentation de l'inflation anticipée pour augmenter le taux réel et refroidir l'économie.
]
   
   d. Interprétez économiquement ce résultat. Pourquoi une réaction trop faible de la Banque Centrale aux anticipations d'inflation ($phi_pi < 1$) peut-elle conduire à une instabilité (spirales inflationnistes ou déflationnistes) ?

#correction[
   Si $phi_pi < 1$, une hausse des anticipations d'inflation entraîne une hausse du taux nominal plus faible que l'inflation. Le taux d'intérêt réel ($i_t - E_t pi_(t+1)$) **baisse**. Une baisse du taux réel stimule la demande (IS), ce qui augmente l'écart de production et donc l'inflation via la courbe de Phillips. Cela valide et renforce les anticipations d'inflation initiales : c'est une spirale inflationniste auto-réalisatrice. L'équilibre est indéterminé.
]

3. *Discussion*

   Comparez les résultats obtenus dans les questions 1 et 2. En quoi l'adoption d'une règle active (réactive) est-elle supérieure à une fixation rigide des taux d'intérêt pour la stabilité macroéconomique ?

#correction[
   Le résultat montre qu'une règle passive (comme un "peg" de taux d'intérêt, $phi_pi = 0$) laisse l'économie sujette à l'indétermination et aux fluctuations purement spéculatives (sunspots). Pour garantir un équilibre unique et stable, la Banque Centrale doit adopter une règle **active** ($phi_pi > 1$) qui réagit vigoureusement à l'inflation. Cela permet d'ancrer les anticipations des agents privés.
]

