#import "@preview/polylux:0.4.0": *
#import "../lib/slides.typ" as hm: *

#show: hm.setup.with(
  title: "Smart Automobile Munich",
  subtitle: "Autonomes Fahren im Maßstab 1:8",
  font: "libertinus serif",
  author: "Alexander Kluge",
)

#hm.title-slide()

#slide-vertical("Wer bin ich?")[
  - Master Informatik

    - Hochschule München

  - Bachelor Wirtschaftsinformatik

    - Hochschule Mainz
]

#slide-vertical("Wer sind wir?")[
  - "Projektstudium" für Bachelor und Master Informatik

  - Etwa 20 Studierende pro Semester

  - Drei Professoren

  - Fünf Tutoren
]

#slide-centered("Was machen wir?")[
  #image("/img/content/waymo.png", width: 100%, fit: "cover")
]

#slide-centered("Was machen wir?")[
  #image("/img/content/waymo.png", height: 3cm, fit: "cover")
]

#slide-split-2(
  "Was machen wir?",
  align(bottom + left, image("/img/content/aadc-transparent.png", height: 60%)),
  align(bottom + right, image("/img/content/samx-transparent.png", height: 70%)),
)
