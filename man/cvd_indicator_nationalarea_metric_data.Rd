% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cvd_api_functions.R
\name{cvd_indicator_nationalarea_metric_data}
\alias{cvd_indicator_nationalarea_metric_data}
\title{Indicator national vs area metric data}
\usage{
cvd_indicator_nationalarea_metric_data(
  metric_id = 1,
  time_period_id = 17,
  area_id = 739
)
}
\arguments{
\item{metric_id}{integer - metric for which to return data (compulsory)}

\item{time_period_id}{integer - time period for which to return data (compulsory)}

\item{area_id}{integer - area for which to return data (compulsory)}
}
\value{
List of named tibbles (\code{area}, \code{target}) where \code{target} is only provided if data is available.
}
\description{
Returns national and area data for the provided metric, area, and time period.
}
\details{
The returned object is a list containing named tibbles. The two possible
tibbles are:
\itemize{
\item \code{area}: contains metric data for the specified area in comparison with national metric data.
\item \code{target}: contains details on how to reach target values, including:
\itemize{
\item target value as a percentage (stored as a whole number up to 100)
\item target patients (the number of additional patients needed to reach the target percentage)
}
}

Note that the \code{target} tibble is only provided if data is available for both
national and the chosen area.

CVD Prevent API documentation:
\href{https://bmchealthdocs.atlassian.net/wiki/spaces/CP/pages/317882369/CVDPREVENT+API+Documentation#\%2Findicator\%2FnationalVsAreaMetricData\%2F\%3Cmetric_ID\%3E}{Indicator national vs area metric data}
}
\examples{
# Compare performance against metric 150  (AF: treatment with anticoagulants
# - all people) in 'Chester South PCN' (area ID 553) with national
# performance:
return_list <- cvd_indicator_nationalarea_metric_data(
    metric_id = 150,
    time_period_id = 17,
    area_id = 553
)

# See what the list contains
return_list |> summary()

# Extract the `area` details
area_data <- return_list$area
area_data |> gt::gt()

# Extract `target` details
target_data <- return_list$target
target_data |> gt::gt()
}
\seealso{
\code{\link[=cvd_indicator_list]{cvd_indicator_list()}}, \code{\link[=cvd_indicator_metric_list]{cvd_indicator_metric_list()}}, \code{\link[=cvd_indicator]{cvd_indicator()}},
\code{\link[=cvd_indicator_tags]{cvd_indicator_tags()}}, \code{\link[=cvd_indicator_details]{cvd_indicator_details()}}, \code{\link[=cvd_indicator_sibling]{cvd_indicator_sibling()}},
\code{\link[=cvd_indicator_child_data]{cvd_indicator_child_data()}}, \code{\link[=cvd_indicator_data]{cvd_indicator_data()}}, \code{\link[=cvd_indicator_metric_data]{cvd_indicator_metric_data()}},
\code{\link[=cvd_indicator_raw_data]{cvd_indicator_raw_data()}},
\code{\link[=cvd_indicator_priority_groups]{cvd_indicator_priority_groups()}}, \code{\link[=cvd_indicator_pathway_group]{cvd_indicator_pathway_group()}},
\code{\link[=cvd_indicator_group]{cvd_indicator_group()}}, \code{\link[=cvd_indicator_metric_timeseries]{cvd_indicator_metric_timeseries()}},
\code{\link[=cvd_indicator_person_timeseries]{cvd_indicator_person_timeseries()}}, \code{\link[=cvd_indicator_metric_systemlevel_comparison]{cvd_indicator_metric_systemlevel_comparison()}},
\code{\link[=cvd_indicator_metric_area_breakdown]{cvd_indicator_metric_area_breakdown()}}
}
