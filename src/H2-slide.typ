#import "@preview/touying:0.6.1": *


#let L2-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  let deco-format(it) = text(size: .6em, fill: gray, it)

  // let header = self => utils.display-current-heading(
  //   setting: utils.fit-to-width.with(grow: false, 100%),
  //   level: 1,
  //   depth: self.slide-level,
  // )
  let header = self => utils.display-current-heading(
    setting: utils.fit-to-width.with(grow: false, 100%),
    level: 1,
    depth: self.slide-level,
  )

  let subslide-preamble = block(
    below: 1.5em,
    text(1.2em, weight: "bold", utils.display-current-heading(level: 2)),
  )

  let self = utils.merge-dicts(
    self,
    config-store(
      header: header,
      subslide-preamble: subslide-preamble,
    ),
  )

  let header(self) = {
    deco-format(
      components.left-and-right(
        utils.call-or-display(self, self.store.header),
        utils.call-or-display(self, self.store.header-right),
      ),
    )
  }

  let footer(self) = {
    v(.5em)
    text(
      size: 0.8em,
      font: "Times New Roman",
      fill: gray,
      components.left-and-right(
        utils.call-or-display(self, self.store.footer),
        utils.call-or-display(self, self.store.footer-right),
      ),
    )
  }


  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),

    config-common(subslide-preamble: it => {
      v(0.1em)
      self.store.subslide-preamble
      v(-1.0em)
      let length = 97%
      line(length: length, stroke: 0.15pt + blue)
      v(-0.85em)
      line(length: length, stroke: 2.0pt + blue)
    }),
  )
  // set par(leading: 1em, spacing: 1em)
  set text(font: ("Times New Roman", "SimHei"))

  touying-slide(
    self: self,
    ..args.named(),
    config: config,
    align(args.pos().sum(default: none)),
  )
})
