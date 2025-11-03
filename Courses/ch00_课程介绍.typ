#import "@preview/touying:0.6.1": *
#import "@preview/mitex:0.2.5": mi, mitex
#import "@preview/physica:0.9.4": *

// #import themes.simple: *
#import "../src/simple.typ": *

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

#show: simple-theme.with(aspect-ratio: "16-9", size: 15.5pt)

#title-slide[
  #let font = ("Times New Roman", "SimHei", "Microsoft YaHei")
  #set text(font: font)
  #set par(spacing: 1em, leading: 0.7em)
  #show math.equation: set text(size: 24pt, font: "SimHei")

  #align(center)[#text(size: 42pt, weight: "bold", font: font)[
    积木式蒸散发模型框架
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
  #set text(size: 21pt, font: ("Times New Roman", "FangSong"))

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


#blank-slide[
  // #image("Figures/BG-GW_02.png")
]

#import "@preview/mannot:0.3.0": *

= 2 模型研发

== 2 模型研发 // <!-- omit in toc -->

#H2-slide[
  // #box-red[这么多模块，从何处下手呢？]
  // 化整为零，各个击破。
  // #box-red[不同模型之间，模块不兼容。]

  #show table: set-table
  // #image("Figures/背景_山洪.png", width: 99%)
  #set text(size: 18pt, font: ("Times New Roman", "FangSong"))
  #show raw: set text(size: 18pt)
  #set par(spacing: 1em, leading: 0.6em)
  #let l = 1.4cm
  #let l2 = 1.79cm

  #v(-0.8em)
  #table(
    columns: (1.75cm, 5.6cm, 0.76fr, 0.7fr),
    rows: (1.2cm, l2, l, l2, l2, l2, l2, l),
    stroke: frame(rgb("21222C")),
    fill: (x, y) => if calc.odd(y) { luma(97%) } else { none },

    align: (horizon + center, horizon, horizon),
    [*状态*], [*模型名*], [#align(center)[*说明*]], [#align(center)[*参考文献*]],
    [#text(fill: green)[*100%*]],
    [`HydroTools.jl`],
    [基本的气象变量处理 \ Penman1948, PT1972, PM1965, FAO98],
    [https://github.com/jl-pkgs/HydroTools.jl],

    [#text(fill: green)[*100%*]], [`BEPS.jl`], [植被生理模块处于领先水平], [Chen JingMing et al., 1999],
    [#text(fill: green)[*100%*]],
    [`SPACKun.jl`],
    [水文过程齐全，下渗、土壤水运动、\ 地下水排泄],
    [Zhang Kun et al., 2022, 2024],

    [#text(fill: green.darken(50%))[*90%*]],
    [`RiverRouting.jl`],
    [汇流算法，马斯京根、线性水库，\ 运动波、扩散波],
    [https://github.com/jl-pkgs/RiverRouting.jl],

    [#text(fill: yellow.darken(10%))[*80%*]],
    [`SoiilDiffEqs.jl`],
    [土壤水运动、均衡水势、土壤水与\ 地下水交互],
    [https://github.com/jl-pkgs/SoiilDiffEqs.jl],

    [#text(fill: red)[*50%*]],
    [`ASAP.jl`],
    [地下水垂向与侧向运动],
    [Fan et al., 2013 _*Science*_; 2024 _*Nature*_; 2025 _*Nature*_],

    [#text(fill: yellow.darken(10%))[*80%*]], [`SPAC.jl`], [PML-V2基础上的模型耦合器], [Zhang\*, Kong\* et al., 2019],
  )
  // #v(-0.5em)
  // #image("Figures/背景/背景1.png", width: 99%)
  #v(-0.3em)
]

// #let

== 2.1 垂向过程—蒸散发

#let pg = markhl.with(color: green)

#H2-slide[
  #set text(size: 16.5pt)

  #grid(
    columns: (1fr, 0.7fr),
    gutter: 2pt,
    [
      *PML-V2碳水耦合蒸散发模型*（#link[Zhang\*, *Kong*\*, et al., _*RSE*_, 2019]）

      模型结构简单、模拟精度可靠。

      根据Beer定律，将净辐射$R n$划分为土壤和冠层。

      $ R n = underbrace(R n (1 - tau), "冠层吸收") + underbrace(R n thin tau, "土壤吸收") $

      #beamer-block[冠层植被蒸腾：Penman-Monteith 1965]

      $ E_c = (Delta R_n + rho c_p "VPD" \/ r_H) / (Delta + gamma ( 1 + pg(bold(r_s))/r_H)) $

      #beamer-block[土壤蒸发：均衡蒸发]

      $
        E_s = beta_w (Delta R_n ) / (Delta + gamma),
        beta_w = (sum_{t=i - N}^{t=i} "Pi") / (sum_{t=i - N}^{i} E_"eq")
      $

      #beamer-block[冠层截留：van Dijk 2001公式]

      #v(0.145em)

    ],
    [
      #par(leading: 0.8em, spacing: 0.4em)[
        共三个模块：*植被光合*（photo）、\ *气孔导度*（stomatal）、*蒸散发*（evap）
      ]

      // #image("Figures/Model_PMLV2.png", height: 75%)
    ],
  )
]

== 2.2 垂向过程—土壤水运动

#H2-slide[
  #set text(size: 15.5pt)
  #show "{": ""
  #show "}": ""

  #grid(
    columns: (1fr, 0.6fr),
    gutter: -25pt,
    [
      #box-red[基于*达西定律*和*Richards方程*，(Bonan et al., 2019)]

      $
        Q = -K pdv(z + psi, z), \
        (theta_k^{n+1} - theta_k^{n}) delta(z_k) / delta(t) = - Q_{k+1} + Q_k - S_k
      $

      其中，$K$为水力传导系数$"cm"\/h$。

      #beamer-block[*土壤上边界：下渗*]

      无降雨：已知通量，$I = 0$

      有降雨：已知状态，$theta_0 = theta_{"sat"}, z_0 = "PE"$ （#Blue[BEPS现行方案]）

      $ I = K_1 ( (theta_"sat" + "PE") - (theta_1 + z_1) ) / delta(z_{1/2}) $

      #beamer-block[*土壤下边界：地下水*]

      方案1：重力排水，$Q_N = -K_N$

    ],
    [
      #pad(left: -2em)[
        // #figure(
        //   image("Figures/土壤层.png", width: 92%),
        //   caption: [],
        // )
      ]
    ],
  )
]

#slide[
  #set text(size: 15.5pt)

  #grid(
    columns: (1fr, 0.9fr),
    gutter: 0pt,
    [
      *方案2：均衡水势*—*考虑GW与SM的交互*
      #v(0.6em)
      // 均衡水势$psi_E$，对应的土壤含水量为均衡含水量$theta_E$。
      当处于均衡状态时，每一层土壤的总势能均相等$==> bold(Q = 0)$（#Blue[CLM5现行方案]，Zeng et al., 2009）。

      #box-red[
        每一层的均衡水势，可通过如下公式计算得到：
      ]
      $ psi_E + z = psi_"sat" + z_"wt" = C $

      #v(0.4em)
      #beamer-block[*$psi_E$随地下水的水位$z_"wt"$变动而变动*]
      #v(0.3em)
      地下水对土壤水运动的调节，通过改变$psi_E$而体现。

      #v(0.1em)
      $
        Q & = -K pdv((psi + z), z) = -K pdv((psi + z - C), z) \
          & = -K pdv((psi - psi_E), z)
      $ <q_psi_e>
    ],
    [
      #v(2em)
      // #figure(
      //   image("Figures/均衡水势.png", width: 100%),
      //   caption: [地下水水位位于2m和4m时土壤层均衡水势\ 垂向分布],
      // ) <fig_>
    ],
  )
]

// #blank-slide[
//   不考虑GW与SM的交互下SM动态（初始状态表层干燥）
//   #v(-0.6em)
//   #figure(
//     image("Figures/Figure1_ET_zwt=2.5_(GW=false).svg", width: 100%),
//     caption: []
//   ) <fig_>
// ]

#blank-slide[

  考虑GW与SM的交互下SM动态（初始状态表层干燥）
  #v(-0.6em)

  // #figure(
  //   image("Figures/Figure1_ET_zwt=2.5_(GW=true).pdf", width: 100%),
  //   caption: [],
  // ) <fig_>
]

== 2.3 垂向过程—根系设定

#H2-slide()[
  // #v(0.1em)
  #quote[根系从SM和GW中抽水，影响壤中流和地下径流。]

  // #v(0.2em)
  // #figure(
  //   image("Figures/Veg_RWU_V2.png", width: 100%),
  //   caption: [
  //     基于逆根系模型反演的全球1km分辨率最大根系抽水深度
  //   ],
  // )
  （#link[Fan et al., 2017, _*PNAS*_]）
]

#slide[
  #quote[根系从SM和GW中抽水，影响壤中流和地下径流。]

  #v(0.4em)
  根系分布公式：$f_root = 1 - beta_z$，$beta$为根系分布参数，$f_root$为$[0, z]$根系比例。

  // 据Fan et al. (2013)最大根系抽水深度$"RWU"_max$，

  假定$"RWU"_max$对应的$f_root = 0.95$，根据$"RWU"_max$可推求根系分布参数：$beta = ln(1 - f_root) / "RWU"_max$

  // #figure(
  //   image("Figures/Veg_root.png", width: 80%),
  //   caption: [
  //     每层土壤根系分布比例(a)与根系累积分布比例(b)
  //   ],
  // ) <fig_>
]

== 2.4 侧向过程—地下水汇流

#H2-slide(composer: (1fr, 1fr))[
  #set par(leading: 0.7em, spacing: 0.6em)
  #grid(
    columns: (1fr, 1.1fr),
    gutter: -20pt,
    [
      #box-red[采用达西定律，考虑相邻8个网格的侧向汇流。]
      #v(0.2em)
      $ Q_i = w d K ((h_n - h) / l), T = K d, i in [1,8] $
      // $d$为导水层厚度，$T$为导水系数，$K$为传力传导系数，l为网格中心距离。

      #v(0.2em)
      $ delta(x) = delta(y) cos("lat") $

      南北向：$w = delta(x), l = delta(y), w/l = delta(x) / delta(y) = cos("lat")$

      东西向：$w = delta(y), l = delta(x), w/l = delta(y)/ delta(x) = 1/cos("lat")$
      // $delta(x)$随lat变化而变化，需要进行矫正。若横向与纵向网格大小相同，则$delta(x) = delta(y) cos("lat")$。

      ```julia
      # 南北向
      q = q + (kcell[i, j + 1] + kcell[i, j]) *    # north
          (head[i, j + 1] - head[i, j]) * cos(d2r * (xlat[i, j] + 0.5 * dxy))
      q = q + (kcell[i, j - 1] + kcell[i, j]) *    # south
          (head[i, j - 1] - head[i, j]) * cos(d2r * (xlat[i, j] - 0.5 * dxy))
      # 东西向
      q = q + (kcell[i - 1, j] + kcell[i, j]) *    # west
          (head[i - 1, j] - head[i, j]) / cos(d2r * xlat[i, j])
      q = q + (kcell[i + 1, j] + kcell[i, j]) *    # east
          (head[i + 1, j] - head[i, j]) / cos(d2r * xlat[i, j])
      qlat[i, j] = 0.5 * q * deltat / area[i, j]   # m3 to m
      ```
    ],
    [
      #v(1em)
      // #figure(
      //   image("Figures/地下水运动.png", width: 12.5cm),
      //   caption: [
      //     Fan et al., 2007, _*JGR-A*_
      //   ],
      // )
    ],
  )
]


== 2.5 垂向过程—地下水与河道交互

#H2-slide[

  #show "{": ""
  #show "}": ""

  #set text(size: 18pt)

  #text(fill: blue)[*Gain River*]（*地下水补给河道*）
  #v(-0.5em)

  $ Q_"rf" = overline(K)_"rb" (h - overline(z)_r) / overline(b)_"rb" A, A = overline(w)_r sum L_r $

  #v(-0.5em)
  #text(fill: red)[*Losing River*]（*河道补给地下水*）
  #v(-0.5em)
  $ h - overline(z)_r = overline(b)_{"rb"}, Q_"rf" = overline(K)_"rb"overline(w)_r sum L_r $

  // #figure(
  //   image("Figures/河道交互.png", width: 75%),
  //   caption: [MODFLOW6],
  // ) <fig_>
]


= 3 模型耦合

== 3.1 模型耦合

#H2-slide[

  #set text(size: 21pt)
  #grid(columns: (0.79fr, 1fr))[

    *模型耦合*，能否像$"pytorch"$一样，

    形成一个积木式的模型框架？
    #v(0.4em)

    ① #Blue[*耦合模块*]：相似模块统一接口，\ 不同*模块能够积木式灵活堆叠*。

    #v(0.4em)
    ② #Blue[*自动参数优化*]：

    - 能够自动收集模型参数、参数的默认值、值域等。

    - 同一代码实现不同模块的参数优化。

    - 指定参数名，实现局部参数优化。
  ][
    #box-blue[TCN时间卷积神经网络]
    #v(-0.4em)
    // #image("Figures/TCN.png", width: 100%)
  ]
]

=== 3.1.1 实现方法

#slide[
  #set text(size: 22pt)
  // *如何实现？*
  #Blue[模型基于Julia语言编写]：https://github.com/jl-pkgs/SPAC.jl

  #grid(columns: (1fr, 0.1fr))[
    #codly()
    // #raw(read("model_structure.jl"), lang: "julia")
  ][]
]

#blank-slide[
  // #image("Figures/PMLV2_params.png")
]

#blank-slide[
  // #image("Figures/PMLV2_result02.png")
]

=== 3.1.2 光周期影响

#slide[
  #v(-0.9em)
  // #image("Figures/光周期/PC_bg1.png", width: 92%)
]

#blank-slide[
  // #image("Figures/光周期/PC_bg2.png", width: 95%)
]

#blank-slide[
  // #image("Figures/光周期/PC_GPP.png", width: 95%)
]

#blank-slide[
  // #image("Figures/光周期/PC_ET.png", width: 95%)
]

// *光周期对植被光合具有显著的调节作用*。
// $ "PC" = ("day"_l / "day"_max)^2 $

= 4 小结

== 4.1 小结

#H2-slide[
  // #box-red[这么多模块，从何处下手呢？]
  // 化整为零，各个击破。
  // #box-red[不同模型之间，模块不兼容。]

  #show table: set-table
  // #image("Figures/背景_山洪.png", width: 99%)
  #set text(size: 18pt, font: ("Times New Roman", "FangSong"))
  #show raw: set text(size: 18pt)
  #set par(spacing: 1em, leading: 0.6em)
  #let l = 1.4cm
  #let l2 = 1.79cm

  #v(-0.8em)
  #table(
    columns: (1.75cm, 5.6cm, 0.9fr, 0.5fr),
    rows: (1.2cm, l2, l, l2, l2, l2, l2, l),
    stroke: frame(rgb("21222C")),
    fill: (x, y) => if calc.odd(y) { luma(97%) } else { none },

    align: (horizon + center, horizon, horizon),
    [*状态*], [*模型名*], [#align(center)[*说明*]], [#align(center)[*参考文献*]],
    [#text(fill: green)[*100%*]],
    [`HydroTools.jl`],
    [基本的气象变量处理 \ Penman1948, PT1972, PM1965, FAO98],
    [https://github.com/jl-pkgs/HydroTools.jl],

    [#text(fill: green)[*100%*]], [`BEPS.jl`], [植被生理模块处于领先水平], [Chen JingMing et al., 1999],
    [#text(fill: green)[*100%*]],
    [`SPACKun.jl`],
    [水文过程齐全，下渗、土壤水运动、\ 地下水排泄],
    [Zhang Kun et al., 2022, 2024],

    [#text(fill: green.darken(50%))[*90%*]],
    [`RiverRouting.jl`],
    [汇流算法，马斯京根、线性水库，\ 运动波、扩散波],
    [https://github.com/jl-pkgs/RiverRouting.jl],

    [#text(fill: yellow.darken(10%))[*80%*]],
    [`SoiilDiffEqs.jl`],
    [土壤水运动、均衡水势、土壤水与\ 地下水交互],
    [https://github.com/jl-pkgs/SoiilDiffEqs.jl],

    [#text(fill: red)[*50%*]],
    [`ASAP.jl`],
    [地下水垂向与侧向运动],
    [Fan et al., 2013 _*Science*_; 2024 _*Nature*_; 2025 _*Nature*_],

    [#text(fill: yellow.darken(10%))[*80%*]], [`SPAC.jl`], [PML-V2基础上的模型耦合器], [Zhang\*, Kong\* et al., 2019],
  )
  // #v(-0.5em)
  // #image("Figures/背景/背景1.png", width: 99%)
  #v(-0.3em)
]

== 4.2 小结

#H2-slide[
  #set text(size: 22pt)
  #set par(leading: 1.6em, spacing: 1.24em)
  1. Julia非常高效的语言，效率媲美C，简洁性如Python，非常适合编写模型；

  2. 构建的模型耦合器，*类似与pytorch不同的layers堆叠*，自带参数堆叠，自动参数优化功能，模型扩展便利（https://github.com/jl-pkgs/SPAC.jl）

  3. 模型结构简洁，*易于扩展新的模块*，600行代码左右完成了一个简单ET--SM--GW交互的方案。

  4. *地下水侧向运动，地下水与河道交互，基本完成*，但有待进一步测试。

  5. *光周期*对提升GPP精度效果显著。
]
