<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:pc="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns:pt="http://schema.primaresearch.org/PAGE/gts/pagecontent/2013-07-15"
    xmlns:in="http://www.intern.de"
    xmlns:gt="http://www.ocr-d.de/GT/"
    xmlns:mets="http://www.loc.gov/METS/"
    xmlns:mods="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output indent="yes" omit-xml-declaration="yes" method="xml"/>
    
    
    <xsl:variable name="path">file:/C:/Users/matth/</xsl:variable>
    
    <xsl:variable name="gttype">frak_simple/16_frak_simple</xsl:variable>
    
    
    <xsl:variable name="jmetadata"><xsl:value-of select="$path"/><xsl:value-of select="$gttype"/>/?select=metadata.json;recurse=yes</xsl:variable>
    
    <xsl:variable name="metadata" select="document(json-to-xml(unparsed-text($jmetadata)))"/>
    
    
    <xsl:template match="/">
        <test>
        <xsl:for-each
            select="collection('file:/C:/Users/matth/frak_simple/?select=*.txt;recurse=yes')">
            <xsl:variable name="vfilename" select="base-uri()" />
            <test t="{$vfilename}"/>
            
        </xsl:for-each>
        </test>
    </xsl:template>
    
    
    
    
    </xsl:stylesheet>




