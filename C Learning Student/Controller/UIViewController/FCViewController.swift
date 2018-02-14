//
//  FCViewController.swift
//  C Learning Teacher
//
//  Created by kit on 2/12/2561 BE.
//  Copyright © 2561 BE kit. All rights reserved.
//

import UIKit

class FCViewController: UIViewController {
    var qbID = ""
    var alert = SweetAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    

    @IBAction func comfirmBtn(_ sender: Any) {
        self.alert.showAlert("Confirm", subTitle: "Please ...", style: AlertStyle.warning ,buttonTitle: "Confirm",buttonColor: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0))  {  Void in
           print("test")
        }
        
            
            
    }
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
