//
//  ViewController.swift
//  memo
//
//  Created by Amelie Baimukanova on 09.01.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var steps: UILabel!
    
     //var state = Array(repeating: false, count: 16)
     var images = ["ant man","ant man",
                   "captain","captain",
                   "hulk", "hulk",
                   "iron man","iron man" ,
                   "phanter", "phanter",
                   "scarlet", "scarlet",
                   "spider man ", "spider man ",
                   "wanda", "wanda"
     ]
     
     
     var isOpened = false
     var previousButtonTag = 0
     var isTimerEnabled = false
     var count = 0
     
     
     var stepss = 0 {
          didSet {
              steps.text = "Steps: " + String(stepss)
          }
      }
      
     
    
     override func viewDidLoad() {
          super.viewDidLoad()
          clear()
     }
     
     func clear(){
          
          images.shuffle()
          count = 0
          stepss = 0
          for i in 1...16 {
               
               let button = view.viewWithTag(i) as! UIButton
               
               button.setBackgroundImage(nil, for: .normal)
          }
     }
     
     func showAlert() {
          let alert = UIAlertController(title: "WIN!", message: "play again?", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
               self.clear()
          }))
          
          present(alert, animated: true, completion: nil)
     }
     
     
     
     
     
     
     
     @IBAction func game(_ sender: UIButton) {
          
          if isTimerEnabled == true {
               return
          }
          
          if sender.backgroundImage(for: .normal) != nil {
               return
          }
          
          sender.setBackgroundImage(UIImage(named: images[sender.tag - 1]), for: .normal)
          
          if isOpened == true {
               stepss += 1
               
               if images[sender.tag - 1] == images[previousButtonTag - 1] {
                    count += 1
                    
               } else {
                    isTimerEnabled = true
                    
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                         sender.setBackgroundImage(nil, for: .normal)
                         
                         let previousButton = self.view.viewWithTag(self.previousButtonTag) as! UIButton
                         
                         previousButton.setBackgroundImage(nil, for: .normal)
                         
                         self.isTimerEnabled = false
                    }
               }
          } else {
               previousButtonTag = sender.tag
          }
          
          isOpened.toggle()
          
          if count == 8 {
               showAlert()
          }
     }
}
