//
//  SplitAmountViewController.swift
//  Split a Bill
//
//  Created by macbook on 04/12/2017.
//  Copyright © 2017 SoftSolutionsPro. All rights reserved.
//

import UIKit

class SplitAmountViewController: UIViewController,UIPickerViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var sliderTip: UISlider!
    @IBOutlet weak var lblPayperson: UILabel!
    @IBOutlet weak var txtTip: UITextField!
    @IBOutlet weak var personsSelectlist: UIPickerView!
    var numberOfPersons: [NSNumber] = [NSNumber]()
    var TotalAmount = Float()
    var people = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (TotalAmount == -1) {
            let alert = UIAlertController(title: "Error", message: "Can not Split the bill, No amount entered", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                switch action.style{
                case .default:
                    self.navigationController?.popViewController(animated: true)
                case .cancel:
                    self.navigationController?.popViewController(animated: true)
                    
                case .destructive:
                    self.navigationController?.popViewController(animated: true)
                }
            }))
            self.present(alert, animated: true, completion: nil)  
        }
 
        self.title = "Spit a Bill"
        
        // Initializing the array to hold number of person
        numberOfPersons = [1,2,3,4,5,6,7,8,9,10]
        
        // declaring delegate for picker view to self to use the protocol extension for picker view
        self.personsSelectlist.delegate = self
        
        // declaring delegate for TextField to self to use the protocol extension for TextField
        txtTip.delegate = self
        
        // setting the controller default values
        setDefaults()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // set defaults method
    func setDefaults(){
        people = 2
        personsSelectlist.selectRow(1, inComponent: 0, animated: false)
        txtTip.text = String(stringInterpolationSegment: sliderTip.value)
        calcshare(tipPercent: sliderTip.value, noOfPerson: Float(people))
    }
    
    // utility function to calculate the share perhead
    func calcshare(tipPercent: Float, noOfPerson: Float) {
        
        let share = (TotalAmount+(TotalAmount*(tipPercent/100)))/noOfPerson
        lblPayperson.text = String(stringInterpolationSegment: share)
    }
    
    
    
    // MARK: - TextField value changed , to update slider on value changed
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        let tipVal : Float = NSString(string: result).floatValue
        
        
        let allowedChars = CharacterSet.decimalDigits
        let charset = CharacterSet(charactersIn: string)
        
        if (tipVal > 100 || tipVal < 0 || allowedChars.isSuperset(of: charset) == false)
        {
            return false
        }
        
        self.sliderTip.setValue(tipVal, animated: true)
        calcshare(tipPercent: tipVal,noOfPerson:Float(people))
        return true
    }
    
    // MARK: - Slider value changed
    @IBAction func tipPercentChanged(_ sender: UISlider) {
        txtTip.text = String(stringInterpolationSegment: sender.value)
        calcshare(tipPercent: sender.value,noOfPerson:Float(people))
    }
    
    
    // MARK: - UIPIcker view datasource and delegate methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfPersons.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberOfPersons[row].stringValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        people = row+1
        calcshare(tipPercent: sliderTip.value,noOfPerson: Float(row+1))
    }
    
}
