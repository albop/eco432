""
= Chapitre 1 – Introduction et comportement des consommateurs

_ECO432 – Macroéconomie du court terme_

Ce premier chapitre a un double objectif. D'une part, il situe la macroéconomie par rapport
aux autres branches de l'économie, en insistant sur le rôle joué par les différents acteurs
et sur la manière dont leurs décisions individuelles se combinent pour déterminer les
grands agrégats. D'autre part, il introduit la modélisation du comportement de
consommation des ménages, qui sera au cœur de l'analyse macroéconomique du court terme.


== Les acteurs de l'économie et la perspective macroéconomique

Dans une économie de marché, les décisions économiques ne sont pas prises par une
autorité centrale omnisciente, mais par une multitude d'agents qui poursuivent chacun
leurs propres objectifs. On distingue notamment :

- les **consommateurs** ou ménages, qui offrent du travail, détiennent éventuellement du
  capital et arbitrent entre consommation et épargne ;
- les **entreprises**, qui décident des niveaux de production, d'investissement et
  d'emploi en cherchant à maximiser leurs profits ;
- les **banques** et institutions financières, qui transforment l'épargne en crédit et
  jouent un rôle essentiel dans la transmission de la politique monétaire ;
- le **gouvernement**, qui prélève des impôts, verse des transferts et fournit des biens
  publics ;
- la **banque centrale**, qui contrôle l'offre de monnaie et influence les taux
  d'intérêt.

La macroéconomie s'intéresse à la manière dont les décisions de ces acteurs, prises en
parallèle et souvent de façon décentralisée, se coordonnent (ou non) sur plusieurs
marchés : marché du travail, marché des biens, marché du crédit, marché des changes,
etc. Elle s'intéresse particulièrement à l'évolution des grands agrégats – produit
intérieur brut (PIB), inflation, taux de chômage, investissement, consommation
agrégée – mais ne se limite pas à la simple description de ces séries : l'objectif est
de comprendre les mécanismes qui les sous-tendent.

Une des caractéristiques majeures de la macroéconomie moderne est qu'elle cherche à
relier ces grandeurs agrégées au comportement microéconomique des agents qui
composent l'économie. C'est cette démarche que l'on désigne sous le terme de
**microfondation**.


== Microfondation : relier les comportements individuels aux agrégats

L'approche académique contemporaine consiste à modéliser explicitement le comportement
des agents – ménages, firmes, gouvernement, banque centrale – avant d'étudier leurs
interactions au niveau agrégé. Pour chaque type d'agent, on décrit :

- un **objectif** (maximisation d'une fonction d'utilité, de profit, de bien‑être
  social, etc.) ;
- des **contraintes** (ressources, technologies, contraintes de crédit, institutions,
  règles de politique économique, etc.).

Par exemple, un **consommateur** peut être modélisé comme maximisant l'utilité
intertemporelle tirée de la consommation et du loisir :

$ max_(t>=0) sum beta^t U(c_t, l_t), $

sous la contrainte budgétaire, pour chaque période $t$ :

$ c_t <= w_t l_t + a_(t-1) r_t + "autres revenus", $

où $c_t$ désigne la consommation, $l_t$ l'offre de travail, $w_t$ le salaire réel et
$a_(t-1) r_t$ le revenu du patrimoine.

De même, une **entreprise** choisit sa production, son niveau d'emploi et son
investissement afin de maximiser un profit intertemporel, sous la contrainte d'une
fonction de production et des conditions de marché.

Il est important de souligner qu'aucune hypothèse « psychologique » particulière n'est
imposée par la méthode elle‑même : rien n'empêche de modéliser des préférences avec
**rationalité limitée**, des **préférences sociales**, des **biais de croyances** ou de
**l'incohérence temporelle**. La microfondation impose seulement que ces comportements
soient explicités et cohérents avec les contraintes auxquelles les agents font face.


== De la micro à la macro : problèmes d'agrégation

Passer d'une description détaillée des agents individuels à une représentation
agrégée de l'économie soulève plusieurs difficultés conceptuelles et techniques.

Du point de vue économique, la coexistence de nombreux agents et de nombreux marchés
génère des **phénomènes émergents** qui ne sont pas visibles au niveau individuel :

- la **demande agrégée** résulte d'une multitude de décisions de consommation,
  d'investissement et de dépense publique ;
- des phénomènes d'**ajustement incomplet** des prix et de la production (rigidités
  nominales, coûts d'ajustement, contrats implicites) apparaissent souvent à court
  terme ;
- diverses **externalités** (de réseau, d'information, environnementales, etc.) font
  que les décisions individuelles ont des conséquences macroéconomiques qui ne sont
  pas prises en compte par les agents eux‑mêmes.

Du point de vue technique, l'agrégation pose deux types de difficultés majeures :

- la **taille de l'espace d'état** : dans des modèles dynamiques avec hétérogénéité des
  agents, le nombre de variables d'état peut devenir très important, ce qui rend la
  résolution analytique ou numérique délicate ;
- le **nombre de degrés de liberté** : à mesure que l'on enrichit la description des
  comportements et des frictions, les modèles disposent de davantage de paramètres,
  ce qui accroît le risque de sur‑ajustement (analogue à l'overfitting en machine
  learning) : un modèle très flexible peut répliquer de nombreux faits stylisés, mais
  perd en pouvoir prédictif et en falsifiabilité.

Face à ces difficultés, deux grandes familles d'approches se dégagent.

=== Approche analytique

La première consiste à **résoudre le problème d'agrégation** en imposant des
simplifications structurelles. On suppose par exemple que :

- les consommateurs sont **identiques** ou peuvent être décrits par un « ménage
  représentatif » ;
- les distributions de revenus, de préférences ou de chocs sont **continues** et
  suffisamment régulières ;
- les agents forment des **anticipations rationnelles**, c'est‑à‑dire utilisent le
  modèle lui‑même pour prévoir le futur.

Dans ce cadre, la macroéconomie est souvent écrite sous la forme d'un système
d'équations agrégées relativement compact. Lorsque les équations restent trop
complexes pour être résolues à la main, on a recours à des **méthodes de
simulation**, par exemple autour d'un point d'équilibre.

=== Approche synthétique

La seconde approche, plus empirique, consiste à partir directement des **grands
agrégats**. Plutôt que de remonter systématiquement aux comportements individuels,
on formule des hypothèses sur la dynamique de variables comme la consommation, l'emploi
ou l'investissement, et l'on cherche à :

- identifier les **types de chocs** (technologiques, de demande, financiers,
  politiques, etc.) susceptibles d'expliquer les fluctuations observées ;
- confronter ces hypothèses aux **données** macroéconomiques et microéconomiques ;
- croiser différentes sources d'information (enquêtes de ménages, séries
  macroéconomiques, données de marché, etc.) pour discipliner l'interprétation.

Dans la pratique, la recherche contemporaine mobilise ces deux approches de façon
complémentaire : les modèles microfondés sont souvent estimés ou calibrés de
manière à reproduire certaines régularités empiriques, tandis que l'analyse des
données inspire la structure des modèles.


== Court terme et long terme

Les phénomènes macroéconomiques ne se déploient pas tous sur les mêmes horizons. Il
est donc utile de distinguer, même de façon un peu schématique, le **court terme** et
le **long terme**.

On parle de **court terme** pour désigner une période suffisamment brève pour que
certaines variables n'aient pas eu le temps de s'ajuster pleinement à un choc
exogène. Par exemple :

- le stock de capital productif est quasi fixe : les entreprises ne peuvent pas
  instantanément construire de nouvelles usines ;
- les salaires et les prix peuvent être **rigides** en raison de contrats, de coûts
  de révision ou de normes sociales ;
- l'ajustement à un choc se fait alors en grande partie par les **quantités** (emploi,
  production, utilisation des capacités) plutôt que par les prix.

On associe souvent au court terme l'**analyse conjoncturelle** : comment l'économie
réagit‑elle à une variation du taux d'intérêt, à une hausse des dépenses publiques,
à un choc pétrolier, à une crise financière ?

Le **long terme**, au contraire, renvoie à des horizons suffisamment lointains pour
qu'une grande partie des ajustements soient réalisés :

- le capital s'adapte à la rentabilité attendue ;
- les prix et les salaires ont eu le temps de se réviser ;
- les structures productives (technologies, organisation des firmes, institutions)
  peuvent évoluer.

L'analyse de long terme est souvent qualifiée de **structurelle** : on s'intéresse
aux déterminants de la croissance, de la productivité, de la capacité de production
ou encore des inégalités de revenu et de patrimoine.

Dans ce chapitre et les suivants consacrés au court terme, nous insisterons
principalement sur la façon dont les **décisions de consommation** des ménages
réagissent à des variations du revenu et des taux d'intérêt.


== Les décisions de consommation : motivations et déterminants

La consommation des ménages représente, dans la plupart des économies développées,
entre la moitié et les deux tiers du PIB. Comprendre ce qui détermine le niveau de
consommation et son évolution au cours du temps est donc crucial pour toute analyse
macroéconomique.

Intuitivement, un ménage peut renoncer à une partie de sa consommation présente pour
épargner, c'est‑à‑dire pour **substituer des biens présents à des biens futurs**.
Cette décision d'épargne reflète plusieurs considérations :

- le **taux d'intérêt réel**, qui mesure combien de biens de consommation futurs
  peuvent être obtenus en renonçant à un bien aujourd'hui ;
- le **profil de revenu** anticipé : un ménage qui s'attend à voir son revenu
  fortement augmenter à l'avenir n'a pas les mêmes incitations à épargner qu'un
  ménage dont le revenu futur est incertain ou décroissant ;
- l'**incertitude** et l'aversion au risque, qui poussent à constituer une épargne de
  précaution ;
- des caractéristiques individuelles telles que l'âge, la situation familiale ou l'état
  de santé, qui influencent l'horizon de planification et les besoins futurs.

De façon très schématique, à court terme, la consommation d'un ménage dépendra donc
principalement de deux facteurs :

- son **revenu courant** $Y_t$ ;
- le **taux d'intérêt réel intertemporel** $r_t$, qui gouverne le prix relatif de la
  consommation présente par rapport à la consommation future.

Dans la suite, nous formalisons cette intuition en modélisant les décisions de
consommation dans un cadre simple à deux périodes.


== Deux types idéaux : ménages ricardiens et ménages keynésiens

Pour organiser la discussion, il est utile de distinguer deux archétypes de ménages,
qui correspondent à des comportements stylisés que l'on retrouve souvent dans la
littérature.

Les **ménages ricardiens** ont accès aux marchés financiers dans des conditions
relativement favorables. Ils peuvent **emprunter et prêter** presque librement au taux
d'intérêt en vigueur, sous réserve de ne pas choisir des trajectoires manifestement
insoutenables. Pour ces ménages, la contrainte de crédit n'est pas centrale : ils
choisissent leur profil de consommation principalement en fonction de leurs
préférences et de leur **revenu permanent**, c'est‑à‑dire de la valeur actualisée de
leurs revenus futurs.

Les **ménages keynésiens**, au contraire, sont soumis à des **contraintes de crédit
strictes**. Ils ne peuvent pas, ou très difficilement, emprunter pour lisser leur
consommation dans le temps. Leur consommation courante est alors essentiellement
déterminée par leur **revenu disponible du moment** : s'ils reçoivent un euro de
revenu supplémentaire aujourd'hui, ils en consomment immédiatement une fraction très
élevée, parfois proche de 1.

Ces deux caricatures ne prétendent pas décrire fidèlement tous les ménages, mais
elles permettent de mettre en évidence un contraste central : selon que l'on insiste
sur le revenu permanent (vision ricardienne) ou sur le revenu courant sous contrainte
de liquidité (vision keynésienne), les implications macroéconomiques des chocs de
politique économique peuvent être très différentes.

Dans ce qui suit, nous commençons par analyser en détail le comportement d'un ménage
ricardien dans un cadre à deux périodes.


== Le ménage ricardien : un modèle à deux périodes

=== Préférences intertemporelles

Considérons un ménage qui vit pendant deux périodes, notées $1$ (aujourd'hui) et $2$
(demain). Il choisit un couple de consommations $(C_1, C_2)$ pour maximiser une
fonction d'utilité intertemporelle de la forme :

$ U(C_1, C_2) = log(C_1) + beta log(C_2), $

où $0 < beta < 1$ est un facteur d'actualisation. Ce paramètre traduit une **préférence
pour le présent** : toutes choses égales par ailleurs, le ménage accorde un poids plus
élevé à la consommation d'aujourd'hui qu'à celle de demain. Lorsque $beta$ est proche
de $1$, le ménage est relativement patient ; lorsque $beta$ est faible, il privilégie
fortement le présent.

La forme logarithmique de la fonction d'utilité implique que l'utilité marginale de la
consommation est décroissante : chaque unité supplémentaire de consommation procure
moins de satisfaction que la précédente. C'est cette concavité qui sera à l'origine du
**lissage de la consommation** au cours du temps.

=== Contraintes de ressources

Nous supposons que le ménage reçoit un revenu réel $Y_1$ à la période 1 et $Y_2$ à la
période 2. Pour faciliter la notation, nous normalisons le niveau des prix à la
période 1 à $P_1 = 1$ et nous notons $P_2$ le niveau des prix à la période 2.

À la période 1, le ménage choisit sa consommation $C_1$ et épargne le reste de son
revenu. La valeur nominale de cette épargne est :

$ "Épargne"_1 = Y_1 P_1 - C_1 P_1. $

Cette épargne est placée au taux d'intérêt **nominal** $i$, si bien qu'à la période 2,
elle rapporte :

$ (Y_1 P_1 - C_1 P_1) (1 + i). $

À la période 2, le ménage dispose donc de deux sources de revenu nominal : le revenu
futur $Y_2 P_2$ et le rendement de l'épargne passée. Sa contrainte budgétaire en
valeur nominale s'écrit :

$ C_2 P_2 <= (Y_1 P_1 - C_1 P_1) (1 + i) + Y_2 P_2. $

Cette expression est valide que le ménage épargne en période 1 ($C_1 P_1 < Y_1 P_1$)
ou qu'il emprunte ($C_1 P_1 > Y_1 P_1$), à la condition qu'il puisse rembourser à la
période 2.

Pour mettre en évidence le rôle du **taux d'intérêt réel**, il est utile de
réécrire cette contrainte sous une forme intertemporelle. En réarrangeant les termes :

$ C_1 P_1 (1 + i) + C_2 P_2 <= Y_1 P_1 (1 + i) + Y_2 P_2. $

En divisant maintenant les deux côtés par $P_2$ et en notant $1 + pi = P_2 / P_1$ le
facteur d'inflation entre les deux périodes, on obtient :

$ C_1 frac(1 + i, 1 + pi) + C_2 <= Y_1 frac(1 + i, 1 + pi) + Y_2. $

Par définition, le **taux d'intérêt réel** $r$ vérifie :

$ 1 + r = frac(1 + i,1 + pi). $

La contrainte de ressources intertemporelle peut donc se réécrire de manière très
compacte :

$ C_1 (1 + r) + C_2 <= Y_1 (1 + r) + Y_2. $

Le membre de droite représente la **richesse intertemporelle totale** du ménage, c'est‑à‑dire la
valeur actuelle de ses revenus lorsqu'on les exprime en unités de « consommation
future ». Le membre de gauche décrit la valeur actuelle de son plan de
consommation.

On peut interpréter $(1 + r)$ comme le **prix relatif** d'une unité de consommation
aujourd'hui en termes de consommation demain : consommer une unité de plus aujourd'hui
coûte $(1 + r)$ unités de consommation future.

Un taux d'intérêt réel plus élevé a donc deux effets :

- un **effet de substitution** : la consommation présente devient plus chère relativement
  à la consommation future, ce qui incite à reporter une partie de la consommation ;
- un **effet de richesse** : pour un ménage qui est épargnant net, une hausse du taux
  d'intérêt augmente la valeur de ses ressources futures et peut, au contraire,
  l'inciter à consommer davantage dans les deux périodes.

Le signe net de la variation de $C_1$ en réponse à une hausse de $r$ dépend donc de la
force relative de ces deux effets.

=== Résolution du problème d'optimisation

Le problème du ménage peut maintenant être formulé de manière synthétique :

$ max_(C_1, C_2) \quad log(C_1) + beta log(C_2) \\
	ext{s.c.} \quad C_1 (1 + r) + C_2 <= Y_1 (1 + r) + Y_2. $

À l'optimum, la contrainte est saturée (le ménage ne laisse pas de ressources
inutilisées), si bien que :

$ C_2 = Y_1 (1 + r) + Y_2 - C_1 (1 + r). $

En substituant dans la fonction d'utilité et en maximisant par rapport à $C_1$, on
obtient une condition du premier ordre qui conduit, après quelques calculs, à :

$ C_1 = \frac{1}{1 + beta} \left( Y_1 + \frac{1}{1 + r} Y_2 \right). $

Ainsi, la consommation optimale aujourd'hui est proportionnelle à une combinaison du
revenu présent et du revenu futur actualisé.

On peut définir le **revenu permanent** du ménage comme :

$ Y^P = Y_1 + \frac{1}{1 + r} Y_2. $

La formule précédente s'écrit alors simplement :

$ C_1 = \frac{1}{1 + beta} Y^P. $

Le ménage consomme donc une **fraction fixe** de son revenu permanent, fraction qui
dépend uniquement du paramètre d'actualisation $beta$.

Lorsque $beta$ est proche de 1, cette fraction est voisine de $1/2$ : dans un modèle à
deux périodes, le ménage choisit alors de répartir sa richesse de manière relativement
équilibrée entre aujourd'hui et demain.

Dans un modèle à horizon infini

$ max sum_(t=0)^(infinity) beta^t log(C_t), $

une analyse similaire montre que le ménage consomme à chaque période une fraction
$(1 - beta)$ de son revenu permanent défini comme la valeur actualisée de tous ses
revenus futurs :

$ Y^P = Y_1 + \frac{1}{1 + r} Y_2 + \frac{1}{(1 + r)^2} Y_3 + \cdots. $

Sous l'hypothèse souvent utilisée en équilibre stationnaire $1/beta = 1 + r$, la
fraction consommée correspond exactement aux **intérêts** du revenu permanent : le
ménage choisit de vivre perpétuellement des intérêts de son patrimoine humain et
financier, sans en entamer le capital.


== Réponses aux chocs : taux d'intérêt et revenu

La formule de consommation obtenue permet d'analyser de manière transparente la façon
dont un ménage ricardien réagit à différents chocs.

=== Variation du taux d'intérêt réel

Considérons tout d'abord une petite variation $\Delta r$ du taux d'intérêt réel,
indépendante des revenus $Y_1$ et $Y_2$. On peut approximer l'effet sur la
consommation d'aujourd'hui en dérivant la formule :

$ C_1 = \frac{1}{1 + beta} \left( Y_1 + \frac{1}{1 + r} Y_2 \right). $

En première approximation :

$ \frac{\Delta C_1}{\Delta r} \approx - \frac{1}{1 + beta} \frac{1}{(1 + r)^2} Y_2. $

Le signe négatif est conforme à l'intuition : lorsque le taux d'intérêt réel
augmente, la consommation présente tend à diminuer, car il devient plus rentable de
reporter la consommation dans le futur. La magnitude de l'effet dépend notamment du
niveau du revenu futur $Y_2$ : plus ce revenu futur est élevé, plus le ménage est
sensible au taux qui permet d'arbitrer entre aujourd'hui et demain.

=== Choc temporaire de revenu

Supposons maintenant que le ménage subisse un **choc de revenu temporaire** à la
période 1 : son revenu courant augmente de $\Delta Y$, mais son revenu futur reste
inchangé. Son revenu permanent devient :

$ Y^P_\text{nouveau} = (Y_1 + \Delta Y) + \frac{1}{1 + r} Y_2. $

La consommation optimale d'aujourd'hui s'ajuste en conséquence :

$ C_1 + \Delta C_1 = \frac{1}{1 + beta} Y^P_\text{nouveau}. $

On en déduit la **propension marginale à consommer** (PMC) d'un ménage ricardien à la
suite d'un choc de revenu temporaire :

$ \text{PMC}^\text{ricardien} = \frac{\Delta C_1}{\Delta Y} = \frac{1}{1 + beta}. $

Comme $beta$ est en général proche de 1, cette PMC est **nettement inférieure à 1**.
Autrement dit, un ménage ricardien qui reçoit un revenu temporaire supplémentaire
consacre une fraction relativement modeste de ce revenu à la consommation immédiate,
et garde le reste pour lisser sa consommation dans le temps.


== Au‑delà du modèle de base : remarques de modélisation

Le modèle que nous venons de présenter est volontairement simple, mais il contient
déjà plusieurs éléments importants.

Sur le plan des **préférences**, nous avons utilisé une forme logarithmique. Une
généralisation très courante est la fonction d'utilité à aversion relative au risque
constante (CRRA) :

$ U(C_1, C_2) = \frac{C_1^(1 - sigma)}{1 - sigma} + beta \frac{C_2^(1 - sigma)}{1 - sigma}, $

où $sigma > 0$ mesure à la fois l'aversion au risque et l'**élasticité intertemporelle
de substitution** (élasticité de la consommation future par rapport au prix relatif de
la consommation présente). Lorsque $sigma = 1$, on retrouve le cas logarithmique.

Sur le plan de l'**horizon temporel**, nous avons raisonné à deux périodes, mais la
logique se transpose à un horizon infini. Le résultat clé – consommation proportionnelle
au revenu permanent – subsiste dans de nombreux cadres, même si la formule détaillée
change.

Enfin, notre modèle est pour l'instant **déterministe** : les revenus futurs sont connus
avec certitude. Une extension naturelle consiste à supposer que le revenu futur $Y_2$
est une variable **aléatoire** suivant une certaine distribution $\mathcal{D}$. Le
ménage cherche alors à maximiser son **utilité espérée** :

$ \mathbb{E}[U(C_1, C_2)] = log(C_1) + beta \, \mathbb{E}[log(C_2)]. $

Dans ce contexte, la concavité de la fonction d'utilité fait apparaître une **aversion
au risque** : les ménages préfèrent des trajectoires de consommation plus lisses et
peuvent constituer une **épargne de précaution** pour se protéger contre les chocs
défavorables. Nous reviendrons sur ces aspects dans les exercices et les chapitres
suivants.


== Les ménages keynésiens et la contrainte de liquidité

Revenons maintenant au second archétype : le ménage keynésien, pour lequel la
contrainte de crédit joue un rôle central.

Sur le plan des préférences, rien ne distingue a priori un ménage keynésien d'un
ménage ricardien : il a les mêmes goûts pour le lissage de la consommation et la même
structure d'utilité intertemporelle. Ce qui change radicalement est la **contrainte de
ressources** : le ménage ne peut pas emprunter, ou seulement dans des limites très
restreintes.

Dans le cas extrême d'un **ménage keynésien pur**, la consommation de la première
période est bornée par le revenu courant :

$ C_1 <= Y_1. $

Si l'on suppose en outre que ce ménage souhaite consommer autant que possible compte
tenu de cette contrainte, on obtient simplement :

$ C_1 = Y_1. $

La **propension marginale à consommer** à partir du revenu courant est alors :

$ \text{PMC}^\text{keynésien} = \frac{\mathrm{d} C_1}{\mathrm{d} Y_1} = 1. $

Autrement dit, chaque euro supplémentaire de revenu disponible se traduit
quasi intégralement en consommation supplémentaire. Ce comportement est très
différent de celui du ménage ricardien, pour lequel la PMC par rapport à un choc de
revenu temporaire est nettement inférieure à 1.

Dans la réalité, de nombreux ménages se situent entre ces deux extrêmes : ils
disposent d'un certain accès au crédit, mais sous des conditions qui dépendent de leur
historique, de la valeur de leurs garanties, du fonctionnement du système bancaire,
etc. L'idée d'un **mélange** de ménages ricardiens et keynésiens s'avère néanmoins
très utile pour penser les effets distributifs des politiques économiques.


== Consommation agrégée et composition des ménages

Pour passer du niveau individuel au niveau agrégé, il ne suffit pas de connaître la
fonction de consommation d'un ménage représentatif. Il faut également tenir compte de
la **composition** de la population : quelle fraction des ménages se comporte de
manière principalement ricardienne, et quelle fraction est davantage contrainte par le
crédit au sens keynésien ?

La **propension marginale à consommer agrégée** dépendra de cette composition et de la
manière dont les chocs de revenu ou de politique économique sont **redistributifs** :

- un choc qui augmente le revenu d'agents ricardiens fortunés pourra avoir un effet
  limité sur la consommation agrégée, car ces ménages épargnent une large part du
  surplus ;
- un choc qui augmente le revenu de ménages contraints, proches de la subsistance,
  pourra, au contraire, se traduire par une forte hausse de la consommation immédiate.

L'analyse fine de ces mécanismes demande de spécifier la distribution des revenus, des
actifs et des contraintes de crédit au sein de la population. Ce sera l'objet de
séances de travaux dirigés et de chapitres ultérieurs.


== Points à retenir

Ce chapitre a introduit plusieurs idées centrales qui serviront de fil conducteur
pour la suite du cours :

1. La macroéconomie moderne cherche à **relier les agrégats** (PIB, consommation,
   investissement, etc.) aux **comportements individuels** d'agents optimisateurs
   soumis à des contraintes.
2. Le passage de la micro à la macro soulève des **problèmes d'agrégation** qui
   justifient à la fois les simplifications théoriques et le recours aux données.
3. Les décisions d'épargne et de consommation reposent sur un **arbitrage
   intertemporel** entre biens présents et futurs, gouverné par le taux d'intérêt réel
   et les anticipations de revenu.
4. Un ménage ricardien lisse sa consommation en fonction de son **revenu permanent**
   et réagit de manière relativement modérée aux chocs temporaires de revenu.
5. Un ménage keynésien, au contraire, est fortement contraint par son **revenu
   courant** et présente une propension marginale à consommer beaucoup plus élevée.
6. La **consommation agrégée** dépend de la composition de l'économie en ménages de ces
   différents types et de la nature redistributive des chocs.

Les prochains chapitres approfondiront ces idées en étudiant la demande agrégée,
l'offre agrégée, puis le rôle de la politique monétaire et budgétaire dans la
stabilisation des fluctuations économiques.
"""
