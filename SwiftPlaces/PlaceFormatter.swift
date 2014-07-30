//
//  PlaceFormatter.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/28/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation

/** Creates display text from a Place object. */
class PlaceFormatter
{
    class func formatCoordinatesForPlace(place: Place) -> String
    {
        let
        fmt = { String(format: "%.2f", $0) },
        lat = fmt(place.latitude),
        lng = fmt(place.longitude)
        return "(\(lat), \(lng))"
    }
}
