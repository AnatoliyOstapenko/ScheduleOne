//
//  WeatherViewController.swift
//  ScheduleOne
//
//  Created by MacBook on 22.09.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var textLabel: String?

    
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityLabel.text = textLabel
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
