//
//  TransportViewModel.swift
//  TBFDemo_RxSwift
//
//  Created by khan on 16/08/16.
//  Copyright © 2016 TBF. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxDataSources
#if !RX_NO_MODULE
    import RxSwift
    import RxAlamofire
    import RxCocoa

#endif


class TransportViewModel {
    
 
    func fetchTransportData(type: TransportMode) -> Observable<[SectionModel<String, TransportModel<String>>]>  {
        
        return DefaultAPI.sharedAPI.fetchTransportData(type)
            .map{(data: [TransportModel<String>]) -> [SectionModel<String, TransportModel<String>>] in
                [SectionModel(model: "", items: data)]
            }
   }
}