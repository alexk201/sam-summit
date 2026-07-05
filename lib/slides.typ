// HM Polylux Theme
// Presentation theme for Hochschule München
#import "@preview/polylux:0.4.0": *

// ============================================
// HM Brand Colors
// ============================================

#let colors = (
  red: rgb(252, 85, 85),
  green: rgb(74, 211, 134),
  yellow: rgb(255, 255, 0),
  blue: rgb(62, 70, 217),
  dark-gray: rgb(110, 110, 110),
  light-gray: rgb(198, 198, 198),
  accent1: rgb(87, 66, 63),
  accent2: rgb(191, 165, 163),
  accent3: rgb(110, 158, 0),
  accent4: rgb(55, 106, 0),
)

#let default-theme-colors(
  dark-mode: true,
  background-color: rgb(33, 33, 33),
  text-color: rgb(255, 255, 255),
  color-primary: colors.red,
  color-accent: colors.red,
  heading-1-color: none,
  heading-2-color: none,
) = {
  let resolved-heading-1 = if heading-1-color != none {
    heading-1-color
  } else if dark-mode {
    text-color
  } else {
    black
  }
  let resolved-heading-2 = if heading-2-color != none {
    heading-2-color
  } else if dark-mode {
    text-color.lighten(15%)
  } else {
    colors.dark-gray
  }
  let resolved-secondary-text = if dark-mode {
    text-color.lighten(25%)
  } else {
    rgb(80, 80, 80)
  }

  (
    dark-mode: dark-mode,
    background-color: background-color,
    text-color: text-color,
    secondary-text-color: resolved-secondary-text,
    heading-1-color: resolved-heading-1,
    heading-2-color: resolved-heading-2,
    color-primary: color-primary,
    color-accent: color-accent,
  )
}

// Metadata for access across slides
#let meta-state = state("meta", (:))

// ============================================
// Footer
// ============================================

#let hm-footer() = {
  set text(size: 10pt)
  context {
    let m = meta-state.get()
    grid(
      columns: (1fr, 6fr, 1fr),

      align(left)[
        #image("../img/HM_Logo.svg", height: 22pt)
      ],
      [#text(weight: "bold")[#m.title #if m.subtitle != none {
            [\- #m.subtitle]
          }] #linebreak()
        #m.author #if m.institute != none {
          [\- #m.institute]
        }],
      align(right)[
        #toolbox.slide-number#if m.show-footer-num-pages == true {
          [/#toolbox.last-slide-number]
        }],
    )
  }
}

// ============================================
// Title slide
// ============================================

#let title-slide(
  title: [],
  subtitle: [],
  author: [],
  institute: [],
  date: [],
  uppercase-title: true,
  show-footer: false,
  content-overlay: none,
) = slide[
  #set align(center + horizon)
  #set page(footer: if show-footer { hm-footer() })

  #context {
    let m = meta-state.get()
    let theme = m.theme

    set text(fill: theme.text-color)

    place(top + right)[
      #image("../img/HM_Logo_Text_red.pdf", height: 2.5cm)
    ]

    place(left + horizon, dx: 25%, dy: 10%, {
      let override-or-meta(value, meta-value) = if value == [] {
        meta-value
      } else { value }

      // Title
      text(size: 22pt, weight: "bold", fill: theme.heading-1-color)[
        #if uppercase-title { upper(override-or-meta(title, m.title)) } else {
          override-or-meta(title, m.title)
        }
      ]

      v(0.5em)

      // Subtitle
      text(
        size: 18pt,
        fill: theme.heading-2-color,
        style: "italic",
        weight: "light",
      )[
        #override-or-meta(subtitle, m.subtitle)
        #linebreak()
      ]

      // Author
      text(
        size: 16pt,
        weight: "light",
        fill: theme.secondary-text-color,
      )[
        #linebreak()
        #override-or-meta(author, m.author)]

      text(size: 16pt, weight: "light", fill: theme.secondary-text-color)[
        #linebreak()
        #override-or-meta(institute, m.institute)]

      // Date
      text(size: 14pt, weight: "light", fill: theme.secondary-text-color)[
        #linebreak()
        #override-or-meta(date, m.date)]
    })
  }
  #if content-overlay != none {
    content-overlay
  }
]

// ============================================
// Theme Setup
// ============================================

#let setup(
  aspect-ratio: "16-9",
  title: none,
  subtitle: none,
  author: none,
  institute: none,
  date: none,
  show-footer: true,
  show-footer-num-pages: true,
  dark-mode: true,
  background-color: rgb(33, 33, 33),
  text-color: rgb(255, 255, 255),
  heading-1-color: none,
  heading-2-color: none,
  color-primary: colors.red,
  color-accent: colors.red,
  font: ("Helvetica Neue", "Nimbus Sans"),
  size-base: 16pt,
  body,
) = {
  let theme = default-theme-colors(
    dark-mode: dark-mode,
    background-color: background-color,
    text-color: text-color,
    color-primary: color-primary,
    color-accent: color-accent,
    heading-1-color: heading-1-color,
    heading-2-color: heading-2-color,
  )

  // Store metadata in state
  meta-state.update((
    title: title,
    subtitle: subtitle,
    author: author,
    institute: institute,
    date: date,
    show-footer: show-footer,
    show-footer-num-pages: show-footer-num-pages,
    color-primary: color-primary,
    color-accent: color-accent,
    theme: theme,
  ))

  set text(
    font: font,
    weight: "light",
    size: size-base,
    fill: theme.text-color,
  )

  // Page setup
  set page(
    paper: "presentation-" + aspect-ratio,
    fill: theme.background-color,
    margin: (x: 3em, top: 3em, bottom: 4em),
    footer: if show-footer { hm-footer() },
  )

  // Heading styles
  show heading.where(level: 1): set text(
    size: 28pt,
    fill: theme.heading-1-color,
    weight: "bold",
  )

  show heading.where(level: 2): set text(
    size: 22pt,
    fill: theme.heading-2-color,
    weight: "bold",
  )

  // List styling
  set list(
    marker: (
      text(fill: theme.color-accent, [▶]),
      text(fill: theme.color-accent.darken(20%), [▶]),
      text(fill: theme.color-accent.darken(40%), [▶]),
      text(fill: theme.color-accent.darken(50%), [▶]),
      text(fill: theme.color-accent.darken(60%), [▶]),
    ),
    indent: 0.25em,
  )
  set enum(indent: 1em)

  body
}


// ============================================
// BMFTR Note
// ============================================

#let bmftr-note(language: "en", dx: 50pt, dy: 50pt) = {
  let note = if language == "de" { [Gefördert durch] } else if (
    language == "en"
  ) {
    [Funded by]
  }
  let img-path = if language == "de" { "../img/BMFTR_Logo_DE.svg" } else if (
    language == "en"
  ) {
    "../img/BMFTR_Logo_EN.svg"
  }
  place(bottom + right, dx: dx, dy: dy)[
    #stack(spacing: 0pt, align(left)[#text(size: 8pt)[#note]], box(
      width: 6cm,
    )[
      #image(img-path, width: 6cm)
    ])
  ]
}

// ============================================
// Slide Layouts
// ============================================

#let slide-content(body) = box(width: 100%, height: 100%)[
  #pad(bottom: 0.5cm)[#body]
]

#let slide-vertical(
  title,
  body,
  show-footer: true,
  content-overlay: none,
) = slide[
  #set page(footer: if show-footer { hm-footer() })
  #grid(
    rows: (auto, 1fr),
    align(left)[#heading[#title]],
    box(width: 100%, height: 100%)[
      #v(1.2em)
      #slide-content[
        #align(horizon)[
          #body
        ]
        #if content-overlay != none {
          content-overlay
        }
      ]
    ],
  )
]

#let slide-centered(
  title,
  body,
  show-footer: true,
  content-overlay: none,
) = slide[
  #set page(footer: if show-footer { hm-footer() })
  #grid(
    rows: (auto, 1fr),
    align(left)[#heading[#title]],
    box(width: 100%, height: 100%)[
      #v(1.2em)
      #slide-content[
        #align(center + horizon)[
          #body
        ]
        #if content-overlay != none {
          content-overlay
        }
      ]
    ],
  )
]

#let slide-split-2(
  title,
  content-left,
  content-right,
  show-footer: true,
  content-overlay: none,
) = slide[
  #set page(footer: if show-footer { hm-footer() })
  #grid(
    rows: (auto, 1fr),
    align(left)[#heading[#title]],
    box(width: 100%, height: 100%)[
      #v(1.2em)
      #slide-content[
        #grid(
          columns: (1fr, 1fr),
          rows: 1fr,
          content-left, content-right,
        )
        #if content-overlay != none {
          content-overlay
        }
      ]
    ],
  )
]

#let slide-split-1-2(
  title,
  content-left,
  content-right,
  bg-color: white,
  show-footer: true,
  content-overlay: none,
) = slide[
  #set page(
    background: place(left + top, box(
      width: 30%,
      height: 100%,
      fill: bg-color,
    )),
  )
  #set page(footer: if show-footer { hm-footer() })
  #grid(
    rows: (auto, 1fr),
    align(left)[#heading[#title]],
    box(width: 100%, height: 100%)[
      #v(1.2em)
      #slide-content[
        #grid(
          columns: (1fr, 2fr),
          rows: 1fr,
          content-left, content-right,
        )
        #if content-overlay != none {
          content-overlay
        }
      ]
    ],
  )
]

// ============================================
// Section Support
// ===========================================

#let page-progress = toolbox.progress-ratio(ratio => {
  set grid.cell(inset: (y: .05em))
  let m = meta-state.get()
  grid(
    columns: (ratio * 100%, 1fr),
    grid.cell(fill: m.color-primary)[],
    grid.cell(fill: m.color-primary.luma().lighten(50%))[],
  )
})

#let new-section(name, show-slide: true) = {
  toolbox.register-section(name)
  if show-slide == true {
    slide({
      set page(header: none, footer: none)
      show: pad.with(x: 10%, y: 25%)
      set text(size: 22pt, weight: "bold")
      name
      page-progress
    })
  }
}

#let new-section-orientation(name, highlight-color: none) = slide({
  set page(header: none, footer: none)
  show: pad.with(x: 10%, y: 5%)
  set text(size: 22pt)

  toolbox.register-section(name)

  toolbox.all-sections((sections, current) => {
    for section in sections {
      if section == current {
        text(
          weight: "bold",
          fill: if highlight-color != none { highlight-color } else {
            text.fill
          },
          top-edge: "ascender",
        )[#section]
      } else {
        text(weight: "light", fill: text.fill.lighten(50%))[#section]
      }
      linebreak()
    }
  })

  align(bottom)[
    #page-progress
  ]
})

#let toc = toolbox.all-sections((sections, _cur) => {
  list(..sections)
})

#let slide-toc(title: "Content") = slide[
  #set page(footer: none)
  #heading[#title]
  #text(size: 22pt, weight: "light")[
    #grid(
      columns: (1fr, 7fr, 2fr),
      rows: (5fr, 1fr),
      [], align(horizon, toc),
    )
  ]
]
