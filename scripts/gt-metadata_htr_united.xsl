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
    <xsl:output name="txt_out" indent="yes" omit-xml-declaration="yes" method="text"
        normalization-form="none"/>
    
    
    
    <xsl:variable name="docMETADATA">
        <xsl:copy-of select="json-to-xml(unparsed-text('../METADATA.json'))"/>
    </xsl:variable>
    
    
    <xsl:variable name="path">
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key/contains(.,'gtTyp')]/text() = 'data_document'">../data</xsl:if>
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
    <xsl:variable name="key13">countUnkownRegion</xsl:variable>
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
                                <string key="{$key13}"><xsl:value-of select="count(document($filename)//*/*[local-name()='UnkownRegion'])"/></string>
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
        
        
        
        
        
        
        
        <xsl:message select="$docMETADATA"></xsl:message>
<xsl:result-document format="txt_out" href="METADATA_htr_united.yml">schema: https://htr-united.github.io/schema/2023-06-27/schema.json
title: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/>
    url: <xsl:value-of select="$docMETADATA//fn:map[not(@key='license')]/fn:string[@key='url']"/>
authors:<xsl:for-each select="$docMETADATA//fn:map/fn:array[@key='authors']/fn:map">
      - name: <xsl:value-of select="fn:string[@key='name']"/> 
        surname: <xsl:value-of select="fn:string[@key='surname']"/>
        orcid: <xsl:value-of select="fn:string[@key='orcid']"/>
        roles:<xsl:for-each select="fn:array[@key='roles']/fn:string">
          - <xsl:value-of select="."/>
        </xsl:for-each>
        </xsl:for-each>
institutions: []
description: >-
  <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/>
project-name: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-name']"/>
project-website: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-website']"/>
language:<xsl:for-each select="$docMETADATA//fn:map/fn:array[@key='language']/fn:string">
  - <xsl:value-of select="."/>
</xsl:for-each>
production-software: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='production-software']"/>
automatically-aligned: false
script:<xsl:for-each select="$docMETADATA//fn:map/fn:array[@key='script']//fn:string">
  - iso: <xsl:value-of select="."/>
    </xsl:for-each>
script-type: only-typed
time:
  notAfter: '<xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notAfter']"/>'
  notBefore: '<xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notBefore']"/>'
hands:
  count: less-than-11
  precision: exact
license:
  name: <xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']//fn:string[@key='name']"/>
  url: <xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']//fn:string[@key='url']"/>
format: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/>
volume:
- count: 640976
  metric: characters
  - count: <xsl:value-of select="$k16"/>
  metric: files
  - count: <xsl:value-of select="$k15"/>
  metric: lines
  - count: <xsl:value-of select="sum($k1 + $k2 + $k3 + $k4 + $k5 + $k6 + $k7 + $k8 + $k9 + $k10 + $k11 + $k12 + $k13 + $k14)"/>
  metric: regions
citation-file-link: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='citation-file-link']"/>
transcription-guidelines: >-
  <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines']"/>
</xsl:result-document>
</xsl:template>
</xsl:stylesheet>