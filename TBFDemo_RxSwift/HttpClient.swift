//
//  HttpClient.swift
//  TBFDemo_RxSwift
//
//  Created by khan on 16/08/16.
//  Copyright © 2016 TBF. All rights reserved.
//

import Foundation
import SwiftyJSON
#if !RX_NO_MODULE
    import RxSwift
    import RxAlamofire
    import RxCocoa
#endif


class DefaultAPI: GoEuroAPI {
    
    let URLSession: NSURLSession
    let disposeBag = DisposeBag()
    static let sharedAPI = DefaultAPI(
        URLSession: NSURLSession.sharedSession()
    )
    
    init(URLSession: NSURLSession) {
        self.URLSession = URLSession
    }
    

   static func parseJSON(data: AnyObject) -> [TransportModel<String>] {
        
        var transportModel: [TransportModel<String>] = [TransportModel<String>]()
        let json = JSON(data).arrayValue
        for item in json {
            
            let id = item[kId].stringValue
            let logo = item[kLogo].stringValue
            let departuteTime = item[kDepartureTime].stringValue
            let arrivalTime = item[kArrivalTime].stringValue
            let numberOfStops = item[kNumberOfStops].stringValue
            let price  = item[kPriceInEuros].stringValue
            
            let model  = TransportModel<String>(id: id, logo: logo, price: price, departureTime: departuteTime, arrivalTime: arrivalTime, noOfStops: numberOfStops)
            transportModel.append(model!)
        }
        
        return transportModel
    }
    
    func fetchTransportData(type: TransportMode) -> Observable<[TransportModel<String>]>  {
        
        var endPoint: String?
        
        switch type {
        case .Flight:   endPoint = Config.Endpoints.flightURL
        case .Train:    endPoint = Config.Endpoints.trainURL
        case .Bus:      endPoint = Config.Endpoints.busURL
        }
        
         let url = NSURL(string: endPoint!)
            return  requestJSON(.GET, url!)
                    .map{response, data in return DefaultAPI.parseJSON(data)}
    }
}