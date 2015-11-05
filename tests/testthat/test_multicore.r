context("cf multicore")

test_that("cf multicore", {
  skip_on_os("windows")

  reg = makeTempRegistry(make.default = FALSE)
  reg$cluster.functions = makeClusterFunctionsMulticore(ncpus = 1L, max.load = 99, max.jobs = 99)
  ids = batchMap(Sys.sleep, time = c(5, 10), reg = reg)
  submitJobs(1:2, reg = reg)
  expect_equal(findOnSystem(reg = reg), findJobs(reg = reg))
  expect_true(killJobs(2, reg = reg)$killed)
  expect_true(waitForJobs(1, reg = reg))
  expect_equal(findDone(reg = reg), findJobs(ids = 1, reg = reg))
  expect_equal(findNotDone(reg = reg), findJobs(ids = 2, reg = reg))
})