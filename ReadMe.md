
# Psychotropic polypharmacy in *All of Us*

Supplement to: K. Oliver Schubert, Pengyao Ping, Vijayaprakash Suppiah, Scott R. Clark, Azmeraw T. Amare. Psychotropic polypharmacy is a marker of diagnostic uncertainty, social adversity, and externalising vulnerability: clinical and polygenic evidence from the *All of Us*cohort

## Notebooks

* `00_creating_workspace_bucket.ipynb`: Creates the storage bucket used for this project.
* `00_Setting_Env_Variables.ipynb`: Configures the required workspace environment variables.
* `01_functions.ipynb`: Contains functions used for data extraction and analysis.
* `02_cohort_data_collection_analysis.ipynb`: Extracts non-genetic data and performs epidemiological analyses.
* `03_association_analysis.ipynb`: Examines associations between polypharmacy and sociodemographic and clinical characteristics.
* `04_01_merge_phenotype_PGS.ipynb`: Merges phenotype data with polygenic scores and genetic principal components.
* `04_02_genotype_data_extraction_and_preprocessing.ipynb`: Extracts whole-genome sequencing data and performs preprocessing and quality control.
* `05_PGS_PRScs.ipynb`: Calculates polygenic scores using PRS-CS.
* `06_multi_clinical_PGSs_predict_polypharmacy.ipynb`: Performs integrated clinical and multi-trait polygenic modelling of complex polypharmacy.
* `07_individual_PGS_polypharmacy_associations.ipynb`: Examines associations between polypharmacy and individual polygenic scores.

### Reproducing the analysis

* **Step 1:** download this repo
  * ```Shell
    git clone [github.com/JappyPing/Psychotropic_polypharmacy_in_AoU.git](https://github.com/JappyPing/Psychotropic_polypharmacy_in_AoU.git)
    ```
* Run `run_analysis_python.ipynb` to execute the complete workflow. **(recommended)**
* Alternatively, run notebooks `01_functions.ipynb` through `07_individual_PGS_polypharmacy_associations.ipynb` sequentially. When running the notebooks individually, users must configure the required data paths, software paths, and environment kernels and variables for their own workspace.

### Important note

* All analyses were conducted in the *All of Us* Researcher Workbench. Access to *All of Us* Controlled Tier data is required to execute the full analysis workflow.
* All notebooks in this repository are cleaned versions with outputs removed to comply with the privacy and data-security requirements of the *All of Us* Research Program.
* If you encounter errors while running any part of the analysis, they are most likely caused by incorrect file paths, missing dependencies, environment-specific configuration issues, or typographical errors introduced when notebook outputs were removed and the files were cleaned for public release.

## Support

If you have any questions, please reach out to Pengyao.Ping@adelaide.edu.au