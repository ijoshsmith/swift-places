//
//  URLFactory.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/25/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation

/** Builds the URLs needed to call Web services. */
class URLFactory
{
    /** 
    Creates a URL that searches for places with a certain postal code.
    Only supports numeric postal codes, due to a Web service limitation.
    */
    class func searchWithPostalCode(postalCode: String) -> NSURL
    {
        return urlWithName("postalCodeSearchJSON",
            args: [
                "postalcode" : postalCode,
                "maxRows"    : String(20)])
    }
    
    /** Creates a URL that looks up the weather at a geographic location. */
    class func weatherAtLatitude(latitude:  Double, longitude: Double) -> NSURL
    {
        let format = { f in String(format: "%.5f", f) }
        return urlWithName("findNearByWeatherJSON",
            args: [
                "lat" : format(latitude),
                "lng" : format(longitude)])
    }
    
    private class func urlWithName(name: String, var args: [String: String]) -> NSURL
    {
        args["username"] = "ijoshsmith"
        let
        baseURL      = "http://api.geonames.org/",
        queryString  = queryWithArgs(args),
        absolutePath = baseURL + name + "?" + queryString
        return NSURL(string: absolutePath)!
    }
    
    private class func queryWithArgs(args: [String: String]) -> String
    {
        let parts: [String] = reduce(args, [])
        {
            result, pair in
            let
            key   = pair.0,
            value = pair.1,
            part  = "\(key)=\(value)"
            return result + [part]
        }
        return (parts as NSArray).componentsJoinedByString("&")
    }
}
