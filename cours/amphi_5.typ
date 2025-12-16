#import "@preview/touying:0.5.3": *
#import "@preview/fontawesome:0.3.0": *
#import "quarto_theme.typ": *

#show: clean-theme.with(
  aspect-ratio: "16-9",
)

#title-slide(
  title: [Politique Monétaire],
  subtitle: [ECO432 - Macroéconomie],
  authors: (
    (
      name: [Pablo Winant],
      affiliation: [],
      email: [],
      orcid: [],
    ),
  ),
  date: [],
)

#let content = read("notes_5.typ")
#eval(content, mode: "markup", scope: (
  pause: pause,
  only: only,
))
