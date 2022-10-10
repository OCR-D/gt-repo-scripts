# gt-repo-scripts


## Description
XSLT and shell scripts for analyzing and creating GitHub pages of a ground truth repository. 
These are centrally managed and can be used by all repositories created with the template.

**gt-overview_metadata.xsl**
- Analysis of ground truth, GitHub page creation, following parameters are to be followed.
    - repoBase=$GITHUB_REF_NAME 
    - repoName=$GITHUB_REPOSITORY 
    - bagitDumpNum=$GITHUB_RUN_NUMBER 
      
      Use environment variables https://docs.github.com/en/actions/learn-github-actions/environment-variables

**Output parameter group:**
- Specifies what type of analysis and in what form it should be displayed.
    - output=METADATA -> transform METADATA and create GT overview 
    - output=TABLE ->compressed table view
    - output=OVERVIEW->detailed table view

**Metadata parameter group:**
- indicates that a metadata set is created for the GT corpus and the README and the README file is adapted.
    - output=METS ->generate metadata for (METS)-Ingest in OCR-D workflow, mets.sh is generated
    - output=METSvolume->generate METS metadata for the whole corpus
    - output=README ->creation of a customized README file

**data_structure.sh**


**readmefolder.sh**


**table_hide.css**


**xreadme.sh**
