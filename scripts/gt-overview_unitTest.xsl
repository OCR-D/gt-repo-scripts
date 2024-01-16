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
    xmlns:ns3="http://www.loc.gov/METS/"
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output indent="yes" omit-xml-declaration="yes" method="xml"/>
    
    
    
    <xsl:variable name="docMETADATA">
        <xsl:copy-of select="json-to-xml(unparsed-text('../METADATA.json'))"/>
    </xsl:variable>
    
    
    <xsl:variable name="colly">../?select=*.xml;recurse=yes</xsl:variable>
    
    
    <xsl:variable name="data_path">
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_document'">../data_document</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_structure'">../data</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_structure_and_text'">../data</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_line'">../data</xsl:if>
     </xsl:variable>
    
    <xsl:variable name="gtTyp">
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_document'">data_document/</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_structure'">data_structure/</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_structure_and_text'">data_structure_and_text/</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_line'">data_line/</xsl:if>
    </xsl:variable>
    
    <xsl:variable name="gtFormat" select="$docMETADATA//fn:map/fn:string[@key='format']"/>
    
    <xsl:variable name="coll"><xsl:value-of select="$data_path"/>/?select=*.xml;recurse=yes</xsl:variable>
    
    <xsl:variable name="conMets"><xsl:value-of select="$data_path"/>/?select=mets.xml;recurse=yes</xsl:variable>
    
    <xsl:variable name="conNets"><xsl:value-of select="$data_path"/>/?select=nets.xml;recurse=yes</xsl:variable>
    
    <xsl:variable name="conPage"><xsl:value-of select="$data_path"/>/?select=*/GT-PAGE/*.xml;recurse=yes</xsl:variable>
    
    <xsl:variable name="conImg"><xsl:value-of select="$data_path"/>/?select=*.[jpgtiffpng]+;recurse=yes</xsl:variable>
    
        
    <xsl:param name="output"/>
    
    
    
    <xsl:template match="/">
        
        <xsl:if test="$output = 'unitTest1'">
            <xsl:variable name="CconPage">
                <xsl:for-each select="collection($colly)" >
                    <xsl:element name='pathfile'>
                        <xsl:value-of select="substring-after(base-uri(), 'file:/')"/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:variable>
            
    <xsl:message select="$CconPage"/>        
            
            <xsl:variable name="CconPage2">
                <xsl:for-each select="$CconPage//pathfile">
                    <xsl:if test="not(contains(.,'/data/')) or not(contains(.,'/scripts/'))"><xsl:copy-of select="."/></xsl:if>
                
                <!--<xsl:if test="tokenize(.,'/')[position() != [6]] ='data'"><xsl:copy-of select="."/></xsl:if>
                <xsl:if test="tokenize(.,'/')[position() != [6]] ='scripts'"><xsl:copy-of select="."/></xsl:if> 
                <xsl:if test="tokenize(.,'/')[position() != [8]] ='GT-PAGE'"><xsl:copy-of select="."/></xsl:if>-->
            </xsl:for-each>
            </xsl:variable>
            
            <xsl:if test="$CconPage2 !=''">
                <xsl:text>## Path Log</xsl:text><xsl:text disable-output-escaping="no">&#10;</xsl:text>
                <xsl:text>Please check the folder structure and the naming of your directories in your GT repository.</xsl:text><xsl:text disable-output-escaping="no">&#10;</xsl:text>
                <xsl:text>You are not using the "data" or the "GT-PAGE" directory.</xsl:text><xsl:text disable-output-escaping="no">&#10;</xsl:text>
                <xsl:copy-of select="$CconPage2"/>
            </xsl:if>
            
        </xsl:if>
       </xsl:template>
    </xsl:stylesheet>




