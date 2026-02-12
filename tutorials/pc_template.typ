  #let correction(content, visible: true) = {
    if visible {
      block(
        emph(content),
        breakable: true,
        stroke: (left: 1pt),
        inset: (left: 12pt)
      )
    }
  }

#let pc(pcn, title, doc, correct: true) = {

  // set correction(with_correction: with_correction )
  set page(
    paper: "a4",
    number-align: center,
    // header: align(
    //   right + horizon,
    //   title
    // ),
  )

  set page(numbering: "1")

  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      numbering(
        el.numbering,
        ..counter(eq).at(el.location())
      )
    } else {
      // Other references as usual.
      it
    }
  } 


  {
  set align(center)

    text(
      12pt,
      [École Polytechnique - Eco 432 - Macroéconomie\
      \
      ]
    )

    if correct {
      text(12pt, "PC " +str(pcn)+" - "+title + " - Correction")
    } else {
      text(12pt, "PC " +str(pcn)+" - "+title)
    }
  }

  set math.equation(numbering: "(1)")

  set par(justify: true)
  set text(
    font: "New Computer Modern",
    size: 10pt
  )

  text("")




  doc
}


