---
layout: post
title: "Creating publication quality figures"
description: ""
category: Tips
redirect-from:
- /Tips/2014/01/22/creating-publication-quality-figures/
excerpt_separator: <!--more-->
tags: [Matlab, Latex, Tikz, Figure]
---
{% include JB/setup %}
<div id="content">
One of the most annoying parts of writing publishable research
material is making figures. Although it may seem rather simple to make
a figures from, say, a spreadsheet program, systematic generation of
high-quality figures is not that easy. I decided to write this post as
a guide to my fellow lab members, and thought it may be useful to
other researchers as well. The system described here is mainly based
on the excellent <a href="https://github.com/nschloe/matlab2tikz">matlab2tikz</a> package.

<div id="outline-container-sec-1" class="outline-2">
<h3 id="sec-1"><span class="section-number-2">1</span> How hard is it to make a nice figure out of Matlab?</h3>
<div class="outline-text-2" id="text-1">
<p>
I am going to argue that the answer is <b>very hard</b>. Now of course
anyone having used Matlab knows of the <i>plot</i> and <i>saveas</i> functions,
and is able to quickly produce a figure using something like this:
</p>
<div class="org-src-container">

<pre class="src src-matlab">x = [0:0.01:1];
y = x+0.1.*randn(1,length(x));
h=figure;
plot(x,y)
xlabel('X [m]')
ylabel('Y [s]')
saveas(h,'fig1.jpg')
</pre>
</div>
<p>
Which results in the following image.
</p>

<div class="figure">
<p><img src="{{ BASE_PATH }}/assets/images/tikz/fig1.jpg" alt="fig1.jpg" width="600px" />
</p>
</div>

<p>
This figure is certainly fine, but the fonts are too small, not to
mention ugly, and the line is too thin. This can of course be remedied
by using the export setup feature before saving the figure. Loading
the default presentation parameters, for instance, and saving as
before, gives us the following image.
</p>

<div class="figure">
<p><img src="{{ BASE_PATH }}/assets/images/tikz/fig2.jpg" alt="fig2.jpg" width="600px" />
</p>
</div>

<p>
This is better. The fonts look better, and the line is thick enough to
be easily seen. This figure could almost be put in a poster. But as
always, the devil is in the details. The first problem we notice is
the jpg compression. On a poster, this will be really noticeable. So
let's use a loss-less format, like png
</p>

<div class="figure">
<p><img src="{{ BASE_PATH }}/assets/images/tikz/fig3.png" alt="fig3.png" width="600px" />
</p>
</div>

<p>
Now this we could put in a poster&#x2026; maybe. We may still need to
change the font to something like Helvetica to be in accordance with
the rest of the text. But for the most part, this is probably fine. If
we want to be really picky, we can always remove all text from this
figure.
</p>
<div class="org-src-container">

<pre class="src src-matlab">set(gca,'YTickLabel',[])
set(gca,'XTickLabel',[])
</pre>
</div>
<p>
This way we can insert all the text (tick labels, axis labels, etc.)
directly in whatever program we use for making the poster. I made many
of my posters in this way, except that I used vector graphics.
</p>
</div>
</div>

<div id="outline-container-sec-2" class="outline-2">
<h3 id="sec-2"><span class="section-number-2">2</span> Vector graphics</h3>
<div class="outline-text-2" id="text-2">
<p>
So far, we used raster formats to save our figure. In raster formats
(bitmap, jpeg, png, gif, tiff etc.), the colour of each pixel in the
image is independently stored. A bitmap image, for instance, is simply
an array of colours, each for one pixel of the image. <a href="https://en.wikipedia.org/wiki/Vector_graphics">Vector graphics</a>,
on the other hand, store data about how the image was generated. For
example, a vector image file can simple contain a line telling the
viewer to draw a circle, instead of defining the value of all pixels
in the image.
</p>

<p>
The great advantage of vector formats over raster formats is the the
former can be arbitrarily resized without any loss in quality. If our
figure was smaller, resizing it to be larger would cause it to look
like this:
</p>

<div class="figure">
<p><img src="{{ BASE_PATH }}/assets/images/tikz/fig4.png" alt="fig4.png" width="600px" />
</p>
</div>

<p>
Those jagged line (steps) are due to the resizing of the image. We can
avoid them by storing our figure in a vectorial format, such as svg.
Matlab can not do this out of the box, but we can use an external
script for this. One such script can be found <a href="http://www.mathworks.com/matlabcentral/fileexchange/7401-scalable-vector-graphics-svg-export-of-figures">here</a>.
The same figure saved as an svg image looks like this:
</p>

<div class="figure">
<p><img src="{{ BASE_PATH }}/assets/images/tikz/fig5.svg" alt="fig5.svg" width="600px" />
</p>
</div>

<p>
So here we have it. Make matlab figures. Set the right options (remove
all text, change line width, etc.). Save them as vector graphics
(<i>eps</i> is fine, and included in matlab). Add text accordingly. If you
are using Windows, you can also copy and paste matlab figures directly
into powerpoint or word. This works for the most part pretty well and
you can also safely resize the resulting figure directly in
powerpoint. I don't use windows, so I usually used the eps format.
</p>

<p>
There are other problems associated with this approach. There is a lot
of manual work involved, which makes the process very error-prone. In
addition, adding the text externally is really only feasible for a
poster. If you are writing a document, either in a word processor or
using LaTeX, this becomes impractical. Another problem with this
approach is visible in the last figure. Resizing the figure also
resized the lines, points, and any text in the figure. In the last
figure, the line is way too thick. This means that the figures need to
be created at the right size inside Matlab, before being exported.
This means that figures can not be made once, and used for different
posters/papers/etc. 
</p>

<p>
These problems led me to use tikz for figures in my thesis. In the
rest of this post, I will explain the basics of using tikz to create a
figure and including tikz figures inside LaTeX documents.
</p>
</div>
</div>

<div id="outline-container-sec-3" class="outline-2">
<h3 id="sec-3"><span class="section-number-2">3</span> Making figures with tikz</h3>
<div class="outline-text-2" id="text-3">
<p>
Here is the basic code to generate and export our figure to tikz.
</p>
<div class="org-src-container">

<pre class="src src-matlab">set(0,'defaulttextinterpreter','none'); % Prevents Matlab from trying to
    % interpret latex string.
h=figure;
plot(x,y);
xlabel('X [m]');
ylabel('Y [s]');
cleanfigure;
matlab2tikz('fig6.tikz', 'showInfo', false, ...
        'parseStrings',false,'standalone', true, ...
        'height', '5cm', 'width','6cm');
</pre>
</div>
<p>
Running this chuck of code will give us a tikz file. A tikz file
basically contains instructions that can be understood by a latex
interpreter to produce an image. In this case, the tikz file uses
another package, <i>pgfplot</i>, which provides commands to easily draw
axes and coordinates. Our tikz file contains :
</p>
<div class="org-src-container">

<pre class="src src-latex"><span style="color: #93a1a1; font-style: italic;">% </span><span style="color: #93a1a1; font-style: italic;">This file was created by matlab2tikz v0.4.4 running on MATLAB 8.2.</span>
<span style="color: #93a1a1; font-style: italic;">% </span><span style="color: #93a1a1; font-style: italic;">Copyright (c) 2008--2013, Nico Schl&#246;mer <a href="mailto:nico.schloemer%40gmail.com">&lt;nico.schloemer@gmail.com&gt;</a></span>
<span style="color: #93a1a1; font-style: italic;">% </span><span style="color: #93a1a1; font-style: italic;">All rights reserved.</span>
<span style="color: #93a1a1; font-style: italic;">% </span>
<span style="color: #859900;">\documentclass</span>[<span style="color: #268bd2;">tikz</span>]{<span style="color: #268bd2;">standalone</span>}
<span style="color: #859900;">\usepackage</span>{<span style="color: #268bd2;">pgfplots</span>}
<span style="color: #696969;">\pgfplotsset</span>{compat=newest}
<span style="color: #696969;">\usetikzlibrary</span>{plotmarks}
<span style="color: #859900;">\usepackage</span>{<span style="color: #268bd2;">amsmath</span>}

<span style="color: #859900;">\begin</span>{<span style="color: #268bd2;">document</span>}
<span style="color: #859900;">\begin</span>{<span style="color: #268bd2;">tikzpicture</span>}

<span style="color: #859900;">\begin</span>{<span style="color: #268bd2;">axis</span>}[<span style="color: #93a1a1; font-style: italic;">%</span>
width=6cm,
height=5cm,
scale only axis,
xmin=0,
xmax=1,
xlabel={X [m]},
ymin=-0.4,
ymax=1.2,
ylabel={Y [s]}
]
<span style="color: #696969;">\addplot</span> [
color=blue,
solid,
forget plot
]
table[row sep=crcr]{
0 0.05376671395461<span style="color: #dc322f; font-weight: bold;">\\</span>
0.01 0.193388501459509<span style="color: #dc322f; font-weight: bold;">\\</span>
0.02 -0.205884686100365<span style="color: #dc322f; font-weight: bold;">\\</span>
0.03 0.116217332036812<span style="color: #dc322f; font-weight: bold;">\\</span>
0.04 0.0718765239858981<span style="color: #dc322f; font-weight: bold;">\\</span>
0.05 -0.0807688296305274<span style="color: #dc322f; font-weight: bold;">\\</span>
0.06 0.0166407977694316<span style="color: #dc322f; font-weight: bold;">\\</span>
0.07 0.104262446653865<span style="color: #dc322f; font-weight: bold;">\\</span>
0.08 0.437839693972576<span style="color: #dc322f; font-weight: bold;">\\</span>
0.09 0.366943702988488<span style="color: #dc322f; font-weight: bold;">\\</span>
...
0.99 0.810532115854488<span style="color: #dc322f; font-weight: bold;">\\</span>
1 1.08403755297539<span style="color: #dc322f; font-weight: bold;">\\</span>
};
<span style="color: #859900;">\end</span>{<span style="color: #268bd2;">axis</span>}
<span style="color: #859900;">\end</span>{<span style="color: #268bd2;">tikzpicture</span>}<span style="color: #93a1a1; font-style: italic;">%</span>
<span style="color: #859900;">\end</span>{<span style="color: #268bd2;">document</span>}
</pre>
</div>
<p>
This is actually human readable. You could, if you wanted to, dig in
and change anything about the figure. Since it is a plain-text file,
you could also automate these changes. Imagine that instead of putting
voltage on one of your axes, you wanted to use potential. You could do
that for all the figures in one folder by running a command like:
</p>
<div class="org-src-container">

<pre class="src src-bash">sed 's/voltage/potential/g' *.tikz
</pre>
</div>
<p>
We can also use all sorts of tools that work nicely with plain-text
files, such as version control systems. The tikz file can be converted
into a pdf file by running on the command line (not in matlab):
</p>
<div class="org-src-container">

<pre class="src src-bash">lualatex fig6.tikz
</pre>
</div>
<p>
This creates a pdf <a href="{{ BASE_PATH }}/assets/images/tikz/fig6.pdf">file</a>, that looks like this:
</p>

<div class="figure">
<p><img src="{{ BASE_PATH }}/assets/images/tikz/fig6.png" alt="fig6.png" width="600px" />
</p>
</div>

<p>
Crucially, changing the width and height on the tikz file, and
regenerating the pdf file results in a figure that looks as good. If
we divide the height by 2, we get the following <a href="{{ BASE_PATH }}/assets/images/tikz/fig7.pdf">figure</a>:
</p>

<div class="figure">
<p><img src="{{ BASE_PATH }}/assets/images/tikz/fig7.png" alt="fig7.png" width="600px" />
</p>
</div>

<p>
The width of the line, the shape and the placement of text labels are
all preserved perfectly, and of course, the pdf being a vectorial
format, there is no jaggedness or steps. 
</p>
</div>
</div>
<div id="outline-container-sec-4" class="outline-2">
<h3 id="sec-4"><span class="section-number-2">4</span> Inside a LaTeX document</h3>
<div class="outline-text-2" id="text-4">
<p>
The advantages of this workflow, even though the generated figures are
gorgeous, are not obvious so far. Instead of having a tikz file, we
could also have saved the matlab figure as <i>.fig</i> file and exported
from it as a <i>.tiff</i> file in the right size anytime we needed to. With
the tikz format, we have to modify the <i>.tikz</i> file and recompile it
every time we need a different sized figure. This can be done
programmatically thanks to the plain-text format, but is far from
being really practical.
</p>

<p>
Where this method really shows its potential is inside a LaTeX
document. Instead of compiling the figure into a pdf file to be
included in the pdf generated by LaTeX, you can import the tikz file
directly. First, we need to generate a non-standalone tikz file. This
can be done by running the matlab2tikz command with the standalone
option set to false:
</p>
<div class="org-src-container">

<pre class="src src-matlab">matlab2tikz('fig8.tikz', 'showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '\figureheight', 'width','\figurewidth');
</pre>
</div>
<p>
Notice that instead of specifying a width and a height, we give two
LaTeX comamnds: \figurewidth and \figureheight. These are not standard
latex commands. We will define them in our LaTeX document. The
generated tikz file contains:
</p>
<div class="org-src-container">

<pre class="src src-latex"><span style="color: #93a1a1; font-style: italic;">% </span><span style="color: #93a1a1; font-style: italic;">This file was created by matlab2tikz v0.4.4 running on MATLAB 8.2.</span>
<span style="color: #93a1a1; font-style: italic;">% </span><span style="color: #93a1a1; font-style: italic;">Copyright (c) 2008--2013, Nico Schl&#246;mer <a href="mailto:nico.schloemer%40gmail.com">&lt;nico.schloemer@gmail.com&gt;</a></span>
<span style="color: #93a1a1; font-style: italic;">% </span><span style="color: #93a1a1; font-style: italic;">All rights reserved.</span>
<span style="color: #93a1a1; font-style: italic;">% </span>
<span style="color: #859900;">\begin</span>{<span style="color: #268bd2;">tikzpicture</span>}

<span style="color: #859900;">\begin</span>{<span style="color: #268bd2;">axis</span>}[<span style="color: #93a1a1; font-style: italic;">%</span>
width=<span style="color: #696969;">\figurewidth</span>,
height=<span style="color: #696969;">\figureheight</span>,
scale only axis,
xmin=0,
xmax=1,
xlabel={X [m]},
ymin=-0.4,
ymax=1.2,
ylabel={Y [s]}
]
<span style="color: #696969;">\addplot</span> [
color=blue,
solid,
forget plot
]
table[row sep=crcr]{
0 0.05376671395461<span style="color: #dc322f; font-weight: bold;">\\</span>
0.01 0.193388501459509<span style="color: #dc322f; font-weight: bold;">\\</span>
0.02 -0.205884686100365<span style="color: #dc322f; font-weight: bold;">\\</span>
...
0.99 0.810532115854488<span style="color: #dc322f; font-weight: bold;">\\</span>
1 1.08403755297539<span style="color: #dc322f; font-weight: bold;">\\</span>
};
<span style="color: #859900;">\end</span>{<span style="color: #268bd2;">axis</span>}
<span style="color: #859900;">\end</span>{<span style="color: #268bd2;">tikzpicture</span>}<span style="color: #93a1a1; font-style: italic;">%</span>
</pre>
</div>
<p>
We cannot directly compile this file into a pdf document. Instead,
this file can be included inside a LaTeX document:
</p>
<div class="org-src-container">

<pre class="src src-latex"><span style="color: #859900;">\documentclass</span>[<span style="color: #268bd2;">a4paper</span>]{<span style="color: #268bd2;">article</span>}
<span style="color: #859900;">\usepackage</span>[<span style="color: #268bd2;">utf8</span>]{<span style="color: #268bd2;">inputenc</span>}
<span style="color: #859900;">\usepackage</span>[<span style="color: #268bd2;">english</span>]{<span style="color: #268bd2;">babel</span>}
<span style="color: #859900;">\usepackage</span>{<span style="color: #268bd2;">tikz, pgfplots</span>} <span style="color: #93a1a1; font-style: italic;">% Necessary package for tikz</span>
<span style="color: #859900;">\usepackage</span>[<span style="color: #268bd2;">font=normal,labelfont=bf</span>]{<span style="color: #268bd2;">caption</span>}
<span style="color: #696969;">\pgfplotsset</span>{ <span style="color: #93a1a1; font-style: italic;">% Here we specify options for all figures in the document</span>
  compat=1.8, <span style="color: #93a1a1; font-style: italic;">% Which version of pgfplots do we want to use?</span>
  legend style = {font=<span style="color: #b58900;">\small</span><span style="color: #696969;">\sffamily</span>}, <span style="color: #93a1a1; font-style: italic;">% Legends in a sans-serif font</span>
  label style = {font=<span style="color: #b58900;">\small</span><span style="color: #696969;">\sffamily</span>} <span style="color: #93a1a1; font-style: italic;">% Labels in a sans-serif font</span>
}
<span style="color: #859900;">\begin</span>{<span style="color: #268bd2;">document</span>}
<span style="color: #859900;">\newlength</span><span style="color: #268bd2;">\figureheight</span>
<span style="color: #859900;">\newlength</span><span style="color: #268bd2;">\figurewidth</span>

<span style="color: #859900;">\begin</span>{<span style="color: #268bd2;">figure</span>}[h]
  <span style="color: #859900;">\setlength</span><span style="color: #268bd2;">\figureheight</span>{<span style="color: #268bd2;">0.3</span><span style="color: #268bd2;">\textwidth</span>}
  <span style="color: #859900;">\setlength</span><span style="color: #268bd2;">\figurewidth</span>{<span style="color: #268bd2;">0.8</span><span style="color: #268bd2;">\textwidth</span>}
  <span style="color: #859900;">\input</span>{<span style="color: #2aa198;">fig8.tikz</span>}<span style="color: #93a1a1; font-style: italic;">%</span>
  <span style="color: #859900;">\caption</span>{<span style="color: #859900;">\label</span><span style="color: #b58900;">{</span><span style="color: #2aa198;">fig:1</span><span style="color: #b58900;">}Our figure</span>}
<span style="color: #859900;">\end</span>{<span style="color: #268bd2;">figure</span>}

<span style="color: #859900;">\begin</span>{<span style="color: #268bd2;">figure</span>}[h]
  <span style="color: #859900;">\setlength</span><span style="color: #268bd2;">\figureheight</span>{<span style="color: #268bd2;">0.6</span><span style="color: #268bd2;">\textwidth</span>}
  <span style="color: #859900;">\setlength</span><span style="color: #268bd2;">\figurewidth</span>{<span style="color: #268bd2;">0.8</span><span style="color: #268bd2;">\textwidth</span>}
  <span style="color: #859900;">\input</span>{<span style="color: #2aa198;">fig8.tikz</span>}<span style="color: #93a1a1; font-style: italic;">%</span>
  <span style="color: #859900;">\caption</span>{<span style="color: #859900;">\label</span><span style="color: #b58900;">{</span><span style="color: #2aa198;">fig:2</span><span style="color: #b58900;">}Our figure, with a different size</span>}
<span style="color: #859900;">\end</span>{<span style="color: #268bd2;">figure</span>}

<span style="color: #859900;">\end</span>{<span style="color: #268bd2;">document</span>}
</pre>
</div>

<p>
There are a few remarkable things about this document. First of all,
notice that we define parameter for the figure inside the LaTeX
document. For instance, we decide to use a sans-serif font for all the
figures in the document, as opposed to the one used in the standalone
case. We also define two latex variables, <i>\figrelength</i> and
<i>\figureheight</i>, using the <i>\newlength</i> command. We can change the
values of these variable before we include each figure (using
<i>\input</i>). This is how we can create figures with different heights
from the same original tikz file. Compiling this LaTeX document
creates this pdf <a href="{{ BASE_PATH }}/assets/images/tikz/fig8.pdf">file</a>:
</p>

<div class="figure">
<p><img src="{{ BASE_PATH }}/assets/images/tikz/fig8.png" alt="fig8.png" width="650px" />
</p>
</div>

<p>
Notice how not only do we have the same figure with two different
sizes although we used the same tikz file, but the two figures are
both perfectly typeset. Additionally, the lower figure has more ticks
on the Y-axis, since its height allows enough space for the additional
ticks.
</p>
</div>
</div>
</div>

