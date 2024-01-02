<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    exclude-result-prefixes="tei">
    <xsl:output method = "xml" indent="yes" omit-xml-declaration="no" /> 
<!-- Count words in text divs of XML documents -->    
    <xsl:template match="//tei:teiHeader//node()|text()"/>
        <xsl:template match="/">
            <texts>
                <xsl:for-each select=".//tei:text[not(descendant::tei:text)]">
                    <wordcount title="{ substring-after(base-uri(), 'croatiae-auctores-latini-textus/txts/') }" wc="{count(tokenize(.,'(\W|[0-9])+')[.!='']) + 1}">
            </wordcount>
                </xsl:for-each>
            </texts>
        </xsl:template>
    
</xsl:stylesheet>
