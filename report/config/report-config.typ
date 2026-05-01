#import "../config/constants.typ": chapter
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *


#let config(
    myAuthor: "Nome cognome",
    myTitle: "Titolo",
    myLang: "en",
    myNumbering: "1.",
    body
) = {
    // Set the document's basic properties.
    set document(author: myAuthor, title: myTitle)
    show math.equation: set text(weight: 400)
    show link: set text(fill: rgb("#1749ec"))
    
    // LaTeX look (secondo la doc di Typst)
    set page(margin: 1.2in, numbering: "1", number-align: center)
    // set par(leading: 0.55em, first-line-indent: 1.8em, justify: true)
    set par(
        leading: 1em,   // 0.55em
        spacing: 0.55em,
        justify: true)
    set text(font: "New Computer Modern", size: 12pt, lang: myLang) // 10pt
    set sub(size: 0.65em)
    set heading(numbering: myNumbering)
    show raw: set text(font: "New Computer Modern Mono", size: 11pt, lang: myLang) // 10pt
    //show par: set block(spacing: 0.55em)
    set par(spacing: 1em) // 0.55em
    show heading: set block(above: 1.8em, below: 1em) // 1.4em e 1em
    // set block of codes with codly
    show: codly-init.with()
    codly(languages: codly-languages)
    codly(smart-indent: true)

    
    show heading.where(level: 1): set text(size: 25pt)

    show heading.where(level: 2): set text(size: 15pt)

  body
}


#let configFirstPage(
    myLang: "it",
    body
) = {
    // set par(leading: 0.55em, first-line-indent: 1.8em, justify: true)
    set par(
        leading: 0.55em,
        spacing: 0.55em,
        first-line-indent: 1.8em,
        justify: true)
    //show par: set block(spacing: 0.55em)
    set par(spacing: 0.55em)

  body
}