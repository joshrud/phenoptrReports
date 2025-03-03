% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/excel_helpers.R
\name{write_count_within_sheet}
\alias{write_count_within_sheet}
\title{Write a "count within" summary to an Excel workbook}
\usage{
write_count_within_sheet(
  wb,
  stats,
  sheet_name = "Count Within",
  sheet_title = "Count of cells within the specified radius"
)
}
\arguments{
\item{wb}{An openxlsx Workbook from \link[openxlsx:createWorkbook]{openxlsx::createWorkbook}}

\item{stats}{A summary data frame.}

\item{sheet_name}{Optional name for the worksheet.}

\item{sheet_title}{Optional title header for the table.}
}
\description{
Write a formatted "count within" summary table to a
sheet in an Excel workbook.
}
\seealso{
Other output functions: 
\code{\link{write_counts_sheet}()},
\code{\link{write_density_sheet}()},
\code{\link{write_expression_sheet}()},
\code{\link{write_h_score_sheet}()},
\code{\link{write_nearest_neighbor_summary_sheet}()},
\code{\link{write_percents_sheet}()},
\code{\link{write_plot_sheet}()},
\code{\link{write_summary_sheet}()}
}
\concept{output functions}
