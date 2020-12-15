//
//  ViewController.swift
//  SD
//
//  Created by KOK on 14/12/2020.
//

import UIKit

class ViewController: UIViewController,FloatyDelegate {
    var floaty = Floaty()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layoutFAB()
        floaty.addDragging()
    }

    func layoutFAB() {
      let item = FloatyItem()
      item.hasShadow = false
      item.buttonColor = UIColor.blue
      item.circleShadowColor = UIColor.red
      item.titleShadowColor = UIColor.blue
      item.titleLabelPosition = .right
      item.title = "titlePosition right"
      item.handler = { item in
        
      }
      
      floaty.hasShadow = false
      floaty.addItem(title: "I got a title")
      floaty.addItem("I got a icon", icon: UIImage(named: "icShare"))
      floaty.addItem("I got a handler", icon: UIImage(named: "icMap")) { item in
        let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
      floaty.addItem(item: item)
      floaty.paddingX = self.view.frame.width/2 - floaty.frame.width/2
      floaty.fabDelegate = self
      
      self.view.addSubview(floaty)
      
    }
    
}

