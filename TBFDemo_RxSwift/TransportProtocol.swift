//
//  TransportProtocol.swift
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

protocol GoEuroAPI {
    
    func fetchTransportData(type: TransportMode) -> Observable<[TransportModel<String>]> 
}