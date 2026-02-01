# Define functions for exercise
###############################

#' Subset spatial sample dataframe
#'
#' Given a dataframe, subset based on desired version, scheme and water
#' class(es).
#'
#' @param version_number_val Sample version
#' @param scheme_val Scheme name
#' @param hydr_class_val Water class name (single value or vector)
#'
#' @return Subsection of sample dataframe showing only rows related to the
#' desired scheme and to the stratum values belonging to the desired water
#' class(es).
#' @export
#'
#' @examples
#' With single water class
#' subset_by_scheme_water("poc_0.14.0", "GW_03.3", "HC2")
#' With vector of water classes
#' subset_by_scheme_water("poc_0.14.0", "GW_03.3", c("HC2", "HC3))
subset_by_scheme_water <- function(version_number_val,
                                   scheme_val,
                                   hydr_class_val){

    # Get the list of water classes associated to stratum variable (from n2khab)
    list_type_hydr_class <- n2khab::read_types()[,c("type", "hydr_class")]

    # Define the stratum values associated with the desired hydr_class
    types_in_hydr_class <- filter(list_type_hydr_class, hydr_class %in% hydr_class_val)

    # Read CSV file of the asked version
    spatial_samples_raw <- read.csv(sprintf("./Versies/%s/samples/spatial_samples.csv",
                                            version_number_val))

    # Filter CSV based on scheme and the stratum values associated to the given hydr_class
    spatial_samples <- filter(spatial_samples_raw,
                              scheme == scheme_val,
                              stratum %in% types_in_hydr_class$type)

    return(spatial_samples)
}


#' Find unique sample locations per type
#'
#' Given a dataframe, subset based on desired version, scheme and water
#' class(es).
#'
#' @param sample_subset Sample dataframe already subset to a desired scheme and
#' to stratum values corresponding to the desired water classes
#'
#' @return New dataframe showing the stratum types of the desired water class
#' associated to the number of unique locations.
#' @export
#'
#' @examples
#' get_unique_locations(my_sample_subset)
get_unique_locations <- function(sample_subset){

    # Get number of unique grts_address values per stratum in a given sample version
    unique_grts_per_stratum <- sample_subset %>% group_by(stratum) %>% summarise(unique = length(unique(grts_address)))

    return(unique_grts_per_stratum)
}
