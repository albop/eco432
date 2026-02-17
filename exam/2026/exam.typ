#let show_correction = (sys.inputs.at("correction", default: "false") == "true")

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
 
// #align(center)[
//   #text(14pt, weight: "bold")[ECO432 - Macroéconomie]\
//   #v(0.5em)
//   #text(12pt)[Examen - Mars 2026]\
//   \
//   #text(style: "italic")[Durée: 2h. Documents autorisés: dictionnaire papier et une feuille A4 manuscrite.]
// ]

#v(1cm)




= Indice des Prix et Demande

On considère une économie composée d'un nombre fini $N$ de variétés de biens, indexées par $i = 1, ..., N$. Les préférences du consommateur sont représentées par une fonction d'utilité $U(C_t)$, où $C_t$ est un indice de consommation agrégé défini par la fonction CES (Dixit-Stiglitz) :
$ C_t = (sum_(i=1)^N C_t (i)^((epsilon-1)/epsilon))^(epsilon/(epsilon-1)) $
où $epsilon > 1$ est l'élasticité de substitution entre les biens.

Le consommateur cherche à minimiser sa dépense totale $ E_t = sum_(i=1)^N P_t (i) C_t (i) $ pour atteindre un niveau de consommation agrégée $C_t$ donné.

1. _Condition d'optimalité_

   À l'optimum, le rapport des utilités marginales de deux biens doit être égal au rapport de leurs prix.
   Montrez que cela implique la relation suivante entre les quantités consommées de deux biens quelconques $i$ et $j$ :
   $ ( C_t (i) ) / ( C_t (j) ) = ( (P_t (i)) / (P_t (j)) )^(-epsilon) $

2. _Demande individuelle_

   En utilisant la relation précédente et la définition de l'agrégat $C_t$, montrez que la demande optimale pour chaque variété $i$ s'écrit :
   $ C_t (i) = ( (P_t (i)) / P_t)^(-epsilon) C_t $
   où $P_t$ est un indice des prix que vous définirez en fonction des prix individuels $P_t (j)$.

3. _Dépense totale_

   Montrez qu'avec ces fonctions de demande, la dépense totale minimale est simplement le produit de l'indice des prix et de la consommation agrégée : $E_t = P_t C_t$.

4. _Élasticité et Concurrence_

   Que représente le paramètre $epsilon$ économiquement ? 
   Si $epsilon$ est très grand ($epsilon -> infinity$), comment réagit la demande à une petite variation de prix ?
   Quel est le lien intuitif entre ce paramètre et le "pouvoir de marché" des firmes qui produiront ces biens (dans un cadre de concurrence monopolistique) ?

#correction[
   1. _Démonstration_ :
      La condition d'optimalité est $ (U'(C_t) partial C_t) / (partial C_t (i)) = (U'(C_t) partial C_t) / (partial C_t (j)) dot (P_t (j)) / (P_t (i)) $.
      Ou plus simplement :
      $ (partial C_t) / (partial C_t (i)) / ( (partial C_t) / (partial C_t (j)) ) = (P_t (i)) / (P_t (j)) $
      
      Avec la dérivée donnée en indice :
      $ (C_t / (C_t (i)))^(1/epsilon) / (C_t / (C_t (j)))^(1/epsilon) = (C_t (j)/(C_t (i)))^(1/epsilon) = (P_t (i)) / (P_t (j)) $
      En élevant à la puissance $-epsilon$ :
      $ (C_t (i)) / (C_t (j)) = ((P_t (i)) / (P_t (j)))^(-epsilon) $
      
      *Barème : 1 pt*.
   
   2. _Démonstration_ :
      On peut exprimer $C_t (j)$ en fonction de $C_t (i)$ :
      $ C_t (j) = C_t (i) ((P_t (j)) / (P_t (i)))^(-epsilon) $
      On substitue dans la définition de l'agrégat CES :
      $ C_t = ( sum_j [ C_t (i) ((P_t (j)) / (P_t (i)))^(-epsilon) ]^((epsilon-1)/epsilon) )^(epsilon/(epsilon-1)) $
      $ C_t = C_t (i) P_t (i)^epsilon ( sum_j P_t (j)^(1-epsilon) )^(epsilon/(epsilon-1)) $
      
      Soit $P_t = (sum_j P_t (j)^(1-epsilon))^(1/(1-epsilon))$. Alors le terme entre parenthèse est $P_t^(-epsilon)$.
      On obtient $C_t = C_t (i) ((P_t (i)) / P_t)^epsilon$, d'où $C_t (i) = ((P_t (i)) / P_t)^(-epsilon) C_t$.

      *Barème : 1 pt*.
   
   3. _Démonstration_ :
      La dépense totale est :
      $ sum_(i=1)^N P_t (i) C_t (i) = sum P_t (i) ((P_t (i)) / P_t)^(-epsilon) C_t = C_t P_t^epsilon sum P_t (i)^(1-epsilon) $
      Or, par définition, $P_t^(1-epsilon) = sum P_t (i)^(1-epsilon)$.
      Donc $E_t = C_t P_t^epsilon P_t^(1-epsilon) = P_t C_t$.

      *Barème : 1 pt*.

   4. _Interprétation_ :
      - $epsilon$ est l'élasticité de substitution (et l'élasticité-prix de la demande).
      - Si $epsilon -> infinity$, les biens deviennent parfaitement substituables. Une firme qui augmente son prix même légèrement perd toute sa demande (concurrence parfaite).
      - Plus $epsilon$ est faible (proche de 1), plus les biens sont différenciés et indispensables, donc plus les firmes ont un pouvoir de marché important (elles peuvent fixer un prix élevé sans perdre tous leurs clients).

      *Barème : 1 pt*.
]

= La courbe de Phillips Néo-Keynésienne

On considère maintenant une économie avec un grand nombre de firmes produisant des biens différenciés au prix $P_t (i)$. Pour l'index des prix, on utilise l'agrégateur CES des prix individuels $P_t=(sum_i P_t (i)^(1-epsilon))^(1/(1-epsilon))$.

On suppose une rigidité des prix à la Calvo : à chaque période, une firme a une probabilité $1-theta$ de pouvoir réoptimiser son prix (elle fixe alors $P_t^*$). Avec une probabilité $theta$, elle doit garder son prix inchangé ($P_t (i) = P_(t-1) (i)$).

1. Écrivez la loi d'évolution de l'indice des prix agrégés $P_t$ (supposé être un agrégateur CES standard) en fonction de $P_t^*$ et $P_(t-1)$.
En effectuant une approximation log-linéaire autour d'un état stationnaire à inflation nulle, montrez que l'inflation $pi_t = p_t - p_(t-1)$ est proportionnelle à l'écart entre le prix optimal et le niveau moyen des prix :
$ pi_t = (1-theta)/theta (p_t^* - p_t) $

#correction[
  _Dérivation_ :
  L'indice des prix évolue selon :
  $ P_t^(1-epsilon) = (1-theta) (P_t^*)^(1-epsilon) + theta P_(t-1)^(1-epsilon) $
  En divisant par $P_(t-1)^(1-epsilon)$ et en log-linéarisant autour de l'état stationnaire où $P_t/P_(t-1) = 1$ et $P_t^* / P_(t-1) = 1$ :
  $ (1-epsilon) pi_t approx (1-theta) (1-epsilon) (p_t^* - p_(t-1)) $
  $ pi_t = (1-theta) (p_t^* - p_t + pi_t) $
  $ theta pi_t = (1-theta) (p_t^* - p_t) $
  D'où le résultat : $pi_t = (1-theta)/theta (p_t^* - p_t)$.

  *Barème : 2.5 pts* (1 pt pour la loi d'évolution, 1.5 pour la log-lin).
]

2. Une firme qui a l'opportunité de changer son prix au temps $t$ choisit $P_t^*$ pour maximiser la somme actualisée de ses profits futurs attendus, sachant que ce prix restera effectif avec probabilité $theta^k$ à la période $t+k$.
La condition de premier ordre (simplifiée) s'écrit :
$ E_t sum_(k=0)^infinity (beta theta)^k Q_(t, t+k) Y_(t+k|t) (P_t^* - cal(M) P_(t+k) M C_(t+k)) = 0 $
où $M C_t$ est le coût marginal réel.
Expliquez #underline[intuitivement] pourquoi le prix optimal $P_t^*$ est une moyenne pondérée des coûts marginaux nominaux futurs attendus.

#correction[
  _Intuition_ :
  La firme sait que son prix $P_t^*$ risque d'être bloqué pour plusieurs périodes. Elle ne doit pas seulement couvrir son coût marginal actuel, mais aussi anticiper l'évolution future de ses coûts. Si elle anticipe une hausse future des coûts marginaux (inflation des coûts), elle fixe un prix plus élevé dès aujourd'hui ("Front-loading"). Le prix optimal est donc un *markup* constant $cal(M)$ sur une "moyenne" des coûts marginaux nominaux futurs ($P_(t+k) M C_(t+k)$) durant la période de validité du prix.

  *Barème : 1.5 pts* (Mot-clés : forward-looking, bloqué, coût futurs).
]

3. On admet que la log-linéarisation de la condition de prix optimal et la réorganisation des sommes infinies conduisent à la relation suivante entre le prix optimal relatif et l'inflation future :
$ p_t^* - p_t = (1 - beta theta) m c_t + beta theta E_t [ p_(t+1)^* - p_(t+1) + pi_(t+1) ] $
où $m c_t$ est la log-déviation du coût marginal réel.

   En combinant ce résultat avec la relation obtenue à la question 1 ($p_t^* - p_t = theta/(1-theta) pi_t$), dérive la courbe de Phillips Néo-Keynésienne (NKPC) reliant l'inflation à ses anticipations et au coût marginal réel :
$ pi_t = beta E_t pi_(t+1) + lambda m c_t $
   Donnez l'expression du paramètre $lambda$ en fonction de $beta$ et $theta$.

#correction[
  _Dérivation_ :
  On remplace $p_t^* - p_t$ par $theta/(1-theta) pi_t$ dans l'équation admise :
  $ theta/(1-theta) pi_t = (1 - beta theta) m c_t + beta theta E_t [ theta/(1-theta) pi_(t+1) + pi_(t+1) ] $
  
  Le terme entre crochets se simplifie :
  $ theta/(1-theta) pi_(t+1) + pi_(t+1) = pi_(t+1) ( theta/(1-theta) + 1 ) = pi_(t+1) ( (theta + 1 - theta)/(1-theta) ) = 1/(1-theta) pi_(t+1) $
  
  Donc :
  $ theta/(1-theta) pi_t = (1 - beta theta) m c_t + beta theta/(1-theta) E_t pi_(t+1) $
  
  En multipliant tout par $(1-theta)/theta$ :
  $ pi_t = (1-theta)(1-beta theta)/theta m c_t + beta E_t pi_(t+1) $
  
  On obtient la NKPC standard avec la pente :
  $ lambda = ((1-theta)(1-beta theta))/theta $

  *Barème : 2 pts* (1 pt pour la substitution / 1pt pour l'algèbre finale).
]

4. Pour passer de la relation en coûts marginaux ($m c_t$) à la relation en écart de production ($y_t$), on utilise généralement une relation de la forme $m c_t = (sigma + phi) y_t$.
   Récrivez l'équation finale (Courbe de Phillips Néo-Keynésienne) en fonction de l'output gap.
   Commentez : Selon ce modèle, l'inflation est-elle un phénomène purement rétrospectif (inertie) ou prospectif (anticipations) ?

#correction[
  _Dérivation_ :
  En substituant $m c_t$ :
  $ pi_t = beta E_t pi_(t+1) + kappa y_t $
  avec $kappa = lambda (sigma + phi) = ((1-theta)(1-beta theta))/theta (sigma + phi)$.
  
  _Commentaire_ :
  Selon ce modèle (NKPC pure), l'inflation est un phénomène purement *prospectif* (forward-looking). L'inflation d'aujourd'hui dépend de la demande présente ($y_t$) et de toute la séquence future d'écarts de production anticipés (via le terme $E_t pi_(t+1)$ itéré). Il n'y a pas d'inertie intrinsèque dans ce modèle de base (pas de terme $pi_(t-1)$), ce qui est souvent critiqué car l'inflation réelle montre de la persistance.

  *Barème : 2 pts* (1 pt pour l'équation, 1 pt pour le commentaire).
]

= Politique Monétaire et Déterminations

On considère le modèle Néo-Keynésien standard décrit par les équations log-linéarisées suivantes :

$ y_t &= E_t y_(t+1) - 1/sigma (i_t - E_t pi_(t+1) - r_t^n) quad &"(IS)" \
pi_t &= beta E_t pi_(t+1) + kappa y_t quad &"(PC)" $

où $y_t$ est l'écart de production, $pi_t$ l'inflation, $i_t$ le taux d'intérêt nominal, et $r_t^n$ le taux naturel (exogène). Les paramètres $sigma, kappa, beta > 0$ sont strictement positifs, avec $beta < 1$#footnote[Dans cette exercice, il n'y a pas de source d'incertitude. Les signes d'espérance mathématiques peuvent être simplement ignorés: $E_t y_(t+1) -> y_(t+1)$, $E_t pi_(t+1) -> pi_(t+1)$].

La Banque Centrale adopte une règle de Taylor prospective :
$ i_t = r_t^n + phi_pi E_t pi_(t+1) $
avec $phi_pi > 0$ le coefficient de réponse à l'inflation anticipée (coefficient de Taylor).

1. *Règle de Taylor*

   La règle utilisée dans cet exercice est une règle de ciblage d'inflation anticipée.    Comparez cette règle à celle(s) vue(es) en cours.
   
#correction[
   _Commentaire_ :
   En cours, nous avons vu deux perspectives principales :
   1. *Modèle IS-MP* : La Banque Centrale fixe le *taux d'intérêt réel* $r_t$ (par exemple $r_t = overline(r) + lambda pi_t$). Ici, la règle porte sur le taux *nominal* $i_t$, ce qui est plus réaliste opérationnellement.
   2. *Règle de Taylor empirique* : En cours, nous avons discuté des graphiques montrant que la Fed (US) suivait relativement bien une règle de Taylor jusqu'à 2014 environ. Ensuite le taux d' intérêt est resté très bas essentiallement collé à la Zero lower bound. Cela dit une règle de Taylor améliorée avec les anticipations d'inflation et d'output gap s'avère une bonne approximation de la politique monétaire de la Fed même après 2014.

   *Barème : 2 pts* (1 pt pour IS-MP, 1 pt pour l'historique Fed).
]



2. *Système dynamique*

   a. En substituant la règle de taux dans l'équation (IS) et en utilisant l'équation (PC), montrez que le modèle peut s'écrire sous la forme matricielle suivante :
      $ mat(E_t y_(t+1); E_t pi_(t+1)) = Omega mat(y_t; pi_t) $
      Donnez l'expression de la matrice de transition $Omega$ en fonction des paramètre $beta, sigma, kappa$ et $phi_pi$.

   b. Calculez le déterminant et la trace de cette matrice $Omega$. Montrez en particulier que le déterminant est égal à $1/beta$.

#correction[
   a. _Dérivation_ :
   - Équation PC : $pi_t = beta E_t pi_(t+1) + kappa y_t => E_t pi_(t+1) = 1/beta pi_t - kappa/beta y_t$.
   - Équation IS avec règle : $y_t = E_t y_(t+1) - 1/sigma (phi_pi E_t pi_(t+1) - E_t pi_(t+1)) = E_t y_(t+1) - (phi_pi-1)/sigma E_t pi_(t+1)$.
     Donc $E_t y_(t+1) = y_t + (phi_pi-1)/sigma E_t pi_(t+1)$.
   
   En remplaçant $E_t pi_(t+1)$ par son expression en fonction de $y_t, pi_t$ :
   $ E_t y_(t+1) = (1 - (kappa(phi_pi-1))/(sigma beta)) y_t + (phi_pi-1)/(sigma beta) pi_t $
   
   La matrice est donc :
   $ Omega = mat(1 - (kappa(phi_pi-1))/(sigma beta), (phi_pi-1)/(sigma beta); -kappa/beta, 1/beta) $

   b. _Calcul_ :
   $det(Omega) = (1 - (kappa(phi_pi-1))/(sigma beta)) 1/beta - (-kappa/beta) ((phi_pi-1)/(sigma beta))$
   $det(Omega) = 1/beta - (kappa(phi_pi-1))/(sigma beta^2) + (kappa(phi_pi-1))/(sigma beta^2) = 1/beta$.
   
   $op("Tr")(Omega) = 1 - (kappa(phi_pi-1))/(sigma beta) + 1/beta = 1 + 1/beta - (kappa(phi_pi-1))/(sigma beta)$.

   *Barème : 2.5 pts* (1.5 pts pour la matrice, 1 pt pour det/trace).
]

3. *Condition de stabilité et déterminacy*

   Dans un système d'équations rationnelles forward-looking ($y_t$ et $pi_t$ ne sont pas prédéterminées), l'existence d'un équilibre unique et stable (appelé *déterminacy*) requiert que toutes les valeurs propres de la matrice de transition $Omega$ soient de module strictement supérieur à 1.
   
   En étudiant le polynôme caractéristique de la matrice $Omega$, montrez que la condition d'unicité de l'équilibre est $phi_pi > 1$.
   
#correction[
   _Démonstration_ :
   Le polynôme caractéristique est $P(lambda) = lambda^2 - op("Tr")(Omega) lambda + det(Omega)$.
   On a $det(Omega) = 1/beta > 1$. Le produit des racines est donc supérieur à 1.
   Pour que les deux racines soient supérieures à 1, il faut et il suffit que $P(1) > 0$.
   $P(1) = (kappa (phi_pi - 1)) / (sigma beta)$.
   La condition $P(1) > 0$ implique donc *$phi_pi > 1$*.

   *Barème : 2 pts* (1 pt pour le polynôme, 1 pt pour la condition).
]

4. *Interprétation et Crédibilité*

   On appelle *Principe de Taylor* le respect de la condition $phi_pi > 1$.
   Si cette condition n'est pas respectée (règle passive, $phi_pi < 1$), le modèle prédit une "indétermination" de l'équilibre : il existe une infinité de trajectoires possibles pour l'inflation (appelées équilibres de taches solaires ou "sunspots"), toutes compatibles avec les équations du modèle.
   
   Commentez ce résultat du point de vue de la Banque Centrale. Pourquoi l'indétermination pose-t-elle un problème fondamental pour la conduite de la politique monétaire et l'ancrage des anticipations ?
   
#correction[
   _Commentaire_ :
   Si $phi_pi < 1$, la Banque Centrale ne réagit pas suffisamment pour contrer les chocs d'inflation. Paradoxalement, cette passivité permet à n'importe quelle croyance arbitraire des agents (sunspot) de se réaliser (prophétie auto-réalisatrice).
   Pour une Banque Centrale, c'est désastreux car elle perd le contrôle de l'inflation. Elle ne peut plus garantir un sentier prévisible pour les taux d'intérêt ni pour les prix. Pour ancrer les anticipations et assurer la stabilité des prix (son mandat), elle *doit* s'engager de manière crédible à suivre une règle active ($phi_pi > 1$), éliminant ainsi les trajectoires instables ou multiples.
   
   *Barème : 1.5 pts* (Mot-clés : passivité / prophétie auto-réalisatrice / ancrage).
]

#pagebreak()


#correction[
  #heading(numbering: none)[Barème Global]

  *Exercice 1 : Indice des Prix et Demande (4 points)*
  1. Condition d'optimalité : 1 pt
  2. Demande individuelle : 1 pt
  3. Dépense totale : 1 pt
  4. Élasticité et Concurrence : 1 pt

  *Exercice 2 : La courbe de Phillips Néo-Keynésienne (8 points)*
  1. Loi d'évolution et log-linéarisation : 2.5 pts
  2. Intuition prix optimal (forward-looking) : 1.5 pts
  3. Dérivation NKPC (paramètre $lambda$) : 2 pts
  4. NKPC (output gap) et commentaire prospectif : 2 pts

  *Exercice 3 : Politique Monétaire et Détermination (8 points)*
  1. Règle de Taylor (Comparaison IS-MP / Historique) : 2 pts
  2. Système dynamique (Matrice, déterminant, trace) : 2.5 pts
  3. Condition de stabilité (Polynôme caractéristique) : 2 pts
  4. Interprétation (Indétermination et Crédibilité) : 1.5 pts

  *Total : 20 points*
  
  _Répartition indicative :_
  - *Calculs et Dérivations : 13 points* (Ex1: 3, Ex2: 5.5, Ex3: 4.5)
  - *Questions de Cours et Interprétation : 7 points* (Ex1: 1, Ex2: 2.5, Ex3: 3.5)
  
  _Note :_ La plupart des questions d'interprétation (Q4 Ex1, Q2 Ex2, Q1 & Q4 Ex3) peuvent être traitées de manière indépendante des calculs.
]


