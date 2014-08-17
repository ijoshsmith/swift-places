//
//  Operators.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/25/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation

/*
Marshal operator
Source: ijoshsmith.com/2014/07/05/custom-threading-operator-in-swift/
*/
infix operator ~> {}

// Serial dispatch queue used by the ~> operator.
private let queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL)

/**
Executes the lefthand closure on a background thread and,
upon completion, the righthand closure on the main thread.
*/
func ~> (
    backgroundClosure: () -> (),
    mainClosure:       () -> ())
{
    dispatch_async(queue) {
        backgroundClosure()
        dispatch_async(dispatch_get_main_queue(), mainClosure)
    }
}

/**
Executes the lefthand closure on a background thread and,
upon completion, the righthand closure on the main thread.
Passes the background closure's output to the main closure.
*/
func ~> <R> (
    backgroundClosure: () -> R,
    mainClosure:       (result: R) -> ())
{
    dispatch_async(queue) {
        let result = backgroundClosure()
        dispatch_async(dispatch_get_main_queue()) {
            mainClosure(result: result)
        }
    }
}
