#import "@preview/mitex:0.2.4": *
#import "pc_template.typ": pc

#show: doc => pc(
  3,
  [Coûts de catalogue],
  doc,
)

#mitext(`

On considère le modèle suivant de concurrence monopolistique avec rigidités nominales sur le marché des biens. Les firmes forment un continuum de longueur 1. Chaque firme maximise son profit réel et fait face à la fonction de demande

\begin{equation}
Y_{i}=Y\left( \frac{P_{i}}{P}\right) ^{-\eta },\;\eta >1
\end{equation}

où $Y_{i}$, $i\in \left[ 0,1\right] $ est la demande adressée à la firme $i$, $P_{i}$ le prix de vente nominal du bien qu'elle produit, $P$ le niveau général de prix (qu'on déterminera plus loin) et $Y$ la demande agrégée. Les firmes sont dotées de la fonction de production $Q_{i}=L_{i}$.


`)

#mitext(`

L'offre de travail des ménages est donnée par 

\begin{equation}
L^{o}=A\left( \frac{W}{P}\right) ^{\xi }
\end{equation}

où $\xi >0$ est l'élasticité de l'offre de travail au salaire, $W$ le salaire nominal et

\begin{equation*}
A=\left( \frac{\eta }{\eta -1}\right) ^{\xi }>0
\end{equation*}

une constante d'échelle. 

`)

#mitext(`

Enfin, on suppose que la demande agrégée est donnée par:
\begin{equation}
y=\theta-p
\end{equation}

où $\theta$ est un choc de demande. 
Comme d'habitude, les lettres minuscules désignent le logarithme des lettres majuscules correspondantes. Par ailleurs, on raisonnera toujours au voisinage de l'équilibre symétrique où toutes les firmes fixent le même prix de vente, ce qui implique que le log du prix moyen $p=\ln P$ est en première approximation égal à la moyenne des prix de vente individuels en log $p_{i}=\ln P_{i}$:

\begin{equation*}
p\simeq \int_{0}^{1}p_{i}\text{d}i,
\end{equation*}

et de même pour la demande de travail totale en log :

\begin{equation*}
l^{d}\simeq \int_{0}^{1}l_{i}\text{d}i.
\end{equation*}

`)

#mitext(`

\textbf{Première partie : prix de vente optimal et équilibre naturel}



\textbf{1.} Interpréter les équations du modèle.



\textbf{2.} Calculer le prix de vente optimal de la firme, 
$P^{\ast }$, en fonction du salaire nominal $W,$ et interpréter.


%Montrer qu'au voisinage de $P^{\ast }$ le choix d'un prix de vente $p_{i}\neq
%p^{\ast }$ engendre une perte proportionnelle de profit de l'ordre de $%
%K\left( p_{i}-p^{\ast }\right) ^{2}$, où $K$ est une constante positive
%qui dépend de l'intensité de la concurrence sur le marché des
%biens.


Dans ce qui suit, exprimez toutes les variables en logarithme.


\textbf{3.}  Utiliser l'équilibre sur le marché du travail
pour exprimer le prix réel optimal $p^{\ast }-p$ en fonction de $y$ et
expliquer le résultat obtenu.



\textbf{4.} Calculer l'équilibre de prix flexibles ($%
y^{n},p^{n}$) lorsque $\theta=\theta_{0}=0$ 


`)

#mitext(`

\textbf{Deuxième partie : coûts de catalogue hétérogènes et pente de l'arbitrage}

On suppose dans cette partie que $\xi =1$, et que l'économie est à l'équilibre naturel ($y^{n},p^{n}$) avant un choc de demande de taille $\Delta
\theta=\theta_{1}-\theta_{0}$ ($=\theta_{1}$). Les firmes font face à des coûts fixes de changement de prix (coûts de catalogues), de sorte qu'elles peuvent rationnellement
choisir de maintenir leur prix de vente au niveau $p^{n}$ même après le choc. Les coûts de catalogue diffèrent d'une firme à l'autre : en classant les firmes $i\in \left[ 0,1\right] $ par ordre croissant de coût de catalogue, on suppose que la firme $i$ fait face au coût :
\begin{equation*} 
z\left( i\right) =\bar{z}i
\end{equation*}%
où $\bar{z}$ est une constante positive.

\textbf{5.} Le choix d'un prix de vente $p_{i}\neq p^{\ast }$ engendre une perte de profit. Au voisinage de l'équilibre symétrique (où $p^{\ast }\simeq p$) la perte est de second ordre et égale à $K \left(p_ {i} -p ^ {\ast} \right) ^ {2} $, où $ K> 0 $ est une constante positive.\footnote{Il n'est pas nécessaire de dériver ce résultat.} Plus l'écart entre le prix courant  et le prix optimal  est important, plus la perte est importante.  Calculer la proportion $\omega \in \left[ 0,1\right] $
de firmes maintenant leur prix inchangé en fonction du nouveau prix
optimal $p^{\ast }$ prévalant après le choc, et interpréter.

\textbf{6.} Calculer le niveau général des prix $p$ en
fonction de $p^{\ast }$, et en déduire la relation entre $p$, $\omega $
et $y.$ Interpréter le résultat obtenu.

\textbf{7.} Utiliser les réponses aux questions 5 et 6 pour
montrer que la courbe d'offre agrégée peut s'écrire%
\begin{equation}
y\left( p\right) =\left( \left( \bar{z}/K\right) ^{\frac{1}{3}}\left\vert
p\right\vert ^{-\frac{2}{3}}-1\right) p,  \tag{OA}
\end{equation}%
et représenter graphiquement cette fonction dans le plan ($y,p$). Commentez la pente de la courbe. 

`)

#mitext(`

\textbf{Troisième partie (facultatif) : coûts de catalogue
et multiplicité d'équilibres}

On suppose maintenant que $\xi >1$, et que toutes les firmes font face au même coût de catalogue $\bar{z} $. Comme dans la deuxième partie, l'économie est initialement à l'équilibre naturel et on s'interroge sur les incitations qu'ont les firmes à changer leur prix suite au choc $\Delta \theta$.

\textbf{8.} Exprimer $p$, $y$ et $p^{\ast }$ en fonction de $\Delta \theta$ et $%
1-\omega $

\textbf{9.} Calculer $Kp^{\ast 2}$ en fonction de $\omega $, et interpréter le résultat obtenu.

\textbf{10.} Calculer les valeurs de $\Delta \theta $ pour lesquelles

\begin{itemize}
\item $\omega =0$ est le seul équilibre de Nash symétrique

\item $\omega =1$ est le seul équilibre de Nash symétrique

\item les deux équilibres de Nash sont possibles.
\end{itemize}

`)