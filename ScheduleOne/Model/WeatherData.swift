//
//  WeatherData.swift
//  ScheduleOne
//
//  Created by MacBook on 23.09.2021.
//

import Foundation

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    
}

struct Weather: Codable {
    let icon: String
}

struct Main: Codable {
    let temp: Float
}
