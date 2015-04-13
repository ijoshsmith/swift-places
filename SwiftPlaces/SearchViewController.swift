//
//  ViewController.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/25/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import UIKit

/** Shows a search bar and lists places found by postal code. */
class SearchViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = "Search"
        
        dataSource = PlaceDataSource(tableView: tableView)
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        // Allow the primary and detail views to show simultaneously.
        splitViewController!.preferredDisplayMode = .AllVisible

        // Show an "empty view" on the right-hand side, only on an iPad.
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
        {
            let emptyVC = storyboard!.instantiateViewControllerWithIdentifier("EmptyPlaceViewController") as! UIViewController
            splitViewController!.showDetailViewController(emptyVC, sender: self)
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let placeVC = storyboard!.instantiateViewControllerWithIdentifier("PlaceViewController") as! PlaceViewController
        placeVC.place = dataSource.places[indexPath.row]
        showDetailViewController(placeVC, sender: self)
    }
    
    // MARK: - UISearchBarDelegate
    
    // Called when the keyboard search button is pressed.
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        let input = searchBar.text?
            .stringByTrimmingCharactersInSet(
                NSCharacterSet.whitespaceCharacterSet())
        
        if let postalCode = input
        {
            if performSearchForPostalCode(postalCode)
            {
                searchBar.resignFirstResponder()
            }
            else
            {
                let image = UIImage(named: "ErrorColor")
                searchBar.showErrorMessage("Numbers only!", backgroundImage: image)
            }
        }
    }
    
    // MARK: - Search service
    
    private func performSearchForPostalCode(postalCode: String) -> Bool
    {
        let valid = postalCode.toInt() != nil
        if valid
        {
            let url = URLFactory.searchWithPostalCode(postalCode)
            JSONService
                .GET(url)
                .success({json in {self.makePlaces(json)} ~> {self.showPlaces($0)}})
                .failure(onFailure, queue: NSOperationQueue.mainQueue())
        }
        return valid
    }
    
    private func makePlaces(json: AnyObject) -> [Place]
    {
        if let places = BuildPlacesFromJSON(json) as? [Place]
        {
            if let unique = NSSet(array: places).allObjects as? [Place]
            {
                return unique.sorted { $0.name < $1.name }
            }
        }
        return []
    }
    
    private func showPlaces(places: [Place])
    {
        dataSource.places = places
    }
    
    private func onFailure(statusCode: Int, error: NSError?)
    {
        println("HTTP status code \(statusCode)")
        
        let
        title = "Error",
        msg   = error?.localizedDescription ?? "An error occurred.",
        alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .Default,
            handler: { _ in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - State
    
    private var dataSource: PlaceDataSource!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
}
