//
//  PlaceBuilder.h
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/26/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Weather;

/** Creates an array of Place data objects. */
extern NSArray *BuildPlacesFromJSON(id json);

/** Creates a Weather data object. */
extern Weather *BuildWeatherFromJSON(id json);
