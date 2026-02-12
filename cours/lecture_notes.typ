
#set text(font: "Linux Libertine", size: 11pt)
#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  numbering: "1",
)

#let title-slide(..args) = {
  let info = args.named()
  align(center + horizon)[
    #text(2em, weight: "bold")[#info.title]
    #v(1em)
    #text(1.5em)[#info.subtitle]
    #v(1em)
    #if "authors" in info {
      for author in info.authors [
        #author.name \
      ]
    }
    #v(1em)
    #if "date" in info {
      info.date
    }
  ]
  pagebreak()
}

// Mock slide-specific functions to make them work in a document context
#let pause = []
#let slide(..args) = {
  // Just return the body content, ignoring slide configuration
  for arg in args.pos() {
    if type(arg) == content {
      arg
    }
  }
}
#let touying-slide(..args) = {
  for arg in args.pos() {
    if type(arg) == content {
      arg
    }
  }
}
#let mean = [] // Assuming this might be used somewhere, though not seen in snippets

// Redefine columns to just show content sequentially if needed, or keep as is if it works well.
// But for notes, single column might be better. Let's keep it simple for now and see.
// Actually, #columns(2, [...]) works in standard Typst, so we can keep it.

// Redefine #only to just show the content (or show all versions?)
// For notes, we probably want to show everything, or maybe just the last version?
// Let's just show the content.
#let only(..args) = {
  let pos = args.pos()
  if pos.len() > 1 {
    pos.last()
  }
}

// Redefine #colbreak to nothing or standard colbreak
#let colbreak() = {
  // In a standard document, colbreak might force a column break if we are in columns.
  // If we are not in columns, it does nothing.
  // The slide content uses #columns(2, [...]), so colbreak() inside should work.
  // However, if we want a linear document, maybe we should redefine columns to be 1 column?
  // Let's try to keep the layout as intended by the author for now.
  typst.colbreak()
}

// Redefine #clean-theme to just return the body
#let clean-theme(..args, body) = {
  body
}

// Define other missing functions if any.
// amphi_1.typ uses:
// #import "@preview/touying:0.5.3": *
// #import "@preview/fontawesome:0.3.0": *
// #import "quarto_theme.typ": *

// We need to make sure quarto_theme.typ functions don't interfere.
// Since we are NOT importing quarto_theme.typ here, we need to mock what's used in the content files.
// The content files DO NOT import quarto_theme.typ. The DRIVER files do.
// Wait, I checked amphi_1_content.typ, it contains:
// = Introduction
// ...
// It does NOT contain imports. The imports are in amphi_1.typ.
// So I need to provide the environment for the content files.

#import "@preview/fontawesome:0.3.0": *
#import "@preview/mitex:0.2.4": *

// We need to mock functions that might be used inside the content.
// I saw #pause, #columns, #colbreak, #only, #image
// #image is standard.

// Let's define a chapter function to separate the slidesets
#let chapter(title) = {
  pagebreak(weak: true)
  heading(level: 1, numbering: "1.")[#title]
}

// Now include the content
// Define assets path for amphi 4
#let assets = "assets_4a/"

#chapter("Introduction et Consommateurs")
#let content = read("notes_1.typ")
#eval(content, mode: "markup", scope: (pause: pause, only: only))

#chapter("Demande Agrégée")
#let content = read("notes_2.typ")
#eval(content, mode: "markup", scope: (pause: pause, only: only))

#chapter("Offre Agrégée")
#let content = read("notes_3.typ")
#eval(content, mode: "markup", scope: (pause: pause, only: only))

#chapter("Modèle AS/AD et chocs Macroéconomiques")
#let content = read("notes_4.typ")
#eval(content, mode: "markup", scope: (pause: pause, only: only, assets: assets))

#chapter("Politique Monétaire")
#let content = read("notes_5.typ")
#eval(content, mode: "markup", scope: (pause: pause, only: only))
