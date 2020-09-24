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
    var SatSlider: SaturationSlider!
    var BriSlider: BrightnessSlider!
    @objc func numberValueChanged(sender: UISlider) {
        hueSlider.thumbTintColor = generateColor(forcolors: hueSlider.value)
    }
    @objc func satNumberValueChanged(sender: UISlider) {
        SatSlider.thumbTintColor = satGenerateColor(forcolors: SatSlider.value)
    }
    @objc func briNumberValueChanged(sender: UISlider) {
        BriSlider.thumbTintColor = briGenerateColor(forcolors: BriSlider.value)
    }
  
    func generateColor(forcolors currentVaule: Float) -> UIColor{
        return UIColor(hue: (1-CGFloat(currentVaule)), saturation: 1, brightness: 1, alpha: 1)
    }
    
    func satGenerateColor(forcolors currentVaule: Float) -> UIColor{
        return UIColor(hue: 1, saturation: CGFloat(currentVaule), brightness: 1, alpha: 1)
    }
    
    func briGenerateColor(forcolors currentVaule: Float) -> UIColor{
        return UIColor(hue: 1, saturation: 0, brightness: CGFloat(currentVaule), alpha: 1)
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
        
        SatSlider = SaturationSlider(frame: CGRect(x: 400, y: 60, width: 500, height: 2))
        SatSlider.value = 0.5
        SatSlider.thumbTintColor = satGenerateColor(forcolors: SatSlider.value)
        SatSlider.isContinuous = true
        SatSlider.addTarget (self,
                             action: #selector(satNumberValueChanged),for: UIControl.Event.valueChanged)
       
        view.addSubview(SatSlider)
        BriSlider = BrightnessSlider(frame: CGRect(x: 400, y: 90, width: 500, height: 2))
        BriSlider.value = 0.5
        BriSlider.thumbTintColor = briGenerateColor(forcolors: BriSlider.value)
        BriSlider.isContinuous = true
        BriSlider.addTarget (self,
                              action: #selector(briNumberValueChanged),for: UIControl.Event.valueChanged)
        
         view.addSubview(BriSlider)
        
        
    }
     
    
}
