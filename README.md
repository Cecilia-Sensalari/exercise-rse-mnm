# Documentation

## Goal

The `exercise_rse_mnm` repository contains the code written to solve the two tasks assigned as exercise for the INBO Research Software Engineer voor de Meetnetten Natuurlijk Milieu position.
The user has access to different versions of spatial samples from the PAS impact monitoring project and the goal is to compare them according to what explained here below.

### Task 1
Set up a function to filter the sample dataset of a user-defined version according to the user-defined monitoring network (`scheme`) and to the user-defined habitat water class (`hydr_class`).

### Task 2
Compare, between two sample dataset versions (poc_0.13.1 en poc_0.14.0), the sample sizes (number of unique `grts_address` values) for each habitat (`stratum`), given a monitoring network (`scheme`: GW_03.3) and water class(es) (`hydr_class`: HC1, HC12 of HC2).


## Configuration

The user defines input variable from the configuration file `config_exercise.R`:

Define the two sample versions to be compared. The two strings must be the name of the directories containing the source data (assumed located at `samples/spatial_samples.csv`):
```
version_1 <- "poc_0.13.1"
version_2 <- "poc_0.14.0"
```

Define to which monitoring network the sample dataset will be restricted:
```
scheme_input <- "GW_03.3"
```

Define to which water class(es) the sample dataset will be restricted. This value can either be a string for a single class or a vector for a list of classes:
```
hydr_class_input <- "HC1"
hydr_class_input <- c("HC1", "HC12", "HC2")
```

## How to use

After having configured file `config_exercise.R`, the user executes `exercise.R` on the terminal:
```
Rscript exercise.R
```
The called functions are defined in `functions_exercise.R`.


## Output

The script generates in the launching directory a PDF plot showing the number of unique sample locations per habitat type in each sample version. Example name: `sample_location_poc_0.13.1_poc_0.14.0.pdf`.

![Example output plot for versions poc_0.13.1 and poc_0.14.0.](example_output_poc_0.13.1_poc_0.14.0.pdf)

