//
//  PickerViewController.swift
//  RandomTimer
//
//  Created by 澤田世那 on 2022/02/14.
//

import UIKit

class PickerViewController: UIViewController , UIPickerViewDataSource , UIPickerViewDelegate {
    
    // これを分単位で表示したい
    let settingArray = [300,600,900,1200,1500,1800,2100,2400,2700,3000,3300,3600]
    let settingArrayMinute = [5,10,15,20,25,30,35,40,45,50,55,60]
    let settingKey = "timer_value"

    override func viewDidLoad() {
        super.viewDidLoad()

        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        let settings = UserDefaults.standard
        let timervalue = settings.integer(forKey: settingKey)
        
        for row in 0..<settingArray.count {
            if settingArray[row] == timervalue {
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var timerSettingPicker: UIPickerView!
    @IBAction func decisionButtonAction(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(settingArrayMinute[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let settings = UserDefaults.standard
        settings.setValue(settingArray[row], forKey: settingKey)
        settings.synchronize()
    }
}
