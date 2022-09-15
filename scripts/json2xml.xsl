<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:pc="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns:pt="http://schema.primaresearch.org/PAGE/gts/pagecontent/2013-07-15"
    xmlns:in="http://www.intern.de"
    
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output indent="yes" omit-xml-declaration="yes" method="xml"/>
    
    <xsl:param name="repoName"/>
    <xsl:param name="repoBase"/>
    
    
    
    <xsl:variable name="docMETADATA">
        <xsl:copy-of select="json-to-xml(unparsed-text('test.json'))"/>
    </xsl:variable>


<xsl:template match="/">
    <xsl:copy-of select="json-to-xml(unparsed-text('test.json'))"/>
</xsl:template>


</xsl:stylesheet>