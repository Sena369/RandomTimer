//
//  ViewController.swift
//  RandomTimer
//
//  Created by 澤田世那 on 2022/02/14.
//

import UIKit

class ViewController: UIViewController {
    
    var timer : Timer?
    var count = 0
    let settingKey = "timer_value"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let settings = UserDefaults.standard
        settings.register(defaults: [settingKey:10])
        
    }

    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var CountdownLabel: UILabel!
    
    @IBAction func SettingButtonAction(_ sender: Any) {
        
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
        
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    @IBAction func StartButtonAction(_ sender: Any) {
    
        if let nowTimer = timer {
            // ↓の形は値でしかない。
            if nowTimer.isValid == true {
                return
            }
        }
        
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerInterrupt(_:)), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func StopButtonAction(_ sender: Any) {
        // 変数はブロック毎でしか使えない。
        if let nowTimer = timer {
            if nowTimer.isValid == true {
             // ↓何かを実行したいなら、メソッドをあてる。
                nowTimer.invalidate()
            }
            
        }
    }
    
    func displayUpdate() -> Int {
    
        let settings = UserDefaults.standard
        let timervalue = settings.integer(forKey: settingKey)
        let remainCount = timervalue - count
    
        CountdownLabel.text = "\(remainCount)秒"
        return remainCount
    }
    
   @objc func timerInterrupt(_ timer:Timer) {
 
       count += Int.random(in: -1..<4)
 
       if displayUpdate() <= 0 {
 
           count = 0
           timer.invalidate()
           
           let alertController = UIAlertController(title: "終了", message: "タイマー終了時間です", preferredStyle: .alert)
           let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           
           alertController.addAction(defaultAction)
           
           present(alertController, animated: true, completion: nil)
           
       }
   }
    
    override func viewDidAppear(_ animated: Bool) {
        
        count = 0
        _ = displayUpdate()
    }
}


