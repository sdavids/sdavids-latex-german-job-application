% !TeX program = xelatex
% !TeX encoding = UTF-8 Unicode

% SPDX-FileCopyrightText: © 2024 Sebastian Davids <sdavids@gmx.de>
% SPDX-License-Identifier: Apache-2.0

\ProvidesClass{germancv}[German CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % pass through any options to the base class
\ProcessOptions\relax % process given options

\LoadClass[a4paper]{article} % load the base class

\RequirePackage[bottom=2cm,left=2.5cm,right=1.5cm,top=2cm]{geometry} % DIN 5008
\RequirePackage{fontenc} % support for German special characters
\RequirePackage[utf8]{inputenc} % allow UTF-8 source encoding
\RequirePackage[english,ngerman]{babel} % German as main language
\RequirePackage[ngerman=ngerman-x-latest]{hyphsubst} % use newest hyphenation rules
\RequirePackage[strict,autostyle]{csquotes} % use appropriate German quotes
\defineshorthand{"`}{\openautoquote}
\defineshorthand{"'}{\closeautoquote}
\RequirePackage[useregional=numeric]{datetime2} % date formatting
\RequirePackage[document]{ragged2e} % required for non-justified text % required for non-justified text
\RequirePackage{xifthen} % required for conditional statements
\RequirePackage{hyperref} % hyperlinks
\hypersetup{
  colorlinks=true,
  urlcolor=black
}

\RequirePackage{titlesec} % customize title styles
\titleformat{\section}{\normalfont\Large\bfseries\sffamily}{\thesection}{1em}{}[\titlerule\vspace*{4pt}]

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
\newlist{listcvsection}{enumerate}{2}
\setlist[listcvsection]{leftmargin=0.1em,itemsep=1em,label={}}
\newlist{listcvitemlist}{enumerate}{2}
\setlist[listcvitemlist]{leftmargin=1.6em,itemsep=0pt,parsep=0.5em,labelsep=1em,label=\rule[0.3ex]{0.6ex}{0.6ex}}

\pagestyle{empty} % suppress headers and footers

\newcommand{\range}[2]{%
  #1\,\textendash\,#2%
}

\newenvironment{cvsection}[1]{%
  \section*{#1}%
  \begin{listcvsection}%
}{%
  \end{listcvsection}%
}

\newenvironment{cvitemplain}[1]{%
  \item%
  \begin{minipage}[t]{0.2\textwidth}#1\end{minipage}%
  \hfill%
  \begin{minipage}[t]{0.75\textwidth}%
}{%
  \end{minipage}%
}

\newenvironment{cvitembold}[1]{%
  \begin{cvitemplain}{#1}%
  \bfseries%
}{%
  \end{cvitemplain}%
}

\newenvironment{cvitem}[5]{%
  \begin{cvitemplain}{#1}%
    \textbf{#2}%
    \ifthenelse{\isempty{#3}}{\\}{, #3\\}%
    \ifthenelse{\isempty{#4}}{}{\textbf{#4}\\}%
    \ifthenelse{\isempty{#5}}{}{\vspace{1em}#5}%
    }{%
  \end{cvitemplain}%
}

\newenvironment{cvitemlist}[5]{%
  \begin{cvitemplain}{#1}%
    \textbf{#2}%
    \ifthenelse{\isempty{#3}}{\\}{, #3\\}%
    \ifthenelse{\isempty{#4}}{}{\textbf{#4}\\}%
    \ifthenelse{\isempty{#5}}{}{\vspace{1em}#5}%
    \begin{listcvitemlist}%
    }{%
    \end{listcvitemlist}%
  \end{cvitemplain}%
}
