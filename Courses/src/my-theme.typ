#import "@preview/touying:0.6.1": *
#import "@preview/cuti:0.3.0": show-cn-fakebold
#import "@preview/codly:1.3.0": *
#import "H2-slide.typ": *
#import "table.typ": *


#let blank-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(
      header: none,
      footer: none,
      margin: (x: 0.2em, y: 0em),
    ),
  )
  set par(leading: 1em, spacing: 1em)
  set text(font: ("Times New Roman", "SimHei"))

  touying-slide(
    self: self,
    ..args.named(),
    config: config,
    align(center + horizon, args.pos().sum(default: none)),
  )
})

/// Centered slide for the presentation.
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
#let centered-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  touying-slide(self: self, ..args.named(), config: config, align(center + horizon, args.pos().sum(default: none)))
})

/// Title slide for the presentation.
///
/// Example: `#title-slide[Hello, World!]`
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
#let title-slide(config: (:), body) = {
  let setting = doc => {
    set text(size: 50pt, font: "SimHei")
    doc
  }
  centered-slide(
    config: utils.merge-dicts(config, config-common(freeze-slide-counter: true)),
    setting: setting,
  )[
    #set text(size: 50pt, font: "SimHei")

    #place(
      horizon,
      image("../images/bg.png", width: 120%),
      dy: 175pt,
    )
    #body
    // #v(1em)
  ]
}

#let L3-slide(config: (:), body) = {
  let self = utils.merge-dicts(
    self,
    config-page(
      header: none,
      footer: none,
      margin: (x: 0.2em, y: 0em),
    ),
  )
  body
}

/// New section slide for the presentation. You can update it by updating the `new-section-slide-fn` argument for `config-common` function.
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
#let new-section-slide(config: (:), body) = centered-slide(config: config, [
  #grid(
    rows: (1fr, 1fr),
    [
      #place(
        horizon + center,
        image("../images/logo_cug.png", width: auto),
        // dx: 300pt,
        dy: 30pt,
      )
      // #v(10.5em)
      #v(16.5em)
      #text(size: 50pt, weight: "bold", utils.display-current-heading(level: 1), fill: blue.darken(10%))
      #body
    ],
    [
      #v(8.5em)
      #image("../images/bg.png", width: 120%)
    ],
  )
])


#let my-theme(self: none, size: 22pt, body) = {
  // set text(size: size, font: ("Times New Roman", "FangSong"))
  // set par(leading: 1em, spacing: 1em)
  set text(size: size, font: "Microsoft YaHei") //
  set par(leading: 1em, spacing: 1.2em)
  // #set list(marker: text(size: 1.2em)[•])
  set list(marker: scale(x: 150%, y: 150%, origin: center)[•])

  show: show-cn-fakebold

  set math.equation(numbering: none) //"(1)"
  show math.equation: set text(size: 1em)
  show math.equation.where(block: true): set par(spacing: 0.7em, leading: 0.5em)

  show footnote.entry: set text(size: 1.5em)
  // show heading: set text(20pt)
  show heading.where(level: 3): it => {}
  show table: set-table

  // 链接
  show link: underline
  show link: set text(fill: rgb(0, 0, 255))

  set figure.caption(separator: "")
  // set figure(numbering: num => numbering("1", num))
  set figure(numbering: none)
  show figure.where(kind: image): it => {
    set figure(supplement: text("图", weight: "bold"))
    set text(size: 16.5pt, font: ("Times New Roman", "SimHei"))
    it
  }

  show raw: set text(font: ("consolas", "Microsoft Yahei", "SimSun"), size: 0.8em)
  show: codly-init.with()
  codly(stroke: 1pt + blue)
  codly(display-icon: true)
  // show heading.where(level: self.slide-level + 1): set text(1.4em)
  // show heading.where(level: 1): set text(1.6em)
  body
}
