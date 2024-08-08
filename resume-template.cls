\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{resume-template}{2024/07/30}{0.0.1}{Curriculum Vitea Template}

\LoadClass[a4paper, 12pt]{article}

\RequirePackage[T1]{fontenc}
\RequirePackage{fontawesome}

\RequirePackage{afterpage}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{tabularx}

\RequirePackage{xcolor}
\RequirePackage{hyperref}

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
    hmargin={1.5cm,1.5cm},
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

%---------------------------------------------------------------
% Curriculum Vitae Attributes
%---------------------------------------------------------------
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
        {\Huge\textbf{\textsc{\@author}}}\\

        \ifdefined\@address
            \iconfield{\faGithub}{\href{\@githubUrl}{Github}} \hspace{0.2cm}
        \fi

        \ifdefined\@linkedin
            \iconfield{\faLinkedin}{\href{\@linkedinUrl}{LinkedIn}} \hspace{0.2cm}
        \fi

        \ifdefined\@website
            \iconfield{\faHome}{\href{\@websiteUrl}{Website}}
        \fi
    }
    \fancyhead[R]{
        \@email\\ 
        \@phone
    }

    \fancyfoot{} % clear all footer fields
    \fancyfoot[L]{\@date}
    \fancyfoot[R]{\thepage}
}

\fancypagestyle{otherpages}{
    \fancyhead{} % clear all header fields
    \fancyfoot{} % clear all footer fields
    \fancyfoot[L]{\@date}
    \fancyfoot[R]{\thepage}
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
\renewcommand{\section}[1]{
    \bigskip
    {\large\textsc{#1}}\\ [-0.75\baselineskip]
    {\rule{\linewidth}{0.4pt}\par}
    \smallskip
}

%---------------------------------------------------------------
% Experience
%---------------------------------------------------------------
\newlength{\experiencelength}
\setlength{\experiencelength}{\textwidth}

\newcommand{\experience}[5]{
    \begin{minipage}[t]{\experiencelength}
        \begin{tabularx}{\experiencelength}{
            @{}>{\raggedright\arraybackslash}X
            >{\raggedleft\arraybackslash}p{0.25\textwidth}@{}
        }
            {\large\textbf{#1}} \newline {\textbf{\textit{#2}}}
            & 
            \hfill{\textit{#3}} \newline \hfill{\textit{#4}}
        \end{tabularx}
        \par
        \smallskip
        {#5}
        \par\normalsize
        \bigskip
    \end{minipage}
}

\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}

% \skill{skill type}{skill description}
\newcommand{\skill}[2]{
    \begin{minipage}[t]{\experiencelength}
        \begin{tabularx}{\experiencelength}{@{}R{2.85cm} X}
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
            {\large\textbf{#1}} \newline {\textbf{\textit{#2}}}
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