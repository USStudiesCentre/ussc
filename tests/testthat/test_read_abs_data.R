library(usscr)
data_path <- "../testdata/5206002_expenditure_volume_measures.xls"

test_that("Check that the resulting output contains three headers", {
    result <- usscr::read_abs_data(data_path, sheet=2)
    print(colnames(result))
    expect_equal(colnames(result), c("Date", "series", "value"))
})
