//
//  PopUpMenuViewController.swift
//  imageFilter
//
//  Created by Jin Hou on 23/9/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class PopUpMenuViewController: UIViewController {
    var hueSlider: HueGraindentSlider!
    var label = UILabel()
    @objc func numberValueChanged(sender: UISlider) {
        print(hueSlider.value)
        hueSlider.thumbTintColor = generateColor(forcolors: hueSlider.value)
    }
  
    func generateColor(forcolors currentVaule: Float) -> UIColor{
        return UIColor(hue: (1-CGFloat(currentVaule)), saturation: 1, brightness: 1, alpha: 1)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hueSlider = HueGraindentSlider(frame: CGRect(x: 400, y: 30, width: 500, height: 2))
        hueSlider.value = 0.5
        hueSlider.thumbTintColor = generateColor(forcolors: hueSlider.value)
        hueSlider.isContinuous = true
        hueSlider.addTarget (self,
                             action: #selector(numberValueChanged),for: UIControl.Event.valueChanged)
        view.addSubview(hueSlider)
        
        
    }
     
    
}
