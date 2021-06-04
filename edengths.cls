%%
%% edengths.cls - LaTeX2e thesis class
%%
%% Copyright (C) 1998 George Taylor
%% Copyright (C) 2002 Mike Nolta <mrnolta@princeton.edu>
%% Copyright (C) 2010-2021 Mathew Topper <damm_horse@yahoo.co.uk>
%%
%%
%%   ABOUT
%%
%% This is the class file for a Latex2e template which corresponds to the
%% regulations regarding layout of a thesis submitted within the University
%% of Edinburgh.

%% BEGIN CLASS FILE
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{edengths}[2012/02/12 University of Edinburgh Engineering thesis %
                        class]

%% LOAD PACKAGES REQUIRED FOR CLASS

%% `ifthen' provides simple boolean commands
\RequirePackage{ifthen}

%% 'ifpdf' detects whether pdflatex is being used.
\RequirePackage{ifpdf}

%% Calc package is needed for titlepage length calculation
\RequirePackage{calc}

%% DECLARE VARIABLES AND COMMANDS FOR CLASS

%% Define a command to switch between report and rapport3 classes.
%% 'rapport3' class does brutalist spacing, but the bibspacing needs
%% manually controlled as it sets this to zero.
\newcommand{\classfile}{report}

%% Define an option warning to print when unwanted options are given
\newcommand{\OptionWarning}[1]{\ClassWarning{edengths}{Option '#1' not available for edengths.}}

%% Define a command to declare the unused options in the report class, giving
%% a warning in the output.
\newcommand{\OffOption}[1]{\DeclareOption{#1}{\OptionNotUsed\OptionWarning{#1}}}

%% Define a command to declare the available options in the report class.
\newcommand{\OnOption}[1]{%
               \DeclareOption{#1}{\PassOptionsToClass{#1}{\classfile}}}

%% Make some booleans for special package options
\newboolean{sansflag}                   % Default is for sans serif fonts for 
\setboolean{sansflag}{true}             % captions and headers

\newboolean{msfontsflag}                % Use MS fonts
\setboolean{msfontsflag}{false}

\newboolean{fancychapflag}              % Use fancy chapter headerings
\setboolean{fancychapflag}{false}

\newboolean{crestflag}                  % Put a crest on the frontpage
\setboolean{crestflag}{false}

\newboolean{labelflag}                  % Print labels on the page
\setboolean{labelflag}{false}

\newboolean{twosideflag}                % Is the twoside option set?
\setboolean{twosideflag}{false}

\newboolean{hyperflag}
\setboolean{hyperflag}{false}           % Use hyperref package?


%%%% DECLARE OPTIONS

%% LOCAL OPTIONS

%% Enable numbering of subsubsections (note: these don't appear in the contents)
\DeclareOption{subsubnos}{\addtocounter{secnumdepth}{1}}

%% Don't use the sans serif headers and captions
\DeclareOption{nosans}{\setboolean{sansflag}{false}}

%% Remove paragraph indent and add a line skip by switch class to rapport3
\DeclareOption{nopardent}{\renewcommand{\classfile}{rapport3}}

%% Use MS fonts rather than latex default
\DeclareOption{msfonts}{\setboolean{msfontsflag}{true}}

%% Use fancy chapter headings like jthesis-v1
\DeclareOption{fancychap}{\setboolean{fancychapflag}{true}}

%% Use a crest on the front page
\DeclareOption{crest}{\setboolean{crestflag}{true}}

%% Print equation labels next to equation numbers.
\DeclareOption{labels}{\setboolean{labelflag}{true}}

%% Use hyperref
\DeclareOption{hyper}{\setboolean{hyperflag}{true}}

%% Must have options.
\OnOption{a4paper}
\OnOption{openright}     % Start chapters on righthand side pages
\OnOption{titlepage}     % Title should be on it's own page.

%% Pass options to the report class which are still OK
\OnOption{10pt}
\OnOption{11pt}
\OnOption{12pt}
\OnOption{draft}
\OnOption{final}
\OnOption{fleqno}
\OnOption{leqno}
\OnOption{oneside}

%% Set a boolean in addition for the twoside option
\DeclareOption{twoside}{\setboolean{twosideflag}{true}%
                        \PassOptionsToClass{twoside}{\classfile}}

%% Switch off `report' options that won't be allowed.
\OffOption{letterpaper}
\OffOption{legalpaper}
\OffOption{executivepaper}
\OffOption{a5paper}
\OffOption{b5paper}
\OffOption{landscape}
\OffOption{twocolumn}
\OffOption{notitlepage}
\OffOption{openany}
\OffOption{openbib}

%% OTHER OPTIONS

%% Pass a warning for any options that are not known at this stage
\DeclareOption*{\OptionWarning{\CurrentOption}}

%% PROCESS OPTIONS
\ProcessOptions\relax

%% Load report class with default setup
\LoadClass[a4paper,openright,titlepage]{\classfile}

%% COLORS FIRST

%% xcolor should be loaded prior to the user inputted packages or stuff like
%% pstricks will not work apparently. xcolor gives better color match for
%% hyperlinks.
\ifthenelse{\boolean{pdf}}{%
    \newcommand{\colordriver}{pdftex}
    }{%
    \newcommand{\colordriver}{xdvi, dvipdfmx}
    }
\ifthenelse{\boolean{hyperflag}}{%
    \RequirePackage[\colordriver, dvipsnames, hyperref]{xcolor}%
   }{
    \RequirePackage[\colordriver, dvipsnames]{xcolor}%
   }

%%%% INPUT THE USER DEFINED PACKAGES (Loading here allows options to be passed
%%%%                                  to the auto loaded packages)

\InputIfFileExists{packages.tex}{\typeout{Succesful input of user packages.}}%
                                {\typeout{No user packages.tex file found.}}

%%%% LOAD MAIN PACKAGES

%% Putting some packages into the class.
%% There could be a number of options to ``turn off'' the styleised
%% parts and that the behavioural parts could be maintained in a separate file.

%% List the very must haves first...
\RequirePackage{graphicx}		        % Allows inclusion of graphics
						% in eps or jpg/pdf format

%% General formatting specified in format.tex
\RequirePackage[includehead]{geometry}          % A more modern way of setting 
                                                % the page margins.
                                                % Report options are passed
                                                % automatically.
\RequirePackage{setspace}                       % Define line spacing

%% Appendix
\RequirePackage{appendix}                       % Required for appendices

%% FONTS 
\RequirePackage{ae}                             % Virtual fonts for T1 encoded
                                                % CMR-fonts.
\RequirePackage[T1]{fontenc}                    % T1 encoding stops some errors
                                                % for unknown fonts

\ifthenelse{\boolean{msfontsflag}}{%            % Use MS fonts if the option is
  \RequirePackage{mathptmx}%                    % given
  \RequirePackage[scaled=.92]{helvet}%
  }{%
  }

%% Provide the font options to packages for the sans serif fonts
%% This loads caption and subcaption. Caption does caption formatting and
%% subcaption allows subfigures.
\ifthenelse{\boolean{sansflag}}{%
   \RequirePackage[labelfont={sf,bf}, textfont=sf]{caption, subcaption}%
  }{%
   \RequirePackage[labelfont=bf]{caption, subcaption}%
  }

%% TITLES AND CAPTIONS

%% Titlesec does headers and title formating. The definitions for the chapter
%% headers are set below
\RequirePackage[nobottomtitles*,pagestyles,clearempty]{titlesec}%

%% Allow modifications to the able of contents and lists
\RequirePackage[titles]{tocloft}%

%% HYPERLINKS

%% Load the hyperref package if the option is set. Set to the correct driver
%% dependant on the ifpdf package. Also load hypcap for better linking to 
%% figures.
\ifthenelse{\boolean{pdf}}{%
    \newcommand{\hyperdriver}{pdftex}
    }{%
    \newcommand{\hyperdriver}{dvipdfm}
    }
\ifthenelse{\boolean{hyperflag}}{%
    \AtEndOfClass{\RequirePackage[\hyperdriver]{hyperref}}%
    \PassOptionsToPackage{caption}{hypcap=true}%
   }{}

%% LABELS

%% Print labels on the page if option is given
\ifthenelse{\boolean{labelflag}}{%
   \AtEndOfClass{\RequirePackage[inner]{showlabels}}%
}{}


%%%% MORE PACKAGES CAN BE DEFINED IN packages.tex

%%%% FORMAT DEFINITIONS.

%% FONTS

%% Make a special command called defaultfont which sets sans or not. This is
%% the main control for changing the font style, only caption and subcaption are
%% set otherwise, above.
\newcommand{\defaultfont}{\ifthenelse{\boolean{sansflag}}{\sffamily}{}}

%% Update the default font
\ifthenelse{\boolean{sansflag}}%
{%
	\renewcommand{\familydefault}{\sfdefault}
}%
{}

%% Considering the optional fonts a lot of work has to be done to the table of
%% contents otherwise there is no action taken.
\ifthenelse{\boolean{sansflag}}%
  {%
    %% Make at symbol an internal command
    \makeatletter%
    %% Because of the font change, the page number becomes too large for the
    %% horizontal space LaTeX reserves for it by default. Without the following
    %% redefines to fix it, this would cause the Chapter entry page numbers
    %% to extend a few points into the right margin. The horror!
    \renewcommand{\@pnumwidth}{1.75em}%
    \renewcommand{\@tocrmarg}{2.75em}%
    %%
    %% Make at symbol safe again.
    \makeatother%
    %%
    %% Switch all list fonts to sans serif.
    \renewcommand{\cftpartfont}{\bfseries\sffamily}
    \renewcommand{\cftchapfont}{\bfseries\sffamily}%
    \renewcommand{\cftsecfont}{\sffamily}%
    \renewcommand{\cftsubsecfont}{\sffamily}%
    \renewcommand{\cftfigfont}{\sffamily}%
    \renewcommand{\cfttabfont}{\sffamily}%
    %%
    \renewcommand{\cftpartpagefont}{\bfseries\sffamily}%
    \renewcommand{\cftchappagefont}{\bfseries\sffamily}%
    \renewcommand{\cftsecpagefont}{\sffamily}%
    \renewcommand{\cftsubsecpagefont}{\sffamily}%
    \renewcommand{\cftfigpagefont}{\sffamily}%
    \renewcommand{\cfttabpagefont}{\sffamily}}%
  {%
    %% Otherwise, do nothing, I guess.
  }
  
%% PARTS

%% There is a particular issue with hyperef and the part definition which can be
%% fixed as follows:
\ifthenelse{\boolean{hyperflag}}{%
  \AtBeginDocument{%
    \pdfstringdefDisableCommands{%
      \let\MakeUppercase\relax%
    \typeout{Disabled uppercase in PDF strings}%
    } 
  }}{}

%% Standardise the part definitions
\titleformat{\part}[display]
   {\Huge\defaultfont\filcenter}
   {\MakeUppercase{\partname{} \thepart}}
   {0em}
   {}

%% The following code is recommended, but doesn't work. See:
%% http://tex.stackexchange.com/questions/6609/problems-with-part-labels-using-titlesec

% \makeatletter
% \let\titlesec@part\part
% \renewcommand{\part}{\@ifstar\part@star\part@nostar}
% \def\part@star#1{\NR@gettitle{#1}\titlesec@part*{#1}}
% \def\part@nostar{\@ifnextchar[\part@nostar@opt\part@nostar@nopt}
% \def\part@nostar@nopt#1{\NR@gettitle{#1}\titlesec@part{#1}}
% \def\part@nostar@opt[#1]#2{\NR@gettitle{#2}\titlesec@part[#1]{#2}}
% \makeatother

%% MAIN CHAPTER HEADINGS

%% These are produced using the titlesec package.

%% Check for fancychap flag and change chapter default if true
\ifthenelse{\boolean{fancychapflag}}{%
  \titleformat{\chapter}[display]%
    {\huge\normalfont\defaultfont\filleft\onehalfspacing%
    \titlerule[1pt]%
    \vspace{1pt}%
    \titlerule}%
    {%
    \vspace{1ex}%
    \chaptertitlename \space \thechapter}%
    {0.5ex}%
    {\bfseries\Huge}%
    [\vspace{1ex}%
    \titlerule]%
    %% Control the spacing of the numbered chapters.
    \titlespacing*{\chapter}{0pt}{0pt}{30pt}
    \titleformat{name=\chapter,numberless}[display]%
    {\huge\normalfont\defaultfont\filcenter}%
    %% Move the title to the top of the page
    {\vspace{-6ex}}%
    {0pt}%
    {\titlerule\huge}%
    [\vspace{\parskip}%
    \titlerule]
    %% Control the spacing of the un-numbered chapters.
    \titlespacing*{name=\chapter,numberless}{0pt}{0pt}{30pt}%
    }%
  {%% Fix chapter spacing to one and a half
    \titleformat{\chapter}[display]%
    {\huge\normalfont\defaultfont\bfseries\onehalfspacing}%
    {\chaptertitlename\ \thechapter}%
    {20pt}%
    {\Huge}%
  }

%% FRONT MATTER CHAPTER HEADINGS

%% Design some chapter headings for centred headings in the front matter like
%% the dmathesis style thesis. These are applied to the front matter using
%% a wrapper enviroment. Also kill the chapter numbers from \chapter, but still
%% add a TOC entry.

\newenvironment{precontent}
  {%% No chapter number, but still TOC entry.
   \setcounter{secnumdepth}{-1}%
   \renewcommand{\chaptermark}[1]{}%
   \pagestyle{plain}%
   \titlespacing*{\chapter}{0pt}{0pt}{30pt}%
   \ifthenelse{\boolean{fancychapflag}}{%
      %% 'numberless' definition above is sufficient.
    }{%
      %% Redifine the chapters to center.
      \titleformat{\chapter}[display]%
      {\normalfont\defaultfont\bfseries\filcenter}%
      {\chaptertitlename \thechapter}%
      {20pt}%
      {\Huge}%
   }}%
  {
   %% Restart numbering
   \setcounter{secnumdepth}{2}%
  }

%% SECTIONS

%% Protect the section definitions from the rapport3 class as
%% it does some weird alignment to them.
\titleformat{\section}
  {\normalfont\defaultfont\Large\bfseries}{\thesection}{1em}{}
\titleformat{\subsection}
  {\normalfont\defaultfont\large\bfseries}{\thesubsection}{1em}{}
\titleformat{\subsubsection}
  {\normalfont\defaultfont\normalsize\bfseries}{\thesubsubsection}{1em}{}


%%%% SINGLE SPACING QUOTE ENVIRONMENTS

\let\oldquote=\quote
\let\endoldquote=\endquote
\renewenvironment{quote}{%
    \begin{oldquote}%
    \begin{singlespace}%
  }{%
    \end{singlespace}%
    \end{oldquote}%
  }
\let\oldquotation=\quotation
\let\endoldquotation=\endquotation
\renewenvironment{quotation}{%
    \begin{oldquotation}%
    \begin{singlespace}%
  }{%
    \end{singlespace}%
    \end{oldquotation}%
  }


%%%% STRUCTURAL DEFINITIONS

%% TITLE PAGE

%% Define a command for the path the to crest. Default is to
%% stylefiles/EdUniCrest.pdf. Default will go to eps or to
%% pdf dependant on pdf option.
\ifthenelse{\boolean{pdf}}%
          {\newcommand{\crestdefault}{front/EdUniCrest.pdf}}%
          {\newcommand{\crestdefault}{front/EdUniCrest.eps}}

\newcommand{\crestfile}[1]{%
    \renewcommand{\crestdefault}{#1}}

%% If crestflag is true, check the path of the crest and set
%% crestflag to false if the path is wrong
\ifthenelse{\boolean{crestflag}}{%
  \IfFileExists{\crestdefault}
       {\typeout{Crest image file found.}}%
       {\setboolean{crestflag}{false}%
           \ClassWarning{edengths}{Crest image file not found.}}%
  }{% Do nothing if crestflag is false
  }

%% Add a command for defining the title of the qualification
\newcommand{\qualidefault}{\textit{Doctor of Philosophy}}%

\newcommand{\qualification}[1]{%
    \renewcommand{\qualidefault}{#1}}
    
%% Add a command for defining the name of the institution
\newcommand{\unidefault}{\textsc{The University of Edinburgh}}%

\newcommand{\university}[1]{%
    \renewcommand{\unidefault}{#1}}

%% Make a box and a height to record the height of the title
\newsavebox{\titlebox}
\newlength{\titleboxheight}

%% Allow internal use of @ symbol
\makeatletter

\renewcommand{\maketitle}{%
    %% Make the dummy title box to check the height
    \savebox{\titlebox}{%
      \parbox{0.9\linewidth}{%
        {\Huge\defaultfont\bfseries%
        \begin{onehalfspace}%
          \centering%
          \@title%
        \end{onehalfspace}%
        }%
      }%
    }%
    %% Get the height and if it's < 4cm set it to 4cm.
    \setlength{\titleboxheight}{\ht\titlebox + \dp\titlebox}%
    \ifthenelse{\lengthtest{ \titleboxheight < 4cm }}{
       \setlength{\titleboxheight}{4cm}}{}%
    \thispagestyle{empty}%
    \null\vfil%
    \begin{center}%
      {%\parskip=0pt
      %% Title in a parbox. Set its height to \titleboxheight
      \hrule%
      \vskip 1em%
      {\Huge\defaultfont\bfseries%
        \parbox[c][\titleboxheight][c]{0.9\linewidth}{%
          \begin{onehalfspace}%
            \centering%
            \@title%
          \end{onehalfspace}%
        }%
      }%
      \vskip 1em%
      \hrule%
      \vskip 1.5em%
      %% Author
      {\fontfamily{\rmdefault}\selectfont%
      {\LARGE\itshape%
      \parbox[c]{0.9\linewidth}{%
        \centering%
        \@author%
      }}}%
      %% University crest. Check crestflag.
      \ifthenelse{\boolean{crestflag}}{%
        \vskip 10mm%
        \centering%
          \includegraphics[width=2in]{\crestdefault}\par%
        \vskip 10mm%
      }{%
         \vskip 70mm%
      }%
      %% Qualification
      {\fontfamily{\rmdefault}\selectfont%
      {\LARGE%
      \parbox[c]{10cm}{%
        \begin{onehalfspace}%
          \centering%
          \qualidefault%
        \end{onehalfspace}%
      }\\%
      %% University
      [2mm] {\unidefault} \\%
      %% Date
      [10mm]\@date
      }}}%
    \end{center}\par%
    \vfil\null}

%% Make at safe again.
\makeatother

%% DEDICATION

\newcommand{\dedication}[1]{%%
   \thispagestyle{empty}
   \begin{center}%
    \vspace*{2cm}%
    {\fontfamily{\rmdefault}\selectfont%
    	\textit{\Large {#1}}%
	}%
  \end{center}%
}

%% ABSTRACT

\renewcommand{\abstract}[1]{%
  \chapter{\abstractname}%
  #1%
}

%% LAY SUMMARY

\newcommand{\summary}[1]{%
  \chapter{Lay Summary}%
  #1%
}

%% ACKNOWLEDGEMENTS

\newcommand{\acknowledgements}[1]{%
  \chapter{Acknowledgements}%
  #1%
}

%% DECLARATION

\newcommand{\declaration}[1]{%
  \chapter{Declaration}%
  #1
}

\newcommand{\standarddeclaration}[1]{%
  % Set up a box for the author name
  \newsavebox{\mybox}%
  \sbox{\mybox}{\bfseries{#1}}%
  %
  % Now measure its length
  \newlength{\myboxlen}%
  \settowidth{\myboxlen}{\usebox{\mybox}}%
  %
  \chapter{Declaration}%
  %
  I declare that this thesis was composed by myself, that the work contained herein is %
  my own except where explicitly stated otherwise in the text, and that this work has not %
  been submitted for any other degree or professional qualification except as specified.%
  %
  \vfill
  %
  % Add a line with the authors name underneath.
  % The line should not be less than 0.4/textwidth
  \noindent%
  \ifthenelse{\lengthtest{ \myboxlen < 0.4\textwidth }}{%
       \rule{0.4\textwidth}{.01in}\\}{%
       \rule{\myboxlen}{.01in}\\%
       }%
  %
  \usebox{\mybox}\\%
  %
  \vspace*{5cm}%
}


%% REDEFINE LOF AND LOT TO ADD LINE TO TOC

%% Maually add a line to the contents with phantomsection
%% to make better links if hyperref is used.
\let\oldlistoffigures\listoffigures
\renewcommand{\listoffigures}{
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\listfigurename}
    \oldlistoffigures
}

\let\oldlistoftables\listoftables
\renewcommand{\listoftables}{
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\listtablename}
    \oldlistoftables
}

%% ADD A FRONT MATTER CHAPTER COMMAND.
%% STARRED VERSION HAS NO TOC ENTRY.

%% Allow internal use of @ symbol
\makeatletter

\newcommand{\frontchapter}{\@ifstar
                     \frontchapterStar%
                     \frontchapterNoStar%
}

\newcommand{\frontchapterStar}[1]{%
    \cleardoublepage%
    \phantomsection%
    \chapter*{{#1}%
             \@mkboth{\MakeUppercase{#1}}%
                     {\MakeUppercase{#1}}%
             }%
    }

\newcommand{\frontchapterNoStar}[1]{%
    \cleardoublepage%
    \phantomsection%
    \addcontentsline{toc}{chapter}{#1}%
    \chapter*{{#1}%
             \@mkboth{\MakeUppercase{#1}}%
                     {\MakeUppercase{#1}}%
             }%
    }

%% Make at safe again.
\makeatother

%% DEFINITION OF A COMBINED FIGURE AND TABLE LIST

%% Make a name for it.
\newcommand{\listfiguretablename}{Figures and Tables}

%% Allow internal use of @ symbol
\makeatletter

\newcommand\listoffiguresandtables{%
    \if@twocolumn%
      \@restonecoltrue\onecolumn%
    \else%
      \@restonecolfalse%
    \fi%
    \frontchapter{\listfiguretablename}%
    \section*{Figures}%
     {\@starttoc{lof}}%
    \mrule%
    \section*{Tables}%
     {\@starttoc{lot}}%
    \if@restonecol\twocolumn\fi%%
    }

%% Make at safe again.
\makeatother

%% DEFINE BIBLIOGRAPHY HYPHENATION PENALTY
\let\bibhyphenpenalty\hyphenpenalty

%% DEFINE EDBIBLIOGRAPHY TO ADD LINE TO TOC AND SET
%% HYPHENPENTALTY

%% Maually add a line to the contents with phantomsection
%% to make better links if hyperref is used.
\newcommand{\edbibliography}{%
    \cleardoublepage%
    \phantomsection%
    \addcontentsline{toc}{chapter}{\bibname}%
    \message{Bibliography hyphenation penalty: \the\bibhyphenpenalty}%
    \hyphenpenalty=\bibhyphenpenalty%
    \bibliography
}

%% SHORTCUT WRAPPERS

%% Wrapper to produce the front matter in one go.
\newcommand{\makeprecontent}[1]{%
    %% Start the page numbering in roman
    \pagenumbering{roman}%
    \setcounter{page}{1}%
    %% Make the title page
    \maketitle%
    \cleardoublepage%
    \begin{precontent}%
       \input{#1}%
    \end{precontent}
    %% Make sure declaration has right page style
    %% and page numbering is sane.
    \cleardoublepage
    %% Use alternative style if twosideflag is true
    \ifthenelse{\boolean{twosideflag}}%
      {\pagestyle{twomain}}%
      {\pagestyle{main}}%
    }

%% Wrapper to call commands to start the main body text.
\newcommand{\startbody}{%
    \cleardoublepage%
    \pagenumbering{arabic}%
    \setcounter{page}{1}%
    %% Use alternative style if twosideflag is true
    \ifthenelse{\boolean{twosideflag}}%
      {\pagestyle{twomain}}%
      {\pagestyle{main}}%
    }

%% Appendix work is now done in a separate file
%% appendix/edengapp.tex

%%%% OTHER STUFF

%% Define new counter so you can have the equation
%% number 4.2.1a for example, this a gift from J.F.Blowey
%% Usage \eqlabon to start a,b numbering and \eqlaboff
%% to stop.

\newcounter{ind}
\newcommand{\eqlabon}{%
  \setcounter{ind}{\value{equation}}\addtocounter{ind}{1}%
  \setcounter{equation}{0}%
  \renewcommand{\theequation}{\arabic{chapter}%
          .\arabic{section}.\arabic{ind}\alph{equation}}}

\newcommand{\eqlaboff}{%
  \renewcommand{\theequation}{\arabic{chapter}%
          .\arabic{section}.\arabic{equation}}%
  \setcounter{equation}{\value{ind}}}

%% Thick horizontal line.
\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}

%% Short centred horizontal line.
\newcommand{\mrule}{%
   \begin{center}%
    \rule{0.5\linewidth}{0.2mm}%
   \end{center}}

%%%% INPUT THE USER DEFINED FORMATTING FILE

\AtEndOfClass{%
\InputIfFileExists{edengfmt.tex}{\typeout{Succesful input of formatting file.}}%
                                {\ClassError{edengths}{%
                                 Formatting file not found!%
                                }{%
                                 Oh dear! Something's gone wrong. \MessageBreak%
                                 Where is edengfmt.tex? I need it!}}%
}
