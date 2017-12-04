//
//  ViewController.swift
//  Split a Bill
//
//  Created by macbook on 04/12/2017.
//  Copyright © 2017 SoftSolutionsPro. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtTotAmount: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Home"
        
        txtTotAmount.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        let allowedChars = CharacterSet.decimalDigits
        let charset = CharacterSet(charactersIn: string)
        return allowedChars.isSuperset(of: charset)
    
    }
    
    
    //Mark: - Prepare for segue , UIviewController transition
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let splitVC : SplitAmountViewController = segue.destination as! SplitAmountViewController

        
        if (txtTotAmount.text?.isEmpty)!
        {
            splitVC.TotalAmount = -1
        }
        else{
            splitVC.TotalAmount = Float(self.txtTotAmount.text!)! as Float
        }
 
    }
    
}

