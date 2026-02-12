

+ 
+ 
+ 

#strong[Perte de profit]

Soit $Theta lr((X_i))$ le profit d’une firme qui vend au prix r éel
$X_i eq P_i slash P$ :
$ Theta lr((X_i)) eq Y X_i^(minus eta) lr((X_i minus W / P)) comma $
avec $Theta lr((X^ast.basic))$ le profit d’une firme qui vend au prix
réel optimal. Pour $X_i$ proche de $X^ast.basic$ on a :
$$ Theta(X_i) - Theta(X^{ast}) \simeq
  left. frac(partial Theta(X_i), partial X_i) right|_{X_i = X^{ast}} (X_i - X^{ast})
  + frac(1, 2) left. frac(partial^2 Theta(X_i), partial X_i^2) right|_{X_i = X^{ast}} (X_i - X^{ast})^2 $$
$$ frac(Theta(X_i) - Theta(X^{ast}), Theta(X^{ast})) \simeq
  left( frac(X^{ast 2}, 2 Theta(X^{ast})) left. frac(partial^2 Theta(X_i), partial X_i^2) right|_{X_i = X^{ast}} right)
  left( frac(X_i - X^{ast}, X^{ast}) right)^2 $$
où $x_i eq ln X_i eq p_i minus p$. Ainsi, un écart proportionnel au prix
r éel optimal engendre une perte proportionnelle de profit de second
ordre. Pour mesurer la taille de cet effet, utilisons d’abord
#link(<prix-reel-optimal>)[Prix reel optimal] pour écrire le profit au
prix optimal comme suit
$$ Theta(X_i) = Y X_i^{-eta} (X_i - W / P)
  = Y X_i^{-eta} left( X_i - left( frac(eta - 1, eta) right) frac(P^{ast}, P) right) $$
This implies:
$$ align(
  frac(partial Theta(X_i), partial X_i) = -eta Y X_i^{-eta - 1} left( X_i - left( frac(eta - 1, eta) right) frac(P^{ast}, P) right) + Y X_i^{-eta};
  frac(partial^2 Theta(X_i), partial X_i^2) = eta (eta + 1) Y X_i^{-eta - 2} left( X_i - left( frac(eta - 1, eta) right) frac(P^{ast}, P) right) - 2 eta Y X_i^{-eta - 1}
) $$
and therefore
$$ left. frac(partial^2 Theta(X_i), partial X_i^2) right|_{X_i = X^{ast}}
  = eta (eta + 1) Y left( 1 - frac(eta - 1, eta) right) - 2 eta Y = Y (1 - eta) $$
Near the symmetric equilibrium ($X^{ast.basic} tilde.eq 1$) we get:
$$ frac(X^{ast 2} Theta''(X^{ast}), 2 Theta(X^{ast})) \simeq
  frac(Theta''(1), 2 Theta(1))
  = frac(Y (1 - eta), 2 frac(Y, eta)) = frac(eta (1 - eta), 2) < 0 $$
La perte proportionnelle de profit s’écrit donc
$ K (p_i - p^ast.basic)^2, text("avec") K = - frac(eta (1 - eta), 2) > 0 $
Plus les biens sont substituables entre eux (c’est-à-dire plus $eta$ est
élevé), plus l’intensité de la concurrence augmente et plus il devient
coûteux de s’écarter du prix optimal $p^ast.basic$.
