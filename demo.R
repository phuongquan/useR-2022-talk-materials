# devtools::install_github("phuongquan/daiquiri", build_vignettes = TRUE)
rm(list = ls())

library(daiquiri)

?daiquiri
vignette("daiquiri", package = "daiquiri")

# location of example dataset
filename <- system.file("extdata", "example_data.csv", package = "daiquiri", mustWork = TRUE)

# load dataset as all character columns
example_data <- read_data(
  filename,
  delim = ",",
  col_names = TRUE,
  showprogress = FALSE
)

head(example_data)

# specify the fieldtype of each column
fts <- fieldtypes(
  PrescriptionID = ft_uniqueidentifier(),
  PrescriptionDate = ft_timepoint(),
  AdmissionDate = ft_datetime(includes_time = FALSE),
  Drug = ft_freetext(),
  Dose = ft_numeric(),
  DoseUnit = ft_categorical(),
  PatientID = ft_ignore(),
  Location = ft_categorical(aggregate_by_each_category=TRUE)
)

# generate the report
daiqobj <- create_report(
  df = example_data,
  fieldtypes = fts,
  override_columnnames = FALSE,
  na = c("","NULL"),
  dataset_shortdesc = "Example prescription data",
  aggregation_timeunit = "day",
  save_directory = ".",
  save_filename = "example_data_report",
  showprogress = TRUE,
  log_directory = "."
)
