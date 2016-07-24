//
//  SecondViewController.swift
//  cmtester
//
//  Created by Daniel Burke on 24/07/2016.
//  Copyright © 2016 Daniel Burke. All rights reserved.
//

import CoreMotion
import UIKit

class HistoricViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	let manager = CMMotionActivityManager();
	var activities = [CMMotionActivity]();

	@IBOutlet var fuckedTableView: UITableView?;

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);

		if !CMMotionActivityManager.isActivityAvailable() {
			return;
		}

		manager.queryActivityStartingFromDate(NSDate(timeIntervalSinceNow: -1*60*60*24), toDate: NSDate(timeIntervalSinceNow: 0), toQueue: NSOperationQueue.mainQueue(), withHandler:{ (activity, error) in self.handleActivity(activity, error: error);
		});
	}

	func handleActivity(activities:[CMMotionActivity]?, error:NSError?) {
		if error != nil {
			NSLog("Error: %@", error!);
			self.activities = []
		}
		else {
			self.activities = activities!;
		}

		self.fuckedTableView!.reloadData();
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1;
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return activities.count;
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell: UITableViewCell?;

		cell = tableView.dequeueReusableCellWithIdentifier("basiccell");
		if cell == nil {
			cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "basiccell");
		}

		let forma = NSDateFormatter();
		forma.dateStyle = .ShortStyle;
		forma.timeStyle = .ShortStyle;
		forma.timeZone = NSTimeZone.localTimeZone();

		let act = activities[indexPath.row];
		cell?.textLabel?.text = activityToType(act) + " @ " + forma.stringFromDate(act.startDate);
		cell?.detailTextLabel?.text = activityConfidenceToString(act);

		return cell!;
	}
}

