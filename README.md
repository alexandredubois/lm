# lm v0.3

> Copyright (C) 2012  Alexandre Dubois  (dev@alexandredubois.com)
> Copyright (C) 2012  Guillaume Garchery  (polluxxx@gmail.com)  
> Copyright (C) 2010  Jérôme Poisson  (goffi@goffi.org)

lm is a software to list movies, loosely inspired from ls. Extra features
allow you to download subtitles, and interact with the opensubtitles hash
database.


# LICENSE

> lm is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.


> lm is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

> You should have received a copy of the GNU General Public License
along with lm.  If not, see <http://www.gnu.org/licenses/>.

# MANUAL

> 0 WTF?  
1 INSTALLATION  
   1.1 Python packages  
   1.2 Note for Windows users about terminal coloration  
2 HOW TO USE IT  
    2.0 Basic things about script and PATH  
    2.1 How to make it return interesting command lines  
    2.2 Colors Meanings  
    2.3 Principal arguments  
    2.4 Focus on filtering files by genre, actor, size  
    2.5 Download subtitles  
3 MECHANISMS  
4 CREDITS  
5 CHANGES LOG  

## 0. WTF ?

lm lists movie files, getting information on IMDb, allowing you to:

- display sexy titles (instead of often unreadable filename) in terminal
- display custom info (outline, actor ...)
- sort by rating
- display a global view on an html page with cover and trailer links
- download subtitles for all your movies
- share your info, and upload the couple of info (`moviehash`, `imdb_id`) to
  opensubtitles database

**Remark**: lm description part is not english oriented. Matchs are done
through file hash, or non original titles.

### Examples:

`python lm.py YOUR_DIR_TO_SCAN -f @genre:action`
will list all your action movies

`python lm.py YOU_DIR_TO_SCAN -s -a`
will build an HTML page containig your movies sorted alphabetically and display it into your default web browser 

`python lm.py YOU_DIR_TO_SCAN --download ger`
will download the 3 best subtitles match, for every movie in you dir

`python lm.py YOU_DIR_TO_SCAN -a --html-build --export WWW_APACHE_DIR`
will build an HTML page with your movies sorted alphabetically and will copy it into your www apache directory


## 1. INSTALLATION

### 1.1 Python packages

You will need the following packages:

- IMDbPY: http://imdbpy.sourceforge.net/
    * accessible on Ubuntu software center easily (look for python-imdbpy)
    * installation may be more complicated for windows users
    * to run properly, lm only needs imdb package at its minimal form
    * Note: IMDbPY requires 'lxml' to speed up parsing. If not installed,
       be sure to have 'BeautifulSoup' package.
- argparse:
    * usually present in standard library, you may have to install
      python-argparse package (in Debian 6.0 stable, for example, as pointed
      by rvrignaud)

### 1.2 Note for Windows users about terminal coloration

lm is principaly designed to return result on a terminal, as 'ls' function.
to 'map' terminal coloration on the windows terminal, please install the
following package:

- colorama: http://pypi.python.org/pypi/colorama

## 2. How to use it ?

### 2.0 Basic things about scripts and PATH

lm.py is a simple python script.

How can I call it?

* At you convenience, add python and the folder containing lm.py in
  your path to be able to call it like that: `python lm.py`
* You can also make this script executable to call it this way `./lm.py`
* you can make an alias for your terminal: in that case, we recommend
  to start with this default lm call: `lm.py -r @size:500`
* Or the hard way, (for windows users for exemple):
  `c:/python/python.exe f:/myscriptfolder/lm.py`

### 2.1 How to make it return interesting things?

As always: `python lm.py --help` will give you syntax details DEFAULT CALL

`python lm.py` will analyse the current folder (recursively) :

* build the movie file hash
* look fot correspondances in opensubtitles database
* if nothing found, try to guess title from filename
* find best match (in all local languages titles)
* result in your terminal (with coloration)
* default behaviour is to scan current directory. Of course this command
  will work as expected: `python lm.py target_directory_to_screen`

**ADVICE**: Each time you launch lm, it gets metadata for files it
doesn't know, which is really slow. So, be sure to try on a directory with a few movies to test it.

### 2.2 Colors Meanings

When displayed in your terminal, titles can have different color:

**MAGENTA**: the best! It means your movie hash matches an opensubtitles
known movie. 95% sure to display the right title

**ORANGE**: Not bad. We did'nt find any match in opensubtitles, but
we looked through imdb movies, and are quite confident. 80% chance to
display the right title

**ORANGE with RED /|\ symbol**: We didn't find anything on opensubtitles
And we didnt find any good match in IMDb results neither. We stronly
recommend you to manually confirm this movie with the shell interactive
command: `lm.py YOUR_DIR -f @unsure --confirm`

### 2.3 Principal arguments

    -l : returns a more complete description, with YEAR, RATE, FILE SIZE
    -L : returns a VERY detailled view with synopsis. Ideal for ONE movie.
         `python lm.py -L movie_dir/movie_file.avi`
    -f : filter the query (see 2.4)
    --confirm: launch an interactive process to confirm/search movies
               You will be able to confirm found movie (if we are not
               sure), or provide an imdb id, or a title and a year, to
               find the correct match.
    --download: downloads subtitles for selected movies. Subtitles will
                be written in movies directories with suffixe
                `_LANGUAGE_LM1.srt`, `_LANGUAGE_LM2.srt`, ...
                (several subtitles can be downloaded for each movie,
                depending on their popularity)
    -d : delete selected paths from cache. When calling
         `python lm.py YOUR_DIR -d`, all movie files in `YOUR_DIR` will
         be deleted from cache. Note: A confirmation is asked before
         any deletion. To delete all cache call: `python lm.py cache -d`
    --debug: activate debug mode, in terminal but also in file 
             `~/.lm/lm_log.txt`

    HTML DISPLAY
    -S : will open you web browser and display results with rates, cover,
         links to trailers, and IMDb movie page.
    -s : will open all IMDb related pages (don't use with a lot a files)
    --html-build : will build an HTML catalog but without launching your web browser
    --export : allow to defin a target directory for the HTML output


### 2.4 Filters

You can filter your query using the `--filter` argument (or the short `-f`).

Currently, you can filter on: **genre**, **director**, **actor**, **size**
(bigger than xxMb), **unsure** (movies wich hash not found in opensubtitles,
and bad title match in imdb results)

The syntax is `--filter @keyword:filter,filter,filter@keyword2:filter,filter`

e.g.: `python lm.py -f "@director:tim burton@genre:drama,fantasy@size:500"`
`python lm.py -f @unsure@size:500`

Filters are case insensitive.

### 2.5 Download Subtitles

lm download subtitles for all movie files selected.

Before any downloading, you need to determine the language ISO639 code.
3 letters (see: [The list of ISO639 codes](http://en.wikipedia.org/wiki/List_of_ISO_639-2_codes))

`python lm.py YOUR_DIR --download eng`

* will recursively go through `YOUR_DIR`, and search for english subtitles
* will write subtitles in every movie file directory with syntax
  `moviefilename_ENG_LM1.srt`, `moviefilename_ENG_LM2.srt`

lm will download up to 3 most downloaded subtitles with preference to
subtitles that match movie hash.

## 3. MECHANISMS

### CACHE AND HTML DISPLAY

Basically, all metadata (text data, not pictures) are stored with pickle
in the hidden directory:
`~/.lm/cache_path`: storing absolute paths and hashs
`~/.lm/cache_hash`: storing hashs and metadatas

HTML file (build when -s parameter is used) is stored in:
`~/.lm/html_sumup.html`


### MOVIE SEARCH

Since v0.2:

1. Build hash for file
   (see: [Opensubtitles XMLRPC](http://trac.opensubtitles.org/projects/opensubtitles/wiki/XMLRPC))
2. Call opensubtitle through XMLRPC call. Do they know this hash?
3. If yes: -> perfect, we get an `imdb_id`, GO TO
4. Try to guess movie title/year with filename, clean filename, omit
   some stop words look for a potential year in the movie filename
5. Send guessed title to IMDB
6. if we guessed a year, reduce answers to guessed year movies
7. find best match on all results, for ALL AKAS (non original title)
8. if the best match isn't very good, and if we reduced answer at
   step 6, GOTO 7 with non filtered answers

**REMARK**: lm.py is not english oriented at all. exemple "sexcrimes.avi"
will match "wild things" original title.

## 4. CREDIT

Internet Movie Database (IMDb) is one of the oldest site on Internet, and,
as its name says, give a lot of informations on movies

**IMDbPY**: lm use IMDbPY to get information on IMDb:
[IMDbPY](http://imdbpy.sourceforge.net/), many thanks to its authors

Opensubtitles API through XMLRPC protocol (default python's module xmlrpclib)
website: [Opensubtitles XMLRPC](http://trac.opensubtitles.org/projects/opensubtitles/wiki/XMLRPC)
You can participate by uploading some.

### Contact:

> Creator: goffi@goffi.org (http://www.goffi.org)  
v0.2 : polluxxx@gmail.com (http://redrises.blogspot.com)
v0.3 : dev@alexandredubois.com (http://www.alexandredubois.com)

## 5. CHANGES LOG

What's new in version 0.3:
+ better movie hash calculation (faster and supported by more CPU architectures, as the Readynas SParc processor ;)
+ ability to export the HTML output to a specified directory with the `--export` option
+ the HTML output is now built from a readable template and use web controls powered by Twitter Bootstrap and Datatables.net
+ the HTML output is more detailed with movie description, country flag icons, file creation date... and more...
+ IMDB covers are locally cached !
+ Cron template file added, which allow for example to rebuild the movie index every night if you wish so ! 

What's new in version 0.2:
+ Add of logging module (--debug parameter). If activated, creates a log file
  `~/.lm/lm_log.txt`
+ interactive confirmation process (`--confirm` parameter)
+ Subtitles downloads (`--download language` parameter)
+ Use of opensubtitles hash database to find imdb id
+ Upload (`moviehash`, `imdb_id`) to opensubtitles (`--upload` parameter)
+ new home designed search algorithm, with YEAR, and through all akas (not
  original title) through all IMDbPY results
+ HTML display with cover, links to trailer and IMDb page
+ cache deletion via -d command (possibility to remove only some filtered
  file names, `lm.py -d -f @genre:action`)
+ filtering by size (+ and - like @size:+500), and by 'unsure'
+ recursive search in directory
+ windows terminal coloration
+ change optionparse to argparse
