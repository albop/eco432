#import "@preview/touying:0.5.3": *
#import "@preview/fontawesome:0.3.0": *
#import "quarto_theme.typ": *

#show: clean-theme.with(
  aspect-ratio: "16-9",
)

#title-slide(
  title: [Introduction et Consommateurs],
  subtitle: [ECO432 - Macroéconomie],
  authors: (
    (name: [Pablo Winant], affiliation: [], email: [], orcid: []),
  ),
  date: [],
)

#let content = read("notes_1.typ")
#eval(content, mode: "markup", scope: (
  pause: pause,
  only: only,
))
