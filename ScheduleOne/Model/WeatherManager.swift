//
//  WeatherManager.swift
//  ScheduleOne
//
//  Created by MacBook on 23.09.2021.
//

import Foundation

protocol WeatherDelegate {
    
    func getData(_ temp: Float, _ icon: String)
}

struct WeatherManager {
    
    var weatherDelegate: WeatherDelegate?
    
    private let apiKey = "158ad76558d0df40e3b310c6152d85ce"
    let initialURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&"
    
    func getCityName(_ city: String) {
        let url = "\(initialURL)q=\(city)&appid=\(apiKey)"
        print(url)
        
        performRequest(url)
    }
    
    func performRequest(_ url: String) {
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil, let data = data else { return }
            
            parseJSON(data)
            
            
        }
       
        dataTask.resume()
    }
    
    func parseJSON(_ data: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            
            let temp = decodedData.main.temp
            let icon = decodedData.weather[0].icon
            
            print("temp is \(temp)")
            print("icon is \(icon)")
            
            weatherDelegate?.getData(temp, icon)
            
        } catch { print("error in parsing JSON \(error)")}
    }
    
    
    
}
