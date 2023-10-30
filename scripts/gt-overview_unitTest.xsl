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
    
    <!--<xsl:param name="repoName"/>
    <xsl:param name="repoBase"/>
    <xsl:param name="bagitDumpNum"/>
    <xsl:param name="releaseTag"/>-->
    
    
    <xsl:variable name="docMETADATA">
        <xsl:copy-of select="json-to-xml(unparsed-text('../METADATA.json'))"/>
    </xsl:variable>
    
    
    
    
    
    
    <xsl:variable name="colly">../?select=*.xml;recurse=yes</xsl:variable>
    
    
    <xsl:variable name="data_path">
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_document'">../data_document</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_structure'">../data</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_structure_and_text'">../data</xsl:if>
        <!--<xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_structure_and_text'">data</xsl:if>-->
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
    
    
    
    
    
    
    <xsl:variable name="details">
        <xsl:element name="div">
            <xsl:element name="h2">Details</xsl:element>
            <xsl:element name="ul">
                <xsl:element name="li"><a href="metadata">Metadata</a></xsl:element>
                <xsl:element name="li"><a href="table">Compressed table view</a></xsl:element>
                <xsl:element name="li"><a href="overview">Detailed table view</a></xsl:element>
        </xsl:element>
        </xsl:element>
    </xsl:variable>
    
    
    <xsl:template match="/">
        
        <xsl:if test="$output = 'unitTest1'">
            <xsl:variable name="CconPage">
                <xsl:for-each select="collection($colly)" >
                    <xsl:element name='pf'>
                        <xsl:value-of select="base-uri()"/>
                    </xsl:element>
                </xsl:for-each>
                
            </xsl:variable>
            
            
            
            <xsl:variable name="CconPage2">
            <xsl:for-each select="$CconPage//pf">
                <xsl:choose>
                    <xsl:when test="not(contains(.,'/data/'))">
                        <xsl:if test="not(contains(.,'/GT-PAGE/'))">
                            
                            <xsl:if test="not(contains(.,'mets.xml'))">
                                <pathfile><xsl:value-of select="."/></pathfile>
                            </xsl:if>
                            
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="not(contains(.,'/GT-PAGE/'))">
                            <xsl:if test="not(contains(.,'mets.xml'))">
                                <pathfile><xsl:value-of select="."/></pathfile>
                            </xsl:if>
                            
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                
            </xsl:for-each>
            </xsl:variable>
            
            <xsl:if test="$CconPage2 !=''">
                <xsl:text>## Path Log</xsl:text><xsl:text disable-output-escaping="no">&#10;</xsl:text>
                <xsl:text>Please check the folder structure and the naming of your directories in your GT repository.</xsl:text><xsl:text disable-output-escaping="no">&#10;</xsl:text>
                
                <xsl:copy-of select="$CconPage2"/>
            </xsl:if>
            
        </xsl:if>
            
        
        
        
        
        
   <!--<xsl:if test="$output = 'METADATA'">
       
            <link rel="stylesheet" href="table_hide.css"/>
                <xsl:element name="div">
                    
                    <xsl:attribute name="class">metadata</xsl:attribute>
                    <h2>Metadata</h2>
                    <dl class="grid">
                        <dt>Name:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></dd>
                        <dt>Description:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/></dd>
                        <dt>Language:</dt><dd><xsl:value-of separator=", " select="$docMETADATA//fn:map/fn:array[@key='language']/fn:string"/></dd>
                        <dt>Format:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/></dd>
                        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='production-software'] !=''"><dt>Production software:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='production-software']"/></dd></xsl:if>
                        <dt>Time:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notBefore']"/>-<xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notAfter']"/></dd>
                        <dt>GT Type:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='gtTyp']"/></dd>
                        
                    </dl>
                    <xsl:if test="($docMETADATA//fn:map/fn:string[@key='transcription-guidelines'] !='') or ($docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name'] !='') or ($docMETADATA//fn:map/fn:string[@key='project-name'] !='') or ($docMETADATA//fn:map/fn:string[@key='project-website'] !='')">
                    <details>
                        <summary>More Information</summary>
                        <dl class="more-grid">
                            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines'] !=''">
                            <dt>Transcription Guidelines:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines']"/></dd>
                            </xsl:if>
                            <xsl:if test="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name'] !=''">
                            <dt>License:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name']"/></dd>
                            </xsl:if>
                            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='project-name'] !=''">
                            <dt>Project:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-name']"/></dd>
                            </xsl:if>
                            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='project-website'] !=''">
                            <dt>Project-URL:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-website']"/></dd>
                            </xsl:if>
                        </dl>
                    </details>
                    </xsl:if>
                </xsl:element>
       
       <xsl:element name="div">
           
          
           <xsl:variable name="CconMets">
               <xsl:for-each select="collection($conMets)"><xsl:value-of select="."/></xsl:for-each>
           </xsl:variable>
           
           
        <xsl:variable name="cMets">
               <mets>
                   <xsl:if test="$CconMets !=''">
                   <xsl:for-each select="collection($conMets)">
                       <xsl:copy-of select="//gt:state"/>
                       <gt:state prop="content-type/corpus"/>
                       <gt:state prop="platform/platform-independent"/>
                       <gt:state prop="content-encoding/structured"/>
                       <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/text"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/ocr"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/tables"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key1] !='0'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/layoutAnalysis"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="contentOfInterest/visual/text"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key4] !='0'"><gt:state prop="contentOfInterest/visual/graphical"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key7] !='0'"><gt:state prop="contentOfInterest/visual/graphical/separator"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key2] !='0'"><gt:state prop="contentOfInterest/visual/image"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key3] !='0'"><gt:state prop="contentOfInterest/visual/image/drawing"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><gt:state prop="contentOfInterest/visual/composite/tables"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key18] !='0'"><gt:state prop="contentOfInterest/visual/composite/maps"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key6] !='0'"><gt:state prop="contentOfInterest/visual/composite/charts"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key8] !='0'"><gt:state prop="contentOfInterest/visual/composite/maths"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key9] !='0'"><gt:state prop="contentOfInterest/visual/composite/chem"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key10] !='0'"><gt:state prop="contentOfInterest/visual/composite/music"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key16] !='0'"><gt:state prop="granularity/physical/document-related/page"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key15] !='0'"><gt:state prop="granularity/physical/document-related/text-line"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key20] !='0'"><gt:state prop="granularity/physical/document-related/word"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key21] ='true'"><gt:state prop="granularity/logical/document-related/paragraph"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key22] ='true'"><gt:state prop="data-attributes/document-related/structural/footnotes"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key23] ='true'"><gt:state prop="data-attributes/document-related/structural/footnote-continued"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key24] ='true'"><gt:state prop="data-attributes/document-related/structural/endnote"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key25] ='true'"><gt:state prop="data-attributes/document-related/structural/running-titles"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key26] ='true'"><gt:state prop="data-attributes/document-related/visual/decorations"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key27] ='true'"><gt:state prop="condition/wear/additions/informative/stamps"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key28] ='true'"><gt:state prop="data-attributes/document-related/visual/text/drop-caps"/></xsl:if>
                       <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Goth'"><gt:state prop="data-attributes/document-related/visual/text/font/typeface/blackletter"/></xsl:if>
                       <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Latn'"><gt:state prop="data-attributes/document-related/visual/text/font/typeface/antiqua"/></xsl:if>
                       
                   </xsl:for-each>
                   </xsl:if>
                   <xsl:if test="$CconMets =''">
                       <gt:state prop="content-type/corpus"/>
                       <gt:state prop="platform/platform-independent"/>
                       <gt:state prop="content-encoding/structured"/>
                       <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/text"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/ocr"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/tables"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key1] !='0'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/layoutAnalysis"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="contentOfInterest/visual/text"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key4] !='0'"><gt:state prop="contentOfInterest/visual/graphical"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key7] !='0'"><gt:state prop="contentOfInterest/visual/graphical/separator"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key2] !='0'"><gt:state prop="contentOfInterest/visual/image"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key3] !='0'"><gt:state prop="contentOfInterest/visual/image/drawing"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><gt:state prop="contentOfInterest/visual/composite/tables"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key18] !='0'"><gt:state prop="contentOfInterest/visual/composite/maps"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key6] !='0'"><gt:state prop="contentOfInterest/visual/composite/charts"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key8] !='0'"><gt:state prop="contentOfInterest/visual/composite/maths"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key9] !='0'"><gt:state prop="contentOfInterest/visual/composite/chem"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key10] !='0'"><gt:state prop="contentOfInterest/visual/composite/music"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key16] !='0'"><gt:state prop="granularity/physical/document-related/page"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key15] !='0'"><gt:state prop="granularity/physical/document-related/text-line"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key20] !='0'"><gt:state prop="granularity/physical/document-related/word"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key21] ='true'"><gt:state prop="granularity/logical/document-related/paragraph"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key22] ='true'"><gt:state prop="data-attributes/document-related/structural/footnotes"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key23] ='true'"><gt:state prop="data-attributes/document-related/structural/footnote-continued"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key24] ='true'"><gt:state prop="data-attributes/document-related/structural/endnote"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key25] ='true'"><gt:state prop="data-attributes/document-related/structural/running-titles"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key26] ='true'"><gt:state prop="data-attributes/document-related/visual/decorations"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key27] ='true'"><gt:state prop="condition/wear/additions/informative/stamps"/></xsl:if>
                       <xsl:if test="$holeMetric//string[@key=$key28] ='true'"><gt:state prop="data-attributes/document-related/visual/text/drop-caps"/></xsl:if>
                       <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Goth'"><gt:state prop="data-attributes/document-related/visual/text/font/typeface/blackletter"/></xsl:if>
                       <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Latn'"><gt:state prop="data-attributes/document-related/visual/text/font/typeface/antiqua"/></xsl:if>
                   </xsl:if>
               </mets>
           </xsl:variable>



             <xsl:variable name="dMetslabel">
               <xsl:for-each select="distinct-values($cMets/mets/gt:state/@prop)">
                   <xsl:sort 
                       select="." 
                       order="ascending"/>
                   <details>
                       <xsl:variable name="o" select="."/>
                   <summary><xsl:value-of select="."/></summary>
                       <p><strong>Description: </strong><xsl:value-of select="distinct-values($labelling//dlentry/dt[text() = $o]/following-sibling::dd)"/></p>
                   </details>
                </xsl:for-each>
           </xsl:variable>
           
           
           <xsl:attribute name="class">metadata</xsl:attribute>
           <h2>Labelling</h2>
           <xsl:element name="p">The GT data has been labeled. The labeling is 
               based on an ontology defined by the Pattern Recognition and Image Analysis Research Lab 
               (PRImA-Research-Lab) at the University of Salford. 
               This normalized and semantic description of the OCR-GT data can be found in the METS metadata file. 
               The labeling metadata is created for each available page. The following labeling metadata is available for the complete collection.</xsl:element>
           <xsl:element name="p">Here you will find a description and explanation of the labeling metadata.</xsl:element>
           
               <xsl:copy-of select="$dMetslabel"/>
           
           
       </xsl:element>
       
       
       
                
                <xsl:element name="div">
                    <xsl:attribute name="class">metadata</xsl:attribute>
                    <h2>Download</h2>
                    <xsl:element name="p">You can download the complete data here. 
                        They contain a zip file in which the components of the collection are also in zip files.
                        Metadata for the complete collection and the components are in METS format.</xsl:element>
                    <ul>
                        <li><a><xsl:attribute name="href">https://github.com/<xsl:value-of select="$repoName"/>/releases/tag/<xsl:value-of select="$releaseTag"/></xsl:attribute>The BagIt 'ocrd.zip' files for the current version, please download them from the latest release.: Release <xsl:value-of select="$bagitDumpNum"/>_<xsl:value-of select="$releaseTag"/></a></li>
                    <li><a><xsl:attribute name="href">https://github.com/<xsl:value-of select="$repoName"/>/releases</xsl:attribute>Version archive</a></li>
                    </ul>
                </xsl:element>
                
                <xsl:element name="div">
                    <xsl:attribute name="class">metadata</xsl:attribute>
                <h2>Total view</h2>
                
                    <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_structure_and_text'">
                        
                        
                        <!-\- beginn columes -\->
                        
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
                        
                        
                        
                        
                        
                        
                        <!-\- end columes -\->
                        
                        <table class="noStyle">
                            <tr><td>&#x1F4A1; You can show and hide individual columns of the table.<br/>Click the corresponding button.
                                <details>
                                    <summary>Legend</summary>
                                    <dl class="grid">
                                        <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                        <dd>TextLine</dd>
                                        <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                        <dd>Page</dd>
                                        
                                        <xsl:if test="$k1 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k2 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k3 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                        <dd>LineDrawingRegion</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k4 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k5 > 0">    
                                        <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k6 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                        <dd>ChartRegion</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k7 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k8 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k9 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k10 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                        </xsl:if>
                                            
                                        <xsl:if test="$k11 > 0">   
                                        <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                        </xsl:if>
                                            
                                        <xsl:if test="$k12 > 0">    
                                        <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k13 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySonstiges.html" target="_blank">UnkownRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k14 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                        <dd>CustomRegion</dd>
                                        </xsl:if>   
                                    </dl>
                                </details>
                            </td>
                                
                                <td>
                                    <div class="grid-container">
                                        
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide1')"><i><xsl:value-of select="$tableHeader//th[16]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide2')"><i><xsl:value-of select="$tableHeader//th[17]"/></i></button>
                                        
                                        
                                        <xsl:if test="$k1 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide3')"><i><xsl:value-of select="$tableHeader//th[2]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        <xsl:if test="$k2 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide4')"><i><xsl:value-of select="$tableHeader//th[3]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k3 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide5')"><i><xsl:value-of select="$tableHeader//th[4]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k4 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide6')"><i><xsl:value-of select="$tableHeader//th[5]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k5 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide7')"><i><xsl:value-of select="$tableHeader//th[6]"/></i></button>    
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k6 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide8')"><i><xsl:value-of select="$tableHeader//th[7]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k7 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide9')"><i><xsl:value-of select="$tableHeader//th[8]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k8 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide10')"><i><xsl:value-of select="$tableHeader//th[9]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k9 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide11')"><i><xsl:value-of select="$tableHeader//th[10]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k10 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide12')"><i><xsl:value-of select="$tableHeader//th[11]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k11 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide13')"><i><xsl:value-of select="$tableHeader//th[12]"/></i></button>   
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k12 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide14')"><i><xsl:value-of select="$tableHeader//th[13]"/></i></button>    
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k13 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide15')"><i><xsl:value-of select="$tableHeader//th[14]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k14 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide16')"><i><xsl:value-of select="$tableHeader//th[15]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                    </div>
                                </td>
                            </tr>
                        </table>
                        
                        
                        
                        
                        
                        <xsl:element name="table">
                            <xsl:attribute name="id">table_id</xsl:attribute>
                            <xsl:element name="thead">
                                <xsl:element name="tr">
                                    <xsl:copy-of select="$tableHeader//thead/tr/th[position()>15]"/>
                                    <xsl:if test="$k1 > 0">
                                        <th>TxtRegion</th>
                                    </xsl:if>

                                    <xsl:if test="$k2 > 0">
                                        <th>ImgRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k3 > 0">
                                        <th>LineDrawRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k4 > 0">
                                        <th>GraphRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k5 > 0">
                                        <th>TabRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k6 > 0">
                                        <th>ChartRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k7 > 0">
                                        <th>SepRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k8 > 0">
                                        <th>MathRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k9 > 0">
                                        <th>ChemRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k10 > 0">
                                        <th>MusicRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k11 > 0">
                                        <th>AdRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k12 > 0">
                                        <th>NoiseRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k13 > 0">
                                        <th>UnkownRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k14 > 0">
                                        <th>CustomRegion</th>
                                    </xsl:if>
                                    
                                </xsl:element>
                            </xsl:element>
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
                    
                    
                    <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_structure'">
                    <table class="noStyle">
                        <tr><td>&#x1F4A1; You can show and hide individual columns of the table.<br/>Click the corresponding button.
                            <details>
                                <summary>Legend</summary>                         
                                <dl class="grid">
                                    <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                    <dd>LineDrawingRegion</dd>
                                    <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                    <dd>ChartRegion</dd>
                                    <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySonstiges.html" target="_blank">UnkownRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                    <dd>CustomRegion</dd>
                                    <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                    <dd>TextLine</dd>
                                    <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                    <dd>Page</dd>
                                </dl>
                            </details>
                        </td>
                            
                            <td>
                                <div class="grid-container">
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide1')"><i><xsl:value-of select="$tableHeader//th[2]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide2')"><i><xsl:value-of select="$tableHeader//th[3]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide3')"><i><xsl:value-of select="$tableHeader//th[4]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide4')"><i><xsl:value-of select="$tableHeader//th[5]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide5')"><i><xsl:value-of select="$tableHeader//th[6]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide6')"><i><xsl:value-of select="$tableHeader//th[7]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide7')"><i><xsl:value-of select="$tableHeader//th[8]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide8')"><i><xsl:value-of select="$tableHeader//th[9]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide9')"><i><xsl:value-of select="$tableHeader//th[10]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide10')"><i><xsl:value-of select="$tableHeader//th[11]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide11')"><i><xsl:value-of select="$tableHeader//th[12]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide12')"><i><xsl:value-of select="$tableHeader//th[13]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide13')"><i><xsl:value-of select="$tableHeader//th[14]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide14')"><i><xsl:value-of select="$tableHeader//th[15]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide15')"><i><xsl:value-of select="$tableHeader//th[16]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide16')"><i><xsl:value-of select="$tableHeader//th[17]"/></i></button>
                                </div>
                            </td>
                        </tr>
                    </table>
                    
                    
                    
                    <xsl:element name="table">
                        <xsl:attribute name="id">table_id</xsl:attribute>
                    <xsl:element name="thead">
                        <xsl:element name="tr">
                    <xsl:copy-of select="$tableHeader//thead/tr/th[position()>1]"/>
                    </xsl:element>
                    </xsl:element>
                    <xsl:element name="tbody">
                    
                    
                    <xsl:element name="tr">
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key1])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key2])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key3])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key4])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key5])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key6])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key7])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key8])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key9])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key10])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key11])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key12])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key13])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key14])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key15])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key16])"/>
                            </xsl:for-each>
                        </xsl:element>
                        
                    </xsl:element>
                    </xsl:element>
                </xsl:element>
                </xsl:if>
                    
                    
                    
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_line'">
                        
                        
                        <!-\- beginn columes -\->
                        
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
                        
                        
                        
                        
                        
                        
                        <!-\- end columes -\->
                        
                        <table class="noStyle">
                            <tr><td>&#x1F4A1; You can show and hide individual columns of the table.<br/>Click the corresponding button.
                                <details>
                                    <summary>Legend</summary>
                                    <dl class="grid">
                                        <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                        <dd>TextLine</dd>
                                        <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                        <dd>Page</dd>
                                        
                                        <xsl:if test="$k1 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k2 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k3 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                        <dd>LineDrawingRegion</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k4 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k5 > 0">    
                                        <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k6 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                        <dd>ChartRegion</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k7 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k8 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k9 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k10 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                        </xsl:if>
                                            
                                        <xsl:if test="$k11 > 0">   
                                        <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                        </xsl:if>
                                            
                                        <xsl:if test="$k12 > 0">    
                                        <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k13 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySonstiges.html" target="_blank">UnkownRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k14 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                        <dd>CustomRegion</dd>
                                        </xsl:if>   
                                    </dl>
                                </details>
                            </td>
                                
                                <td>
                                    <div class="grid-container">
                                        
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide1')"><i><xsl:value-of select="$tableHeader//th[16]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide2')"><i><xsl:value-of select="$tableHeader//th[17]"/></i></button>
                                        
                                        
                                        <xsl:if test="$k1 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide3')"><i><xsl:value-of select="$tableHeader//th[2]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        <xsl:if test="$k2 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide4')"><i><xsl:value-of select="$tableHeader//th[3]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k3 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide5')"><i><xsl:value-of select="$tableHeader//th[4]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k4 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide6')"><i><xsl:value-of select="$tableHeader//th[5]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k5 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide7')"><i><xsl:value-of select="$tableHeader//th[6]"/></i></button>    
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k6 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide8')"><i><xsl:value-of select="$tableHeader//th[7]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k7 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide9')"><i><xsl:value-of select="$tableHeader//th[8]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k8 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide10')"><i><xsl:value-of select="$tableHeader//th[9]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k9 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide11')"><i><xsl:value-of select="$tableHeader//th[10]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k10 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide12')"><i><xsl:value-of select="$tableHeader//th[11]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k11 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide13')"><i><xsl:value-of select="$tableHeader//th[12]"/></i></button>   
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k12 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide14')"><i><xsl:value-of select="$tableHeader//th[13]"/></i></button>    
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k13 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide15')"><i><xsl:value-of select="$tableHeader//th[14]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k14 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide16')"><i><xsl:value-of select="$tableHeader//th[15]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                    </div>
                                </td>
                            </tr>
                        </table>
                        
                        
                        
                        
                        
                        <xsl:element name="table">
                            <xsl:attribute name="id">table_id</xsl:attribute>
                            <xsl:element name="thead">
                                <xsl:element name="tr">
                                    <xsl:copy-of select="$tableHeader//thead/tr/th[position()>15]"/>
                                    <xsl:if test="$k1 > 0">
                                        <th>TxtRegion</th>
                                    </xsl:if>

                                    <xsl:if test="$k2 > 0">
                                        <th>ImgRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k3 > 0">
                                        <th>LineDrawRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k4 > 0">
                                        <th>GraphRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k5 > 0">
                                        <th>TabRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k6 > 0">
                                        <th>ChartRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k7 > 0">
                                        <th>SepRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k8 > 0">
                                        <th>MathRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k9 > 0">
                                        <th>ChemRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k10 > 0">
                                        <th>MusicRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k11 > 0">
                                        <th>AdRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k12 > 0">
                                        <th>NoiseRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k13 > 0">
                                        <th>UnkownRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k14 > 0">
                                        <th>CustomRegion</th>
                                    </xsl:if>
                                    
                                </xsl:element>
                            </xsl:element>
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
                </xsl:element>
                
                
                <xsl:element name="div">
                    <xsl:element name="h2">Details</xsl:element>
                    <xsl:element name="ul">
                        <xsl:copy-of select="$details//li[position()>1]"/>
                    </xsl:element>
                </xsl:element>
                
                    
                    
                
                <xsl:if test="$docMETADATA//map/string[@key='gtTyp']/text()='text'">
                
                    <!-\-<array key="volume_lines">
                    <map>
                        <string key="count"/>
                        <string key="metric"/>
                    </map>
                </array>-\->
                </xsl:if>
             </xsl:if>
        <xsl:if test="$output = 'TABLE'">
            <link rel="stylesheet" href="table_hide.css"/>
            
            
            
            
            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_structure_and_text'">
            
                    
                    <xsl:element name="div">
                        
                        <xsl:element name="h2">Details</xsl:element>
                        <xsl:element name="ul">
                            <xsl:copy-of select="$details//li[1]"/>
                            <xsl:copy-of select="$details//li[3]"/>
                        </xsl:element>
                    </xsl:element>
                    
                    <xsl:element name="div">
                        <xsl:attribute name="class">metadata</xsl:attribute>
                        
                        <h2>Metadata</h2>
                        <dl class="grid">
                            <dt>Name:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></dd>
                            <dt>Description:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/></dd>
                            <dt>Language:</dt><dd><xsl:value-of separator=", " select="$docMETADATA//fn:map/fn:array[@key='language']/fn:string"/></dd>
                            <dt>Format:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/></dd>
                            <dt>Time:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notBefore']"/>-<xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notAfter']"/></dd>
                            <dt>GT Type:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='gtTyp']"/></dd>
                        </dl>
                        
                        <xsl:if test="($docMETADATA//fn:map/fn:string[@key='transcription-guidelines'] !='') or ($docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name'] !='') or ($docMETADATA//fn:map/fn:string[@key='project-name'] !='') or ($docMETADATA//fn:map/fn:string[@key='project-website'] !='')">
                            <details>
                                <summary>More Information</summary>                         
                                <dl class="more-grid">
                                    <xsl:if test="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines'] !=''">
                                        <dt>Transcription Guidelines:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines']"/></dd>
                                    </xsl:if>
                                    <xsl:if test="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name'] !=''">
                                        <dt>License:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name']"/></dd>
                                    </xsl:if>
                                    <xsl:if test="$docMETADATA//fn:map/fn:string[@key='project-name'] !=''">
                                        <dt>Project:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-name']"/></dd>
                                    </xsl:if>
                                    <xsl:if test="$docMETADATA//fn:map/fn:string[@key='project-website'] !=''">
                                        <dt>Project-URL:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-website']"/></dd>
                                    </xsl:if>
                                </dl>
                            </details>
                        </xsl:if>
                        
                        
                        <h2>Compressed table view</h2>
                        <div>
                            <table class="noStyle">
                                <tr><td>&#x1F4A1; You can show and hide individual columns of the table.<br/>Click the corresponding button.
                                    <details>
                                        <summary>Legend</summary>                         
                                        <dl class="grid">
                                            <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                            <dd>TextLine</dd>
                                            <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                            <dd>Page</dd>
                                            <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                            <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                            <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                            <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                            <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                            <dd>LineDrawingRegion</dd>
                                            <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                            <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                            <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                            <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                            <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                            <dd>ChartRegion</dd>
                                            <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                            <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                            <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                            <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                            <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                            <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                            <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                            <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                            <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                            <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                            <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                            <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                            <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                            <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySonstiges.html" target="_blank">UnkownRegion</a></dd>
                                            <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                            <dd>CustomRegion</dd>
                                        </dl>
                                    </details>
                                </td>
                                    
                                    <td>
                                        <div class="grid-container">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide2')"><i><xsl:value-of select="$tableHeader//th[16]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide3')"><i><xsl:value-of select="$tableHeader//th[17]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide4')"><i><xsl:value-of select="$tableHeader//th[2]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide5')"><i><xsl:value-of select="$tableHeader//th[3]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide6')"><i><xsl:value-of select="$tableHeader//th[4]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide7')"><i><xsl:value-of select="$tableHeader//th[5]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide8')"><i><xsl:value-of select="$tableHeader//th[6]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide9')"><i><xsl:value-of select="$tableHeader//th[7]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide10')"><i><xsl:value-of select="$tableHeader//th[8]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide11')"><i><xsl:value-of select="$tableHeader//th[9]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide12')"><i><xsl:value-of select="$tableHeader//th[10]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide13')"><i><xsl:value-of select="$tableHeader//th[11]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide14')"><i><xsl:value-of select="$tableHeader//th[12]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide15')"><i><xsl:value-of select="$tableHeader//th[13]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide16')"><i><xsl:value-of select="$tableHeader//th[14]"/></i></button>
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide17')"><i><xsl:value-of select="$tableHeader//th[15]"/></i></button>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <table id="table_id" class="display">
                                
                                <thead>                
                                    <tr>
                                        <th>document</th>
                                        <th>TextLine</th>
                                        <th>Page</th>
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
                                        <th>UnkownRegion</th>
                                        <th>CustomRegion</th>
                                        
                                    </tr>
                                </thead>
                                
                                
                                
                                
                                <tbody> 
                                    <xsl:for-each-group select="$holeMetric//*" group-by="@key1">
                                        
                                        <xsl:variable name="content"><list><xsl:copy-of select="current-group()"/></list></xsl:variable>
                                        
                                        <tr>
                                            <th><xsl:value-of select="current-grouping-key()"/></th>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key15])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key16])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key1])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key2])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key3])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key4])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key5])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key6])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key7])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key8])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key9])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key10])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key11])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key12])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key13])"/></td>
                                            <td><xsl:value-of select="sum(current-group()//*[@key=$key14])"/></td>
                                            
                                            
                                        </tr>
                                        <tr><td colspan="17" style="text-align:left !important;">
                                            
                                            <details>
                                                <summary>Overview</summary>
                                                
                                                <table>
                                                    
                                                    <thead>                
                                                        <tr>
                                                            <th>document</th>
                                                            <th>TextLine</th>
                                                            <th>Page</th>
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
                                                            <th>UnkownRegion</th>
                                                            <th>CustomRegion</th>
                                                            
                                                        </tr>
                                                    </thead>
                                                    
                                                    
                                                    <xsl:for-each select="$content//map">
                                                        
                                                        
                                                        <tr>
                                                            <td><a><xsl:attribute name="href">https://github.com/<xsl:value-of select="$repoName"/>/blob/<xsl:value-of select="$repoBase"/>/data/<xsl:value-of select="substring-after(@file, '/data/')"/></xsl:attribute><xsl:value-of select="@key2"/></a></td>
                                                            <td><xsl:value-of select="string[@key=$key15]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key16]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key1]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key2]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key3]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key4]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key5]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key6]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key7]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key8]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key9]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key10]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key11]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key12]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key13]"/></td>
                                                            <td><xsl:value-of select="string[@key=$key14]"/></td>
                                                            
                                                        </tr>
                                                    </xsl:for-each>
                                                </table>
                                            </details>
                                        </td></tr>
                                    </xsl:for-each-group>
                                </tbody>       
                            </table>
                        </div>
                    </xsl:element>
            </xsl:if>
            
            
            
            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_structure'">
                
                <xsl:element name="div">
                    <xsl:element name="h2">Details</xsl:element>
                    <xsl:element name="ul">
                        <xsl:copy-of select="$details//li[1]"/>
                        <xsl:copy-of select="$details//li[3]"/>
                    </xsl:element>
                </xsl:element>
                
                <xsl:element name="div">
                    <xsl:attribute name="class">metadata</xsl:attribute>
                    <h2>Metadata</h2>
                    <dl class="grid">
                        <dt>Name:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></dd>
                        <dt>Description:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/></dd>
                        <dt>Language:</dt><dd><xsl:value-of separator=", " select="$docMETADATA//fn:map/fn:array[@key='language']/fn:string"/></dd>
                        <dt>Format:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/></dd>
                        <dt>Time:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notBefore']"/>-<xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notAfter']"/></dd>
                        <dt>GT Type:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='gtTyp']"/></dd>
                    </dl>
                    
                    <xsl:if test="($docMETADATA//fn:map/fn:string[@key='transcription-guidelines'] !='') or ($docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name'] !='') or ($docMETADATA//fn:map/fn:string[@key='project-name'] !='') or ($docMETADATA//fn:map/fn:string[@key='project-website'] !='')">
                        <details>
                            <summary>More Information</summary>                         
                            <dl class="more-grid">
                                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines'] !=''">
                                    <dt>Transcription Guidelines:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines']"/></dd>
                                </xsl:if>
                                <xsl:if test="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name'] !=''">
                                    <dt>License:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name']"/></dd>
                                </xsl:if>
                                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='project-name'] !=''">
                                    <dt>Project:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-name']"/></dd>
                                </xsl:if>
                                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='project-website'] !=''">
                                    <dt>Project-URL:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-website']"/></dd>
                                </xsl:if>
                            </dl>
                        </details>
                    </xsl:if>
                    
                    
                    <h2>Compressed table view</h2>
                    <div>
                    <table class="noStyle">
                        <tr><td>&#x1F4A1; You can show and hide individual columns of the table.<br/>Click the corresponding button.
                            <details>
                                <summary>Legend</summary>                         
                                <dl class="grid">
                                    <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                    <dd>LineDrawingRegion</dd>
                                    <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                    <dd>ChartRegion</dd>
                                    <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySonstiges.html" target="_blank">UnkownRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                    <dd>CustomRegion</dd>
                                </dl>
                            </details>
                        </td>
                            
                        <td>
                        <div class="grid-container">
                            <button onclick="document.getElementById('table_id').classList.toggle('hide2')"><i><xsl:value-of select="$tableHeader//th[2]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide3')"><i><xsl:value-of select="$tableHeader//th[3]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide4')"><i><xsl:value-of select="$tableHeader//th[4]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide5')"><i><xsl:value-of select="$tableHeader//th[5]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide6')"><i><xsl:value-of select="$tableHeader//th[6]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide7')"><i><xsl:value-of select="$tableHeader//th[7]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide8')"><i><xsl:value-of select="$tableHeader//th[8]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide9')"><i><xsl:value-of select="$tableHeader//th[9]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide10')"><i><xsl:value-of select="$tableHeader//th[10]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide11')"><i><xsl:value-of select="$tableHeader//th[11]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide12')"><i><xsl:value-of select="$tableHeader//th[12]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide13')"><i><xsl:value-of select="$tableHeader//th[13]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide14')"><i><xsl:value-of select="$tableHeader//th[14]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide15')"><i><xsl:value-of select="$tableHeader//th[15]"/></i></button>
                        </div>
                        </td>
                        </tr>
                    </table>
                    <table id="table_id" class="display">
                        
                       <xsl:copy-of select="$tableHeader"/>
                       
                       <tbody> 
                       <xsl:for-each-group select="$holeMetric//*" group-by="@key1">
                           
                           <xsl:variable name="content"><list><xsl:copy-of select="current-group()"/></list></xsl:variable>
                           
                        <tr>
                            <th><xsl:value-of select="current-grouping-key()"/></th>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key1])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key2])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key3])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key4])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key5])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key6])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key7])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key8])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key9])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key10])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key11])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key12])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key13])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key14])"/></td>
                            </tr>
                           <tr><td colspan="17" style="text-align:left !important;">
                           
                           <details>
                               <summary>Overview</summary>
                               
                               <table>
                                   
                                   <xsl:copy-of select="$tableHeader"/>
                                   
                                   
                                   <xsl:for-each select="$content//map">
                                       
                                       
                                       <tr>
                                           <td><a><xsl:attribute name="href">https://github.com/<xsl:value-of select="$repoName"/>/blob/<xsl:value-of select="$repoBase"/>/data/<xsl:value-of select="substring-after(@file, '/data/')"/></xsl:attribute><xsl:value-of select="@key2"/></a></td>
                                           <td><xsl:value-of select="string[@key=$key1]"/></td>
                                           <td><xsl:value-of select="string[@key=$key2]"/></td>
                                           <td><xsl:value-of select="string[@key=$key3]"/></td>
                                           <td><xsl:value-of select="string[@key=$key4]"/></td>
                                           <td><xsl:value-of select="string[@key=$key5]"/></td>
                                           <td><xsl:value-of select="string[@key=$key6]"/></td>
                                           <td><xsl:value-of select="string[@key=$key7]"/></td>
                                           <td><xsl:value-of select="string[@key=$key8]"/></td>
                                           <td><xsl:value-of select="string[@key=$key9]"/></td>
                                           <td><xsl:value-of select="string[@key=$key10]"/></td>
                                           <td><xsl:value-of select="string[@key=$key11]"/></td>
                                           <td><xsl:value-of select="string[@key=$key12]"/></td>
                                           <td><xsl:value-of select="string[@key=$key13]"/></td>
                                           <td><xsl:value-of select="string[@key=$key14]"/></td>
                                       </tr>
                                   </xsl:for-each>
                               </table>
                           </details>
                            </td></tr>
                    </xsl:for-each-group>
                  </tbody>       
                </table>
               </div>
                </xsl:element>
            </xsl:if>
            
            
            
            
            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_line'">
                
                <xsl:element name="div">
                    
                    <xsl:element name="h2">Details</xsl:element>
                    <xsl:element name="ul">
                        <xsl:copy-of select="$details//li[1]"/>
                        <xsl:copy-of select="$details//li[3]"/>
                    </xsl:element>
                </xsl:element>
                
                <xsl:element name="div">
                    <xsl:attribute name="class">metadata</xsl:attribute>
                    
                    <h2>Metadata</h2>
                    <dl class="grid">
                        <dt>Name:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></dd>
                        <dt>Description:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/></dd>
                        <dt>Language:</dt><dd><xsl:value-of separator=", " select="$docMETADATA//fn:map/fn:array[@key='language']/fn:string"/></dd>
                        <dt>Format:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/></dd>
                        <dt>Time:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notBefore']"/>-<xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notAfter']"/></dd>
                        <dt>GT Type:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='gtTyp']"/></dd>
                    </dl>
                    
                    <xsl:if test="($docMETADATA//fn:map/fn:string[@key='transcription-guidelines'] !='') or ($docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name'] !='') or ($docMETADATA//fn:map/fn:string[@key='project-name'] !='') or ($docMETADATA//fn:map/fn:string[@key='project-website'] !='')">
                        <details>
                            <summary>More Information</summary>                         
                            <dl class="more-grid">
                                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines'] !=''">
                                    <dt>Transcription Guidelines:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines']"/></dd>
                                </xsl:if>
                                <xsl:if test="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name'] !=''">
                                    <dt>License:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name']"/></dd>
                                </xsl:if>
                                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='project-name'] !=''">
                                    <dt>Project:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-name']"/></dd>
                                </xsl:if>
                                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='project-website'] !=''">
                                    <dt>Project-URL:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-website']"/></dd>
                                </xsl:if>
                            </dl>
                        </details>
                    </xsl:if>
                    
                    
                    <h2>Compressed table view</h2>
                    <div>
                        <table class="noStyle">
                            <tr><td>&#x1F4A1; You can show and hide individual columns of the table.<br/>Click the corresponding button.
                                <details>
                                    <summary>Legend</summary>                         
                                    <dl class="grid">
                                        <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                        <dd>TextLine</dd>
                                        <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                        <dd>Page</dd>
                                        <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                        <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                        <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                        <dd>LineDrawingRegion</dd>
                                        <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                        <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                        <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                        <dd>ChartRegion</dd>
                                        <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                        <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                        <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                        <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                        <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                        <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                        <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySonstiges.html" target="_blank">UnkownRegion</a></dd>
                                        <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                        <dd>CustomRegion</dd>
                                    </dl>
                                </details>
                            </td>
                                
                                <td>
                                    <div class="grid-container">
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide2')"><i><xsl:value-of select="$tableHeader//th[16]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide3')"><i><xsl:value-of select="$tableHeader//th[17]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide4')"><i><xsl:value-of select="$tableHeader//th[2]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide5')"><i><xsl:value-of select="$tableHeader//th[3]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide6')"><i><xsl:value-of select="$tableHeader//th[4]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide7')"><i><xsl:value-of select="$tableHeader//th[5]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide8')"><i><xsl:value-of select="$tableHeader//th[6]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide9')"><i><xsl:value-of select="$tableHeader//th[7]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide10')"><i><xsl:value-of select="$tableHeader//th[8]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide11')"><i><xsl:value-of select="$tableHeader//th[9]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide12')"><i><xsl:value-of select="$tableHeader//th[10]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide13')"><i><xsl:value-of select="$tableHeader//th[11]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide14')"><i><xsl:value-of select="$tableHeader//th[12]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide15')"><i><xsl:value-of select="$tableHeader//th[13]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide16')"><i><xsl:value-of select="$tableHeader//th[14]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide17')"><i><xsl:value-of select="$tableHeader//th[15]"/></i></button>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table id="table_id" class="display">
                            
                            <thead>                
                                <tr>
                                    <th>document</th>
                                    <th>TextLine</th>
                                    <th>Page</th>
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
                                    <th>UnkownRegion</th>
                                    <th>CustomRegion</th>
                                    
                                </tr>
                            </thead>
                            
                            
                            
                            
                            <tbody> 
                                <xsl:for-each-group select="$holeMetric//*" group-by="@key1">
                                    
                                    <xsl:variable name="content"><list><xsl:copy-of select="current-group()"/></list></xsl:variable>
                                    
                                    <tr>
                                        <th><xsl:value-of select="current-grouping-key()"/></th>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key15])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key16])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key1])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key2])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key3])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key4])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key5])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key6])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key7])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key8])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key9])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key10])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key11])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key12])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key13])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key14])"/></td>
                                        
                                        
                                    </tr>
                                    <tr><td colspan="17" style="text-align:left !important;">
                                        
                                        <details>
                                            <summary>Overview</summary>
                                            
                                            <table>
                                                
                                                <thead>                
                                                    <tr>
                                                        <th>document</th>
                                                        <th>TextLine</th>
                                                        <th>Page</th>
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
                                                        <th>UnkownRegion</th>
                                                        <th>CustomRegion</th>
                                                        
                                                    </tr>
                                                </thead>
                                                
                                                
                                                <xsl:for-each select="$content//map">
                                                    
                                                    
                                                    <tr>
                                                        <td><a><xsl:attribute name="href">https://github.com/<xsl:value-of select="$repoName"/>/blob/<xsl:value-of select="$repoBase"/>/data/<xsl:value-of select="substring-after(@file, '/data/')"/></xsl:attribute><xsl:value-of select="@key2"/></a></td>
                                                        <td><xsl:value-of select="string[@key=$key15]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key16]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key1]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key2]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key3]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key4]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key5]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key6]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key7]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key8]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key9]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key10]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key11]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key12]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key13]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key14]"/></td>
                                                        
                                                    </tr>
                                                </xsl:for-each>
                                            </table>
                                        </details>
                                    </td></tr>
                                </xsl:for-each-group>
                            </tbody>       
                        </table>
                    </div>
                </xsl:element>
            </xsl:if>
            
            
            
            
            
            
        </xsl:if>
        <xsl:if test="$output = 'OVERVIEW'">
                <link rel="stylesheet" href="table_hide.css"/>
                <link rel="stylesheet"
                    type="text/css"
                    href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.css"/>
                <script type="text/javascript"
                    charset="utf8"
                    src="https://code.jquery.com/jquery-3.5.1.js"><xsl:text> </xsl:text></script>
                <script charset="utf8" type="text/javascript"
                    src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"><xsl:text> </xsl:text></script>
                <script type="text/javascript">
                    $(document).ready(function() {
                    $('#table_id').DataTable( {
                    "scrollX": "1800px",
                    "scrollCollapse": true,
                    "pagingType": "full_numbers",
                    "ordering": true,
                    "info":     true,
                    
                    } );
                    } );
                </script>
            
            
            
            <xsl:element name="div">
                <xsl:element name="h2">Details</xsl:element>
                <xsl:element name="ul">
                    <xsl:copy-of select="$details//li[1]"/>
                    <xsl:copy-of select="$details//li[2]"/>
                </xsl:element>
            </xsl:element>
            
            
            
            
            
            
            <h2>Detailed table view</h2>
            
            <div>
                <table class="noStyle">
                    <tr><td> 
                        <details>
                            <summary>Legend</summary>
                            <dl class="grid_only">
                                <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                <dd>TextLine</dd>
                                <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                <dd>Page</dd> 
                                <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                <dd>LineDrawingRegion</dd>
                                <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                <dd>ChartRegion</dd>
                                <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySonstiges.html" target="_blank">UnkownRegion</a></dd>
                                <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                <dd>CustomRegion</dd>
                            </dl>
                        </details>
                    </td>
                        
                        
                    </tr>
                </table>
                
            </div>
            
                        
            <table id="table_id">
                            
                            
                <xsl:element name="thead">
                    <xsl:element name="tr">
                        <th style="position: sticky !important; left: 0 !important;">document</th>
                        <xsl:copy-of select="$tableHeader//thead/tr/th[position()>1]"/>
                    </xsl:element>
                </xsl:element>
                            
                            
                            <tbody>
                            <xsl:for-each select="$holeMetric/array/array">
                                <tr>
                                    <th><xsl:value-of select="map/@key2"/></th>
                                    <td><xsl:value-of select="map/string[@key=$key1]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key2]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key3]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key4]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key5]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key6]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key7]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key8]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key9]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key10]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key11]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key12]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key13]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key14]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key15]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key16]"/></td>
                                </tr>
                            </xsl:for-each>
                            </tbody>     
                        </table>
                    
            
            
            
            
            
            
        </xsl:if>
        <xsl:if test="$output = 'METS'">
            
            <!-\- Mets Control -\->
            
            
            <xsl:variable name="ocrdMets">
                <xsl:for-each select="collection($conMets)">
                   <xsl:copy-of select="//*[local-name()='fileGrp']/@*[local-name()!='USE']!='OCR-D-IMG'"/>
                </xsl:for-each>
            </xsl:variable>
            
           
           
            
            <xsl:if test="$ocrdMets = ''">
                <xsl:for-each select="$holeMetric/array/array">
                        
                        <xsl:variable name="Image1" select="substring-before(map/image1, '.')"/>
                        <xsl:variable name="Image2" select="substring-before(map/image2, '.')"/>
                        <xsl:variable name="Image3" select="substring-before(map/image3, '.')"/>
                    
                        <xsl:variable name="Page" select="substring-before(map/page, '.')"/>
                    
                    
                    <xsl:variable name="Image2Path">
                        <xsl:choose>
                            <xsl:when test="contains(map/image2,'..')">
                                <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/>/<xsl:value-of select="tokenize(substring-before(map/image2, tokenize(map/image2,'/')[last()]), '\.\./')[last()]"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/>GT-PAGE/<xsl:value-of select="tokenize(substring-before(map/image2, tokenize(map/image2,'/')[last()]), '\.\./')[last()]"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    
                    
                    
                    
                       
                    <xsl:if test="$Image1 != ''">
                       <xsl:if test="$Image2 = $Page">
                            cd <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/>
                            wget <xsl:value-of select="map/image1"/> -O GT-PAGE/<xsl:value-of select="map/image2"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-IMG -i OCR-D-IMG_<xsl:number format="0001"/> -m image/<xsl:value-of select="substring-after(tokenize(map/image1, '/')[last()], '.')"/><xsl:text>  </xsl:text><xsl:value-of select="$Image2Path"/><xsl:value-of select="tokenize(map/image2,'/')[last()]"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-PAGE -i OCR-D-GT-SEG-PAGE_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-BLOCK -i OCR-D-GT-SEG-BLOCK_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                        </xsl:if>
                    </xsl:if>


                    <xsl:if test="$Image3 != ''">
                        <xsl:if test="$Image2 = $Page">
                            cd <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/>
                            wget <xsl:value-of select="substring-before(map/image3, '&amp;fileType=view')"/> -O GT-PAGE/<xsl:value-of select="map/image2"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-IMG -i OCR-D-IMG_<xsl:number format="0001"/> -m image/<xsl:value-of select="substring-after(tokenize(map/image1, '/')[last()], '.')"/><xsl:text>  </xsl:text><xsl:value-of select="$Image2Path"/><xsl:value-of select="map/image2"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-PAGE -i OCR-D-GT-SEG-PAGE_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-BLOCK -i OCR-D-GT-SEG-BLOCK_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                        </xsl:if>
                    </xsl:if>




                    <xsl:if test="$Image1 = '' and $Image3 = ''">
                    <xsl:if test="$Image2 = $Page">
                        <xsl:variable name="wget_img" select="map/image2"/>
                        cd <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/>
                        <xsl:if test="$wget_img[contains(text(),'http')]">
                           wget <xsl:value-of select="map/image2"/> -O GT-PAGE/<xsl:value-of select="map/image2"/>
                        </xsl:if>
                        
                        ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-IMG -i OCR-D-IMG_<xsl:number format="0001"/> -m image/<xsl:value-of select="substring-after(tokenize(map/image2, '/')[last()], '.')"/><xsl:text>  </xsl:text><xsl:value-of select="$Image2Path"/><xsl:value-of select="tokenize(map/image2,'/')[last()]"/>
                        ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-PAGE -i OCR-D-GT-SEG-PAGE_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                        ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-BLOCK -i OCR-D-GT-SEG-BLOCK_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                    </xsl:if>
                    </xsl:if>
                </xsl:for-each>
            </xsl:if>
            
            <!-\-<xsl:if test="contains($ocrdMets, 'http')">
                <xsl:for-each select="collection($conMets)">
                    <xsl:variable name="imgURL" select="//*[local-name()='fileGrp'][@*[local-name()='USE']='OCR-D-IMG']/*[local-name()='file']/*[local-name()='FLocat']/@*[namespace-uri()='http://www.w3.org/1999/xlink' and local-name()='href']" />
                    <xsl:copy-of select="//*[local-name()='fileGrp']/@*[local-name()!='USE']!='OCR-D-IMG'"/>
                    <xsl:value-of select="$imgURL"/>
                </xsl:for-each>
                
                
                
                <xsl:for-each select="$holeMetric/array/array">
                    
                    <xsl:variable name="Image1" select="substring-before(map/image1, '.')"/>
                    <xsl:variable name="Image2" select="substring-before(map/image2, '.')"/>
                    <xsl:variable name="Image3" select="substring-before(map/image3, '.')"/>
                    
                    <xsl:variable name="Page" select="substring-before(map/page, '.')"/>
                    
                    
                    <xsl:variable name="Image2Path">
                        <xsl:choose>
                            <xsl:when test="contains(map/image2,'..')">
                                <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/>/<xsl:value-of select="tokenize(substring-before(map/image2, tokenize(map/image2,'/')[last()]), '\.\./')[last()]"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/>GT-PAGE/<xsl:value-of select="tokenize(substring-before(map/image2, tokenize(map/image2,'/')[last()]), '\.\./')[last()]"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    
                    
                    
                    
                    
                    <xsl:if test="$Image1 != ''">
                        <xsl:if test="$Image2 = $Page">
                            cd <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/>
                            wget <xsl:value-of select="map/image1"/> -O GT-PAGE/<xsl:value-of select="map/image2"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-IMG -i OCR-D-IMG_<xsl:number format="0001"/> -m image/<xsl:value-of select="substring-after(tokenize(map/image1, '/')[last()], '.')"/><xsl:text>  </xsl:text><xsl:value-of select="$Image2Path"/><xsl:value-of select="tokenize(map/image2,'/')[last()]"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-PAGE -i OCR-D-GT-SEG-PAGE_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-BLOCK -i OCR-D-GT-SEG-BLOCK_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                        </xsl:if>
                    </xsl:if>
                    
                    
                    <xsl:if test="$Image3 != ''">
                        <xsl:if test="$Image2 = $Page">
                            cd <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/>
                            wget <xsl:value-of select="substring-before(map/image3, '&amp;fileType=view')"/> -O GT-PAGE/<xsl:value-of select="map/image2"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-IMG -i OCR-D-IMG_<xsl:number format="0001"/> -m image/<xsl:value-of select="substring-after(tokenize(map/image1, '/')[last()], '.')"/><xsl:text>  </xsl:text><xsl:value-of select="$Image2Path"/><xsl:value-of select="map/image2"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-PAGE -i OCR-D-GT-SEG-PAGE_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-BLOCK -i OCR-D-GT-SEG-BLOCK_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                        </xsl:if>
                    </xsl:if>
                    
                    
                    
                    
                    <xsl:if test="$Image1 = '' and $Image3 = ''">
                        <xsl:if test="$Image2 = $Page">
                            <xsl:variable name="wget_img" select="map/image2"/>
                            cd <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/>
                            <xsl:if test="$wget_img[contains(text(),'http')]">
                                wget <xsl:value-of select="map/image2"/> -O GT-PAGE/<xsl:value-of select="map/image2"/>
                            </xsl:if>
                            
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-IMG -i OCR-D-IMG_<xsl:number format="0001"/> -m image/<xsl:value-of select="substring-after(tokenize(map/image2, '/')[last()], '.')"/><xsl:text>  </xsl:text><xsl:value-of select="$Image2Path"/><xsl:value-of select="tokenize(map/image2,'/')[last()]"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-PAGE -i OCR-D-GT-SEG-PAGE_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                            ocrd workspace add -g P<xsl:number format="0001"/> -G OCR-D-GT-SEG-BLOCK -i OCR-D-GT-SEG-BLOCK_<xsl:number format="0001"/> -m text/xml <xsl:value-of select="substring-after(map/@file, 'file:')"/>
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
            </xsl:if> -\->           
            </xsl:if>

        <xsl:if test="$output = 'DrawImages'">
            
            
            <xsl:message select="$holeMetric"/>
            <!-\- GT Type Control -\->
            <xsl:variable name="gtTypeJson">
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp'] = 'data_structure'">structure_profile.json</xsl:if>
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp'] = 'data_structure_and_text'">structure_text_profile.json</xsl:if>
            </xsl:variable>
            
            
            
            
                <xsl:for-each select="$holeMetric/array/array">
                    
                    
                    <xsl:variable name="Image1" select="substring-before(tokenize(map/image1, '/')[last()], '.')"/>
                    <xsl:variable name="Image2" select="substring-before(tokenize(map/image2, '/')[last()], '.')"/>
                    <xsl:variable name="Image3" select="substring-before(tokenize(map/image3, '/')[last()], '.')"/>
                    
                    <xsl:variable name="Page" select="substring-before(map/page, '.')"/>
                    
                    <xsl:variable name="Image2Path">
                        <xsl:choose>
                            <xsl:when test="contains(map/image2,'..')">
                                <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/><xsl:value-of select="tokenize(substring-before(map/image2, tokenize(map/image2,'/')[last()]), '\.\./')[last()]"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="substring-after(substring-before(map/@file, 'GT-PAGE'), 'file:')"/>GT-PAGE/<xsl:value-of select="tokenize(substring-before(map/image2, tokenize(map/image2,'/')[last()]), '\.\./')[last()]"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    
                    
                    
                    <xsl:if test="$Image1 != ''">
                        <xsl:if test="$Image2 = $Page">
                            
                            page-xml-draw -i <xsl:value-of select="substring-after(map/@file, 'file:')"/> -o <xsl:value-of select="substring-before(substring-after(map/@file, 'file:'), 'data')"/>ghout/drawImg/<xsl:value-of select="substring-before(tokenize(map/image2, '/')[last()], '.')"/>.png -b <xsl:value-of select="$Image2Path"/> -p <xsl:value-of select="substring-before(substring-after(map/@file, 'file:'),'data')"/>scripts/<xsl:value-of select="$gtTypeJson"/>
                            mogrify -resize 50% <xsl:value-of select="substring-before(substring-after(map/@file, 'file:'), 'data')"/>ghout/drawImg/<xsl:value-of select="substring-before(tokenize(map/image2, '/')[last()], '.')"/>.png
                        </xsl:if>
                    </xsl:if>
                    
                    
                    <xsl:if test="$Image3 != ''">
                        <xsl:if test="$Image2 = $Page">
                            
                            page-xml-draw -i <xsl:value-of select="substring-after(map/@file, 'file:')"/> -o <xsl:value-of select="substring-before(substring-after(map/@file, 'file:'), 'data')"/>ghout/drawImg/<xsl:value-of select="substring-before(tokenize(map/image2, '/')[last()], '.')"/>.png -b <xsl:value-of select="$Image2Path"/> -p <xsl:value-of select="substring-before(substring-after(map/@file, 'file:'),'data')"/>scripts/<xsl:value-of select="$gtTypeJson"/>
                            mogrify -resize 50% <xsl:value-of select="substring-before(substring-after(map/@file, 'file:'), 'data')"/>ghout/drawImg/<xsl:value-of select="substring-before(tokenize(map/image2, '/')[last()], '.')"/>.png
                        </xsl:if>
                    </xsl:if>
                    
                    
                    
                    
                    <xsl:if test="$Image1 = '' and $Image3 = ''">
                        <xsl:if test="$Image2 = $Page">
                            
                            page-xml-draw -i <xsl:value-of select="substring-after(map/@file, 'file:')"/> -o <xsl:value-of select="substring-before(substring-after(map/@file, 'file:'), 'data')"/>ghout/drawImg/<xsl:value-of select="substring-before(tokenize(map/image2, '/')[last()], '.')"/>.png -b <xsl:value-of select="$Image2Path"/> -p <xsl:value-of select="substring-before(substring-after(map/@file, 'file:'),'data')"/>scripts/<xsl:value-of select="$gtTypeJson"/>
                            mogrify -resize 50% <xsl:value-of select="substring-before(substring-after(map/@file, 'file:'), 'data')"/>ghout/drawImg/<xsl:value-of select="substring-before(tokenize(map/image2, '/')[last()], '.')"/>.png
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
        </xsl:if>




        <xsl:if test="$output = 'METSMETADATA'">
            <mets:mets
                xsi:schemaLocation="http://www.loc.gov/METS/ http://www.loc.gov/mets/mets.xsd http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-8.xsd"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mets="http://www.loc.gov/METS/"
                xmlns:dv="http://dfg-viewer.de/" xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:mods="http://www.loc.gov/mods/v3">
                <mets:metsHdr>
                    <xsl:attribute name="LASTMODDATE"><xsl:value-of select="$dat"/></xsl:attribute>
                    <mets:agent ROLE="CREATOR" TYPE="ORGANIZATION">
                        <mets:name>ocrd</mets:name>
                    </mets:agent>
                </mets:metsHdr>
                
                <!-\- Bibliographische Beschreibung des gesamten Dokuments (Gesamtaufnahme) -\->
                <mets:dmdSec ID="dmd_000">
                    <mets:mdWrap MDTYPE="MODS">
                        <mets:xmlData>
                            <mods:mods>
                                <mods:typeOfResource>text</mods:typeOfResource>
                                <mods:titleInfo>
                                    <mods:title><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></mods:title>                                    
                                </mods:titleInfo>
                                <mods:language>
                                    <xsl:for-each select="$docMETADATA//fn:array[@key='authors']/fn:map/fn:array[@key='language']/fn:string">
                                        <mods:languageTerm authority="iso639-2b" type="code"><xsl:value-of select="."/></mods:languageTerm>
                                    </xsl:for-each>
                                 </mods:language>
                                
                                <xsl:for-each select="$docMETADATA//fn:array[@key='authors']/fn:map">
                                    <mods:name type="personal">
                                        <mods:displayForm>
                                            <xsl:value-of select="fn:string[@key='name']"/><xsl:text>, </xsl:text><xsl:value-of select="fn:string[@key='surname']"/>
                                        </mods:displayForm>
                                        <xsl:if test="$docMETADATA//fn:array[@key='authors']/fn:map/fn:array[@key='roles'] !=''">
                                            <mods:role>
                                                <xsl:for-each select="$docMETADATA//fn:array[@key='authors']/fn:map/fn:array[@key='roles']/fn:string">
                                                    <mods:roleTerm authority="ocrdrelator" type="code" valueURI="https://raw.githubusercontent.com/tboenig/gt-metadata/master/schema/2022-03-15/schema.json"><xsl:value-of select="."/></mods:roleTerm>
                                                </xsl:for-each>
                                            </mods:role>
                                        </xsl:if>
                                    </mods:name>
                                </xsl:for-each>
                                <mods:originInfo eventType="publication">
                                <mods:dateIssued point="start" keyDate="yes" encoding="iso8601"><xsl:value-of select="$docMETADATA//fn:map[@key='time']/fn:string[@key='notBefore']"/></mods:dateIssued>
                                <mods:dateIssued point="end" keyDate="yes" encoding="iso8601"><xsl:value-of select="$docMETADATA//fn:map[@key='time']/fn:string[@key='notAfter']"/></mods:dateIssued>
                                </mods:originInfo>
                                <mods:genre>Ground Truth</mods:genre>
                                <!-\-<mods:originInfo eventType="publication">
                                    <mods:dateIssued encoding="iso8601" qualifier="approximate">1888</mods:dateIssued>
                                    <mods:displayDate>wahrscheinlich 1888 erstmals erschienen</mods:displayDate>
                                    <mods:place>
                                        <mods:placeTerm type="text">Kuchenberg</mods:placeTerm>
                                    </mods:place>
                                    <mods:publisher>Verlag Küche und Keller</mods:publisher>
                                </mods:originInfo>-\->
                                <mods:originInfo eventType="digitization">
                                    <mods:dateCaptured encoding="iso8601"><xsl:value-of select="format-date(current-date(), '[Y]-[M]-[D]')"/></mods:dateCaptured>
                                </mods:originInfo>
                                <mods:language>
                                    
                                    <xsl:for-each select="$docMETADATA//fn:array[@key='language']/fn:string">
                                        <mods:languageTerm authority="iso639-3" type="code"><xsl:value-of select="."/></mods:languageTerm>
                                    </xsl:for-each>
                                    
                                </mods:language>
                                <mods:recordInfo>
                                    <mods:recordIdentifier>OCR-D_bagitDumpNum-v<xsl:value-of select="$bagitDumpNum"/><xsl:value-of select="generate-id(.)"/></mods:recordIdentifier>
                                </mods:recordInfo>
                            </mods:mods>
                        </mets:xmlData>
                    </mets:mdWrap>
                </mets:dmdSec>
                
                
                
                
                <!-\- Informationen zum Labelling -\->
                <xsl:variable name="cMets">
                    <mets>
                        <xsl:for-each select="collection($conNets)">
                            <xsl:copy-of select="//gt:state"/>
                            <gt:state prop="content-type/corpus"/>
                            <gt:state prop="platform/platform-independent"/>
                            <gt:state prop="content-encoding/structured"/>
                            <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/text"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/ocr"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/tables"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key1] !='0'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/layoutAnalysis"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="contentOfInterest/visual/text"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key4] !='0'"><gt:state prop="contentOfInterest/visual/graphical"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key7] !='0'"><gt:state prop="contentOfInterest/visual/graphical/separator"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key2] !='0'"><gt:state prop="contentOfInterest/visual/image"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key3] !='0'"><gt:state prop="contentOfInterest/visual/image/drawing"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><gt:state prop="contentOfInterest/visual/composite/tables"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key18] !='0'"><gt:state prop="contentOfInterest/visual/composite/maps"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key6] !='0'"><gt:state prop="contentOfInterest/visual/composite/charts"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key8] !='0'"><gt:state prop="contentOfInterest/visual/composite/maths"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key9] !='0'"><gt:state prop="contentOfInterest/visual/composite/chem"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key10] !='0'"><gt:state prop="contentOfInterest/visual/composite/music"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key16] !='0'"><gt:state prop="granularity/physical/document-related/page"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key15] !='0'"><gt:state prop="granularity/physical/document-related/text-line"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key20] !='0'"><gt:state prop="granularity/physical/document-related/word"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key21] ='true'"><gt:state prop="granularity/logical/document-related/paragraph"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key22] ='true'"><gt:state prop="data-attributes/document-related/structural/footnotes"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key23] ='true'"><gt:state prop="data-attributes/document-related/structural/footnote-continued"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key24] ='true'"><gt:state prop="data-attributes/document-related/structural/endnote"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key25] ='true'"><gt:state prop="data-attributes/document-related/structural/running-titles"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key26] ='true'"><gt:state prop="data-attributes/document-related/visual/decorations"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key27] ='true'"><gt:state prop="condition/wear/additions/informative/stamps"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key28] ='true'"><gt:state prop="data-attributes/document-related/visual/text/drop-caps"/></xsl:if>
                            <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Goth'"><gt:state prop="data-attributes/document-related/visual/text/font/typeface/blackletter"/></xsl:if>
                            <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Latn'"><gt:state prop="data-attributes/document-related/visual/text/font/typeface/antiqua"/></xsl:if>
                            
                            
                            
                            
                            
                            <!-\- granularity/logical/table
                                    granularity/logical/table/column
                                    granularity/logical/table/row
                                    granularity/logical/table/cell-\->
                            
                            
                        </xsl:for-each>
                    </mets>
                </xsl:variable>
                
                <xsl:variable name="dMetslabel">
                    <xsl:for-each select="distinct-values($cMets/mets/gt:state/@prop)">
                        <gt:state>
                            <xsl:attribute name="prop"><xsl:value-of select="."/></xsl:attribute>
                        </gt:state>
                    </xsl:for-each>
                </xsl:variable>
                
                <!-\- automatic labeling -\->
                
                
                
                
                <!-\- Informationen zum Labelling gesamte Sammlung-\->
                <mets:dmdSec>
                    
                    <xsl:attribute name="ID">dmgt_0000</xsl:attribute>
                    <mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="GT">
                        <mets:xmlData>
                            <gt:gt xmlns:gt="http://www.ocr-d.de/GT/">
                                <xsl:copy-of select="$dMetslabel"/>
                            </gt:gt>
                        </mets:xmlData>
                    </mets:mdWrap>
                </mets:dmdSec>
                
                
                
                
                
                <xsl:for-each select="distinct-values($holeMetric//@key1)">
                    <xsl:variable name="filenum" select="position()"/>
                    
                    <!-\- Informationen zum Labelling einzelne Dokumente-\->
                    <mets:dmdSec>
                        <xsl:attribute name="ID">dmgt_<xsl:value-of select="format-number($filenum,'0000')"/></xsl:attribute>
                        
                        <!-\-<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="GT">
                            <mets:xmlData>
                                <gt:gt xmlns:gt="http://www.ocr-d.de/GT/">
                                    <xsl:for-each select="distinct-values($cMets//doc[fn:position() = $filenum]/gt:state/@prop)">
                                        <gt:state>
                                            <xsl:attribute name="prop"><xsl:value-of select="."/></xsl:attribute>
                                        </gt:state>
                                    </xsl:for-each>
                                </gt:gt>
                            </mets:xmlData>
                        </mets:mdWrap>-\->
                    </mets:dmdSec>
                </xsl:for-each>
                
                <mets:amdSec ID="amd_01">
                    <!-\- Informationen zu Rechten am Digitalisat -\->
                    <mets:rightsMD ID="rights_01">
                        <mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="DVRIGHTS">
                            <mets:xmlData>
                                <dv:rights xmlns:dv="http://dfg-viewer.de/">
                                    <dv:license><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='url']"/></dv:license>
                                </dv:rights>
                            </mets:xmlData>
                        </mets:mdWrap>
                    </mets:rightsMD>
                    
                    
                    
                    <!-\- Links zu weiteren Repräsentationen der Daten -\->
                    <mets:digiprovMD ID="digiprov_01">
                        <mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="DVLINKS">
                            <mets:xmlData>
                                <dv:links xmlns:dv="http://dfg-viewer.de/">
                                    <dv:presentation>https://<xsl:value-of select="fn:tokenize($repoName, '/')[1]"/>.github.io/<xsl:value-of select="fn:tokenize($repoName, '/')[2]"/></dv:presentation>
                                </dv:links>
                            </mets:xmlData>
                        </mets:mdWrap>
                    </mets:digiprovMD>
                </mets:amdSec>
                
                
                
                <!-\- Die hierarchische Struktur des Mehrteiligen Dokuments -\->
                <!-\-<mets:structMap TYPE="LOGICAL">
                    <mets:div ADMID="amd_01" DMDID="dmd_000" ID="LOG_00" TYPE="multivolume work">
                        <xsl:attribute name="LABEL"><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></xsl:attribute>
                        <mets:div DMDID="dmgt_0000" ID="LOG_001" TYPE="volume">
                            <xsl:attribute name="LABEL">Collection: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></xsl:attribute>
                            <xsl:for-each select="distinct-values($holeMetric//@key1)">
                                <xsl:variable name="filenum" select="position()"/>
                                <mets:div TYPE="volume">
                                    <xsl:attribute name="LABEL">Volume: <xsl:value-of select="."/></xsl:attribute>
                                    <xsl:attribute name="ID">LOG_<xsl:value-of select="format-number($filenum,'0000')"/></xsl:attribute>
                                    <xsl:attribute name="DMID">dmgt_<xsl:value-of select="format-number($filenum,'0000')"/></xsl:attribute>
                                    <xsl:attribute name="ORDER"><xsl:value-of select="$filenum"/></xsl:attribute>
                                    <xsl:attribute name="ORDERLABEL">vol. <xsl:value-of select="$filenum"/></xsl:attribute>
                                    
                                    <mets:mptr LOCTYPE="URL">
                                        <xsl:attribute name="xlink:href"><xsl:value-of select="."/>.ocrd/data/mets.xml</xsl:attribute>
                                    </mets:mptr>
                                </mets:div>
                            </xsl:for-each>
                        </mets:div>
                    </mets:div>
                </mets:structMap>-\->
                
                <xsl:variable name="t1"><xsl:copy-of select="."/></xsl:variable>
                <mets:structMap TYPE="PHYSICAL">
                    <mets:div TYPE="physSequence">
                        <xsl:attribute name="ID">physroot</xsl:attribute>
                        <xsl:attribute name="DMDID">dmgt_0000</xsl:attribute>
                        <xsl:for-each select="$t1//mets:structMap[@TYPE='PHYSICAL']/mets:div[@TYPE='physSequence']/mets:div[@TYPE='page']">
                            <mets:div TYPE="page">
                                
                                <xsl:attribute name="ORDER" select="@ORDER"/>
                                <xsl:attribute name="ID" select="@ID"/>
                                <xsl:attribute name="DMDID" select="@DMDID"/>
                                <xsl:for-each select="mets:fptr">
                                    <xsl:choose>
                                        <xsl:when test="fn:matches(./@FILEID, 'DEFAULT[_0-9A-Z]+')"/>
                                        <xsl:otherwise><mets:fptr>
                                            <xsl:attribute name="FILEID" select="@FILEID"/>
                                        </mets:fptr></xsl:otherwise>
                                    </xsl:choose>
                                    
                                    
                                    
                                </xsl:for-each>
                            </mets:div>
                        </xsl:for-each>
                    </mets:div>
                </mets:structMap>
                
                
            </mets:mets>
           
        </xsl:if>




        <xsl:if test="$output = 'METAJSON'">
            
            
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
            
            
            
            
            
            <xsl:variable name="metaj">
                <xsl:element name="fn:map">
                    
                <xsl:copy-of select="$docMETADATA/fn:map/*"/>
                
                
                <!-\- volume -\->
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_structure_and_text'">
                    <xsl:element name="fn:map">
                        <xsl:attribute name="key">volume</xsl:attribute>
                                <xsl:if test="$k1 > 0">
                                    <fn:string key="TxtRegion"><xsl:value-of select="$k1"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k2 > 0">
                                    <fn:string key="ImgRegion"><xsl:value-of select="$k2"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k3 > 0">
                                    <fn:string key="LineDrawRegion"><xsl:value-of select="$k3"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k4 > 0">
                                    <fn:string key="GraphRegion"><xsl:value-of select="$k4"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k5 > 0">
                                    <fn:string key="TabRegion"><xsl:value-of select="$k5"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k6 > 0">
                                    <fn:string key="ChartRegion"><xsl:value-of select="$k6"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k7 > 0">
                                    <fn:string key="SepRegion"><xsl:value-of select="$k7"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k8 > 0">
                                    <fn:string key="MathRegion"><xsl:value-of select="$k8"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k9 > 0">
                                    <fn:string key="ChemRegion"><xsl:value-of select="$k9"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k10 > 0">
                                    <fn:string key="MusicRegion"><xsl:value-of select="$k10"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k11 > 0">
                                    <fn:string key="AdRegion"><xsl:value-of select="$k11"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k12 > 0">
                                    <fn:string key="NoiseRegion"><xsl:value-of select="$k12"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k13 > 0">
                                    <fn:string key="UnkownRegion"><xsl:value-of select="$k13"/></fn:string>
                                </xsl:if>
                                
                                <xsl:if test="$k14 > 0">
                                    <fn:string key="CustomRegion"><xsl:value-of select="$k14"/></fn:string>
                                </xsl:if>
                        
                                <xsl:if test="$k15 > 0">
                                    <fn:string key="TextLine"><xsl:value-of select="$k15"/></fn:string>
                                </xsl:if>
                        
                                <xsl:if test="$k16 > 0">
                                    <fn:string key="Page"><xsl:value-of select="$k16"/></fn:string>
                                </xsl:if>
                                
                            </xsl:element>
                </xsl:if>
                
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_structure'">
                    <xsl:element name="fn:map">
                        <xsl:attribute name="key">volume</xsl:attribute>
                        <xsl:if test="$k1 > 0">
                            <fn:string key="TxtRegion"><xsl:value-of select="$k1"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k2 > 0">
                            <fn:string key="ImgRegion"><xsl:value-of select="$k2"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k3 > 0">
                            <fn:string key="LineDrawRegion"><xsl:value-of select="$k3"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k4 > 0">
                            <fn:string key="GraphRegion"><xsl:value-of select="$k4"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k5 > 0">
                            <fn:string key="TabRegion"><xsl:value-of select="$k5"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k6 > 0">
                            <fn:string key="ChartRegion"><xsl:value-of select="$k6"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k7 > 0">
                            <fn:string key="SepRegion"><xsl:value-of select="$k7"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k8 > 0">
                            <fn:string key="MathRegion"><xsl:value-of select="$k8"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k9 > 0">
                            <fn:string key="ChemRegion"><xsl:value-of select="$k9"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k10 > 0">
                            <fn:string key="MusicRegion"><xsl:value-of select="$k10"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k11 > 0">
                            <fn:string key="AdRegion"><xsl:value-of select="$k11"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k12 > 0">
                            <fn:string key="NoiseRegion"><xsl:value-of select="$k12"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k13 > 0">
                            <fn:string key="UnkownRegion"><xsl:value-of select="$k13"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k14 > 0">
                            <fn:string key="CustomRegion"><xsl:value-of select="$k14"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k15 > 0">
                            <fn:string key="TextLine"><xsl:value-of select="$k15"/></fn:string>
                        </xsl:if>
                        
                        <xsl:if test="$k16 > 0">
                            <fn:string key="Page"><xsl:value-of select="$k16"/></fn:string>
                        </xsl:if>
                    </xsl:element>
                </xsl:if>
            
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_line'">
                <xsl:element name="fn:map">
                    <xsl:attribute name="key">volume</xsl:attribute>
                
                    <xsl:if test="$k1 > 0">
                        <fn:string key="TxtRegion"><xsl:value-of select="$k1"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k2 > 0">
                        <fn:string key="ImgRegion"><xsl:value-of select="$k2"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k3 > 0">
                        <fn:string key="LineDrawRegion"><xsl:value-of select="$k3"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k4 > 0">
                        <fn:string key="GraphRegion"><xsl:value-of select="$k4"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k5 > 0">
                        <fn:string key="TabRegion"><xsl:value-of select="$k5"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k6 > 0">
                        <fn:string key="ChartRegion"><xsl:value-of select="$k6"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k7 > 0">
                        <fn:string key="SepRegion"><xsl:value-of select="$k7"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k8 > 0">
                        <fn:string key="MathRegion"><xsl:value-of select="$k8"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k9 > 0">
                        <fn:string key="ChemRegion"><xsl:value-of select="$k9"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k10 > 0">
                        <fn:string key="MusicRegion"><xsl:value-of select="$k10"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k11 > 0">
                        <fn:string key="AdRegion"><xsl:value-of select="$k11"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k12 > 0">
                        <fn:string key="NoiseRegion"><xsl:value-of select="$k12"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k13 > 0">
                        <fn:string key="UnkownRegion"><xsl:value-of select="$k13"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k14 > 0">
                        <fn:string key="CustomRegion"><xsl:value-of select="$k14"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k15 > 0">
                        <fn:string key="TextLine"><xsl:value-of select="$k15"/></fn:string>
                    </xsl:if>
                    
                    <xsl:if test="$k16 > 0">
                        <fn:string key="Page"><xsl:value-of select="$k16"/></fn:string>
                    </xsl:if>
                </xsl:element>
            </xsl:if>
                
                <!-\- Labelling -\->
                    
                    <!-\- 
                     <array xmlns="http://www.w3.org/2005/xpath-functions" key="language">
                        <string>lat</string>
                        <string>deu</string>
                     </array>
                    -\->
                    
                    <xsl:variable name="CconMets">
                        <xsl:for-each select="collection($conMets)"><xsl:value-of select="."/></xsl:for-each>
                    </xsl:variable>
                    
                    
                    <xsl:variable name="cMets">
                        <fn:array>
                            <xsl:attribute name="key">labelling</xsl:attribute>
                             <xsl:if test="$CconMets !=''">
                                 <xsl:for-each select="collection($conMets)">
                                     <xsl:variable name="labels"><xsl:copy-of select="//gt:state"/></xsl:variable>
                                     <xsl:for-each select="$labels//@prop">
                                         <fn:string><xsl:value-of select="."/></fn:string>
                                     </xsl:for-each>
                                     <fn:string>content-type/corpus</fn:string>
                                     <fn:string>platform/platform-independent</fn:string>
                                     <fn:string>content-encoding/structured</fn:string>
                                     <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><fn:string>activityDomain/computing/visual/analysisRecognition/text</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><fn:string>activityDomain/computing/visual/analysisRecognition/ocr</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><fn:string>activityDomain/computing/visual/analysisRecognition/tables</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key1] !='0'"><fn:string>activityDomain/computing/visual/analysisRecognition/layoutAnalysis</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><fn:string>contentOfInterest/visual/text</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key4] !='0'"><fn:string>contentOfInterest/visual/graphical</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key7] !='0'"><fn:string>contentOfInterest/visual/graphical/separator</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key2] !='0'"><fn:string>contentOfInterest/visual/image</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key3] !='0'"><fn:string>contentOfInterest/visual/image/drawing</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><fn:string>contentOfInterest/visual/composite/tables</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key18] !='0'"><fn:string>contentOfInterest/visual/composite/maps</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key6] !='0'"><fn:string>contentOfInterest/visual/composite/charts</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key8] !='0'"><fn:string>contentOfInterest/visual/composite/maths</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key9] !='0'"><fn:string>contentOfInterest/visual/composite/chem</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key10] !='0'"><fn:string>contentOfInterest/visual/composite/music</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key16] !='0'"><fn:string>granularity/physical/document-related/page</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key15] !='0'"><fn:string>granularity/physical/document-related/text-line</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key20] !='0'"><fn:string>granularity/physical/document-related/word</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key21] ='true'"><fn:string>granularity/logical/document-related/paragraph</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key22] ='true'"><fn:string>data-attributes/document-related/structural/footnotes</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key23] ='true'"><fn:string>data-attributes/document-related/structural/footnote-continued</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key24] ='true'"><fn:string>data-attributes/document-related/structural/endnote</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key25] ='true'"><fn:string>data-attributes/document-related/structural/running-titles</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key26] ='true'"><fn:string>data-attributes/document-related/visual/decorations</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key27] ='true'"><fn:string>condition/wear/additions/informative/stamps</fn:string></xsl:if>
                                     <xsl:if test="$holeMetric//string[@key=$key28] ='true'"><fn:string>data-attributes/document-related/visual/text/drop-caps</fn:string></xsl:if>
                                     <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Goth'"><fn:string>data-attributes/document-related/visual/text/font/typeface/blackletter</fn:string></xsl:if>
                                     <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Latn'"><fn:string>data-attributes/document-related/visual/text/font/typeface/antiqua</fn:string></xsl:if>
                                  </xsl:for-each>
                                 
                                 
                                 
                             </xsl:if>
                                
                            <xsl:if test="$CconMets =''">
                                <fn:string>content-type/corpus</fn:string>
                                <fn:string>platform/platform-independent</fn:string>
                                <fn:string>content-encoding/structured</fn:string>
                                <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><fn:string>activityDomain/computing/visual/analysisRecognition/text</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><fn:string>activityDomain/computing/visual/analysisRecognition/ocr</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><fn:string>activityDomain/computing/visual/analysisRecognition/tables</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key1] !='0'"><fn:string>activityDomain/computing/visual/analysisRecognition/layoutAnalysis</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><fn:string>contentOfInterest/visual/text</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key4] !='0'"><fn:string>contentOfInterest/visual/graphical</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key7] !='0'"><fn:string>contentOfInterest/visual/graphical/separator</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key2] !='0'"><fn:string>contentOfInterest/visual/image</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key3] !='0'"><fn:string>contentOfInterest/visual/image/drawing</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><fn:string>contentOfInterest/visual/composite/tables</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key18] !='0'"><fn:string>contentOfInterest/visual/composite/maps</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key6] !='0'"><fn:string>contentOfInterest/visual/composite/charts</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key8] !='0'"><fn:string>contentOfInterest/visual/composite/maths</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key9] !='0'"><fn:string>contentOfInterest/visual/composite/chem</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key10] !='0'"><fn:string>contentOfInterest/visual/composite/music</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key16] !='0'"><fn:string>granularity/physical/document-related/page</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key15] !='0'"><fn:string>granularity/physical/document-related/text-line</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key20] !='0'"><fn:string>granularity/physical/document-related/word</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key21] ='true'"><fn:string>granularity/logical/document-related/paragraph</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key22] ='true'"><fn:string>data-attributes/document-related/structural/footnotes</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key23] ='true'"><fn:string>data-attributes/document-related/structural/footnote-continued</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key24] ='true'"><fn:string>data-attributes/document-related/structural/endnote</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key25] ='true'"><fn:string>data-attributes/document-related/structural/running-titles</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key26] ='true'"><fn:string>data-attributes/document-related/visual/decorations</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key27] ='true'"><fn:string>condition/wear/additions/informative/stamps</fn:string></xsl:if>
                                <xsl:if test="$holeMetric//string[@key=$key28] ='true'"><fn:string>data-attributes/document-related/visual/text/drop-caps</fn:string></xsl:if>
                                <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Goth'"><fn:string>data-attributes/document-related/visual/text/font/typeface/blackletter</fn:string></xsl:if>
                                <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Latn'"><fn:string>data-attributes/document-related/visual/text/font/typeface/antiqua</fn:string></xsl:if>
                         </xsl:if>
                        </fn:array>
                    </xsl:variable>
                    
                    <!-\- json labelling output -\->
                    <fn:array>
                       <xsl:attribute name="key">labelling</xsl:attribute>
                        <xsl:for-each select="distinct-values($cMets//fn:array/fn:string)">
                          <fn:string><xsl:value-of select="."/></fn:string>
                        </xsl:for-each>
                    </fn:array>
                </xsl:element>
          </xsl:variable>
            
            <xsl:copy-of select="xml-to-json($metaj)"/>
            <!-\-<xsl:copy-of select="$metaj"/>-\->
        </xsl:if>



        <xsl:if test="$output = 'README'">
            <xsl:element name="div">
        <h1 id="title"><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></h1>
        
         <p id="paragraph"><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/></p>
            
            <h2>Metadata</h2>
                
            <dl class="grid">
                <dt id="Language">Language:</dt><dd><xsl:value-of separator=", " select="$docMETADATA//fn:map/fn:array[@key='language']/fn:string"/></dd>
                <dt id="Format">Format:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/></dd>
                <dt id="Time">Time:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notBefore']"/>-<xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notAfter']"/></dd>
                <dt id="GTT">GT Type:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='gtTyp']"/></dd>
                <dt id="License">License:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name']"/></dd>
                
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines'] !=''">
                    <dt id="Guidelines">Transcription Guidelines:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines']"/></dd>
                </xsl:if>
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='project-name'] !=''">
                    <dt id="Project">Project:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-name']"/></dd>
                </xsl:if>
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='project-website'] !=''">
                    <dt id="Project-URL">Project-URL:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-website']"/></dd>
                </xsl:if>
            </dl>
        
        
        <h2>Sources</h2>
            <h3>The volume of transcriptions:</h3>
        
            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_structure_and_text'">
                    
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
                    
                    
                    
                    <xsl:element name="table">
                        <xsl:attribute name="id">table_id</xsl:attribute>
                        <xsl:element name="thead">
                            <xsl:element name="tr">
                                <xsl:copy-of select="$tableHeader//thead/tr/th[position()>15]"/>
                                <xsl:if test="$k1 > 0">
                                    <th>TxtRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k2 > 0">
                                    <th>ImgRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k3 > 0">
                                    <th>LineDrawRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k4 > 0">
                                    <th>GraphRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k5 > 0">
                                    <th>TabRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k6 > 0">
                                    <th>ChartRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k7 > 0">
                                    <th>SepRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k8 > 0">
                                    <th>MathRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k9 > 0">
                                    <th>ChemRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k10 > 0">
                                    <th>MusicRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k11 > 0">
                                    <th>AdRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k12 > 0">
                                    <th>NoiseRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k13 > 0">
                                    <th>UnkownRegion</th>
                                </xsl:if>
                                
                                <xsl:if test="$k14 > 0">
                                    <th>CustomRegion</th>
                                </xsl:if>
                                
                            </xsl:element>
                        </xsl:element>
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
        
        
        
            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_structure'">
            <xsl:element name="table">
                <xsl:attribute name="id">table_id</xsl:attribute>
                <xsl:element name="thead">
                    <xsl:element name="tr">
                        <xsl:copy-of select="$tableHeader//thead/tr/th[position()>1]"/>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="tbody">
                    
                    
                    <xsl:element name="tr">
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key1])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key2])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key3])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key4])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key5])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key6])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key7])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key8])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key9])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key10])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key11])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key12])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key13])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key14])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key15])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key16])"/>
                            </xsl:for-each>
                        </xsl:element>
                        
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            </xsl:if>
        
        
            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_line'">
                
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
                
                
                
            <xsl:element name="table">
                <xsl:attribute name="id">table_id</xsl:attribute>
                <xsl:element name="thead">
                    <xsl:element name="tr">
                        <xsl:copy-of select="$tableHeader//thead/tr/th[position()>15]"/>
                        <xsl:if test="$k1 > 0">
                            <th>TxtRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k2 > 0">
                            <th>ImgRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k3 > 0">
                            <th>LineDrawRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k4 > 0">
                            <th>GraphRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k5 > 0">
                            <th>TabRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k6 > 0">
                            <th>ChartRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k7 > 0">
                            <th>SepRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k8 > 0">
                            <th>MathRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k9 > 0">
                            <th>ChemRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k10 > 0">
                            <th>MusicRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k11 > 0">
                            <th>AdRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k12 > 0">
                            <th>NoiseRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k13 > 0">
                            <th>UnkownRegion</th>
                        </xsl:if>
                        
                        <xsl:if test="$k14 > 0">
                            <th>CustomRegion</th>
                        </xsl:if>
                        
                    </xsl:element>
                </xsl:element>
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
        
        
        
        
               
            <xsl:element name="div">
                <xsl:attribute name="id">transcriptions</xsl:attribute>
                    <h3>List of transcriptions</h3>
                    
                    <div>
                      <table id="table_id" class="display">
                            
                            <xsl:copy-of select="$tableHeader"/>
                            
                            <tbody> 
                                <xsl:for-each-group select="$holeMetric//*" group-by="@key1">
                                    
                                    <!-\-<xsl:variable name="content"><list><xsl:copy-of select="current-group()"/></list></xsl:variable>-\->
                                    
                                    <tr>
                                        <td><xsl:value-of select="current-grouping-key()"/></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key1]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key1])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key2]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key2])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key3]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key3])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key4]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key4])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key5]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key5])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key6]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key6])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key7]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key7])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key8]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key8])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key9]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key9])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key10]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key10])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key11]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key11])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key12]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key12])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key13]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key13])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key14]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key14])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key15]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key15])"/></xsl:if></td>
                                        <td><xsl:if test="sum(current-group()//*[@key=$key16]) >0"><xsl:value-of select="sum(current-group()//*[@key=$key16])"/></xsl:if></td>
                                        
                                    </tr>
                                    
                                </xsl:for-each-group>
                            </tbody>       
                        </table>
                    </div>
                </xsl:element>
            
        
                
                <xsl:choose>
                <xsl:when test="$READSME//div[@id='extent']">
                    <xsl:copy-of select="$READSME//div[@id='extent']"/>
            </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="div">
                            <xsl:attribute name="id">extent</xsl:attribute>
                            <xsl:element name="h2">Extent</xsl:element>
                            
                            <xsl:element name="p">
                                In this section they can insert additional information, instructions or notes.
                            </xsl:element>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
        
        
        
        
            </xsl:element>
        </xsl:if>
        
    
        <xsl:if test="$output = 'METSvolume'">
            
            <mets:mets
                xsi:schemaLocation="http://www.loc.gov/METS/ http://www.loc.gov/mets/mets.xsd http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-8.xsd"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mets="http://www.loc.gov/METS/"
                xmlns:dv="http://dfg-viewer.de/" xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:mods="http://www.loc.gov/mods/v3">
                <mets:metsHdr>
                    <xsl:attribute name="LASTMODDATE"><xsl:value-of select="$dat"/></xsl:attribute>
                    <mets:agent ROLE="CREATOR" TYPE="ORGANIZATION">
                        <mets:name>ocrd</mets:name>
                    </mets:agent>
                </mets:metsHdr>
                
                <!-\- Bibliographische Beschreibung des gesamten Dokuments (Gesamtaufnahme) -\->
                <mets:dmdSec ID="dmd_000">
                    <mets:mdWrap MDTYPE="MODS">
                        <mets:xmlData>
                            <mods:mods>
                                <mods:typeOfResource>text</mods:typeOfResource>
                                <mods:titleInfo>
                                    <mods:title><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></mods:title>
                                    
                                </mods:titleInfo>
                                <xsl:for-each select="$docMETADATA//fn:array[@key='authors']/fn:map">
                                    <mods:name type="personal">
                                        <mods:displayForm>
                                            <xsl:value-of select="fn:string[@key='name']"/><xsl:text>, </xsl:text><xsl:value-of select="fn:string[@key='surname']"/>
                                        </mods:displayForm>
                                        <xsl:if test="$docMETADATA//fn:array[@key='authors']/fn:map/fn:array[@key='roles'] !=''">
                                        <mods:role>
                                            <xsl:for-each select="$docMETADATA//fn:array[@key='authors']/fn:map/fn:array[@key='roles']/fn:string">
                                                <mods:roleTerm authority="ocrdrelator" type="code" valueURI="https://raw.githubusercontent.com/tboenig/gt-metadata/master/schema/2022-03-15/schema.json"><xsl:value-of select="."/></mods:roleTerm>
                                            </xsl:for-each>
                                        </mods:role>
                                        </xsl:if>
                                    </mods:name>
                                </xsl:for-each>
                                <mods:originInfo eventType="publication">
                                <mods:dateIssued point="start" keyDate="yes" encoding="iso8601"><xsl:value-of select="$docMETADATA//fn:map[@key='time']/fn:string[@key='notBefore']"/></mods:dateIssued>
                                <mods:dateIssued point="end" keyDate="yes" encoding="iso8601"><xsl:value-of select="$docMETADATA//fn:map[@key='time']/fn:string[@key='notAfter']"/></mods:dateIssued>
                                </mods:originInfo>
                                <mods:genre>Ground Truth</mods:genre>
                                <!-\-<mods:originInfo eventType="publication">
                                    <mods:dateIssued encoding="iso8601" qualifier="approximate">1888</mods:dateIssued>
                                    <mods:displayDate>wahrscheinlich 1888 erstmals erschienen</mods:displayDate>
                                    <mods:place>
                                        <mods:placeTerm type="text">Kuchenberg</mods:placeTerm>
                                    </mods:place>
                                    <mods:publisher>Verlag Küche und Keller</mods:publisher>
                                </mods:originInfo>-\->
                                <mods:originInfo eventType="digitization">
                                    <mods:dateCaptured encoding="iso8601"><xsl:value-of select="format-date(current-date(), '[Y]-[M]-[D]')"/></mods:dateCaptured>
                                </mods:originInfo>
                                <mods:language>
                                    
                                    <xsl:for-each select="$docMETADATA//fn:array[@key='language']/fn:string">
                                            <mods:languageTerm authority="iso639-3" type="code"><xsl:value-of select="."/></mods:languageTerm>
                                    </xsl:for-each>
                                        
                                </mods:language>
                                <mods:recordInfo>
                                    <mods:recordIdentifier>OCR-D_bagitDumpNum-v<xsl:value-of select="$bagitDumpNum"/><xsl:value-of select="generate-id(.)"/></mods:recordIdentifier>
                                </mods:recordInfo>
                            </mods:mods>
                        </mets:xmlData>
                    </mets:mdWrap>
                </mets:dmdSec>
                
                
                <!-\- Informationen zum Labelling -\->
                <xsl:variable name="cMets">
                    <mets>
                        <xsl:for-each select="collection($conMets)">
                            <xsl:copy-of select="//gt:state"/>
                            <gt:state prop="content-type/corpus"/>
                            <gt:state prop="platform/platform-independent"/>
                            <gt:state prop="content-encoding/structured"/>
                            <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/text"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/ocr"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/tables"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key1] !='0'"><gt:state prop="activityDomain/computing/visual/analysisRecognition/layoutAnalysis"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key17] ='true'"><gt:state prop="contentOfInterest/visual/text"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key4] !='0'"><gt:state prop="contentOfInterest/visual/graphical"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key7] !='0'"><gt:state prop="contentOfInterest/visual/graphical/separator"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key2] !='0'"><gt:state prop="contentOfInterest/visual/image"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key3] !='0'"><gt:state prop="contentOfInterest/visual/image/drawing"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key5] !='0'"><gt:state prop="contentOfInterest/visual/composite/tables"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key18] !='0'"><gt:state prop="contentOfInterest/visual/composite/maps"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key6] !='0'"><gt:state prop="contentOfInterest/visual/composite/charts"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key8] !='0'"><gt:state prop="contentOfInterest/visual/composite/maths"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key9] !='0'"><gt:state prop="contentOfInterest/visual/composite/chem"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key10] !='0'"><gt:state prop="contentOfInterest/visual/composite/music"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key16] !='0'"><gt:state prop="granularity/physical/document-related/page"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key15] !='0'"><gt:state prop="granularity/physical/document-related/text-line"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key20] !='0'"><gt:state prop="granularity/physical/document-related/word"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key21] ='true'"><gt:state prop="granularity/logical/document-related/paragraph"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key22] ='true'"><gt:state prop="data-attributes/document-related/structural/footnotes"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key23] ='true'"><gt:state prop="data-attributes/document-related/structural/footnote-continued"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key24] ='true'"><gt:state prop="data-attributes/document-related/structural/endnote"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key25] ='true'"><gt:state prop="data-attributes/document-related/structural/running-titles"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key26] ='true'"><gt:state prop="data-attributes/document-related/visual/decorations"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key27] ='true'"><gt:state prop="condition/wear/additions/informative/stamps"/></xsl:if>
                            <xsl:if test="$holeMetric//string[@key=$key28] ='true'"><gt:state prop="data-attributes/document-related/visual/text/drop-caps"/></xsl:if>
                            <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Goth'"><gt:state prop="data-attributes/document-related/visual/text/font/typeface/blackletter"/></xsl:if>
                            <xsl:if test="$docMETADATA//fn:map/fn:array[@key='script']/fn:string ='Latn'"><gt:state prop="data-attributes/document-related/visual/text/font/typeface/antiqua"/></xsl:if>
                            
                            
                            
                            
                            
                            <!-\- granularity/logical/table
                                    granularity/logical/table/column
                                    granularity/logical/table/row
                                    granularity/logical/table/cell-\->
                            
                            
                        </xsl:for-each>
                    </mets>
                </xsl:variable>
                
                <xsl:variable name="dMetslabel">
                    <xsl:for-each select="distinct-values($cMets/mets/gt:state/@prop)">
                    <gt:state>
                        <xsl:attribute name="prop"><xsl:value-of select="."/></xsl:attribute>
                    </gt:state>
                </xsl:for-each>
                </xsl:variable>
                
                <!-\- automatic labeling -\->
                



                <!-\- Informationen zum Labelling gesamte Sammlung-\->
                <mets:dmdSec>
                    
                    <xsl:attribute name="ID">dmgt_0000</xsl:attribute>
                    <mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="GT">
                        <mets:xmlData>
                            <gt:gt xmlns:gt="http://www.ocr-d.de/GT/">
                                <xsl:copy-of select="$dMetslabel"/>
                            </gt:gt>
                        </mets:xmlData>
                    </mets:mdWrap>
                </mets:dmdSec>
                
                
                
                
                
                <xsl:for-each select="distinct-values($holeMetric//@key1)">
                    <xsl:variable name="filenum" select="position()"/>
                    
                    <!-\- Informationen zum Labelling einzelne Dokumente-\->
                    <mets:dmdSec>
                        <xsl:attribute name="ID">dmgt_<xsl:value-of select="format-number($filenum,'0000')"/></xsl:attribute>
                        
                      <mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="GT">
                        <mets:xmlData>
                            <gt:gt xmlns:gt="http://www.ocr-d.de/GT/">
                                <xsl:for-each select="distinct-values($cMets//doc[fn:position() = $filenum]/gt:state/@prop)">
                                    <gt:state>
                                        <xsl:attribute name="prop"><xsl:value-of select="."/></xsl:attribute>
                                    </gt:state>
                                </xsl:for-each>
                            </gt:gt>
                        </mets:xmlData>
                    </mets:mdWrap>
                </mets:dmdSec>
                </xsl:for-each>
                
                <mets:amdSec ID="amd_01">
                    <!-\- Informationen zu Rechten am Digitalisat -\->
                    <mets:rightsMD ID="rights_01">
                        <mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="DVRIGHTS">
                            <mets:xmlData>
                                <dv:rights xmlns:dv="http://dfg-viewer.de/">
                                    <dv:license><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='url']"/></dv:license>
                                </dv:rights>
                            </mets:xmlData>
                        </mets:mdWrap>
                    </mets:rightsMD>
                    
                    
                    
                    <!-\- Links zu weiteren Repräsentationen der Daten -\->
                    <mets:digiprovMD ID="digiprov_01">
                        <mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="DVLINKS">
                            <mets:xmlData>
                                <dv:links xmlns:dv="http://dfg-viewer.de/">
                                    <dv:presentation>https://<xsl:value-of select="fn:tokenize($repoName, '/')[1]"/>.github.io/<xsl:value-of select="fn:tokenize($repoName, '/')[2]"/></dv:presentation>
                                </dv:links>
                            </mets:xmlData>
                        </mets:mdWrap>
                    </mets:digiprovMD>
                </mets:amdSec>
                
                
                
                <!-\- Die hierarchische Struktur des Mehrteiligen Dokuments -\->
                <mets:structMap TYPE="LOGICAL">
                    <mets:div ADMID="amd_01" DMDID="dmd_000" ID="LOG_00" TYPE="multivolume work">
                        <xsl:attribute name="LABEL"><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></xsl:attribute>
                        <mets:div DMDID="dmgt_0000" ID="LOG_001" TYPE="volume">
                            <xsl:attribute name="LABEL">Collection: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></xsl:attribute>
                        <xsl:for-each select="distinct-values($holeMetric//@key1)">
                            <xsl:variable name="filenum" select="position()"/>
                            <mets:div TYPE="volume">
                                <xsl:attribute name="LABEL">Volume: <xsl:value-of select="."/></xsl:attribute>
                                <xsl:attribute name="ID">LOG_<xsl:value-of select="format-number($filenum,'0000')"/></xsl:attribute>
                                <xsl:attribute name="DMDID">dmgt_<xsl:value-of select="format-number($filenum,'0000')"/></xsl:attribute>
                                <xsl:attribute name="ORDER"><xsl:value-of select="$filenum"/></xsl:attribute>
                                <xsl:attribute name="ORDERLABEL">vol. <xsl:value-of select="$filenum"/></xsl:attribute>
                                
                                <mets:mptr LOCTYPE="URL">
                                    <xsl:attribute name="xlink:href"><xsl:value-of select="."/>.ocrd/data/mets.xml</xsl:attribute>
                                </mets:mptr>
                            </mets:div>
                        </xsl:for-each>
                        </mets:div>
                    </mets:div>
                </mets:structMap>
                
            </mets:mets>
          </xsl:if>

        

      <xsl:if test="$output = 'METSdefault'"> 
                 <xsl:for-each select="collection($conMets)">
                      <xsl:variable name="file" select="base-uri()"/>
                      <xsl:variable name="filename" select="tokenize(base-uri(), '/')[last() - 1]"/>
                      
                     <xsl:result-document href="{$file}">
                        <mets:mets
                            xsi:schemaLocation="http://www.loc.gov/METS/ http://www.loc.gov/mets/mets.xsd http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-8.xsd"
                            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mets="http://www.loc.gov/METS/"
                            xmlns:dv="http://dfg-viewer.de/" xmlns:xlink="http://www.w3.org/1999/xlink"
                            xmlns:mods="http://www.loc.gov/mods/v3">
                            <xsl:variable name="t1"><xsl:copy-of select="."/></xsl:variable>
                            <xsl:variable name="t2">
                                <mets:structMap TYPE="PHYSICAL">
                                    <mets:div TYPE="physSequence">
                                        <xsl:if test="$t1//mets:structMap[@TYPE='PHYSICAL']/mets:div[@TYPE='physSequence']/@ID !=''">
                                            <xsl:attribute name="ID" select="$t1//mets:structMap[@TYPE='PHYSICAL']/mets:div[@TYPE='physSequence']/@ID"/>
                                        </xsl:if>
                                        <xsl:if test="$t1//mets:structMap[@TYPE='PHYSICAL']/mets:div[@TYPE='physSequence']/@DMDID !=''">
                                            <xsl:attribute name="DMDID" select="$t1//mets:structMap[@TYPE='PHYSICAL']/mets:div[@TYPE='physSequence']/@DMDID"/>
                                        </xsl:if>
                                        
                                        
                                        <xsl:for-each select="$t1//mets:structMap[@TYPE='PHYSICAL']/mets:div[@TYPE='physSequence']/mets:div[@TYPE='page']">
                                            <mets:div TYPE="page">
                                                <xsl:if test="@ORDER !=''"><xsl:attribute name="ORDER" select="@ORDER"/></xsl:if>
                                                <xsl:if test="@ID !=''"><xsl:attribute name="ID" select="@ID"/></xsl:if>
                                                <xsl:if test="@DMDID !=''"><xsl:attribute name="DMDID" select="@DMDID"/></xsl:if>
                                                <xsl:for-each select="mets:fptr">
                                                    <xsl:choose>
                                                        <xsl:when test="fn:matches(./@FILEID, 'DEFAULT[_0-9A-Z]+')"/>
                                                        <xsl:otherwise><mets:fptr>
                                                            <xsl:attribute name="FILEID" select="@FILEID"/>
                                                        </mets:fptr></xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:for-each>
                                            </mets:div>
                                        </xsl:for-each>
                                    </mets:div>
                                </mets:structMap>
                            </xsl:variable>
                            <xsl:variable name="t3">
                                <xsl:copy-of copy-namespaces="no" select="$t1//mets:structLink"/>
                            </xsl:variable>
                            <xsl:variable name="t4">
                                <xsl:copy-of copy-namespaces="no" select="$t1//mets:metsHdr
                                    | $t1//mets:dmdSec 
                                    | $t1//mets:amdSec" />
                                <xsl:if test="$t1//mets:fileSec/child::*[@USE  != 'DEFAULT']">
                                    <xsl:copy-of copy-namespaces="no" select="$t1//mets:fileSec"/>
                                </xsl:if>
                                <xsl:copy-of copy-namespaces="no" select="$t1//mets:structMap[@TYPE='LOGICAL']
                                    | $t2//mets:structMap[@TYPE='PHYSICAL']
                                    | $t3//mets:structLink"/>
                                <!-\-| $t1//mets:fileSec/child::*[@USE  != 'DEFAULT'] -\->
                            </xsl:variable>
                            <xsl:copy-of copy-namespaces="no" select="$t4"/>
                        </mets:mets>
                    </xsl:result-document>
                    </xsl:for-each>
                    </xsl:if>
        <xsl:if test="$output = 'download'">
            <xsl:for-each-group select="$holeMetric//*" group-by="@key1">
                <xsl:variable name="return"></xsl:variable>
                <xsl:variable name="ocrdZIP"><xsl:text>https://github.com/</xsl:text><xsl:value-of select="$repoName"/>/releases/download/<xsl:value-of select="$releaseTag"/>/<xsl:value-of select="current-grouping-key()"/>.ocrd.zip</xsl:variable>
                    <xsl:value-of select="$ocrdZIP"/>

            </xsl:for-each-group>
        </xsl:if>-->
       </xsl:template>
    </xsl:stylesheet>




