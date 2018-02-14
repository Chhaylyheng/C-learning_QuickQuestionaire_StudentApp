//
//  DetailViewController.swift
//  PNChartSwift
//
//  Created by YiChen Zhou on 8/14/17.
//

import UIKit
import Alamofire


class DetailViewController: UIViewController {
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
    
    
    

    
    @IBAction func cancleBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Main")
        self.present(controller, animated: true, completion: nil)
    }
    
    func getAwnserFromStudent() {
        
        Alamofire.request("https://kit.c-learning.jp/t/ajax/quest/Bent", method: .post, parameters: ["qb":qbID ,"com": "0","mode":"ALL",], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
//            switch(response.result) {
//            case .success(_):
//                if let dictionary = response.result.value as? [String: Any] {
//
//                      print (dictionary)
////                    let res = dictionary["res"] as! NSDictionary
////                    let bent = res["bent"] as? NSDictionary
////                    let all = bent!["ALL"] as? NSArray
////                    self.numArray = (all?.value(forKey: "num")  as! NSArray)
////                    self.perArray = (all?.value(forKey: "per") as! NSArray)
////                    self.yesNum = self.numArray[1] as! Int
////                    self.noNum = self.numArray[2] as! Int
////                    self.yesPer = self.perArray[1] as! Int
////                    self.noPer = self.perArray[2] as! Int
////                    if self.yesNum != 0 || self.noNum != 0 {
////                        let pieChart = self.setPieChart()
////                        self.view.addSubview(pieChart)
//                        // self.noanwserYet.isHidden = true
//
//                    } else {
//                      //  self.noanwserYet.text = "No answer yet!"
//                    }
//            }
//                break
//
//            case .failure(_):
//                print(response.result.error ?? "hek")
//                break
//
//            }
//        }
//
//
//
//    }
    
}

}
}
