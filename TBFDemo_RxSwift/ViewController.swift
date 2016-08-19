//
//  ViewController.swift
//  TBFDemo_RxSwift
//
//  Created by khan on 16/08/16.
//  Copyright © 2016 TBF. All rights reserved.
//

import UIKit
import RxDataSources
import SDWebImage
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var transportTableView: UITableView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, TransportModel<String>>>()
    let transportViewModel = TransportViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.transportTableView.separatorColor = UIColor.clearColor()
        dataSource.configureCell = { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCellWithIdentifier(SC.TIMELINECELL) as! TimeLineCell
            let imgURL = element.logo.stringByReplacingOccurrencesOfString(SC.SIZEREPLACE, withString: SC.SIZEVALUE)
            cell.logoImageView.sd_setImageWithURL(NSURL(string: imgURL))
            
            let dpHourArray = element.departureTime.characters.split{$0 == ":"}.map(String.init)
            let arHourArray = element.arrivalTime.characters.split{$0 == ":"}.map(String.init)
            let finalDepTime = "\(dpHourArray[0].addingLeadingZeros()):\(dpHourArray[1])"
            let finalArTime   = "\(arHourArray[0].addingLeadingZeros()):\(arHourArray[1])"
            cell.departureTime.text = String(finalDepTime)
            cell.arrivalTime.text = String(finalArTime)
            let params = (element.departureTime, element.arrivalTime)
            cell.duration.text = TupleStruct(value: params).durationOfTransport()
            cell.price.text = String(Double(element.price)!.formatAsCurrency(SC.CURRENCY))
            cell.noOfStops.text = String(Int(element.noOfStops)!.zeroOrMore())

            return cell
        }
        
   
        //replaced nested subscriptions with flatmaplatest
   
        
        let segmentedValue = Variable(0)
        segmentControl.rx_value <-> segmentedValue
        
        segmentedValue.asObservable()
            .flatMapLatest{[weak self] index  in
                return self!.transportViewModel.fetchTransportData(TransportMode(rawValue: index)!)
                }
            .bindTo(transportTableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(disposeBag)
        
        
        self.transportTableView.rx_setDelegate(self)
    }

    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
          TimeLineCell.animate(cell)
    }
         
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

