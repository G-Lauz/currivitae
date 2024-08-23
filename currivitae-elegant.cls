\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{resume-template}{2024/07/30}{0.0.1}{Curriculum Vitea Template}

\LoadClass[a4paper, 11pt]{article}

\RequirePackage[T1]{fontenc}
\RequirePackage{fontawesome5}

\RequirePackage{tikz}

\RequirePackage{afterpage}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{tabularx}
\RequirePackage{graphicx}
\RequirePackage{enumitem}
\RequirePackage{multicol}

\RequirePackage{xcolor}
\RequirePackage{hyperref}

% Font packages
% \RequirePackage{helvet} % Helvetica
% \RequirePackage{mathptmx} % Times New Roman
\RequirePackage{palatino} % Palatino
% \RequirePackage{lmodern} % Computer Modern
% \RequirePackage{lato} % Lato

\DeclareOption{english}{
    \PassOptionsToPackage{main=english}{babel}
}
\DeclareOption{french}{
    \PassOptionsToPackage{main=french}{babel}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\RequirePackage[english, french]{babel}

%---------------------------------------------------------------
% Page layout
%---------------------------------------------------------------
\geometry{a4paper,
    hmargin={1.0cm,1.0cm},
    vmargin={2.5cm,2.5cm},
    foot=1.25cm,
    head=0.9cm,
    headsep=0.5cm,
    bindingoffset=0.5cm
}

% Manually adjust the header height according to the warning message
\setlength{\headheight}{36.01994pt}
\addtolength{\topmargin}{-10.41264pt}

% Set the line spacing
\setlength{\parindent}{0em}

%---------------------------------------------------------------
% Colors
%---------------------------------------------------------------
\definecolor{black}{HTML}{000000}
\definecolor{blue}{HTML}{0033cc}

%---------------------------------------------------------------
% Enumeration Configuration
%---------------------------------------------------------------
\newlist{compactitem}{itemize}{1}
\setlist[compactitem,1]{
  nosep, % No space between items
  left=5pt, % No left margin
  label=\faAngleRight, % Use bullet points
  labelsep=0.5em, % Adjust spacing between bullet and text
  itemsep=0pt, % No space between items
  parsep=0pt, % No space between paragraphs
  before={\vspace{-0.75em}},
  after={\vspace{-1.5em}},
}

\newlist{compactmulticolitem}{itemize}{1}
\setlist[compactmulticolitem,1]{
  nosep, % No space between items
  left=5pt, % No left margin
  label=\faAngleRight, % Use bullet points
  labelsep=0.5em, % Adjust spacing between bullet and text
  itemsep=0pt, % No space between items
  parsep=0pt, % No space between paragraphs
  before=\vspace*{-2em}\begin{multicols}{3},
  after=\end{multicols}\vspace{-2em},
}

%---------------------------------------------------------------
% Curriculum Vitae Attributes
%---------------------------------------------------------------
\newcommand{\name}[2]{\def\@firstname{#1} \def\@lastname{#2}}
\newcommand{\email}[1]{\def\@email{#1}}
\newcommand{\phone}[1]{\def\@phone{#1}}
\newcommand{\address}[1]{\def\@address{#1}}
\newcommand{\linkedin}[2]{\def\@linkedin{#1} \def\@linkedinUrl{#2}}
\newcommand{\github}[2]{\def\@github{#1} \def\@githubUrl{#2}}
\newcommand{\website}[2]{\def\@website{#1} \def\@websiteUrl{#2}}

%---------------------------------------------------------------
% Header and footer
%---------------------------------------------------------------
\pagestyle{fancy}

\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0.4pt}

\newcommand{\iconfield}[2]{
    \mbox{\makebox[5mm]{\textcolor{black}{\normalsize #1}}\hspace{0.2em}#2\vspace{0.2em}\newline}
}

\fancypagestyle{firstpage}{
    \fancyhead{} % clear all header fields
    \fancyhead[L]{
        \sffamily
        {\Huge\textbf{\@firstname \hspace{0.2em}\textcolor{blue}{\@lastname}}}\\

        \ifdefined\@address
            \iconfield{\faGithub}{\href{\@githubUrl}{\@github}} \hspace{0.2cm}
        \fi

        \ifdefined\@linkedin
            \iconfield{\faLinkedin}{\href{\@linkedinUrl}{\@linkedin}} \hspace{0.2cm}
        \fi

        \ifdefined\@website
            \iconfield{\faHome}{\href{\@websiteUrl}{Website}}
        \fi
    }
    \fancyhead[R]{
        \href{mailto:\@email}{\@email}\\ 
        \@phone
    }

    \fancyfoot{} % clear all footer fields
    % \fancyfoot[L]{\@date}
    \fancyfoot[R]{\sffamily\thepage}
}

\fancypagestyle{otherpages}{
    \fancyhead{} % clear all header fields
    \fancyfoot{} % clear all footer fields
    % \fancyfoot[L]{\@date}
    \fancyfoot[R]{\sffamily\thepage}
}

\def\afterfirstpage{
    \fancypagestyle{plain}{\pagestyle{otherpages}}
    
    \setlength{\headheight}{0pt}
    \addtolength{\topmargin}{10.41264pt}  % Adjust top margin for non-first pages
    
    \addtolength{\textheight}{36.01994pt}

    \setlength{\footskip}{-36.01994pt} % hack

    \pagestyle{otherpages}
}

\AtBeginDocument{
    \sffamily
    \thispagestyle{firstpage}
}

\AtEndDocument{
    \afterfirstpage
}

% Redefine the \clearpage and \newpage commands to switch styles after the first page
\let\oldclearpage\clearpage
\renewcommand{\clearpage}{\oldclearpage\afterfirstpage}
\let\oldnewpage\newpage
\renewcommand{\newpage}{\oldnewpage\afterfirstpage}

%---------------------------------------------------------------
% Sections
%---------------------------------------------------------------
\renewcommand{\section}[2][]{
    \bigskip
    \ifstrequal{#1}{}{}{{\color{blue}\large \makebox[5mm][c]{#1}\hspace{0.5em}}}
    {\color{blue}\Large\bfseries\MakeUppercase{#2}}\\[-1ex]
    {\rule{\linewidth}{1.0pt}\par}
    \smallskip
}

%---------------------------------------------------------------
% Commands
%---------------------------------------------------------------

% \tagline{A short tagline about yourself}
\newcommand{\tagline}[1]{
    \begin{minipage}[t]{\textwidth}
        \textit{#1}
    \end{minipage}
}

\newlength{\experiencelength}
\setlength{\experiencelength}{\textwidth}

% \experience{title}{organization}{location}{start}{end}{description}
\newcommand{\experience}[6]{
    \begin{minipage}[t]{\experiencelength}
        \begin{tabularx}{\experiencelength}{
            @{}>{\hfill}m{1.8cm} | >{\raggedright\arraybackslash}X@{}
        }
            \textit{#5}     & {\large\textbf{#1}} \\
            \textit{#4}     & {\textbf{\textit{#2}}, \hspace{0.5em}\textit{#3}}
            \ifstrequal{#6}{}{}{\\& #6\par}
        \end{tabularx}
        \normalsize
        \bigskip
    \end{minipage}
}

\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}

% \skill{skill type}{skill description}
\newcommand{\skill}[2]{
    \begin{minipage}[t]{\experiencelength}
        \begin{tabularx}{\experiencelength}{@{}R{2.5cm} X}
            \textbf{#1} & #2
        \end{tabularx}
        \par
        \smallskip
    \end{minipage}
}

% \achievement{title}{organization}{date}{description}{amount}
\newcommand{\achievement}[5]{
    \begin{minipage}[t]{\experiencelength}
        \begin{tabularx}{\experiencelength}{
            @{}>{\raggedright\arraybackslash}X
            >{\raggedleft\arraybackslash}p{0.15\textwidth}@{}
        }
            {\large\textbf{#1}} \newline {\textbf{\textsl{#2}}}
            & 
            \hfill{\textit{#3}} \newline \hfill{\textit{#5}}
        \end{tabularx}
        \par
        \smallskip
        {#4}
        \par\normalsize
        \smallskip
    \end{minipage}
}

% \publication{title}{journals}{ISBN}{date}
\newcommand{\publication}[4]{
    \begin{minipage}[t]{\experiencelength}
        {\large\textbf{#1}} \hfill \textit{#4}\\
        {\textbf{\textit{#2}}} \hspace{5pt} (\textit{#3})
        \par
        \smallskip
        \bigskip
    \end{minipage}
}

\newcommand{\level}[2]{%
    \textcolor{black}{#1}\hfill
    \foreach \x in {1,...,5}{%
      \space{\ifnumgreater{\x}{#2}{\color{gray}}{\color{blue}}\faCircle}}\par%
}
