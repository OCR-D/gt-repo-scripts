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
    
    <xsl:param name="repoName"/>
    <xsl:param name="repoBase"/>
    <xsl:param name="bagitDumpNum"/>
    <xsl:param name="releaseTag"/>
    
    
    <xsl:variable name="docMETADATA">
        <xsl:copy-of select="json-to-xml(unparsed-text('../METADATA.json'))"/>
    </xsl:variable>
    
    <xsl:template match="/">
<xsl:result-document format="txt_out" href="../METADATA_htr_united.yml">schema: https://htr-united.github.io/schema/2023-06-27/schema.json
title: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/>
url: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='url']"/>
authors:
- name: Matthias 
  surname: Boenig
  orcid: 0000-0003-4615-4753
  roles:
  - transcriber
  - aligner
  - project-manager
  - quality-control
  - digitization
  - support
institutions: []
description: >-
  <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/>
project-name: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-name']"/>
project-website: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-website']"/>
language:<xsl:for-each select="$docMETADATA//fn:map/fn:array[@key='language']/fn:string">
  - <xsl:value-of select="."/>
</xsl:for-each>

production-software: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-software']"/>
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
- count: 217
  metric: files
- count: 6608
  metric: lines
- count: 1647
  metric: regions
citation-file-link: <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='citation-file-link']"/>
transcription-guidelines: >-
  <xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines']"/>
</xsl:result-document>
</xsl:template>
</xsl:stylesheet>