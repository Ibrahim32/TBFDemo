//
//  Config.swift
//  TBFDemo_RxSwift
//
//  Created by khan on 16/08/16.
//  Copyright © 2016 TBF. All rights reserved.
//

import Foundation


struct Config {
    
    struct Endpoints {
        
        static let baseURL      = "https://api.myjson.com/bins"
        static let flightURL    = "\(baseURL)/w60i"
        static let trainURL     = "\(baseURL)/3zmcy"
        static let busURL       = "\(baseURL)/37yzm"
    }
}
