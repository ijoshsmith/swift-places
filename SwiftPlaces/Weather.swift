//
//  Weather.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/28/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation

/**
Data entity that represents the current weather of a Place.
Subclasses NSObject to enable Obj-C instantiation.
*/
class Weather : NSObject
{
    let
    temperatureC: Double,
    temperatureF: Double,
    humidity:     Int
    
    init(celcius: Double, humidity: Int)
    {
        self.temperatureC = celcius
        self.temperatureF = celcius * 9/5 + 32
        self.humidity     = humidity
    }
}
