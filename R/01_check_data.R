# ============================================================
# FIFA WORLD CUP BIG DATA ANALYTICS
# STEP 1 - CHECK DATASETS
# ============================================================

cat("========================================\n")
cat(" FIFA WORLD CUP BIG DATA ANALYTICS\n")
cat(" Dataset Verification\n")
cat("========================================\n\n")

# ------------------------------------------------------------
# 1. Show current working directory
# ------------------------------------------------------------

cat("Current working directory:\n")
print(getwd())

# ------------------------------------------------------------
# 2. Show files inside data/raw
# ------------------------------------------------------------

data_path <- "data/raw"

cat("\nFiles inside data/raw:\n\n")

files <- list.files(
  data_path,
  full.names = TRUE
)

print(files)

# ------------------------------------------------------------
# 3. Count files
# ------------------------------------------------------------

cat("\nNumber of files found:", length(files), "\n")

# ------------------------------------------------------------
# 4. Show file names and extensions
# ------------------------------------------------------------

cat("\nFile information:\n")

for (file in files) {
  
  cat(
    "\nFile:",
    basename(file),
    "\n"
  )
  
  cat(
    "Extension:",
    tools::file_ext(file),
    "\n"
  )
  
  cat(
    "Size:",
    round(file.info(file)$size / 1024, 2),
    "KB\n"
  )
}