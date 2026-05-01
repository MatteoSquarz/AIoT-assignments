#let logo = "../images/unipd-logo.svg"
#import "../config/report-config.typ": configFirstPage

#set page(numbering: none)

#show: configFirstPage.with(myLang: "en")

#grid(
    columns: (auto),
    rows: (auto),
    // Corpo
    [
        #v(30pt)
        #align(center, text(18pt, weight: "semibold", "University of Padua"))
        #v(40pt)
        // Logo
        #align(center, image(logo, width: 70%))
        #v(30pt)

        // Titolo
        #set par(justify: false)
        #align(center, text(18pt, hyphenate: false, weight: "semibold", "AIoT basics using Containerization"))
        #set par(justify: true)
        #v(10pt)
        #align(center, text(14pt, weight: "semibold", "Exercises 1, 2, 3"))
        #v(50pt)


        #align(left, text(12pt, weight: 600, "Student: Matteo Squarzoni"))
        #v(5pt)
        #align(left, text(12pt, weight: 600, "Student ID: " + "2197481"))
        #v(70pt)
    ],
    // Piè di pagina
    [
        // Anno accademico
        #line(length: 100%)
        #align(center, text(11pt, weight: 400, "ACADEMIC YEAR " + "2025" + " - " + "2026"))
    ]

)