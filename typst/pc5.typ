#import "@preview/mitex:0.2.4": *
#import "pc_template.typ": pc

#show: doc => pc(
  5,
  [Le biais inflationniste],
  doc,
)

#mitext(`


L'économie est composée de trois types d'agents, les \textit{travailleurs}, les \textit{entrepreneurs} et la \textit{banque centrale}.
Les premiers vendent leur travail aux seconds, lesquels produisent des biens à l'aide de la fonction de production:
\begin{equation*}
Y_{t}=\sqrt{2e^{\epsilon _{t}}l_{t}},
\end{equation*}
où $l_{t}$ désigne la quantité de travail demandée, $Y_{t}$ la production, et où $\epsilon _{t}$ est un choc de productivité de moyenne nulle, non auto-corrélé et de variance $\sigma _{\epsilon}^{2}$. Soit $P_{t}$ le prix nominal des biens, $W_{t}$ le salaire nominal, et $\pi _{t}=\left( P_{t}-P_{t-1}\right) /P_{t-1}$ le taux d'inflation réalisé en période $t$, dont on suppose qu'il est parfaitement contrôlé par la banque centrale. On appelle $P_{t}^{a}$ et $\pi _{t}^{a}$ l'anticipation en période $t-1$ du niveau des prix et du taux d'inflation qui prévaudront en période $t$.

`)

\

#mitext(`

\textbf{Première partie : la fonction d'offre agrégée}


 \textbf{1.} Calculer la demande de travail des entrepreneurs, et
en déduire que la fonction d'offre globale peut s'écrire:
\begin{equation*}
y_{t}=p_{t}-w_{t}+\epsilon _{t},
\end{equation*} 
où $y_{t}=\ln Y_{t},\;p_{t}=\ln P_{t}$ et $w_{t}=\ln W_{t}.$

 \textbf{2.} On suppose que le salaire nominal $W_{t}$ est prédeterminé en période $t-1,$ et fixé par les travailleurs de manière à leur assurer un salaire réel anticipé unitaire: 
\begin{equation*}
W_{t}/P_{t}^{a}=1
\end{equation*}
Montrer que ce mode de fixation du salaire nominal implique que la fonction d'offre globale peut s'écrire:
\begin{equation*}
y_{t}=\pi _{t}-\pi _{t}^{a}+\epsilon _{t},
\end{equation*} 
et interpréter cette relation.


`)

\

#mitext(`
 \textbf{Deuxième partie : discrétion et règle dans la conduite de la politique monétaire}

On suppose que les anticipations sont rationnelles, de sorte que $\pi
_{t}^{a}=E_{t-1}\left( \pi _{t}\right) $. La fonction de perte de la banque
centrale est donnée par:
\begin{equation*}
L_{t}=\pi _{t}^{2}+b\left( y_{t}-y^{\ast }\right) ^{2},\;b\geq 0,
\end{equation*}
où $y^{\ast }>0$ est le niveau du PIB qui garantirait le plein emploi.

 \textbf{3.} On suppose que la banque centrale ne peut influencer les
anticipations des agents privés (elle n'est pas "crédible"), et
prend donc $\pi _{t}^{a}$ comme donnée. Résoudre le programme de la
banque centrale et déduire sa fonction de meilleure réponse, qui
exprime $\pi _{t}$ en fonction de $\pi _{t}^{a}$ et $\epsilon _{t}$.

 \textbf{4.} Sachant que les agents forment leurs anticipations rationnellement, en déduire le biais inflationniste $E_{t-1}\left( \pi_{t}\right) $, puis l'inflation et l'écart au PIB potentiel, $\pi _{t}$
et $y_{t}$. En quel sens peut-on parler d'un arbitrage entre stabilisation de l'inflation et stabilisation du PIB?

 \textbf{5.} On suppose maintenant que la banque centrale peut s'engager, à la date $t-1,$ à suivre une règle prédéfinie $\pi _{t}=\rho _{0}+\rho _{1}\epsilon _{t}$ à la date $t$.
Calculer la perte anticipée de la banque centrale $E_{t-1}\left(L_{t}\right) $, et en déduire les valeurs de $\rho _{0}$ et de $\rho_{1} $ qu'elle choisit à la date $t-1$. Quelles valeurs de $\pi _{t}$ et
de $y_{t}$ cette règle implique-t-elle ?

`)

#mitext(`


\textbf{Troisième partie : délégation de la politique monétaire à un banquier central "conservateur"}

On suppose maintenant que la société peut déléguer la politique monétaire à un banquier central indépendant, qui est choisi à la date $t-1$. Les préférences de ce banquier central
sont représentées par la fonction de perte $L_{t}^{i}\left(b_{i}\right) =\pi _{t}^{2}+b_{i}\left( y_{t}-y^{\ast }\right) ^{2}.$ Le problème pour la société est donc de choisir $b_{i}$ à la date $
t-1$, compte tenu du fait que $b_{i}$ influencera $\pi _{t}$ et $y_{t}$.

 \textbf{6.} En utilisant la réponse à la question \textbf{2.}, écrire en fonction de $b_{i},$ $y^{\ast }$ et $\epsilon _{t}$ le niveau d'inflation $\pi _{t}$ et d'écart au PIB potentiel $y_{t}$ qui
seront choisi par ce banquier central . En déduire la perte anticipée pour la société $E_{t-1}\left( L_{t}\right) $ consécutive du choix d'un banquier central avec préférences $L_{t}^{i}\left(
b_{i}\right) $.

 \textbf{7.} Montrer qu'il est optimal pour la société de choisir $b_{i}<b$ à la date $t-1,$ et interpréter ce résultat.

 \textbf{8.} Quels sont les implications de la délégation en termes de niveau et de volatilité de l'inflation et du PIB?


`)