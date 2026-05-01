// Frontmatter

#include "./preface/firstpage.typ"
#set text(hyphenate: false)
#include "./preface/table-of-contents.typ"

// Mainmatter

#counter(page).update(1)
#include "./chapters/assignment.typ"
