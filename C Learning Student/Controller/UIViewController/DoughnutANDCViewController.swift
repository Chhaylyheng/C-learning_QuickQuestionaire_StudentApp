//
//  DoughnutANDCViewController.swift
//  C Learning Teacher
//
//  Created by kit on 2/13/2561 BE.
//  Copyright © 2561 BE kit. All rights reserved.
//

import UIKit
import Alamofire
class DoughnutANDCViewController: UIViewController {

   
    var chartName: String?
    var qbID = ""
    var numArray : NSArray = []
    var perArray : NSArray = []
    var yesNum : Int = 0
    var yesPer : Int = 0
    var noNum  : Int = 0
    var noPer : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        if qbID == "" {
            
        } else {
            getAwnserFromStudent()
        }
        
    }
    
    private func setPieChart() -> PNPieChart {
        let yesString = "\(yesNum)"
        let noString = "\(noNum)"
        let item1 = PNPieChartDataItem(dateValue: CGFloat(yesPer), dateColor:  PNLightGreen, description: "Agree"+","+yesString)
        let item2 = PNPieChartDataItem(dateValue: CGFloat(noPer), dateColor: PNRed, description: "Disagree"+","+noString)
        let frame = CGRect(x: 40, y: 155, width: 240, height: 240)
        let items: [PNPieChartDataItem] = [item1, item2]
        let pieChart = PNPieChart(frame: frame, items: items)
        pieChart.descriptionTextColor = UIColor.white
        pieChart.descriptionTextFont = UIFont(name: "Avenir-Medium", size: 14)!
        pieChart.center = self.view.center
        return pieChart
    }
    
    
   
    func getAwnserFromStudent() {
        
        Alamofire.request("https://kit.c-learning.jp/t/ajax/quest/Bent", method: .post, parameters: ["qb":qbID ,"com": "0","mode":"ALL",], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let dictionary = response.result.value as? [String: Any] {
                    
                    print (dictionary)
                    let res = dictionary["res"] as! NSDictionary
                    let bent = res["bent"] as? NSDictionary
                    let all = bent!["ALL"] as? NSArray
                    self.numArray = (all?.value(forKey: "num")  as! NSArray)
                    self.perArray = (all?.value(forKey: "per") as! NSArray)
                    self.yesNum = self.numArray[1] as! Int
                    self.noNum = self.numArray[2] as! Int
                    self.yesPer = self.perArray[1] as! Int
                    self.noPer = self.perArray[2] as! Int
                    let pieChart = self.setPieChart()
                    self.view.addSubview(pieChart)
                }
                break
                
            case .failure(_):
                print(response.result.error ?? "hek")
                break
                
            }
        }
        
        
        
    }
    
}



