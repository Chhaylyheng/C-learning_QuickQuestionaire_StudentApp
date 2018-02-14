//
//  BFiCCViewController.swift
//  C Learning Teacher
//
//  Created by kit on 2/14/2561 BE.
//  Copyright © 2561 BE kit. All rights reserved.
//

import UIKit
import Alamofire
class BFiCCViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var QuestioncmdCollection: UICollectionView?
    
    var qbID  =     ""
    var qbMode = ""
    var numArray : NSArray = []
    var perArray : NSArray = []
    var Cone : Int = 0
    var ConePer : Double = 0
    var Ctwo : Int = 0
    var CtwoPer : Double = 0
    var Cthree : Int = 0
    var CthreePer : Double = 0
    var Cfour : Int = 0
    var CfourPer : Double = 0
    var Cfive : Int = 0
    var CfivePer : Double = 0
    var cPosted : Array = [""]
    var text : Array = [""]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestioncmdCollection?.delegate = self
        QuestioncmdCollection?.dataSource = self
        if qbID == "" {
           
        } else {
            getAwnserFromStudent()
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return cPosted.count - 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : BarFiCCCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiveChoices", for: indexPath) as! BarFiCCCollectionViewCell
        cell.cmd.text = cPosted[indexPath.row+1]
        cell.name.text = text[indexPath.row+1]
        return cell
    }
    private func setBarChart() -> PNBarChart {
        let barChart = PNBarChart(frame: CGRect(x: 0, y: 135, width: 320, height: 200))
        barChart.backgroundColor = UIColor.clear
        barChart.animationType = .Waterfall
        barChart.labelMarginTop = 5.0
        barChart.xLabels = ["1", "2", "3", "4", "5"]
        barChart.yValues = [CGFloat(ConePer), CGFloat(CtwoPer), CGFloat(CthreePer), CGFloat(CfourPer), CGFloat(CfivePer)]
        barChart.strokeChart()
        barChart.center = self.view.center
        return barChart
        
    }
    
    func getAwnserFromStudent() {
        
        print(qbID)
        Alamofire.request("https://kit.c-learning.jp/t/ajax/quest/Bent", method: .post, parameters: ["qb":qbID ,"com": "1","mode":"ALL",], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            
            switch(response.result) {
            case .success(_):
                if let dictionary = response.result.value as? [String: Any] {
                    print(dictionary)
                    let res = dictionary["res"] as! NSDictionary
                    let bent = res["bent"] as? NSDictionary
                    let all = bent!["ALL"] as? NSArray
                    self.numArray = (all?.value(forKey: "num")  as! NSArray)
                    self.perArray = (all?.value(forKey: "per") as! NSArray)
                    let comment = res["comment"] as? NSDictionary
                    
                    
                    for i in 1...self.numArray.count - 1 {
                        
                        print(i)
                        switch i {
                        case 1 :
                            self.Cone = self.numArray[1] as! Int
                            self.ConePer = self.perArray[1] as! Double
                            break
                        case 2 :
                            self.Ctwo = self.numArray[2] as! Int
                            self.CtwoPer = self.perArray[2] as! Double
                            break
                        case 3:
                            self.Cthree = self.numArray[3] as! Int
                            self.CthreePer = self.perArray[3] as! Double
                            
                            break
                        case 4 :
                            self.Cfour = self.numArray[4] as! Int
                            self.CfourPer = self.perArray[4] as! Double
                            break
                        case 5 :
                            self.Cfive = self.numArray[5] as! Int
                            self.CfivePer = self.perArray[5] as! Double
                            break
                            
                        default:
                            break
                        }
                        
                        
                    }
                    
                    if self.Cone != 0 || self.Ctwo != 0 || self.Cthree != 0 || self.Cfour != 0 || self.Cfive != 0{
                        let barChart = self.setBarChart()
                        self.view.addSubview(barChart)
                        
                        
                    } else {
                        
                        
                        
                    }
                }
                break
                
            case .failure(_):
                print(response.result.error ?? "hek")
                break
                
            }
        }
    }
    
    
    
}







