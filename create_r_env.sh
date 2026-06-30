#!/usr/bin/env bash

set -euo pipefail

# -----------------------------
# Configuration
# -----------------------------
ENV_NAME="${1:-r_env}"
R_VERSION="${2:-4.4}"
KERNEL_NAME="${3:-ir-r-env}"
KERNEL_DISPLAY_NAME="${4:-R [conda env:${ENV_NAME}]}"

CHANNEL="conda-forge"

echo "Environment name: ${ENV_NAME}"
echo "R version: ${R_VERSION}"
echo "Kernel name: ${KERNEL_NAME}"
echo "Kernel display name: ${KERNEL_DISPLAY_NAME}"

# -----------------------------
# Find Conda
# -----------------------------
if ! command -v conda >/dev/null 2>&1; then
    echo "ERROR: conda was not found in PATH."
    exit 1
fi

# Make 'conda activate' available in this script.
CONDA_BASE="$(conda info --base)"
source "${CONDA_BASE}/etc/profile.d/conda.sh"

# -----------------------------
# Create or update environment
# -----------------------------
if conda env list | awk '{print $1}' | grep -Fxq "${ENV_NAME}"; then
    echo "Conda environment '${ENV_NAME}' already exists."
else
    echo "Creating Conda environment '${ENV_NAME}'..."

    conda create \
        --name "${ENV_NAME}" \
        --channel "${CHANNEL}" \
        --strict-channel-priority \
        --yes \
        "r-base=${R_VERSION}" \
        r-irkernel
fi

echo "Installing required R packages..."

conda install \
    --name "${ENV_NAME}" \
    --channel "${CHANNEL}" \
    --strict-channel-priority \
    --yes \
    "r-base=${R_VERSION}" \
    r-irkernel \
    r-haven \
    r-tidyverse \
    r-broom \
    r-writexl \
    r-tidyr \
    r-glue \
    r-glmnet \
    r-pROC \
    r-matrix \
    r-data.table \
    r-dplyr \
    r-ggplot2 \
    r-foreach \
    r-readxl \
    r-svglite \
    r-caret \
    r-doParallel \
    r-remotes \
    r-fastdummies \
    r-openxlsx

# Install nestedcv 0.8.2 from the CRAN archive
conda run --name "${ENV_NAME}" R --vanilla -e "
options(repos = c(CRAN = 'https://cloud.r-project.org'))

remotes::install_version(
    package = 'nestedcv',
    version = '0.8.2',
    repos = 'https://cloud.r-project.org',
    dependencies = TRUE,
    upgrade = 'never'
)
"

# -----------------------------
# Register Jupyter kernel
# -----------------------------
echo "Registering Jupyter kernel '${KERNEL_NAME}'..."

conda run --name "${ENV_NAME}" R --vanilla -e "
IRkernel::installspec(
    name = '${KERNEL_NAME}',
    displayname = '${KERNEL_DISPLAY_NAME}',
    user = TRUE
)
"

# -----------------------------
# Verify R executable and kernel
# -----------------------------
echo
echo "R installation:"
conda run --name "${ENV_NAME}" R --vanilla -s -e "
cat('R version:', R.version.string, '\n')
cat('R home:', R.home(), '\n')
"

echo
echo "Testing required packages..."

conda run --name "${ENV_NAME}" R --vanilla -s -e "
packages <- c(
    'IRkernel',
    'haven',
    'tidyverse',
    'broom',
    'writexl',
    'tidyr',
    'glue'
)

missing <- packages[
    !vapply(packages, requireNamespace, logical(1), quietly = TRUE)
]

if (length(missing) > 0) {
    stop(
        paste(
            'Missing packages:',
            paste(missing, collapse = ', ')
        )
    )
}

cat('All required packages are installed.\n')
"

echo
echo "Registered Jupyter kernels:"
jupyter kernelspec list

echo
echo "Kernel specification:"
KERNEL_DIR="${HOME}/.local/share/jupyter/kernels/${KERNEL_NAME}"

if [[ -f "${KERNEL_DIR}/kernel.json" ]]; then
    cat "${KERNEL_DIR}/kernel.json"
else
    echo "WARNING: kernel.json was not found at ${KERNEL_DIR}."
fi

echo
echo "Environment setup completed successfully."