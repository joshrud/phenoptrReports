% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/merge_cell_seg_files.R
\name{merge_cell_seg_files}
\alias{merge_cell_seg_files}
\title{Merge inForm output from multiple fields.}
\usage{
merge_cell_seg_files(base_path, update_progress = NULL, recursive = FALSE)
}
\arguments{
\item{base_path}{Path to a directory containing files to merge. All
eligible files in this directory will be merged.}

\item{update_progress}{Callback function which is called with progress.}

\item{recursive}{If TRUE, will find files in subdirectories of \code{base_path}.}
}
\description{
\code{merge_cell_seg_files} merges inForm output from individual fields,
creating "Merge" data files. This is similar to the inForm Merge tab but
does not include the ability to review and reject individual fields.
}
