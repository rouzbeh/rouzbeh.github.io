---
layout: post
title: "Tips and tricks for creating figures in tikz"
description: ""
category: Tips
redirect_from:
- /Tips/2014/01/27/tips-and-tricks-for-creating-figures-in-tikz/
excerpt_separator: <!--more-->

tags: [Matlab, Latex, Tikz, Figure]
---
{% include JB/setup %}
This post is a continuation of
[creating publication quality figures]({{ BASE_PATH }}{% post_url 2014-01-22-creating-publication-quality-figures %}). As you might imagine, the process of creating figures using
<i>matlab2tikz</i> is not always as smooth as in the case of simple
figures. I have come across a few bugs, and here I will try to present
simple workarounds for most cases.

<!--more-->
<div id="outline-container-sec-1" class="outline-2">
<h3 id="sec-1"><span class="section-number-2">1</span> Bar graphs</h3>
<div class="outline-text-2" id="text-1">
<p>
Bar graphs generated using different commands are treated differently.
Exporting a simple bar graph created by:
</p>
<div class="org-src-container">

<pre class="src src-matlab">x=[1,2,3];
y=x;
bar(x,y);
matlab2tikz('bar.tikz', 'showInfo', false, ...
        'parseStrings',false,'standalone', true, ...
        'height', '5cm', 'width','6cm');
</pre>
</div>

<p> results in the following compiled pdf figure: </p> <img src="{{ BASE_PATH }}/assets/images/tikz2/bar.png" alt="bar.png" width="600px" />

<p>
But, if we use a command such as <i>hist</i>:
</p>
<div class="org-src-container">

<pre class="src src-matlab">x=randn(1000,1);
hist(x);
matlab2tikz('hist.tikz', 'showInfo', false, ...
        'parseStrings',false,'standalone', true, ...
        'height', '5cm', 'width','6cm');
</pre>
</div>

<p> The generated pdf figure will be somehow different from what we
expect: <img src="{{ BASE_PATH }}/assets/images/tikz2/hist.png"
alt="hist.png" width="600px" /> </p>

<p>
This is a documented <a href="https://github.com/nschloe/matlab2tikz/issues/294">bug</a> is matlab2tikz. In most cases, it can be
mediated by using the <i>bar</i> command instead of the <i>hist</i> for drawing
the figure:
</p>
<div class="org-src-container">

<pre class="src src-matlab">x=randn(1000,1);
[nelements,centers]=hist(x);
bar(centers, nelements);
matlab2tikz('hist_bar.tikz', 'showInfo', false, ...
        'parseStrings',false,'standalone', true, ...
        'height', '5cm', 'width','6cm');
</pre>
</div>

So that we get the expected figure: <img src="{{ BASE_PATH }}/assets/images/tikz2/hist_bar.png" alt="hist_bar.png" width="600px"
/> </div> </div>
<h3 id="sec-2"><span class="section-number-2">2</span> Figure
alignment</h3>

The width and height variables set when running matlab2tikz refer to
the width and height of each axis, and not the width and height of the
whole figure (including labels, tick labels, etc.). This can results
in figures being misaligned, as is the case of the last figure in the
[previous post]({{ BASE_PATH }}{% post_url 2014-01-22-creating-publication-quality-figures %}). This problem is
more severe in the case of figures with multiple subfigures.One way of
getting rid of this issue is by using a fixed width for tick labels on
the y-axis. This can be accomplished by adding the specifyign the
width inside the figure:

<div class="org-src-container">

<pre class="src src-latex"><span style="color: #859900;">\documentclass</span>[<span style="color: #268bd2;">a4paper</span>]{<span style="color: #268bd2;">article</span>} <span style="color: #859900;">\usepackage</span>[<span style="color: #268bd2;">utf8</span>]{<span style="color: #268bd2;">inputenc</span>}
<span style="color: #859900;">\usepackage</span>{<span style="color: #268bd2;">subfig,float</span>} <span style="color: #859900;">\usepackage</span>[<span style="color: #268bd2;">english</span>]{<span style="color: #268bd2;">babel</span>}
<span style="color: #859900;">\usepackage</span>{<span style="color: #268bd2;">tikz, pgfplots</span>}
<span style="color: #859900;">\usepackage</span>[<span style="color: #268bd2;">font=normal,labelfont=bf</span>]{<span style="color: #268bd2;">caption</span>}
<span style="color: #696969;">\pgfplotsset</span>{ <span style="color: #93a1a1; font-style: italic;">% Here we specify options for all figures in the document</span>
  compat=1.8, <span style="color: #93a1a1; font-style: italic;">% Which version of pgfplots do we want to use?</span>
  legend style =
  {font=<span style="color: #b58900;">\small</span><span style="color: #696969;">\sffamily</span>},
  label style = {font=<span style="color: #b58900;">\small</span><span style="color: #696969;">\sffamily</span>}
}
<span style="color: #859900;">\begin</span>{<span style="color: #268bd2;">document</span>}
<span style="color: #859900;">\newlength</span><span style="color: #268bd2;">\figureheight</span>
<span style="color: #859900;">\newlength</span><span style="color: #268bd2;">\figurewidth</span>

<span style="color: #859900;">\begin</span>{<span style="color: #268bd2;">figure</span>}[h]
<span style="color: #93a1a1; font-style: italic;">% y-axis tick label width</span>
<span style="color: #696969;">\pgfplotsset</span>{yticklabel style={text width=3em,align=right}} 
  <span style="color: #696969;">\subfloat</span>[][Our figure]{ <span style="color: #859900;">\setlength</span><span style="color: #268bd2;">\figureheight</span>{<span style="color: #268bd2;">0.3</span><span style="color: #268bd2;">\textwidth</span>}
    <span style="color: #859900;">\setlength</span><span style="color: #268bd2;">\figurewidth</span>{<span style="color: #268bd2;">0.8</span><span style="color: #268bd2;">\textwidth</span>} <span style="color: #859900;">\input</span>{<span style="color: #2aa198;">fig8.tikz</span>}
  }<span style="color: #dc322f; font-weight: bold;">\\</span>
  <span style="color: #696969;">\subfloat</span>[][Our figure, with a different size]{
    <span style="color: #859900;">\setlength</span><span style="color: #268bd2;">\figureheight</span>{<span style="color: #268bd2;">0.6</span><span style="color: #268bd2;">\textwidth</span>}
    <span style="color: #859900;">\setlength</span><span style="color: #268bd2;">\figurewidth</span>{<span style="color: #268bd2;">0.8</span><span style="color: #268bd2;">\textwidth</span>} <span style="color: #859900;">\input</span>{<span style="color: #2aa198;">fig8.tikz</span>} }
              <span style="color: #859900;">\end</span>{<span style="color: #268bd2;">figure</span>}
<span style="color: #859900;">\end</span>{<span style="color: #268bd2;">document</span>}
</pre>
</div>

<p>
Regenerating our latex document now results in perfectly aligned
figures:
<img src="{{ BASE_PATH }}/assets/images/tikz2/doc.png" alt="doc.png" width="600px" />
</p>

<div id="outline-container-sec-3" class="outline-2">
<h3 id="sec-3"><span class="section-number-2">3</span> Subfigures</h3>
<div class="outline-text-2" id="text-3">
<p>
There are two ways to generate subfigure using this method.
</p>
<ul class="org-ul">
<li>In Matlab
We can generate a figure with subfigures in Matlab and save it as one
figure. 
</li>
<li>In LaTeX
The other solution is to export each subfigure independently, and
put them together in Matlab. I personally prefer this method
because it gives me the highest amount of control over the
presentation of subfigure, and allows fancy tricks such as
referencing subfigures.
</li>
</ul>

<p>
An example of the second method is already shown in the previous
section. We can improve it by making sure that subfigure numbers are
written as required by most journals. I found the following command on
<a href="http://www.latex-community.org/know-how/latex/51-latex-math-science/280-formatting-latex-articles-for-biology-journals">this great page</a>.
</p>
<div class="org-src-container">

<pre class="src src-latex"><span style="color: #93a1a1; font-style: italic;">% </span><span style="color: #93a1a1; font-style: italic;">set package options</span>
<span style="color: #696969;">\captionsetup</span>[subfloat]{position=top,singlelinecheck=false,labelfont={normalsize,sf},
  labelformat=simple,listofformat=subparens,aboveskip=0pt,parskip=0pt,farskip=5pt,
  captionskip=0pt}

<span style="color: #93a1a1; font-style: italic;">% </span><span style="color: #93a1a1; font-style: italic;">customize subfigure label to capitals</span>
<span style="color: #859900;">\renewcommand</span>{<span style="color: #268bd2;">\thesubfigure</span>}{<span style="color: #268bd2;">\textbf</span><span style="color: #268bd2;">{</span><span style="color: #859900; font-weight: bold;">\Alph</span><span style="color: #268bd2; font-weight: bold;">{</span><span style="color: #268bd2; font-weight: bold;">subfigure</span><span style="color: #268bd2; font-weight: bold;">}</span><span style="color: #268bd2;">}</span>}
</pre>
</div>

<p>
Adding this command right before our figure in the LaTeX document
results in:
<img src="{{ BASE_PATH }}/assets/images/tikz2/doc2.png" alt="doc2.png" width="600px" />
</p>
</div>
</div>
<div id="outline-container-sec-4" class="outline-2">
<h3 id="sec-4"><span class="section-number-2">4</span> Cache generated figures</h3>
<div class="outline-text-2" id="text-4">
<p>
Generating figures from tikz files is a relatively expensive (read
<i>long</i>) operation. If you are working on one figure, it might be
annoying to have to wait for all the other figures in your document to
be generated as well. Fortunately, LaTeX can save generated figures as
independent pdf files, and include them automatically instead of
regenerating them from scratch. 
</p>

<p>
Create a folder next to your LaTeX document called autofigs, and add
this line to the header (before <i>\begin{document}</i>) of the latex
document
</p>
<div class="org-src-container">

<pre class="src src-latex"><span style="color: #696969;">\usetikzlibrary</span>{external} <span style="color: #696969;">\tikzset</span>{external/system call={lualatex
    <span style="color: #696969;">\tikzexternalcheckshellescape</span> -halt-on-error
    -interaction=batchmode -jobname "<span style="color: #696969;">\image</span>" "<span style="color: #696969;">\texsource</span>"}}
<span style="color: #696969;">\tikzexternalize</span>[prefix=autofigs/]
</pre>
</div>

<p>
And make sure to compile the resulting document using the
<i>&#x2013;shell-escape</i> option:
</p>
<div class="org-src-container">

<pre class="src src-bash">pdflatex --shell-escape doc.tex
</pre>
</div>

<p>
Once compiled, the autofigs folder will contain pdf files, one per
figure. Recompiling the document will not require regeneration of all
figures, and is therefore much faster.
</p>

<p>
There is one caveat though. Changes in tikz files are not
automatically detected. If you want a figure to be changed you will
need to delete the corresponding files in the autofigs folder.
</p>
</div>
</div>
