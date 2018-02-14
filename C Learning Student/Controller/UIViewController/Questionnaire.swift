//
//  ViewController.swift
//  C Learning Teacher
//
//  Created by kit on 2/6/2561 BE.
//  Copyright © 2561 BE kit. All rights reserved.
//

import UIKit
import Alamofire
class Questionnaire: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var QuestionCollection: UICollectionView!
    var refreshControl: UIRefreshControl!
    var questionTitle : NSArray = []
    var questionType: NSArray  = []
    var questionQb : NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionCollection.delegate = self
        QuestionCollection.dataSource = self
        self.getQuestionAPI()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refresh:", for: UIControlEvents.allTouchEvents)
        QuestionCollection.addSubview(refreshControl)
        
    }
    func refresh(sender:AnyObject) {
      self.getQuestionAPI()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return questionType.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : QCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "QCell", for: indexPath) as! QCollectionViewCell
        
        if questionType == [] {
            cell.questionBtn.setTitle("No connection", for: .normal)
        } else {
            cell.questionBtn.setTitle(questionTitle[indexPath.row] as? String, for: .normal)
            cell.questionBtn.tag = indexPath.row
            cell.questChange.tag = indexPath.row
//            cell.deleted.tag  = indexPath.row
           cell.questionBtn.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
            cell.questChange.addTarget(self, action: #selector(btnResult), for: .touchUpInside)
//            cell.deleted.addTarget(self, action: #selector(deletedHandler), for: .touchUpInside)
            
        }
        return cell
    }
    
    @IBAction func SwipPen(_ sender: Any) {
        self.getQuestionAPI()
    }
    
    // Button handle the result of student submission to show Chart
    
    @IBAction func btnResult(_ sender: UIButton){
        let questType = questionType[sender.tag] as! String
        print(questionType[sender.tag] as! String)
        let checkQuestqbID = "\(questType)"
        if checkQuestqbID == "22" || checkQuestqbID == "23" {
             let Dtail = storyboard?.instantiateViewController(withIdentifier: "Doughnut") as! DoughnutViewController
            Dtail.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(Dtail, animated: true)
            
        } else if checkQuestqbID == "24" || checkQuestqbID == "25" {
            let AND = storyboard?.instantiateViewController(withIdentifier: "AND") as! DoughnutANDViewController
            AND.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(AND, animated: true)
            
        }else if checkQuestqbID == "20" || checkQuestqbID == "21"  {
            let DTC = storyboard?.instantiateViewController(withIdentifier: "DTC") as! DoughnutTCViewController
            DTC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(DTC, animated: true)

        }else if checkQuestqbID == "40"{
            let BCFC = storyboard?.instantiateViewController(withIdentifier: "BCFC") as! BarChartFCViewController
            BCFC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(BCFC, animated: true)

        }else if checkQuestqbID == "30"{
            let BarChart = storyboard?.instantiateViewController(withIdentifier: "BarChart") as! BarChartViewController
            BarChart.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(BarChart, animated: true)

        }else if checkQuestqbID == "50" {
            let BCFiC = storyboard?.instantiateViewController(withIdentifier: "BCFiC") as! BarChartFiCViewController
            BCFiC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(BCFiC, animated: true)
            
        }else if checkQuestqbID == "51"{
            let BFiCC = storyboard?.instantiateViewController(withIdentifier: "BFiCC") as! BFiCCViewController
            BFiCC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(BFiCC, animated: true)
            
        }else if checkQuestqbID == "41"{
            let BFCC = storyboard?.instantiateViewController(withIdentifier: "BFCC") as! BFCCViewController
            BFCC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(BFCC, animated: true)
            
        }else if checkQuestqbID == "31"{
            let BThCC = storyboard?.instantiateViewController(withIdentifier: "BThCC") as! BThCCViewController
            BThCC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(BThCC, animated: true)

        }
    }
    //        }else if checkQuestqbID == "23" {
    //            let DYNC = storyboard?.instantiateViewController(withIdentifier: "DYNC") as! DoughnutYNCViewController
    //            DYNC.qbID  = questionQb[sender.tag] as! String
    //            navigationController?.pushViewController(DYNC, animated: true)
    //
    //        }else if checkQuestqbID == "25" {
    //            let DANDC = storyboard?.instantiateViewController(withIdentifier: "DANDC") as! DoughnutANDCViewController
    //            DANDC.qbID  = questionQb[sender.tag] as! String
    //            navigationController?.pushViewController(DANDC, animated: true)
    //
    //        }else if checkQuestqbID == "21" {
    //            let DTCC = storyboard?.instantiateViewController(withIdentifier: "DTCC") as! DoughnutTCCViewController
    //            DTCC.qbID  = questionQb[sender.tag] as! String
    //            navigationController?.pushViewController(DTCC, animated: true)

    
    // Button to delte question
    
    @IBAction func deletedHandler(_ sender: UIButton) {
        let questionqbID = questionQb[sender.tag] as! String
        let checkQuestionqbID = "\(questionqbID)"
        print(checkQuestionqbID)
        deteleQuestionAPI(qb: checkQuestionqbID)
        
    }
    
    // Button handle to get question list
    
    @IBAction func buttonHandler(_ sender: UIButton) {
        print(questionType,"asdf")
        let questionTypes = questionType[sender.tag] as! String
        print(questionType[sender.tag] as! String)
        let checkQuestionqbID = "\(questionTypes)"
        if checkQuestionqbID == "22" {
            let YN = storyboard?.instantiateViewController(withIdentifier: "YN") as! DetailViewController
            YN.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(YN, animated: true)
            
        } else if checkQuestionqbID == "23"{
            let YNC = storyboard?.instantiateViewController(withIdentifier: "YN*") as! YNCViewController
            YNC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(YNC, animated: true)
           
        } else if checkQuestionqbID == "24"{
            let AG = storyboard?.instantiateViewController(withIdentifier: "AG") as! AGViewController
            AG.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(AG, animated: true)
        } else if checkQuestionqbID == "25"{
            let AGC = storyboard?.instantiateViewController(withIdentifier: "AGC") as! AGCViewController
            AGC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(AGC, animated: true)
            
        }else if checkQuestionqbID == "20"{
            let TC = storyboard?.instantiateViewController(withIdentifier: "TC") as! TCViewController
            TC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(TC, animated: true)
            
        }else if checkQuestionqbID == "21"{
            let TCC = storyboard?.instantiateViewController(withIdentifier: "TCC") as! TCCViewController
            TCC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(TCC, animated: true)
        
        }else if checkQuestionqbID == "30"{
            let ThC = storyboard?.instantiateViewController(withIdentifier: "ThC") as! ThCViewController
            ThC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(ThC, animated: true)
        
        }else if checkQuestionqbID == "31"{
            let ThCC = storyboard?.instantiateViewController(withIdentifier: "ThCC") as! ThCCViewController
            ThCC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(ThCC, animated: true)
            
        }else if checkQuestionqbID == "40"{
            let FC = storyboard?.instantiateViewController(withIdentifier: "FC") as! FCViewController
            FC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(FC, animated: true)
        
        }else if checkQuestionqbID == "41"{
            let FCC = storyboard?.instantiateViewController(withIdentifier: "FCC") as! FCCViewController
            FCC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(FCC, animated: true)
            
        }else if checkQuestionqbID == "50"{
            let FiC = storyboard?.instantiateViewController(withIdentifier: "FiC") as! FiCViewController
            FiC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(FiC, animated: true)
            
        }else if checkQuestionqbID == "51"{
            let FiCC = storyboard?.instantiateViewController(withIdentifier: "FiCC") as! FiCCViewController
            FiCC.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(FiCC, animated: true)
            
        }else if checkQuestionqbID == "1"{
            let CO = storyboard?.instantiateViewController(withIdentifier: "CO") as! COViewController
            CO.qbID  = questionQb[sender.tag] as! String
            navigationController?.pushViewController(CO, animated: true)
        }else {
            
        }
    }
//    @IBAction func quickBtn(_ sender: UIButton) {
//        let vc = CustomAlertViewController()
//        self.present(vc, animated: true)
//    }
//
    
    // API for deleting question
    
    func deteleQuestionAPI(qb : String) {
        Alamofire.request("https://kit.c-learning.jp/t/ajax/quest/Delete", method: .post, parameters: ["qb":qb,], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                  print(response.result.value)
                }
                self.getQuestionAPI()
                break
                
            case .failure(_):
                print(response.result.error)
                break
                
            }
        }
        
    }
    
    // API to get question
    
    func getQuestionAPI() {
        Alamofire.request("https://kit.c-learning.jp/t/ajax/quest/Question", method: .get, parameters: ["":"",], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let dictionary = response.result.value as? [String: Any] {

                    for i in dictionary {
                        
                        if let test = i.value as? NSArray {
                            self.questionTitle = test.value(forKey: "qbTitle") as! NSArray
                            self.questionType = (test.value(forKey: "qbQuickMode") as! NSArray)
                            self.questionQb = test.value(forKey: "qbID") as! NSArray
                        } else {
                            self.questionType = []
                            self.questionQb = []
                        }
                        
                        
                    }
                }
                self.QuestionCollection.reloadData()
                break
                
            case .failure(_):
                print(response.result.error)
                break
                
            }
        }
        
    }

}




