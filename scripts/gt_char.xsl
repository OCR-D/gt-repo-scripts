<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:pc="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns:pt="http://schema.primaresearch.org/PAGE/gts/pagecontent/2013-07-15"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Template für das Wurzelelement -->
    <xsl:template match="/">
        <characters>
        <xsl:variable name="char">
            <xsl:for-each select="//pc:TextEquiv/pc:Unicode/string-to-codepoints(.)">
                <character>
                    <xsl:value-of select="codepoints-to-string(.)"/>
                </character>
            </xsl:for-each>
          </xsl:variable>
            
            <xsl:for-each select="distinct-values($char//character)">
                <character>
                    <xsl:value-of select="."/>
                </character>
            </xsl:for-each>
            
        </characters>
    </xsl:template>
    
    
</xsl:stylesheet>