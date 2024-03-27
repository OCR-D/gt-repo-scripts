<img src="./img/gt-LevelParser2.jpg" width="200" align="right">


# gt-repo-scripts


## Description
XSLT and shell scripts for analyzing and creating GitHub pages of a ground truth repository. These are centrally managed and can be used by all repositories created with gt-repo-template (https://github.com/OCR-D/gt-repo-template).

The format of the output files:
- Markdown,
- ruleset (JSON)
- METS (XML) 
- Shell scripts

## Overview of scripts or programs

**🚀 gt-overview_unitTest.xsl**

- It lists all files in the Ground Truth (GT) directory. In a second step, the xsl checks whether the specified GT directory   structure with the data and GT-PAGE directories is present. If other directories or a different directory structure are present, an error is output (pathtest.md). 
  - It is part of the gtrepo github-action workflow.
  - **:wrench: general program call**
      -  ```shell    
         java -jar saxon-XX.jar -xsl:scripts/gt-overview_unitTest.xsl \
         output=unitTest1 \
         -s:scripts/gt-overview_unitTest.xsl -o:ghout/pathtest.md
         ```


**🚀 gt-overview_metadata.xsl**

   - **Environment parameters group**
        - Analysis of ground truth, GitHub page creation, following parameters are to be followed. Use environment variables https://docs.github.com/en/actions/learn-github-actions/environment-variables
            - repoBase=$GITHUB_REF_NAME
            - repoName=$GITHUB_REPOSITORY
            - bagitDumpNum=$GITHUB_RUN_NUMBER    
        
   - **Output parameter group:**
        - Specifies what type of analysis and in what form it should be displayed.
            - output=METADATA -> transform METADATA and create GT overview 
            - output=TABLE ->compressed table view
            - output=OVERVIEW->detailed table view

   - **Metadata parameter group:**
        - indicates that a metadata set is created for the GT corpus and the README and the README file is adapted.
            - output=METS ->generate metadata for (METS)-Ingest in OCR-D workflow, mets.sh is generated
            - output=METSvolume->generate METS metadata for the whole corpus
            - output=METSdefault->generate METS metadata file without DEFAULT fileGrp (file Group), the METS file(s) contains only the Realease files
            - output=README ->creation of a customized README file
     - **:wrench: general program call**
        - ```shell
          java -jar saxon-XX.jar -xsl:scripts/gt-overview_metadata.xsl \
          output=XX repoBase=$GITHUB_REF_Name repoName=$GITHUB_REPOSITORY bagitDumpNum=$GITHUB_RUN_NUMBER \
          -s:scripts/gt-overview_metadata.xsl -o:XX
          ```  

**🚀 gt-level_parser.xsl**
   - It is a rule-based parser for determining the transcription and structure level of a page file and the corpus of page files.
     The transcription level distinguishes three and the structure two levels.
   - The parser determines the frequencies of characters and structures (regions) that are defined in the rules. Based on this analysis, a specific level is determined for the page and for the corpus.
   - The gt-level_parser.xsl include gt-level_structure.xsl.**gt-level_structure.xsl** specialises in determining the regions used in the Page-XML files. An independent call of this stylesheet is not provided.
   - The output file is overview-level.md, it is the level matrix, the analysis result.
     - **:wrench: general program call**
       - ```shell
         java -jar saxon-XX.jar -xsl:scripts/gt-level_parser.xsl \
         repoName=$GITHUB_REPOSITORY \
         -s:scripts/gt-level_parser.xsl -o:ghout/overview-level.md
         ```

**🚀 gt-coll_metadata.xsl**
  - gt-coll_metadata.xsl automatically creates a readme file for a collection/corpus of Ground Truth repositories. 
    - **:wrench: general program call**
       - ```shell
         java -jar saxon-xx.jar -xsl:scripts/gt-coll_metadata.xsl \
         -s:scripts/gt-coll_metadata.xsl -o:README.md
         ```


**🚀 data_structure.sh**
   - Analysis of the data structure, determination of the METS metadata file and afterwards creation of the Bagit files. For Bagit see: https://ocr-d.de/en/spec/ocrd_zip
     - **:wrench: general program call**
       - ```shell
           sh scripts/data_structure.sh
         ``` 
**🚀 data_mets.sh**
   - During the Github action workflow, METS files that do not contain `OCR-D-IMG fileGrp` are deleted. 


**🚀 readmefolder.sh**
   - Archiving the original README file to the `readme_old` folder
     - **:wrench: general program call**
       - ```shell
           sh scripts/readmefolder.sh
         ```

**🚀 xreadme.sh**
   - Determination of the README file and change of the filename extension from Markdown to XML
     - **:wrench: general program call**
       - ```shell
           sh scripts/xreadme.sh
         ```
**🚀 lang.js**
   - Javascript for the automated language conversion (German/English) of the level description and the links to the OCR-D-GT Guidelines.
     
**🌻 table_hide.css**
   - CSS stylesheet to customize the formatting of GH pages. The GH pages use the dinky template (https://pages-themes.github.io/dinky/).


**🌻 levelparser.css**
   - CSS stylesheet for customising the formatting of GH pages, in particular for determining the transcription and structure levels.

## Github Action Template

In combination or individually, the individual programs and stylesheets can also be used in a Github Action Workflow.
- With XSLT, an XSLT transformer should also be installed. 
- OCR-D is used for the creation of Bagit data containers.

### Example Github Action Workflow with the programs
#### Example 1
see application: https://github.com/OCR-D/gt-repo-template
- gt-overview_unitTest.xsl
- gt-overview_metadata.xsl
- gt-level_parser.xsl
- data_structure.sh
- data_mets.sh 
- readmefolder.sh
- xreadme.sh
 
```yml
name: gtrepo
on:
  push:
    tags:
      - 'v[0-9]+.[0-9]+.[0-9]+'
      
  workflow_dispatch:
      inputs:
        tag-name:
          description: Name of the release tag
          
jobs:
    job1:
        name: uniTest
        runs-on: ubuntu-latest
        permissions:
            checks: write
            contents: write
        # Map a step output to a job output
        outputs:
          output1: ${{ steps.step4.outputs.test }}
          output2: ${{ steps.step4.outputs.test2 }}
          
        steps:      
          - name: Git checkout
            id: step1
            uses: actions/checkout@v4

           # Installation Styles and Saxon
      
          - name: install analyse xsl-styles
            id: step2
            run: | 
                git clone https://github.com/tboenig/gt-repo-scripts.git
                mv gt-repo-scripts/scripts scripts/
                rm -r gt-repo-scripts
          
          - name: Download and install saxon
            id: step3
            run: |
              wget https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-3/SaxonHE12-3J.zip 
              unzip SaxonHE12-3J.zip      
          

           # Installation and Directories   
          
          - name: make gh-pages_out
            run: mkdir ghout


          - name: Get SDK Version from config
            id: lookupSdkVersion
            uses: mikefarah/yq@master
            with:
             cmd: yq -o=json METADATA.yml > METADATA.json  

          - name: PathTest
            run: |
                java -jar saxon-he-12.3.jar -xsl:scripts/gt-overview_unitTest.xsl \
                output=unitTest1 \
                -s:scripts/gt-overview_unitTest.xsl -o:ghout/pathtest.md
            shell: bash

          # Test GT-Page Folder Repo Structure
          
          - name: Empty
            id: step4
            run: |
                [ -s ghout/pathtest.md ] || echo "test=empty" >> $GITHUB_OUTPUT
                [ ! -s ghout/pathtest.md ] || echo "test2=full" >> $GITHUB_OUTPUT
          
          # Error Logview     
          
          - name: uniTestError
            id: step5
            if: ${{steps.step4.outputs.test2 == 'full'}}  
            run: |
              less ghout/pathtest.md          
   
    
    job2:
        name: analyse_and_makebagit
        needs: job1
        if: ${{needs.job1.outputs.output1 == 'empty'}}        
        runs-on: ubuntu-latest
        permissions:
            checks: write
            contents: write
              
        
        steps:
          - name: Using tag name from ref name
            if: github.event.inputs.tag-name == ''
            run: echo "TAG_NAME=$GITHUB_REF_NAME" >> $GITHUB_ENV

          - name: Using tag name from input param
            if: github.event.inputs.tag-name != ''
            run: echo "TAG_NAME=${{ github.event.inputs.tag-name}}" >> $GITHUB_ENV  
  
          - name: Git checkout
            uses: actions/checkout@v4
      
            # Installation Styles
            
          - name: install analyse xsl-styles
            run: | 
              git clone https://github.com/tboenig/gt-repo-scripts.git
              mv gt-repo-scripts/scripts scripts/
              rm -r gt-repo-scripts
      
            # Installation GT-Labelling Documentation
      
            
          - name: install labeling
            run: |
              git clone https://github.com/tboenig/gt-guidelines.git
      
            
          # Installation and Directories
            
          - name: install jq
            run: sudo apt-get install jq
          
                      
          - name: Download and install saxon
            run: |
              wget https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-3/SaxonHE12-3J.zip 
              unzip SaxonHE12-3J.zip
                            
          - name: make metadata_out
            run: mkdir metadata_out
      
          - name: make ocrdzip_out
            run: mkdir ocrdzip_out
            
          - name: make gh-pages_out
            run: mkdir ghout
            
          - name: make readme_out 
            run:  sh scripts/readmefolder.sh
      
      
          - name: readme.xml file
            run: sh scripts/xreadme.sh  
      
                
          
          # Transformation and analyzing
          
          - name: Get SDK Version from config
            id: lookupSdkVersion
            uses: mikefarah/yq@master
            with:
              cmd: yq -o=json METADATA.yml > METADATA.json
                  
          - name: transform METADATA and make GT-Overview
            run: |
              java -jar saxon-he-12.3.jar -xsl:scripts/gt-overview_metadata.xsl \
              output=METADATA repoBase=${{ env.TAG_NAME }} repoName=$GITHUB_REPOSITORY bagitDumpNum=$GITHUB_RUN_NUMBER releaseTag=${{ env.TAG_NAME }} \
              -s:scripts/gt-overview_metadata.xsl -o:ghout/metadata.md
            shell: bash
      
          - name: make Compressed table view
            run: |
              java -jar saxon-he-12.3.jar -xsl:scripts/gt-overview_metadata.xsl \
              output=TABLE repoBase=${{ env.TAG_NAME }} repoName=$GITHUB_REPOSITORY \
              -s:scripts/gt-overview_metadata.xsl -o:ghout/table.md
            shell: bash
      
          - name: detailed table view 
            run: |
              java -jar saxon-he-12.3.jar -xsl:scripts/gt-overview_metadata.xsl \
              output=OVERVIEW repoBase=${{ env.TAG_NAME }} repoName=$GITHUB_REPOSITORY \
              -s:scripts/gt-overview_metadata.xsl -o:ghout/overview.md
            shell: bash

          - name: leveling the volume and documents 
            run: |
              java -jar saxon-he-12.3.jar -xsl:scripts/gt-level_parser.xsl \
              repoName=$GITHUB_REPOSITORY \
              -s:scripts/gt-level_parser.xsl -o:ghout/overview-level.md
            shell: bash  
      
          - name: generate mets.sh
            run: |
              java -jar saxon-he-12.3.jar -xsl:scripts/gt-overview_metadata.xsl \
              output=METS repoBase=${{ env.TAG_NAME }} repoName=$GITHUB_REPOSITORY \
              -s:scripts/gt-overview_metadata.xsl -o:scripts/mets.sh
            shell: bash
            
          - name: generate Metadata JSON file
            run: |
              java -jar saxon-he-12.3.jar -xsl:scripts/gt-overview_metadata.xsl \
              output=METAJSON repoBase=${{ env.TAG_NAME }} repoName=$GITHUB_REPOSITORY bagitDumpNum=$GITHUB_RUN_NUMBER releaseTag=${{ env.TAG_NAME }} \
              -s:scripts/gt-overview_metadata.xsl -o:metadata_out/metadata_l.json
            shell: bash
            
            
          - name: format json file and copy to gh branch
            run: |
              jq '.' metadata_out/metadata_l.json > metadata_out/metadata.json
              cp metadata_out/metadata.json ghout/
              rm metadata_out/metadata_l.json
            
            
          - name: generate README
            run: |
              java -jar saxon-he-12.3.jar -xsl:scripts/gt-overview_metadata.xsl \
              output=README repoBase=${{ env.TAG_NAME }} repoName=$GITHUB_REPOSITORY \
              -s:scripts/gt-overview_metadata.xsl -o:README.md
            shell: bash
            
          - name: generate METS Volume File
            run: |
              java -jar saxon-he-12.3.jar -xsl:scripts/gt-overview_metadata.xsl \
              output=METSvolume repoBase=${{ env.TAG_NAME }} repoName=$GITHUB_REPOSITORY bagitDumpNum=$GITHUB_RUN_NUMBER releaseTag=${{ env.TAG_NAME }} \
              -s:scripts/gt-overview_metadata.xsl -o:metadata_out/mets.xml
            shell: bash
      
          - name: generate release download List
            run: |
              java -jar saxon-he-12.3.jar -xsl:scripts/gt-overview_metadata.xsl \
              output=download repoBase=${{ env.TAG_NAME }} repoName=$GITHUB_REPOSITORY bagitDumpNum=$GITHUB_RUN_NUMBER releaseTag=${{ env.TAG_NAME }} \
              -s:scripts/gt-overview_metadata.xsl -o:ghout/download.txt
            shell: bash  
            
          - name: delete fileGrp DEFAULT
            run: |
              java -jar saxon-he-12.3.jar -xsl:scripts/gt-overview_metadata.xsl \
              output=METSdefault repoBase=${{ env.TAG_NAME }} repoName=$GITHUB_REPOSITORY bagitDumpNum=$GITHUB_RUN_NUMBER releaseTag=${{ env.TAG_NAME }} \
              -s:scripts/gt-overview_metadata.xsl
            shell: bash

          - name: generate CITATION.cff
            run: |
              java -jar saxon-he-12.3.jar -xsl:scripts/gt-overview_metadata.xsl \
              output=CITATION repoBase=${{ env.TAG_NAME }} repoName=$GITHUB_REPOSITORY bagitDumpNum=$GITHUB_RUN_NUMBER releaseTag=${{ env.TAG_NAME }} \
              -s:scripts/gt-overview_metadata.xsl -o:rawCITATION.cff
            shell: bash

          - name: formating CITATION.cff
            id: lookupSdkVersion2
            uses: mikefarah/yq@master
            with:
              cmd: |
                yq -I4 rawCITATION.cff > CITATION.cff
                rm rawCITATION.cff
            
        
          - name: Index-link
            run: |
                cd ghout
                ln -s metadata.md index.md
    
      
          # Mets handling, Install OCR-D and Bagit 
      
          - name: del invalidMets
            run: sh -ex scripts/data_mets.sh
            shell: bash    
              

          - name: install ocrd, make validMets and bagit
            run: |
              sudo apt-get install -y python3 imagemagick libgeos-dev
              python3 -m venv venv         
              source venv/bin/activate     
              pip install -U pip 'setuptools>=61'
              pip install ocrd
              ocrd --version
              

          - name: make validMets  
            run: |
              source venv/bin/activate
              sh -ex scripts/mets.sh
                  

          - name: make bagit
            run: |
              source venv/bin/activate
              sh scripts/data_structure.sh

```
#### Example 2

see application: https://github.com/tboenig/gt_corpus_benchmark
- gt-coll_metadata.xsl
- xreadme.sh

```yml
name: gtrepo
on:
  push:
    tags:
      - 'v[0-9]+.[0-9]+.[0-9]+'
      
      
      
  workflow_dispatch:



jobs:
  cli:
    name: makeDescription
    runs-on: ubuntu-latest
    permissions:
     checks: write
     contents: write
     
    steps:
     
    - name: Git checkout
      uses: actions/checkout@v3

     # Create Directories

    - name: create directories
      run: |
        mkdir frak
        mkdir ant
        mkdir fontmix
        mkdir frak/frak_simple
        mkdir frak/frak_complex
        mkdir ant/ant_simple
        mkdir ant/ant_complex
        mkdir fontmix/fontmix_simple
        mkdir fontmix/fontmix_complex


     # Clone Repos
    - name: clone repos and delete files
      run: |
        cd frak
        cd frak_simple
        git clone https://github.com/tboenig/16_frak_simple.git --branch gh-pages
        cd 16_frak_simple
        rm -rf _config.yml index.md metadata.md overview.md table.md table_hide.css
        cd ..
        git clone https://github.com/tboenig/17_frak_simple.git --branch gh-pages
        cd 17_frak_simple
        rm -rf _config.yml index.md metadata.md overview.md table.md table_hide.css
        

     # Installation Styles
      
    - name: install analyse xsl-styles
      run: | 
        git clone https://github.com/tboenig/gt-repo-scripts.git
        mv gt-repo-scripts/scripts scripts/
        rm -r gt-repo-scripts
     
    # Installation GT-Labelling Documentation

    - name: install labeling
      run: |
        git clone https://github.com/tboenig/gt-guidelines.git

          
    # Installation Transformer

    - name: Download and install saxon
      run: |
        wget https://sourceforge.net/projects/saxon/files/Saxon-HE/11/Java/SaxonHE11-4J.zip/download
        unzip download
    
    
    # Transform Readme

    - name: readme.xml file
      run: sh scripts/xreadme.sh  
    
      
    # Transformation and analyzing

    - name: generate README
      run: |
        java -jar saxon-he-11.4.jar -xsl:scripts/gt-coll_metadata.xsl \
        -s:scripts/gt-coll_metadata.xsl -o:README.md
      shell: bash

```
