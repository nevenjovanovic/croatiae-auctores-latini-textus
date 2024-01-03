# Croatiae auctores Latini - scripts

## XSLT

Directory </xsl>.

* [croala-kay-wordcount.xsl](/scripts/xsl/croala-kay-wordcount.xsl) a test script for word counts, adapted from M. Kay's
* [html-add-class.xsl](/scripts/xsl/html-add-class.xsl) a script which additionally customizes standard TEI XML transformation to XHTML (as supplied with the [oXygen XML editor](https://www.oxygenxml.com/)).

## XQ

Directory </xq>.

Most important: two scripts to create the main database (`croalatextus`) and the additional word count (`croalatextus-wc`) database:

* [createCroALaDB.xq](/scripts/xq/createCroALaDB.xq)
* [createCroALaDB-wc.xq](/scripts/xq/createCroALaDB-wc.xq)

Other scripts are used in preparing the TEI XML and BaseX system functions.

## CroALaBRO

XQuery scripts for RESTXQ publishing system (web app), to be used with the BaseX web server. The scripts produce individual pages. To replicate, put them into the local `basex/webapp/apps/croalabro/` directory.

## CroALaBRO-XQM

XQuery modules for the same system. Put them into the local `basex/webapp/repo/` directory.
