//
//  Transport.swift
//  TBFDemo_RxSwift
//
//  Created by khan on 16/08/16.
//  Copyright © 2016 TBF. All rights reserved.
//

import Foundation



//Constants
    let kId             = "id"
    let kLogo           = "provider_logo"
    let kPriceInEuros   = "price_in_euros"
    let kDepartureTime  = "departure_time"
    let kArrivalTime    = "arrival_time"
    let kNumberOfStops  = "number_of_stops"

struct TransportModel <T> {
    
    let id: T
    let logo : T
    let price : T
    let departureTime: T
    let arrivalTime : T
    let noOfStops: T
    
    init?(id: T, logo: T, price: T, departureTime: T, arrivalTime: T, noOfStops: T) {
        
        self.id             = id
        self.logo           = logo
        self.price          = price
        self.departureTime  = departureTime
        self.arrivalTime    = arrivalTime
        self.noOfStops      = noOfStops
        
    }
    
    func fromJSON () -> [String: T] {
        
        let json = [    kId : id,
                        kLogo: logo,
                        kPriceInEuros: price,
                        kDepartureTime: departureTime,
                        kArrivalTime: arrivalTime,
                        kNumberOfStops: noOfStops   ]
        return json
        
    }
    
}