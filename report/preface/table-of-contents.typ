#import "../config/constants.typ": figuresList, tablesList, codesList
#set page(numbering: "i"); #counter(page).update(n => n + 3)
#show link: set text(fill: rgb("#000000"), size: 13pt)
#[
  #show outline.entry.where(level: 1): it => {
    linebreak()
    link(it.element.location(), strong(it))
//    h(1fr)
  }
  #outline(
    indent: auto,
    depth: 5
  )
]

#v(8em)



#pagebreak()
