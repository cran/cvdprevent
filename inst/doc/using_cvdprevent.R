## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(cvdprevent)

## -----------------------------------------------------------------------------
cvd_time_period_list() |> 
  dplyr::filter(IndicatorTypeName == 'Standard') |> 
  dplyr::slice_max(order_by = TimePeriodID, n = 4) |> 
  dplyr::select(TimePeriodID, TimePeriodName) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_time_period_list(indicator_type_id = 2) |> 
  dplyr::slice_max(order_by = TimePeriodID, n = 4) |> 
  dplyr::select(IndicatorTypeID, IndicatorTypeName, TimePeriodID, TimePeriodName) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_time_period_system_levels() |> 
  dplyr::slice_max(order_by = TimePeriodID) |> 
  dplyr::select(TimePeriodID, TimePeriodName, SystemLevelID, SystemLevelName) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_area_system_level(time_period_id = 17) |> 
  dplyr::select(SystemLevelID, SystemLevelName) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_area_system_level_time_periods() |> 
  dplyr::filter(SystemLevelName == 'Practice') |> 
  dplyr::slice_max(order_by = TimePeriodID, n = 4) |> 
  dplyr::select(SystemLevelID, SystemLevelName, TimePeriodID, TimePeriodName) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_area_list(time_period_id = 17, system_level_id = 4) |> 
  dplyr::select(SystemLevelName, AreaID, AreaCode, AreaName) |> 
  dplyr::slice_head(n = 4) |> 
  gt::gt()

## -----------------------------------------------------------------------------
# get the list from the function
returned_list <- cvd_area_details(time_period_id = 17, area_id = 1103)

## -----------------------------------------------------------------------------
returned_list$area_details |> 
  dplyr::select(AreaCode, AreaName, SystemLevelID) |> 
  gt::gt()

## -----------------------------------------------------------------------------
returned_list$area_parent_details |> 
  dplyr::select(AreaID, AreaName, SystemLevelID) |> 
  gt::gt()

## -----------------------------------------------------------------------------
returned_list$area_child_details |> 
  dplyr::select(AreaID, AreaName, SystemLevelID) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_area_unassigned(time_period_id = 17, system_level_id = 5) |> 
  dplyr::slice_head(n = 4) |> 
  dplyr::select(SystemLevelName, AreaID, AreaName) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_area_unassigned(time_period_id = 17, system_level_id = 1) |> 
  dplyr::select(SystemLevelName, AreaID, AreaName) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_area_search(partial_area_name = 'foo', time_period_id = 17) |> 
  dplyr::select(AreaID, AreaName, AreaCode) |> 
  gt::gt()

## -----------------------------------------------------------------------------
return_list <- cvd_area_nested_subsystems(area_id = 8152) 
return_list |> summary()

## -----------------------------------------------------------------------------
return_list$level_1 |> 
  gt::gt()

## -----------------------------------------------------------------------------
return_list$level_2 |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_area_flat_subsystems(area_id = 5) |> 
  dplyr::glimpse()

## -----------------------------------------------------------------------------
cvd_indicator_list(time_period_id = 17, system_level_id = 5) |> 
  dplyr::select(IndicatorID, IndicatorCode, IndicatorShortName) |> 
  dplyr::slice_head(n = 4) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_metric_list(time_period_id = 17, system_level_id = 1) |>
  dplyr::filter(IndicatorID == 1, MetricCategoryName == '40-59') |> 
  dplyr::count(IndicatorID, IndicatorShortName, MetricID, MetricCategoryName, CategoryAttribute) |> 
  dplyr::select(-n) |> 
  gt::gt()

## -----------------------------------------------------------------------------
return_list <- cvd_indicator(time_period_id = 17, area_id = 1103) 
return_list |> summary()

## -----------------------------------------------------------------------------
return_list$indicators |> 
  dplyr::select(IndicatorID, IndicatorCode, IndicatorShortName) |> 
  dplyr::arrange(IndicatorID) |> 
  dplyr::slice_head(n = 4) |> 
  gt::gt()

## -----------------------------------------------------------------------------
return_list$metric_categories |> 
  dplyr::filter(IndicatorID == 7, MetricCategoryID %in% c(7, 8)) |> 
  dplyr::select(IndicatorID, MetricCategoryTypeName, 
                CategoryAttribute, MetricCategoryName, MetricID) |> 
  gt::gt()

## -----------------------------------------------------------------------------
return_list$metric_data |> 
  dplyr::filter(MetricID %in% c(126, 132)) |>
  dplyr::select(MetricID, Value, Numerator, Denominator) |> 
  gt::gt()

## -----------------------------------------------------------------------------
return_list$timeseries_data |> 
  dplyr::filter(MetricID %in% c(126, 132), !is.na(Value)) |> 
  # prepare for plotting
  dplyr::mutate(
    EndDate = as.Date(EndDate, format = '%a, %d %b %Y 00:00:00 GMT'),
    MetricID = MetricID |> as.factor()
  ) |> 
  ggplot2::ggplot(ggplot2::aes(
    x = EndDate, 
    y = Value, 
    group = MetricID , 
    colour = MetricID)) +
  ggplot2::geom_point() +
  ggplot2::geom_line()

## -----------------------------------------------------------------------------
return_list <- 
  cvd_indicator(time_period_id = 17, area_id = 3, tag_id = c(3, 4))

return_list$indicators |> 
  dplyr::select(IndicatorID, IndicatorCode, IndicatorShortName) |> 
  dplyr::arrange(IndicatorID) |> 
  dplyr::slice_head(n = 4) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_tags() |> 
  dplyr::arrange(IndicatorTagID) |> 
  dplyr::slice_head(n = 5) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_details(indicator_id = 7) |>
  dplyr::select(IndicatorID, MetaDataTitle, MetaData) |> 
  dplyr::slice_head(n=5) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_sibling(time_period_id = 17, area_id = 1103, metric_id = 126) |>
  dplyr::select(AreaID, AreaName, Value, LowerConfidenceLimit, UpperConfidenceLimit) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_child_data(time_period_id = 17, area_id = 74, metric_id = 126) |> 
  dplyr::select(AreaID, AreaName, Value, LowerConfidenceLimit, UpperConfidenceLimit) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_data(time_period_id = 17, indicator_id = 7, area_id = 701) |> 
  dplyr::filter(MetricCategoryTypeName == 'Sex') |> 
  dplyr::select(MetricID, MetricCategoryName, AreaData.AreaName, AreaData.Value, NationalData.AreaName, NationalData.Value) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_metric_data(metric_id = 126, time_period_id = 1, area_id = 399) |> 
  dplyr::select(IndicatorShortName, CategoryAttribute, MetricCategoryName, AreaData.Value, NationalData.Value) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_raw_data(indicator_id = 7, time_period_id = 17, system_level_id = 5) |> 
  dplyr::slice_head(n = 5) |> 
  dplyr::select(AreaCode, AreaName, Value) |> 
  gt::gt()

## -----------------------------------------------------------------------------
return_list <- cvd_indicator_nationalarea_metric_data(
  metric_id = 150, 
  time_period_id = 17, 
  area_id = 553
)

return_list |> summary()

## -----------------------------------------------------------------------------
area_data <- return_list$area
area_data |> gt::gt()

## -----------------------------------------------------------------------------
target_data <- return_list$target
target_data |> gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_priority_groups() |>
  dplyr::select(PriorityGroup, PathwayGroupName, PathwayGroupID, IndicatorID, IndicatorName) |>
  dplyr::slice_head(by = PathwayGroupID) |> 
  gt::gt(row_group_as_column = T)

## -----------------------------------------------------------------------------
cvd_indicator_pathway_group(pathway_group_id = 9) |> 
  dplyr::select(PathwayGroupName, PathwayGroupID, IndicatorCode, IndicatorID, IndicatorName) |>
  dplyr::group_by(PathwayGroupName) |> 
  gt::gt(row_group_as_column = T)

## -----------------------------------------------------------------------------
cvd_indicator_group(indicator_group_id = 13) |> 
  dplyr::select(IndicatorGroupID, IndicatorGroupName, IndicatorGroupTypeName, IndicatorID, IndicatorName) |> 
  dplyr::group_by(IndicatorGroupID, IndicatorGroupName) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_metric_timeseries(metric_id = 130, area_id = 705) |> 
   # prepare for plotting
  dplyr::mutate(TimePeriodName = stats::reorder(TimePeriodName, TimePeriodID)) |>  
  ggplot2::ggplot(ggplot2::aes(
    x = TimePeriodName,
    y = Value, 
    group = AreaName , 
    colour = AreaName)) +
  ggplot2::geom_point() +
  ggplot2::geom_line() +
  ggplot2::theme(
    axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)
  )

## -----------------------------------------------------------------------------
cvd_indicator_metric_timeseries(metric_id = 130, area_id = 705) |>
  dplyr::select(AreaName, TimePeriodName, TimePeriodID, Value) |> 
  tidyr::pivot_wider(
    names_from = AreaName,
    values_from = Value
  ) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_person_timeseries(indicator_id = 7, area_id = 705) |> 
  dplyr::filter(
    MetricCategoryTypeName == 'Age group',
    !is.na(Value)
  ) |> 
  dplyr::mutate(TimePeriodName = stats::reorder(TimePeriodName, TimePeriodID)) |>
  ggplot2::ggplot(
    ggplot2::aes(
      x = TimePeriodName,
      y = Value,
      group = MetricCategoryName,
      colour = MetricCategoryName
    )
  ) +
  ggplot2::geom_point() +
  ggplot2::geom_line() +
  ggplot2::theme(
    axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)
  )

## -----------------------------------------------------------------------------
cvd_indicator_person_timeseries(indicator_id = 7, area_id = 705) |> 
  dplyr::filter(
    MetricCategoryTypeName == 'Age group',
    !is.na(Value)
  ) |> 
  dplyr::select(MetricCategoryName, TimePeriodName, TimePeriodID, 
                Value) |>
  tidyr::pivot_wider(
    names_from = MetricCategoryName,
    values_from = Value
  ) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_metric_systemlevel_comparison(metric_id = 1270, time_period_id = 17, area_id = 705) |> 
  dplyr::filter(AreaID %in% c(705:709), !is.na(Value)) |> 
  dplyr::select(SystemLevelName, AreaID, AreaName, Value) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_indicator_metric_area_breakdown(metric_id = 128, time_period_id = 17, area_id = 705) |> 
  dplyr::select(SystemLevelName, AreaID, AreaName, Value) |> 
  gt::gt()

## -----------------------------------------------------------------------------
cvd_external_resource() |> 
  dplyr::filter(ExternalResourceID < 10) |> 
  dplyr::select(ExternalResourceCategory, ExternalResourceSource, ExternalResourceTitle) |> 
  dplyr::group_by(ExternalResourceCategory) |> 
  gt::gt(row_group_as_column = T)

## -----------------------------------------------------------------------------
cvd_data_availability(time_period_id = 6, system_level_id = 5) |>
  dplyr::select(IndicatorShortName, IsAvailable, SystemLevelName, MetricCategoryTypeID) |> 
  dplyr::slice_head(n = 5) |> 
  gt::gt()

