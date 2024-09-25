% SPDX-FileCopyrightText: © 2024 Sebastian Davids <sdavids@gmx.de>
% SPDX-License-Identifier: Apache-2.0

\ProvidesClass{germanskillsprofile}[German Skills Profile class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % pass through any options to the base class
\ProcessOptions\relax % process given options

\LoadClass[a4paper]{article} % load the base class

\RequirePackage[bottom=2cm,left=2.5cm,right=1.5cm,top=2cm]{geometry} % DIN 5008
\RequirePackage[utf8]{inputenc} % allow UTF-8 source encoding
\RequirePackage[ngerman]{babel} % use German terminology
\RequirePackage[strict]{csquotes} % use appropriate German quotes
\RequirePackage[useregional=numeric,calc]{datetime2} % date formatting
\RequirePackage[document]{ragged2e} % required for non-justified text % required for non-justified text
\RequirePackage{xifthen} % required for conditional statements

\RequirePackage{titlesec} % customize title styles
\titleformat{\section}{\normalfont\Large\bfseries\sffamily}{\thesection}{1em}{}

\RequirePackage{fontspec} % font support
\setmainfont{Nunito}[
  Path=./fonts/,
  Extension=.ttf,
  UprightFont=*-Regular,
  BoldFont=*-Bold,
  ItalicFont=*-Italic,
  BoldItalicFont=*-BoldItalic,
]

\setsansfont{Lora}[
  Path=./fonts/,
  Extension=.ttf,
  UprightFont=*-Regular,
  BoldFont=*-Bold,
  ItalicFont=*-Italic,
  BoldItalicFont=*-BoldItalic,
]

\RequirePackage{enumitem} % customize list styles
\newlist{listnobullet}{enumerate}{2}
\setlist[listnobullet]{leftmargin=0em,itemsep=0em,label={}}
\newlist{listbullet}{enumerate}{2}
\setlist[listbullet]{leftmargin=1em,itemsep=0em,label=\rule[0.3ex]{0.6ex}{0.6ex}}

\pagestyle{empty} % suppress headers and footers

\newenvironment{sptable}[1]{%
  \begin{minipage}[t]{0.3\textwidth}#1\end{minipage}%
  \hfill%
  \begin{minipage}[t]{0.70\textwidth}%
  }{%
  \vspace{0.5em}%
  \end{minipage}%
}

\newcommand{\range}[2]{%
  #1\,\textendash\,#2%
}

\newcommand{\monthyear}{%
  \DTMsavenow{now}%
  \DTMmonthname{\DTMfetchmonth{now}}~\DTMfetchyear{now}%
}

\newcommand{\subtract}[2]{%
  \the\numexpr #1 - #2 \relax%
}

\newcommand{\yearcount}[1]{%
  \ifnum #1<\year%
    \ifnum \subtract{\year}{#1}=1%
      (1 Jahr)%
    \else%
      (\subtract{\year}{#1} Jahre)%
    \fi%
  \fi%
}

\newcommand{\sincewithyears}[1]{%
  seit #1 \yearcount{#1}%
}
