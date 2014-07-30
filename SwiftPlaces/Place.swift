//
//  Place.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/26/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation

/** 
Data entity that represents a geographic area. 
Subclasses NSObject to enable Obj-C instantiation.
*/
class Place : NSObject, Equatable
{
    let
    latitude:   Double,
    longitude:  Double,
    name:       String,
    postalCode: String
    
    init(
        latitude:   Double,
        longitude:  Double,
        name:       String,
        postalCode: String)
    {
        self.latitude   = latitude
        self.longitude  = longitude
        self.name       = name
        self.postalCode = postalCode
    }
    
    // Used by Foundation collections, such as NSSet.
    override var hash: Int
    {
        get { return hashValue }
    }
    
    // I'm not sure where this is inherited from, 
    // or if it needs to be overridden.
    override var hashValue: Int
    {
        get { return name.hashValue }
    }
    
    // Used by Foundation collections, such as NSSet.
    override func isEqual(object: AnyObject!) -> Bool
    {
        return self == object as Place
    }
}

// Required for Equatable protocol conformance
func == (lhs: Place, rhs: Place) -> Bool
{
    return lhs.name == rhs.name
}
