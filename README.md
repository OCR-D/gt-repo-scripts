# gt-repo-scripts


## Description
XSLT and shell scripts for analyzing and creating GitHub pages of a ground truth repository. These are centrally managed and can be used by all repositories created with gt-repo-template (https://github.com/OCR-D/gt-repo-template).

The format of the output files:
- Markdown,
- ruleset (JSON)
- METS (XML) 
- Shell scripts

**gt-overview_unitTest.xsl**

- It lists all files in the Ground Truth (GT) directory. In a second step, the xsl checks whether the specified GT directory   structure with the data and GT-PAGE directories is present. If other directories or a different directory structure are present, an error is output (pathtest.md). 
  - It is part of the gtrepo github-action workflow.
      -  ```shell    
         java -jar saxon-XX.jar -xsl:scripts/gt-overview_unitTest.xsl \
         output=unitTest1 \
         -s:scripts/gt-overview_unitTest.xsl -o:ghout/pathtest.md
         ```


**gt-overview_metadata.xsl**

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
   - **:rocket: :wrench: general program call :wrench: :rocket:**
      - ```shell
        java -jar saxon-XX.jar -xsl:scripts/gt-overview_metadata.xsl \
        output=XX repoBase=$GITHUB_REF_Name repoName=$GITHUB_REPOSITORY bagitDumpNum=$GITHUB_RUN_NUMBER \
        -s:scripts/gt-overview_metadata.xsl -o:XX
        ```  

**parser.xsl**
  - It is a rule-based parser for determining the transcription and structure level of a page file and the corpus of page files.
The transcription level distinguishes three and the structure two levels.
- The parser determines the frequencies of characters and structures (regions) that are defined in the rules. Based on this analysis, a specific level is determined for the page and for the corpus.
- The parser.xsl include LevelGtStructure.xsl. **LevelGtStructure.xsl** specialises in determining the regions used in the Page-XML files. An independent call of this stylesheet is not provided.
- The output file is overview-level.md, it is the level matrix, the analysis result.
  - ```shell
    java -jar saxon-XX.jar -xsl:scripts/parser.xsl \
    repoName=$GITHUB_REPOSITORY \
    -s:scripts/parser.xsl -o:ghout/overview-level.md
``` 

  

**data_structure.sh**
- Analysis of the data structure, determination of the METS metadata file and afterwards creation of the Bagit files. For Bagit see: https://ocr-d.de/en/spec/ocrd_zip
  - **:rocket: :wrench: general program call :wrench: :rocket:**
      - ```shell
         sh scripts/data_structure.sh
        ``` 

**readmefolder.sh**
- Archiving the original README file to the `readme_old` folder
  - **:rocket: :wrench: general program call :wrench: :rocket:**
      - ```shell
         sh scripts/readmefolder.sh
        ```

**xreadme.sh**
- Determination of the README file and change of the filename extension from Markdown to XML
  - **:rocket: :wrench: general program call :wrench: :rocket:**
    - ```shell
         sh scripts/xreadme.sh
        ```

**table_hide.css**
- CSS stylesheet to customize the formatting of GH pages. The GH pages use the dinky template (https://pages-themes.github.io/dinky/).


**levelparser.css**
- CSS stylesheet for customising the formatting of GH pages, in particular for determining the transcription and structure levels.

**lang.js**
- Javascript for the automated language conversion (German/English) of the level description and the links to the OCR-D-GT Guidelines. 

