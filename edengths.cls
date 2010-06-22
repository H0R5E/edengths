%%
%% edengths.cls - LaTeX2e thesis class
%%
%% Copyright (C) 1998 George Taylor
%% Copyright (C) 2002 Mike Nolta <mrnolta@princeton.edu>
%% Copyright (C) 2010 Mathew Topper <damm_horse@yahoo.co.uk>
%%
%% This file is part of the University of Edinburgh, Department of
%% Engineering LaTeX2e thesis template.
%% 
%% The University of Edinburgh, Department of Engineering LaTeX2e thesis
%% template is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%% 
%% The University of Edinburgh, Department of Engineering LaTeX2e thesis
%% template is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public License
%% along with the University of Edinburgh, Department of Engineering
%% LaTeX2e thesis template.  If not, see <http://www.gnu.org/licenses/>.
%%
%%
%%   ABOUT
%%
%% This is the class file for a Latex2e template which corresponds to the
%% regulations regarding layout of a thesis submitted within the University
%% of Edinburgh school of Engineering. It is not `official', but conforms
%% as best as possible to the regulation as detailed at:
%%
%%   http://www.scieng.ed.ac.uk/Postgraduate/PhD/settingoutyourthesis.htm
%%
%% Please feel free to alter the template to your own liking, but note that
%% the template is made available under the GNU GPL and must be similarly
%% licenced should you wish to release your modified template.
%%
%%
%%   CREDITS
%%
%% This template is an amalgamtion of an existing Edinburgh University,
%% Electrical Engineering PhD Thesis class file (jthesis-v1.cls) authored by
%% George S Taylor which was released under the GNU GPL.
%% Code is included from the dmathesis class Written by M. Imran
%% for a thesis according to the university of Durham regulation, which was
%% released without copyright. It also contains ideas (possibly code) from the
%% Princeton thesis class file (PrincetonThesis.cls), authored by Mike Nolta.
%% Mathew Topper, Eoghan Maguire and Bill Edwards forsaw the need to maintain a
%% more recent latex implementation of the thesis regulations and thus, this
%% project was born. It is hoped that the template will be maintained by the
%% Edinburgh Engineering PhD community once released.
%%
%%
%%   RECORD OF REVISIONS
%%
%%     Date      Programmer         Description of change
%%     ====      ==========         =====================
%%   14/06/10    Mathew Topper      Wrote preamble.
%%                                  Declared use of report class options.
%%   20/06/10                       Set an option to use fancy chapter
%%                                  headings like jthesis-v1 except using
%%                                  titlesec to design the headers
%%                                  Modified the titlepage and added an
%%                                  option to include a crest.
%%   21/06/10			    Had to fix interaction between reset
%%				    of parskip and the non-starred title.
%%   22/06/10                       Removed pdf option in favour of
%%                                  ifpdf package.
%%                                  Added 'ae' package to improve ouput
%%                                  quality.
%%                                  Fixed lenghts of TOC, LOF, LOT and
%%                                  section whitespace after the nopardent
%%                                  option is set. Had to counter the effect
%%                                  of the increased parskip.
%%
%%

%% BEGIN CLASS FILE
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{edengths}[2010/06/14 University of Edinburgh Engineering thesis class]

%% LOAD PACKAGES REQUIRED FOR CLASS

%% `ifthen' provides simple boolean commands
\RequirePackage{ifthen}

%% 'ifpdf' detects whether pdflatex is being used.
\RequirePackage{ifpdf}

%% DECLARE VARIABLES AND COMMANDS FOR CLASS

%% Define an option warning to print when unwanted options are given
\newcommand{\OptionWarning}[1]{\ClassWarning{edengths}{Option '#1' not available for edengths.}}

%% Define a command to declare the unused options in the report class, giving
%% a warning in the output.
\newcommand{\OffOption}[1]{\DeclareOption{#1}{\OptionNotUsed\OptionWarning{#1}}}

%% Define a command to declare the available options in the report class.
\newcommand{\OnOption}[1]{\DeclareOption{#1}{\PassOptionsToClass{#1}{report}}}

%% Make some booleans for special package options
\newboolean{sansflag}                  % Default is for sans serif fonts for 
\setboolean{sansflag}{true}            % captions and headers

\newboolean{pardentflag}               % Should the paragraphs be indented
\setboolean{pardentflag}{true}         % or not. Not add additional line.

\newboolean{msfontsflag}	       % Use MS fonts
\setboolean{msfontsflag}{false}

\newboolean{fancychapflag}	       % Use fancy chapter headerings
\setboolean{fancychapflag}{false}

\newboolean{crestflag}                 % Put a crest on the frontpage
\setboolean{crestflag}{false}

\newboolean{labelflag}                 % Print labels on the page
\setboolean{labelflag}{false}


%% DECLARE OPTIONS

%% Pass options to the report class which are still OK
\OnOption{10pt}
\OnOption{11pt}
\OnOption{12pt}
\OnOption{draft}
\OnOption{final}
\OnOption{fleqno}
\OnOption{leqno}
\OnOption{oneside}
\OnOption{twoside}

%% Must have options.
\OnOption{a4paper}	
\OnOption{openright}     % Start chapters on righthand side pages
\OnOption{titlepage}     % Title should be on it's own page.

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

%% LOCAL OPTIONS

%% Enable numbering of subsubsections (note: these don't appear in the contents)
\DeclareOption{subsubnos}{\addtocounter{secnumdepth}{1}}

%% Don't use the sans serif headers and captions
\DeclareOption{nosans}{\setboolean{sansflag}{false}}

%% Remove paragraph indent and add a line skip
\DeclareOption{nopardent}{\setboolean{pardentflag}{false}}

%% Use MS fonts rather than latex default
\DeclareOption{msfonts}{\setboolean{msfontsflag}{true}}

%% Use fancy chapter headings like jthesis-v1
\DeclareOption{fancychap}{\setboolean{fancychapflag}{true}}

%% Use a crest on the front page
\DeclareOption{crest}{\setboolean{crestflag}{true}}

%% Print equation labels next to equation numbers.
\DeclareOption{labels}{\setboolean{labelflag}{true}}

%% OTHER OPTIONS

%% Pass a warning for any options that are not known at this stage
\DeclareOption*{\OptionWarning{\CurrentOption}}

%% PROCESS OPTIONS
\ProcessOptions\relax

%% Load report class with default setup
\LoadClass[11pt,a4paper,openright,titlepage]{report}

%% LOAD MAIN PACKAGES

%% Putting some packages into the class.
%% There could be a number of options to ``turn off'' the styleised
%% parts and that the behavioural parts could be maintained in a separate file.

%% List the very must haves first...
\RequirePackage{graphicx}		        % Allows inclusion of graphics
						% in eps or jpg/pdf format

\RequirePackage{color}				% Let there be color!!!

%% General formatting specified in format.tex
\RequirePackage[includehead]{geometry}          % A more modern way of setting 
                                                % the page margins.
                                                % Report options are passed
                                                % automatically.
\RequirePackage{setspace}                       % Define line spacing

%% Appendix
\RequirePackage{appendix}                       % Required for appendices

%% Bibliography
\RequirePackage{natbib}                         % Natbib with default options
\RequirePackage{url}                            % Typeset URLs properly

%% FONTS
\RequirePackage{ae}                             % Virtual fonts for T1 encoded
                                                % CMR-fonts.
\RequirePackage[T1]{fontenc}                    % T1 encoding stops some errors
                                                % for unknown fonts

%% Provide the font options to packages for the sans serif fonts
%% This loads titlesec, caption and subfig. titlesec does headers
%% and title formating. caption does caption formatting and
%% subfig allows subfigures.
\ifthenelse{\boolean{sansflag}}{%
   \RequirePackage[nobottomtitles*,pagestyles,clearempty,bf,sf]{titlesec}%
   \RequirePackage[labelfont={sf,bf}, textfont=sf]{caption, subfig}%
  }{%
   \RequirePackage[nobottomtitles*,pagestyles,clearempty]{titlesec}%
   \RequirePackage[labelfont=bf]{caption, subfig}%
  }


\RequirePackage[titles,subfigure]{tocloft}    % Allow modifications to the
                                              % table of contents and lists
\RequirePackage[nottoc]{tocbibind}            % Allow stuff to be added to the
                                              % table of contents but dissable
                                              % it's own inclusion. 

%% Use MS fonts if the option is given
\ifthenelse{\boolean{msfontsflag}}{%
  \RequirePackage{times}%
  \RequirePackage[scaled=.92]{helvet}%
}{%
}

%% Print labels on the page if option is given
\ifthenelse{\boolean{labelflag}}{%
   \RequirePackage[inner]{showlabels}%
}{}

%%%% MORE PACKAGES CAN BE DEFINED IN packages.tex


%% DEFINITIONS.

% FONTS

%% Start by considering the optional fonts first. In the normal mode a lot
%% of work has to be done to the table of contents otherwise there is no
%% action taken, so...
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
    \renewcommand{\cftchapfont}{\bfseries\sffamily}%
    \renewcommand{\cftsecfont}{\sffamily}%
    \renewcommand{\cftsubsecfont}{\sffamily}%
    \renewcommand{\cftfigfont}{\sffamily}%
    \renewcommand{\cfttabfont}{\sffamily}%
    %%
    \renewcommand{\cftchappagefont}{\bfseries\sffamily}%
    \renewcommand{\cftsecpagefont}{\sffamily}%
    \renewcommand{\cftsubsecpagefont}{\sffamily}%
    \renewcommand{\cftfigpagefont}{\sffamily}%
    \renewcommand{\cfttabpagefont}{\sffamily}}%
  {%
    %% Otherwise, do nothing, I guess.
  }

%% Make a special command called defaultfont which sets sans or not.
\newcommand{\defaultfont}{\ifthenelse{\boolean{sansflag}}{\sffamily}{}}

%% PARAGRAPH INDENTATION

\ifthenelse{\boolean{pardentflag}}%
  {%
    %% Do nothing if flag is true.
  }{%
    %% No indentation for paragraphs, and set gap between paragraphs
    \setlength{\parindent}{0mm}%
    \setlength{\parskip}{2ex}%
    %% Because we've set \parskip to a >0 value we set \partopsep to 0
    %% so that it doesn't matter if you place a blank line before a list
    \setlength{\partopsep}{0mm}
    %% Repair problems in the TOC, LOF and LOT
    \addtolength{\cftbeforechapskip}{-2ex}%
    \addtolength{\cftbeforesecskip}{-2ex}%
    \addtolength{\cftbeforesubsecskip}{-2ex}%
    \addtolength{\cftbeforefigskip}{-2ex}%
    \addtolength{\cftbeforetabskip}{-2ex}}


%%%% FANCY CHAPTERS

%% These are produced using the titlesec package.
%% Note the use of this then else to switch the font style should
%% the nosans flag be set. It doesn't seem to follow the default for
%% some reason.

%% Check for fancychap flag and change chapter default if true
\ifthenelse{\boolean{fancychapflag}}{%
  \titleformat{\chapter}[display]%
    {\huge\normalfont\defaultfont\filleft%
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
    \titleformat{name=\chapter,numberless}[display]%
    {\huge\normalfont\defaultfont\filcenter%
    \titlerule}%
    {\vspace{-2ex}}%
    % Fix the titles when the parskip is increased.
    {-1.75\parskip}%
    {\huge}%
    [\vspace{1ex}%
    \titlerule]
    %% Control the spacing of the un-numbered chapters.
    \titlespacing*{name=\chapter,numberless}{0pt}{0pt}{30pt}%
    }%
  {%% Do nothing in this case
  }

% Protect the section spacing if parskip has increased
\ifthenelse{\boolean{pardentflag}}%
  {%
    %% Do nothing if flag is true.
  }{%
    \titlespacing*{\chapter}      {0pt}{0pt}%
                                          {20pt}%
    \titlespacing*{\section}      {0pt}{3.5ex plus 1ex minus .2ex}%
                                          {0.6ex plus .2ex}%
    \titlespacing*{\subsection}   {0pt}{3.25ex plus 1ex minus .2ex}%
                                          {0.1ex plus .1ex}%
    \titlespacing*{\subsubsection}{0pt}{3.25ex plus 1ex minus .2ex}%
                                          {0.1ex plus .1ex}}

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
   \setcounter{secnumdepth}{2}}



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

%% Define a command for the path the to list. Default is to
%% stylefiles/EdUniCrest.pdf. Default will go to eps or to
%% pdf dependant on pdf option.
\ifthenelse{\boolean{pdf}}%
          {\newcommand{\crestdefault}{front/EdUniCrest.pdf}}%
          {\newcommand{\crestdefault}{front/EdUniCrest.eps}}

\newcommand{\crestfile}[1]{%
    \renewcommand{\crestdefault{#1}}}

%% If crestflag is true, check the path of the crest and set
%% crestflag to false if the path is wrong
\ifthenelse{\boolean{crestflag}}{%
  \IfFileExists{\crestdefault}
       {\typeout{Crest image file found.}}%
       {\setboolean{crestflag}{false}%
           \ClassWarning{edengths}{Crest image file not found.}}%
  }{% Do nothing if crestflag is false
  }

%% Allow internal use of @ symbol
\makeatletter

\renewcommand{\maketitle}{%
    \pagestyle{empty}%
    %% Title, we use a parbox so the stuff afterwards and the hrules stay
    %% in the space place irrespective of the title length (max 4 lines)
    %% no paragraph indentation in title
    \vspace*{1cm}%
    \begin{center}%
      \HRule%
    \end{center}%
    \vspace{3mm}%
    \begin{center}%
      \parbox[c][4cm][c]{0.9\linewidth}{%
        \centering{\Huge\defaultfont\bfseries%
        \begin{onehalfspace}%
          \@title%
        \end{onehalfspace}}%
      }%
    \end{center}%
    \vspace{3mm}%
    \begin{center}%
      \HRule%
    \end{center}%
    %%
    %% Author
    \vspace{0.5cm}%
    \begin{center} {\Large \it \@author} \end{center}%
    %%
    %% University crest. Check crestflag.
    \ifthenelse{\boolean{crestflag}}{%
      \vspace{0.5cm}%
      \begin{center}%
        \includegraphics[width=2in]{\crestdefault}%
      \end{center}%
      }{% Do nothing if crestflag is false
      }%
    \vfill%
    %%
    %% Degree, University
    \begin{center}%
      {\Large A thesis submitted in fulfilment of the requirements \\%
	for the degree of \textit{Doctor of Philosophy} to \\%
	[4mm]{\textsc{The University of Edinburgh}} \\}%
      \vspace{1cm}%
    \end{center}%
    %%
    %% Date
    \begin{center}%
       {\Large \@date}%
    \end{center}
}

%% Make at safe again.
\makeatother

%% DEDICATION

\newcommand{\dedication}[1]{%%
   \thispagestyle{empty}
   \begin{center}%
    \vspace*{2cm}%
    \textit{\Large {#1}}%
  \end{center}%
}

%% ABSTRACT

\renewcommand{\abstract}[1]{%
  \chapter{\abstractname}%
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
  \cleardoublepage
}

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
    \addcontentsline{toc}{chapter}{\listfiguretablename}%
    \chapter*{\listfiguretablename%
              \@mkboth{\MakeUppercase\listfiguretablename}%
             {\MakeUppercase\listfiguretablename}%
              }%
    {\bfseries\defaultfont\Large Figures\par}%
     \vspace*{10pt}%
    {\parskip2.5\p@\@starttoc{lof}}%
     \mrule%
    {\bfseries\defaultfont\Large Tables\par}%
     \vspace*{10pt}%
    {\@starttoc{lot}}%
    \if@restonecol\twocolumn\fi%%
    }

%% Make at safe again.
\makeatother

%% SHORTCUT WRAPPERS

%% Wrapper to produce the front matter in one go.
\newcommand{\makefrontmatter}[1]{%
    \pagenumbering{roman}%
    \setcounter{page}{1}%
    \maketitle%
    \cleardoublepage
    \begin{precontent}%
       \input{#1}%
    \end{precontent}
    \pagestyle{main}}

%% Wrapper to call commands to start the main body text.
\newcommand{\startbody}{%
    \cleardoublepage
    \pagenumbering{arabic}%
    \setcounter{page}{1}}

%% Wrapper to call commands to start the appendicies.
\newcommand{\startappendix}{%
    \appendix%
    \noappendicestocpagenum%
    \addappheadtotoc%
    \renewcommand{\chaptername}{Appendix}%
    \renewcommand{\theequation}{\Alph{chapter}.\arabic{equation}}}

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

\InputIfFileExists{edengfmt.tex}{\typeout{Succesful input of formatting file.}}%
                                {\ClassError{edengths}{%
				 Formatting file not found!%
                                }{%
                                 Oh dear! Something's gone wrong. \MessageBreak%
				 Where is edengfmt.tex? I need it!}}

