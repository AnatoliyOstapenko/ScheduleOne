//
//  WeatherViewController.swift
//  ScheduleOne
//
//  Created by MacBook on 22.09.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var textLabel: String?
    var temp: String?
    var pic: String?

    

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var iconWeatherView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationController?.navigationBar.tintColor = .white

        cityLabel.text = textLabel
        tempLabel.text = temp
        getIcon()
        

    
    }
    
    // converting icon url to UIImage
    func getIcon() {
        
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(pic!)@2x.png") else { return }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.iconWeatherView.image = UIImage(data: data)
                }
                
                    
            }
        }
    }
    
}



