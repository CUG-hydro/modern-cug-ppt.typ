#import "@preview/touying:0.6.1": *
#import "@preview/mitex:0.2.5": mi, mitex
#import "@preview/physica:0.9.4": *

// #import themes.simple: *
#import "src/simple.typ": *

// #show "{": ""
// #show "}": ""

#let delta(x) = $Delta #x$
#let link(it) = underline[#text(fill: blue)[#it]]
#let quote(it) = beamer-block(it, color: luma(140))


#let set-header(self) = {
  utils.display-current-heading(
    setting: utils.fit-to-width.with(grow: false, 100%),
    level: 1,
    depth: self.slide-level,
    stype: (),
  )
}

#show: simple-theme.with(aspect-ratio: "16-9", size: 19pt)

#title-slide[
  #let font = ("Times New Roman", "SimHei", "Microsoft YaHei")
  #set text(font: font)
  #set par(spacing: 1em, leading: 0.7em)
  #show math.equation: set text(size: 24pt, font: "SimHei")

  #align(center)[#text(size: 42pt, weight: "bold", font: font)[
    水文气象学2025
  ]]

  #v(0.4em)

  #align(center)[#text(size: 28pt, weight: "bold", font: font)[

    孔冬冬 副教授 \

    #v(-0.05em)
    中国地质大学（武汉）

    #v(-0.15em)
    #link[kongdongdong\@cug.edu.cn]

    // #v(3.1em)
    // 2025.09.13~ 西安
  ]]
  // #v(-1.4em)
]


= 1 *研究背景*

== 1.1 *研究目的*

// #set text(size: 18pt, font: ("Times New Roman", "FangSong"))

#H2-slide[
  #set text(size: 20pt, font: ("Times New Roman", "FangSong"))

  #quote[*蒸散发是一个既简单又复杂的过程。涉及的过程众多:*]

  // *简单*：它是一个水汽从低浓度到高浓度扩散的一个过程。
  // *复杂*：
  - *辐射传输*#h(1.2em)：冠层短波与长波辐射传输
  - *冠层结构*#h(1.2em)：大叶模型、双大叶模型、双叶模型、多层树冠
  - *气孔导度*#h(1.2em)：Ball-Berry 1987、Leuning 1995、Yu 2004
  - *植被光合*#h(1.2em)：Thornley 1976、Farquhar 1982
  - *土壤水运动* ：BEPS、SiTH--V2、GLEAM--V4
  - *地下水运动* ：_Fan_ et al., 2013 _*Science*_; 2017 _*PNAS*_ ; 2024 _*Nature*_; 2025 _*Nature*_

  // 2007 _*JGR-A*_
  #box-red[*研究目的*：]

  ① #Blue[研究植被蒸腾如何从土壤和地下水中抽水]；

  ② *模型搭建成功，也是一个简易的水文模型*。
]

#H2-slide[
  // #set text(size: 20pt, font: "Microsoft YaHei") //
  #set par(leading: 1em, spacing: 1.1em)
  // #set list(marker: text(size: 1.2em)[•])
  // #set list(marker: scale(x: 150%, y: 150%, origin: center)[•])

  课程的每一个章节，都可以在实战中进行应用，但是需要一点编程技巧。

  #quote[
    推荐学习：Python、R、Julia中的一种。
  ]

  - *Julia*: 擅长数学、物理，与MATLAB的定位相似，擅长解偏微分方程，速度接近C，
    https://julialang.org/；

  - *R*：统计最强，表格数据处理最强（tidyverse），
    https://cran.r-project.org/bin/windows/base/；

  - *Python*: 深度学习最强，https://conda-forge.org/download/；

  #box-red[#text(size: 21pt)[
    Claude Skills的作用是：*不写代码！*
  ]]

  1. 如果能把低智的大模型教会，那是否意味着也能把所有的学生都教会*数据处理*和*跑模型*？

  2. 如果大模型能学会，而人类学不会？那是否意味着人类的工作 ...
]

#[
  你好
]
