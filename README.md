# Croatiae auctores Latini - texts #

[![DOI](https://zenodo.org/badge/36577371.svg)](https://zenodo.org/badge/latestdoi/36577371)

TEI XML encoded Latin texts from the [Croatiae auctores Latini](https://croala.ffzg.unizg.hr) collection, freely available under a [CC-BY license](LICENSE.md).

The files edited here are published as a [PhiloLogic 4](https://artfl-project.uchicago.edu/philologic4) collection [CroALa](http://solr.ffzg.hr/philo4/croala0/). 

There is also a [BaseX](https://basex.org/) XML database (see an earlier analysis in [Quadrata rotundis](http://solr.ffzg.hr/dokuwiki/doku.php/z:crotyr-quadrata) paper). The BaseX XML db of CroALa is published through own simple text publishing and searching system on the CroALa site: [CroALa CDB](http://croala.ffzg.unizg.hr/cdb/index). For XQuery scripts, see the directories [croalabro](/scripts/croalabro) and [croalabro-xqm](/scripts/croalabro-xqm).

* Address of this Git repo: on [Github](https://github.com/nevenjovanovic/croatiae-auctores-latini-textus)

## Contents ##

* The TEI XML texts are in [txts](/txts) directory
* The word counts for files are in [croala-wordcounts.xml](croala-wordcounts.xml)
* The scripts for a text publishing and searching system: [croalabro](/scripts/croalabro) and [croalabro-xqm](/scripts/croalabro-xqm)
* The reading versions of documents are transformed from TEI XML source to XHTML in oXygen (with an additional XSL script: [html-add-class.xsl](scripts/xsl/html-add-class.xsl)) and served as static files in the local directory `basex/webapp/static/`
* The CSS framework used is [Chota](https://jenil.github.io/chota/)
* Additional scripts for the BaseX XML database: [xq](/scripts/xq)
* The ODD and RNG validation: [schemas](/schemas)
* The oXygen project file is [croalaproject.xpr](croalaproject.xpr)

## How to use ##

Download the files or clone the repository.

### Download the files ###

* From Git repository on Github: go to [Releases](https://github.com/nevenjovanovic/croatiae-auctores-latini-textus/releases) and select the most recent one

### With Git ###

* [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) (if you don't have it already)
* Go to the [croatiae-auctores-latini-textus](https://github.com/nevenjovanovic/croatiae-auctores-latini-textus) Github repository
* Replicate the data on your computer with [git clone](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository)

## Create the DB and the publishing system

TBA

### Current state of the collection ###
On 2024-02-04 the collection contains:

*  *553* TEI XML documents
*  *5,718,422* words in texts (metadata and encodings are not counted)

### Editor ###

* Neven Jovanović (nevenjovanovic), Department of Classical Philology, Faculty of Humanities and Social Sciences, University of Zagreb; [orcid.org/0000-0002-9119-399X](http://orcid.org/0000-0002-9119-399X)
