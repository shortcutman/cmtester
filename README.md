# cmtester
CoreMotion test app

Two views:
* One with current live data via CMMotionActivityManager.startActivityUpdatesToQueue
* One with historic data from the past 24 hours via CMMotionActivityManager.queryActivityStartingFromDate

Currently in use to debug crappy 'automotive' output from CoreMotion on an iPhone 5s. Don't know if it is related to the M7 specifically utilised in 5s and improved in newer phones, or if its just shitty software algorithms.
