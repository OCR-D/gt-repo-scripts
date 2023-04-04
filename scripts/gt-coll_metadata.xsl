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
    
    
    <xsl:variable name="READSME">
        <xsl:copy-of select="document('../README.xml')"/>
    </xsl:variable>
    
    <xsl:variable name="labelling">
        <xsl:copy-of select="document('../gt-guidelines/de/labeling/OCR-D_GT_labeling_schema_xsd_Element_gt_gt.dita')"/>
    </xsl:variable>
    
    
    <xsl:template name="component">
            <xsl:for-each-group select="fn:current-group()" group-by="u2">
                
                <xsl:if test="tokenize(u2, '_')[last()] ='simple'">
                    <div><h3>simple</h3>
                          <xsl:for-each select="a">
                            <xsl:variable name="o" select="."/>
                            <details><summary><xsl:value-of select="."/></summary>
                                <p><xsl:value-of select="distinct-values($labelling//dlentry/dt[text() = $o]/following-sibling::dd)"/></p>
                            </details>
                          </xsl:for-each>
                    </div>
                </xsl:if>
                <xsl:if test="tokenize(u2, '_')[last()] ='complex'">
                    <div><h3>complex</h3>
                        <xsl:for-each select="a">
                            <xsl:variable name="o" select="."/>
                            <details><summary><xsl:value-of select="."/></summary>
                                <p><xsl:value-of select="distinct-values($labelling//dlentry/dt[text() = $o]/following-sibling::dd)"/></p>
                            </details>
                        </xsl:for-each>
                    </div>
                </xsl:if>
            </xsl:for-each-group>
            
    </xsl:template>
    
    
    <xsl:template match="/">
        <div>
        <xsl:if test="$READSME//div[@id='main']">
            <xsl:copy-of select="$READSME//div[@id='main']"/>
        </xsl:if>
        
        
        
        <xsl:variable name="tg">
        <analyse>
            <xsl:variable name="type">
                <xsl:for-each select="uri-collection('../?select=metadata.json;recurse=yes')">
                    <tp><xsl:value-of select="tokenize(.,'/')[(last() - 3)]"/>/<xsl:value-of select="tokenize(.,'/')[(last() - 2)]"/></tp>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:for-each select="fn:distinct-values($type//tp)">
                <form>
                    <u1><xsl:value-of select="tokenize(.,'/')[1]"/></u1>
                    <u2><xsl:value-of select="tokenize(.,'/')[last()]"/></u2>
                <xsl:variable name="input_path">../<xsl:value-of select="."/>/?select=metadata.json;recurse=yes</xsl:variable>
                <xsl:for-each 
                    select="uri-collection($input_path)">
                    <xsl:copy-of select="json-to-xml(unparsed-text(.))"/>
                </xsl:for-each>
                </form>
            </xsl:for-each>
        </analyse>
        </xsl:variable>
        
           
            
        
        <xsl:variable name="evaluation">
        <xsl:for-each select="$tg//form">
            <form>
                <xsl:copy-of select="u1"></xsl:copy-of>
                <xsl:copy-of select="u2"></xsl:copy-of>
        <xsl:for-each select="distinct-values(fn:map/fn:array[@key='labelling']/fn:string)">
               <xsl:sort 
                    select="." 
                    order="ascending"/>
                <a><xsl:value-of select="."/></a>
            </xsl:for-each>
            </form>
        </xsl:for-each>
        </xsl:variable>
        
        
        
            <div><h1>Analyzed collection</h1>
                <p>The GT data has been labeled. The labeling is based on an ontology defined by the Pattern Recognition 
                    and Image Analysis Research Lab (PRImA-Research-Lab) at the University of Salford. The labeling metadata 
                    is created for each available page. The following labeling metadata is available for the different collections.</p>
                <p>see: gt-labelling : semantic-labelling OCR ground truth data (https://github.com/OCR-D/gt-labelling)</p>
            <xsl:for-each-group select="$evaluation//form" group-adjacent="u1">
            <xsl:if test="u1[text()] = 'ant'">
                <div><h2>Antiqua</h2>
                <xsl:call-template name="component"/></div>
            </xsl:if>
            <xsl:if test="u1[text()] = 'frak'">
                <div><h2>Gothic/Blackletter</h2>
                <xsl:call-template name="component"/></div>
            </xsl:if>
            <xsl:if test="u1[text()] = 'fontmix'">
                <div><h2>FontMix (Antiqua and Blackletter)</h2>
                <xsl:call-template name="component"/></div>
            </xsl:if>
            </xsl:for-each-group>
        </div>
        </div>
    </xsl:template>
    </xsl:stylesheet>




