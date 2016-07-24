//
//  util.swift
//  cmtester
//
//  Created by Daniel Burke on 24/07/2016.
//  Copyright © 2016 Daniel Burke. All rights reserved.
//

import CoreMotion
import Foundation

func activityToType(activity:CMMotionActivity) -> String {
	if (activity.automotive) {
		return "Automotive";
	}
	else if (activity.walking) {
		return "Walking";
	}
	else if (activity.cycling) {
		return "Cycling";
	}
	else if (activity.stationary) {
		return "Stationary";
	}
	else {
		return "Unknown";
	}
}

func activityConfidenceToString(activity:CMMotionActivity) -> String {
	switch activity.confidence {
	case .High:
		return "High";

	case .Medium:
		return "Medium";

	case .Low:
		return "Low";
	}
}