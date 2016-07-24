//
//  FirstViewController.swift
//  cmtester
//
//  Created by Daniel Burke on 24/07/2016.
//  Copyright © 2016 Daniel Burke. All rights reserved.
//

import CoreMotion
import UIKit

class LiveViewController: UIViewController {
	let manager = CMMotionActivityManager();

	@IBOutlet var typeLabel: UILabel?;
	@IBOutlet var confidenceLabel: UILabel?;

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated);

		if (!CMMotionActivityManager.isActivityAvailable()) {
			NSLog("CMMotionActivityManager, no activity available.");

			self.typeLabel?.text = "No activity available.";
			self.confidenceLabel?.text = "";

			return;
		}

		self.typeLabel?.text = "Type: ?";
		self.confidenceLabel?.text = "Confidence: ?";

		manager.startActivityUpdatesToQueue(NSOperationQueue.mainQueue(),
		                                    withHandler:{ (activity:CMMotionActivity?) in self.handleActivity(activity); });
	}

	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated);
		manager.stopActivityUpdates();
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func handleActivity(activity:CMMotionActivity?) {
		if (activity == nil) {
			return;
		}

		var type: String;
		var confidence: String;

		if (activity!.automotive) {
			type = "Automotive";
		}
		else if (activity!.walking) {
			type = "Walking";
		}
		else if (activity!.cycling) {
			type = "Cycling";
		}
		else if (activity!.stationary) {
			type = "Stationary";
		}
		else {
			type = "Unknown";
		}

		switch activity!.confidence {
		case .High:
			confidence = "High";

		case .Medium:
			confidence = "Medium";

		case .Low:
			confidence = "Low";
		}

		self.typeLabel?.text = "Type: " + type;
		self.confidenceLabel?.text = "Confidence: " + confidence;
	}
}

