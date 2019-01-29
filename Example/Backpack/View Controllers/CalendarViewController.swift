//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2018. Skyscanner Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import Backpack.Calendar

class CalendarViewController: UIViewController, CalendarDelegate {
    @IBOutlet weak var myView: Backpack.Calendar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        myView.maxDate = Date(timeIntervalSince1970: 1609372800)
        myView.minDate = Date(timeIntervalSince1970: 1546300800)
        myView.locale = Locale.current
        myView.delegate = self

        // This causes the issue
//        myView.selectionType = .range
//        myView.selectedDates = [Date(timeIntervalSince1970: 1546473600), Date(timeIntervalSince1970: 1546819200)]
//        myView.reloadData()
//        myView.setNeedsLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // When selection change and selected dates change
        // here the issue does not happen
        myView.selectionType = .range
        myView.selectedDates = [Date(timeIntervalSince1970: 1546473600), Date(timeIntervalSince1970: 1546819200)]
        myView.reloadData()
        myView.setNeedsLayout()
    }

    @IBAction func valueChanged(_ sender: Any) {
        myView.selectionType = BPKCalendarSelection(rawValue: UInt(segmentedControl!.selectedSegmentIndex))!
        myView.reloadData()
    }

    func calendar(_ calendar: Backpack.Calendar!, didChangeDateSelection dateList: [Date]!) {
        print("calendar:", calendar, "didChangeDateSelection:", dateList)
    }

    func calendar(_ calendar: Backpack.Calendar!, didScroll contentOffset: CGPoint) {
        print("calendar:", calendar, "didScroll:", contentOffset)
    }
}
