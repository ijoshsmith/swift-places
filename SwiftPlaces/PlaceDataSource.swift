//
//  PlaceDataSource.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/27/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import UIKit

/** Manages Place objects for the search controller's UITableView. */
class PlaceDataSource: NSObject, UITableViewDataSource
{
    init(tableView: UITableView)
    {
        self.tableView = tableView
    }
    
    var places: [Place] = [] { didSet { tableView.reloadData() } }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return places.count
    }

    func tableView(tv: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let
        cell = tv.dequeueReusableCellWithIdentifier("") as? UITableViewCell
            ?? UITableViewCell(style: .Default, reuseIdentifier: ""),
        place = places[indexPath.row]
        cell.textLabel!.text = place.name
        return cell
    }
    
    // MARK: - State
    
    private weak var tableView: UITableView!
}
