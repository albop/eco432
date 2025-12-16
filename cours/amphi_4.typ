#import "@preview/touying:0.5.3": *
#import "@preview/fontawesome:0.3.0": *
#import "quarto_theme.typ": *

#show: clean-theme.with(
  aspect-ratio: "16-9",
)

#let assets = "assets_4a/"

#title-slide(
  title: [Modèle AS/AD et chocs Macroéconomiques],
  subtitle: [ECO432 - Macroéconomie],
  authors: (
    (name: [Pablo Winant], affiliation: [], email: [], orcid: []),
  ),
  date: [],
)

#let content = read("notes_4.typ")
#eval(content, mode: "markup", scope: (
  pause: pause,
  only: only,
  assets: assets,
))
