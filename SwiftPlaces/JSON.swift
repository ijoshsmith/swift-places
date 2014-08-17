//
//  JSON.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/28/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation

/** All possible outputs of the JSONObjectWithData function. */
enum JSONObjectWithDataResult
{
    case Success(AnyObject)
    case Failure(NSError)
}

/** 
Attempts to convert the specified data object to JSON data
objects and returns either the root JSON object or an error.
*/
func JSONObjectWithData(
    data:    NSData,
    options: NSJSONReadingOptions = nil)
    -> JSONObjectWithDataResult
{
    var error: NSError?
    let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(
        data,
        options: options,
        error:  &error)
    return json != nil
        ? .Success(json!)
        : .Failure(error ?? NSError())
}
