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
    
    <xsl:param name="repoName"/>
    <xsl:param name="repoBase"/>
    <xsl:param name="bagitDumpNum"/>
    <xsl:param name="releaseTag"/>
    
    
    
    
    <xsl:variable name="dat"><xsl:value-of select="format-date(current-date(), '[Y]-[M]-[D]')"/>T<xsl:value-of select="format-time(current-time(), '[H]:[m]:[s]')"/></xsl:variable>
    <xsl:variable name="docMETADATA">
        <xsl:copy-of select="json-to-xml(unparsed-text('../METADATA.json'))"/>
    </xsl:variable>
   
    <xsl:variable name="labelling">
        <xsl:copy-of select="document('../gt-guidelines/de/labeling/OCR-D_GT_labeling_schema_xsd_Element_gt_gt.dita')"/>
    </xsl:variable>
    
   
    
    
    <xsl:variable name="READSME">
        <xsl:copy-of select="document('../README.xml')"/>
    </xsl:variable>
    
    
    <xsl:variable name="path">
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key/contains(.,'gtTyp')]/text() = 'data_document'">../data_document</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key/contains(.,'gtTyp')]/text() = 'data_structure'">../data</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key/contains(.,'gtTyp')]/text() = 'data_structure_and_text'">../data</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key/contains(.,'gtTyp')]/text() = 'data_line'">../data</xsl:if>
     </xsl:variable>
    
    
    
    <xsl:variable name="gtFormat" select="$docMETADATA//fn:map/fn:string[@key='format']"/>
    
    <xsl:variable name="coll"><xsl:value-of select="$path"/>/?select=*.xml;recurse=yes</xsl:variable>
    
    <xsl:variable name="conMets"><xsl:value-of select="$path"/>/?select=mets.xml;recurse=yes</xsl:variable>
    
    <xsl:variable name="conNets"><xsl:value-of select="$path"/>/?select=nets.xml;recurse=yes</xsl:variable>
    
    <xsl:variable name="conPage"><xsl:value-of select="$path"/>/?select=*GT-PAGE/*.xml;recurse=yes</xsl:variable>
    
    <xsl:variable name="conImg"><xsl:value-of select="$path"/>/?select=*.[jpgtiffpng]+;recurse=yes</xsl:variable>
    
    
    
    <xsl:param name="output"/>
    
    
    <xsl:variable name="key1">countTextRegion</xsl:variable>
    <xsl:variable name="key2">countImageRegion</xsl:variable>
    <xsl:variable name="key3">countLineDrawingRegion</xsl:variable>
    <xsl:variable name="key4">countGraphicRegion</xsl:variable>
    <xsl:variable name="key5">countTableRegion</xsl:variable>
    <xsl:variable name="key6">countChartRegion</xsl:variable>
    <xsl:variable name="key7">countSeparatorRegion</xsl:variable>
    <xsl:variable name="key8">countMathsRegion</xsl:variable>
    <xsl:variable name="key9">countChemRegion</xsl:variable>
    <xsl:variable name="key10">countMusicRegion</xsl:variable>
    <xsl:variable name="key11">countAdvertRegion</xsl:variable>
    <xsl:variable name="key12">countNoiseRegion</xsl:variable>
    <xsl:variable name="key13">countUnknownRegion</xsl:variable>
    <xsl:variable name="key14">countCustomRegion</xsl:variable>
    <xsl:variable name="key15">countTextLine</xsl:variable>
    <xsl:variable name="key16">countPage</xsl:variable>
    <xsl:variable name="key17">identifyText</xsl:variable>
    <xsl:variable name="key18">countMapRegion</xsl:variable>
    <xsl:variable name="key20">countWord</xsl:variable>
    <xsl:variable name="key21">identifyParagraph</xsl:variable>
    <xsl:variable name="key22">identifyFootnote</xsl:variable>
    <xsl:variable name="key23">identifyFootnote-continued</xsl:variable>
    <xsl:variable name="key24">identifyEndnote</xsl:variable>
    <xsl:variable name="key25">identifyHeader</xsl:variable>
    <xsl:variable name="key26">identifyDecorations</xsl:variable>
    <xsl:variable name="key27">identifyStamp</xsl:variable>
    <xsl:variable name="key28">identifyDrop-caps</xsl:variable>
    
    <xsl:variable name="tableHeader">
        <thead>                
            <tr>
                <th>document</th>
                <th>TxtRegion</th>
                <th>ImgRegion</th>
                <th>LineDrawRegion</th>
                <th>GraphRegion</th>
                <th>TabRegion</th>
                <th>ChartRegion</th>
                <th>SepRegion</th>
                <th>MathRegion</th>
                <th>ChemRegion</th>
                <th>MusicRegion</th>
                <th>AdRegion</th>
                <th>NoiseRegion</th>
                <th>UnknownRegion</th>
                <th>CustomRegion</th>
                <th>TextLine</th>
                <th>Page</th>
            </tr>
        </thead>
    </xsl:variable>
    
    
    
    
    <xsl:template match="/">
        <xsl:variable name="holeMetric">
                <xsl:element name="array">
                  <xsl:for-each select="collection($coll)">
                      <xsl:variable name="gtTypPath" select="replace($path, '../(.+)', '$1/')"/>
                      
                      <xsl:variable name="filename" select="base-uri()" />
                      <xsl:variable name="gtdocument">
                          <xsl:if test="$gtFormat = 'Page-XML'"><xsl:value-of select="substring-after(substring-before($filename, '/GT-PAGE/')[1],$gtTypPath)"/></xsl:if>
                          
                      </xsl:variable>
                      
                      
                        <xsl:if test="$gtdocument !=''">
                            
                     
                         <xsl:element name="array"><xsl:attribute name="key">volume_region</xsl:attribute>
                         <xsl:element name="map">
                             <xsl:attribute name="key1" select="substring-after(substring-before($filename, '/GT-PAGE/')[1], 'data/')"/>
                             <xsl:attribute name="key2" select="substring-after($filename, '/GT-PAGE/')"/>
                             <xsl:attribute name="file" select="$filename"/>
                             <image1><xsl:value-of select="document($filename)//*/*[local-name()='Metadata']/@*[local-name()='externalRef']"/></image1>
                             <image2><xsl:value-of select="document($filename)//*/*[local-name()='Page']/@*[local-name()='imageFilename']"/></image2>
                             <image3><xsl:value-of select="document($filename)//*/*[local-name()='Metadata']/*[local-name()='TranskribusMetadata']/@*[local-name()='imgUrl']"/></image3>
                             <page><xsl:value-of select="substring-after($filename, '/GT-PAGE/')"/></page>
                             <string key="{$key1}"><xsl:value-of select="count(document($filename)//*/*[local-name()='TextRegion'])"/></string>
                             <string key="{$key2}"><xsl:value-of select="count(document($filename)//*/*[local-name()='ImageRegion'])"/></string>
                             <string key="{$key3}"><xsl:value-of select="count(document($filename)//*/*[local-name()='LineDrawingRegion'])"/></string>
                             <string key="{$key4}"><xsl:value-of select="count(document($filename)//*/*[local-name()='GraphicRegion'])"/></string>
                             <string key="{$key5}"><xsl:value-of select="count(document($filename)//*/*[local-name()='TableRegion'])"/></string>
                             <string key="{$key6}"><xsl:value-of select="count(document($filename)//*/*[local-name()='ChartRegion'])"/></string>
                             <string key="{$key7}"><xsl:value-of select="count(document($filename)//*/*[local-name()='SeparatorRegion'])"/></string>
                             <string key="{$key8}"><xsl:value-of select="count(document($filename)//*/*[local-name()='MathsRegion'])"/></string>
                             <string key="{$key9}"><xsl:value-of select="count(document($filename)//*/*[local-name()='ChemRegion'])"/></string>
                             <string key="{$key10}"><xsl:value-of select="count(document($filename)//*/*[local-name()='MusicRegion'])"/></string>
                             <string key="{$key11}"><xsl:value-of select="count(document($filename)//*/*[local-name()='AdvertRegion'])"/></string>
                             <string key="{$key12}"><xsl:value-of select="count(document($filename)//*/*[local-name()='NoiseRegion'])"/></string>
                             <string key="{$key13}"><xsl:value-of select="count(document($filename)//*/*[local-name()='UnknownRegion'])"/></string>
                             <string key="{$key14}"><xsl:value-of select="count(document($filename)//*/*[local-name()='CustomRegion'])"/></string>
                             <string key="{$key15}"><xsl:value-of select="count(document($filename)//*/*[local-name()='TextLine'])"/></string>
                             <string key="{$key16}"><xsl:value-of select="count(document($filename)//*/*[local-name()='Page'])"/></string>
                             <string key="{$key17}"><xsl:value-of select="document($filename)//*/*[local-name()='Unicode']/text() != ''"/></string>
                             <string key="{$key18}"><xsl:value-of select="count(document($filename)//*/*[local-name()='MapRegion'])"/></string>
                             <string key="{$key20}"><xsl:value-of select="count(document($filename)//*/*[local-name()='Word'])"/></string>
                             <string key="{$key21}"><xsl:value-of select="document($filename)//*/*[local-name()='TextRegion']/@*[local-name()='type']='paragraph'"/></string>
                             <string key="{$key22}"><xsl:value-of select="document($filename)//*/*[local-name()='TextRegion']/@*[local-name()='type']='footnote'"/></string>
                             <string key="{$key23}"><xsl:value-of select="document($filename)//*/*[local-name()='TextRegion']/@*[local-name()='type']='footnote-continued'"/></string>
                             <string key="{$key24}"><xsl:value-of select="document($filename)//*/*[local-name()='TextRegion']/@*[local-name()='type']='endnote'"/></string>
                             <string key="{$key25}"><xsl:value-of select="document($filename)//*/*[local-name()='TextRegion']/@*[local-name()='type']='header'"/></string>
                             <string key="{$key26}"><xsl:value-of select="document($filename)//*/*[local-name()='GraphicRegion']/@*[local-name()='type']='decorations'"/></string>
                             <string key="{$key27}"><xsl:value-of select="document($filename)//*/*[local-name()='GraphicRegion']/@*[local-name()='type']='stamp'"/></string>
                             <string key="{$key28}"><xsl:value-of select="document($filename)//*/*[local-name()='TextRegion']/@*[local-name()='type']='drop-capital'"/></string>
                        </xsl:element>
                    </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                    </xsl:element>
              </xsl:variable>
        
        
        
            <xsl:variable name="k15">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key15])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k16">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key16])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k1">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key1])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k2">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key2])"/>
                </xsl:for-each>
            </xsl:variable>
            
        <xsl:variable name="k3">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key3])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k4">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key4])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k5">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key5])"/>
                </xsl:for-each>
            </xsl:variable>
            
            
            <xsl:variable name="k6">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key6])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k7">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key7])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k8">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key8])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k9">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key9])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k10">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key10])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k11">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key11])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k12">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key12])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k13">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key13])"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="k14">
                <xsl:for-each select="$holeMetric/array">
                    <xsl:value-of select="sum($holeMetric//string[@key=$key14])"/>
                </xsl:for-each>
            </xsl:variable>
            
            
        <xsl:variable name="tableHeader0">
            <thead>                
                <tr>
                    <th>document</th>
                    <xsl:if test="$k1 >0"><th>TxtRegion</th></xsl:if>
                    <xsl:if test="$k2 >0"><th>ImgRegion</th></xsl:if>
                    <xsl:if test="$k3 >0"><th>LineDrawRegion</th></xsl:if>
                    <xsl:if test="$k4 >0"><th>GraphRegion</th></xsl:if>
                    <xsl:if test="$k5 >0"><th>TabRegion</th></xsl:if>
                    <xsl:if test="$k6 >0"><th>ChartRegion</th></xsl:if>
                    <xsl:if test="$k7 >0"><th>SepRegion</th></xsl:if>
                    <xsl:if test="$k8 >0"><th>MathRegion</th></xsl:if>
                    <xsl:if test="$k9 >0"><th>ChemRegion</th></xsl:if>
                    <xsl:if test="$k10 >0"><th>MusicRegion</th></xsl:if>
                    <xsl:if test="$k11 >0"><th>AdRegion</th></xsl:if>
                    <xsl:if test="$k12 >0"><th>NoiseRegion</th></xsl:if>
                    <xsl:if test="$k13 >0"><th>UnknownRegion</th></xsl:if>
                    <xsl:if test="$k14 >0"><th>CustomRegion</th></xsl:if>
                    <xsl:if test="$k15 >0"><th>TextLine</th></xsl:if>
                    <xsl:if test="$k16 >0"><th>Page</th></xsl:if>
                        
                </tr>
            </thead>
        </xsl:variable>
    <!--<xsl:if test="$output = 'LAYOUT'">-->
       
    
                
       
       
            
       
       
           
                
           <xsl:if test="$docMETADATA//fn:map/fn:string[@key/contains(.,'gtTyp')]/text()='data_structure' or $docMETADATA//fn:map/fn:string[@key/contains(.,'gtTyp')]/text()='data_structure_and_text'">
                    
                        
                        
                        <!-- beginn columes -->
                        
                        <xsl:variable name="k15">
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key15])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k16">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key16])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k1">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key1])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k2">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key2])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k3">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key3])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k4">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key4])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k5">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key5])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        
                        <xsl:variable name="k6">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key6])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k7">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key7])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k8">
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key8])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k9">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key9])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k10">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key10])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k11">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key11])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k12">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key12])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k13">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key13])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k14">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key14])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <!-- end columes -->
                        
                        
                            <xsl:variable name="legend">
                                
                                <details>
                                    <summary class="infolegend">Legend</summary>
                                    <dl class="grid">
                                        <xsl:if test="$k15 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                        <dd>TextLine</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k16 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                        <dd>Page</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k1 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k2 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k3 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                        <dd>LineDrawingRegion</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k4 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k5 > 0">    
                                        <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k6 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                        <dd>ChartRegion</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k7 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k8 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k9 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k10 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                        </xsl:if>
                                            
                                        <xsl:if test="$k11 > 0">   
                                        <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                        </xsl:if>
                                            
                                        <xsl:if test="$k12 > 0">    
                                        <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k13 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lySonstiges.html" target="_blank">UnknownRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k14 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                        <dd>CustomRegion</dd>
                                        </xsl:if>
                                    </dl>
                                </details>
                            </xsl:variable>
                        
                            <xsl:variable name="smatrix">
                                
                                <xsl:element name="ul">
                                    <xsl:attribute name="class">grid-l</xsl:attribute>
                                   <xsl:if test="$k15 > 0">
                                     <xsl:element name="li">
                                         <xsl:attribute name="class">key15</xsl:attribute>
                                      <xsl:value-of select="$k15"/>
                                     </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k16 > 0">
                                     <xsl:element name="li">
                                         <xsl:attribute name="class">key16</xsl:attribute>
                                      <xsl:value-of select="$k16"/>
                                    </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k1 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key1</xsl:attribute>
                                            <xsl:value-of select="$k1"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k2 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key2</xsl:attribute>
                                            <xsl:value-of select="$k2"></xsl:value-of>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k3 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key3</xsl:attribute>
                                            <xsl:value-of select="$k3"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k4 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key4</xsl:attribute>
                                            <xsl:value-of select="$k4"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k5 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key5</xsl:attribute>
                                            <xsl:value-of select="$k5"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k6 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key6</xsl:attribute>
                                            <xsl:value-of select="$k6"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k7 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key7</xsl:attribute>
                                            <xsl:value-of select="$k7"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k8 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key8</xsl:attribute>
                                            <xsl:value-of select="$k8"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k9 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key9</xsl:attribute>
                                            <xsl:value-of select="$k9"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k10 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key10</xsl:attribute>
                                            <xsl:value-of select="$k10"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k11 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key11</xsl:attribute>
                                            <xsl:value-of select="$k11"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k12 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key12</xsl:attribute>
                                            <xsl:value-of select="$k12"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k13 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key13</xsl:attribute>
                                            <xsl:value-of select="$k13"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k14 > 0">
                                        <xsl:element name="li">
                                            <xsl:attribute name="class">key11</xsl:attribute>
                                            <xsl:value-of select="$k11"/>
                                        </xsl:element>
                                    </xsl:if>
                                </xsl:element>
                            </xsl:variable>
                            
                            
                                <xsl:variable name="tlevel">
                                <xsl:choose>
                                    <xsl:when test="($k1 >=0 or $k2 >=0 or $k4 >=0 or $k7 >=0) and ($k5 =0 and $k3 =0 and $k8 =0 and $k9 =0 and $k10 =0 and $k11 =0 and $k12 =0)">
                                        <td  class="leveldesc">
                                            <button type="button" class="bilanguage" onclick="changeLanguage()" data-en="Deutsch" data-de="English"><xsl:text> </xsl:text></button>
                                            <p class="bilanguage" data-de="Layout-Transkription entspricht dem Level 1." data-en="Layout transcription corresponds to level 1."/><span class="level">1</span>
                                            <ul><li><a href="https://ocr-d.de/en/gt-guidelines/trans/structur_gt.html"><span class="bilanguage" data-de="Allgemeines zum Structure Ground Truth" data-en="General explanation of the Structure Ground Truth"/></a></li>
                                                <li><a href="https://ocr-d.de/en/gt-guidelines/trans/ly_level_1_5.html"><span class="bilanguage" data-de="Wie wird im Level 1 das Layout transkribiert." data-en="How to transcribe the layout in Level 1."/></a></li></ul></td>
                                    </xsl:when>
                                    <xsl:when test="($k1 >=0 or $k2 >=0 or $k4 >=0 or $k7 >=0) and ($k5 >='0' and $k3>='0' and $k8>='0' and $k9>='0' and $k10>='0' and $k11>='0' and $k12>='0')">
                                        <td  class="leveldesc">
                                            <button type="button" class="bilanguage" onclick="changeLanguage()" data-en="Deutsch" data-de="English"><xsl:text> </xsl:text></button>
                                            <p class="bilanguage" data-de="Layout-Transkription entspricht dem Level 2." data-en="Layout Transcription corresponds to level 2."/><span class="level">2</span>
                                            <ul><li><a href="https://ocr-d.de/en/gt-guidelines/trans/structur_gt.html"><span class="bilanguage" data-de="Allgemeines zum Structure Ground Truth" data-en="General explanation of the Structure Ground Truth"/></a></li>
                                                <li><a href="https://ocr-d.de/en/gt-guidelines/trans/ly_level_2_5.html"><span class="bilanguage" data-de="Wie wird im Level 2 das Layout transkribiert." data-en="How to transcribe the layout in Level 2."/></a></li></ul></td>
                                    </xsl:when>
                                    
                                    <xsl:otherwise>
                                        <td  class="leveldesc">
                                        Fehler/Error
                                        </td>
                                    </xsl:otherwise>
                                </xsl:choose>
                                </xsl:variable>
               
               <xsl:element name="tr">
                   <xsl:element name="td">
                       <xsl:copy-of select="$smatrix"/>
                       <xsl:copy-of select="$legend"/>
                   </xsl:element>
                   <xsl:copy-of select="$tlevel"/>
               </xsl:element>
               
               
               
                    </xsl:if>
                    
                    
                    
                    
                    
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key/contains(.,'gtTyp')]/text()='data_line'">
                        
                        
                        <!-- beginn columes -->
                        
                        <xsl:variable name="k15">
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key15])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k16">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key16])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k1">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key1])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k2">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key2])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k3">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key3])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k4">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key4])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k5">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key5])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        
                        <xsl:variable name="k6">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key6])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k7">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key7])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k8">
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key8])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k9">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key9])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k10">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key10])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k11">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key11])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k12">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key12])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k13">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key13])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k14">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key14])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        
                        
                        
                        
                        
                        <!-- end columes -->
                        
                        <table class="noStyle">
                            <tr class="grid-l"><td class="infolegend">
                                <details>
                                    <summary class="infolegend">Legend</summary>
                                    <dl class="grid">
                                        <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                        <dd>TextLine</dd>
                                        <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                        <dd>Page</dd>
                                        
                                        <xsl:if test="$k1 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k2 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k3 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                        <dd>LineDrawingRegion</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k4 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k5 > 0">    
                                        <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k6 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                        <dd>ChartRegion</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k7 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k8 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k9 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k10 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                        </xsl:if>
                                            
                                        <xsl:if test="$k11 > 0">   
                                        <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                        </xsl:if>
                                            
                                        <xsl:if test="$k12 > 0">    
                                        <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k13 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                        <dd><a href="https://ocr-d.de/en/gt-guidelines/trans/lySonstiges.html" target="_blank">UnknownRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k14 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                        <dd>CustomRegion</dd>
                                        </xsl:if>   
                                    </dl>
                                </details>
                            </td>
                                
                                
                            </tr>
                        </table>
                        
                        
                        
                        
                        
                        <xsl:element name="table">
                            <xsl:attribute name="id">table_id</xsl:attribute>
                            
                            <xsl:element name="tbody">
                                
                                
                                <xsl:element name="tr">
                                    
                                    
                                    
                                     <xsl:element name="td">
                                      <xsl:value-of select="$k15"/>
                                     </xsl:element>    
                                    
                                    
                                     <xsl:element name="td">
                                      <xsl:value-of select="$k16"/>
                                    </xsl:element>    
                                    
                                    
                                    <xsl:if test="$k1 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k1"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k2 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k2"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k3 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k3"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k4 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k4"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k5 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k5"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k6 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k6"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    <xsl:if test="$k7 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k7"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k8 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k8"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k9 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k9"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k10 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k10"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    <xsl:if test="$k11 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k11"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k12 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k12"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k13 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k13"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    <xsl:if test="$k14 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k11"/>
                                        </xsl:element>    
                                    </xsl:if>
                                  </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:if>
                
                
                
                    
                    
                
                
             <!--</xsl:if>-->
    </xsl:template>
</xsl:stylesheet>