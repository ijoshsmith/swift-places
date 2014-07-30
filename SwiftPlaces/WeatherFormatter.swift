//
//  WeatherFormatter.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/28/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation

/** Creates display text from a Weather object. */
class WeatherFormatter
{
    init(useCelcius: Bool)
    {
        self.useCelcius = useCelcius
    }
    
    func formatWeather(weather: Weather) -> String
    {
        let
        temp    = useCelcius ? weather.temperatureC : weather.temperatureF,
        symbol  = useCelcius ? "C" : "F"
        return "\(Int(temp))°\(symbol)  \(weather.humidity)% humidity"
    }
    
    private let useCelcius: Bool
}
