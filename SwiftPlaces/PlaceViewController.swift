//
//  PlaceViewController.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/28/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import UIKit

/** 
Displays detailed information about a place including
its current weather, which is fetched on demand.
*/
class PlaceViewController: UIViewController
{
    required init(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    /** The place to display. */
    var place: Place!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.title = "Place Info"
        
        nameLabel.text = place.name
        postalCodeLabel.text = place.postalCode
        locationLabel.text = PlaceFormatter.formatCoordinatesForPlace(place)
        weatherLabel.text = "loading…"
        
        fetchWeather()
    }
    
    // MARK: - Weather service
    
    private func fetchWeather()
    {
        let
        plc = place!,
        lat = plc.latitude,
        lng = plc.longitude,
        url = URLFactory.weatherAtLatitude(lat, longitude: lng)
        JSONService
            .GET(url)
            .success({json in {
                 self.makeWeather(json)} ~> {self.showWeather($0)}})
            .failure(onFailure, queue: NSOperationQueue.mainQueue())
    }
    
    private func makeWeather(json: AnyObject) -> Weather
    {
        return BuildWeatherFromJSON(json)
    }
    
    private func showWeather(weather: Weather)
    {
        let weatherFormatter = WeatherFormatter(useCelcius: useCelcius)
        weatherLabel.text = weatherFormatter.formatWeather(weather)
        let myUrl = String(format:"http://maps.google.com/?q=%f,%f", place.latitude,place.longitude)
        let url = NSURL(string: myUrl )
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    private var useCelcius: Bool
    {
        get { return NSLocale.currentLocale()
            .objectForKey(NSLocaleUsesMetricSystem)!.boolValue }
    }
    
    private func onFailure(statusCode: Int, error: NSError?)
    {
        println("HTTP status code \(statusCode) Error: \(error)")
        
        self.weatherLabel.text = "unavailable"
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var postalCodeLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
}
