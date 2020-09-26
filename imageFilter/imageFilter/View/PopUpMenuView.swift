//
//  PopUpMenuView.swift
//  imageFilter
//
//  Created by Jin Hou on 2020/9/24.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

protocol DataDelegate {
    func printThisString(value: Float, _ index: Int)
    func hueChange(hue: Float, sat: Float, bri: Float)
    func hsbAdustment(hue: Float, sat: Float, bri: Float)
    func satChange(value: Float)
    func briChange(value: Float)
}

class PopUpMenuView: UIView {
    
      var delegate: DataDelegate?
      var hueSlider: HueGraindentSlider!
      var SatSlider: SaturationSlider!
      var BriSlider: BrightnessSlider!
      
      @objc func numberValueChanged(sender: UISlider) {
          delegate?.printThisString(value: sender.value, 0)
          delegate?.hsbAdustment(hue: sender.value, sat:SatSlider.value, bri: BriSlider.value)
          hueSlider.thumbTintColor = generateColor(forcolors: hueSlider.value)
          hueSlider.awakeFromNib(color: generateColor(forcolors: hueSlider.value))
      }
      @objc func hueThumReset(sender: UISlider) {
             hueSlider.thumbTintColor = generateColor(forcolors: hueSlider.value)
         }
      @objc func satNumberValueChanged(sender: UISlider) {
          delegate?.printThisString(value: sender.value, 1)
          delegate?.hsbAdustment(hue: sender.value, sat:SatSlider.value, bri: BriSlider.value)
          SatSlider.thumbTintColor = satGenerateColor(forcolors: SatSlider.value)
          SatSlider.awakeFromNib(color: satGenerateColor(forcolors: SatSlider.value))
      }
      @objc func briNumberValueChanged(sender: UISlider) {
          delegate?.printThisString(value: sender.value, 2)
          delegate?.hsbAdustment(hue: sender.value, sat:SatSlider.value, bri: BriSlider.value)
          BriSlider.thumbTintColor = briGenerateColor(forcolors: BriSlider.value)
          BriSlider.awakeFromNib(color: briGenerateColor(forcolors: BriSlider.value))
      }
    
      func generateColor(forcolors currentVaule: Float) -> UIColor{
          return UIColor(hue: (1-CGFloat(currentVaule)), saturation: 1, brightness: 1, alpha: 1)
      }
      
      func satGenerateColor(forcolors currentVaule: Float) -> UIColor{
        return UIColor(hue: 1, saturation: CGFloat(currentVaule), brightness: CGFloat(currentVaule+0.5), alpha: 1)
      }
      
      func briGenerateColor(forcolors currentVaule: Float) -> UIColor{
          return UIColor(hue: 1, saturation: 0, brightness: CGFloat(currentVaule), alpha: 1)
      }
      
    override func awakeFromNib() {
       
         hueSlider = HueGraindentSlider(frame: CGRect(x: 384, y: 40, width: 534, height: 4))
         let hue = UILabel(frame:CGRect(x: 930, y: 32, width: 106, height: 24))
         hue.textColor = UIColor(red: 140, green: 141, blue: 140, alpha: 1)
         hue.font = UIFont(name: "SF-UI-Display-Regular.otf", size: 20)
         hue.text = "Hue"
         hueSlider.value = 0.5
         hueSlider.thumbTintColor = generateColor(forcolors: hueSlider.value)
         hueSlider.isContinuous = true
         hueSlider.awakeFromNib(color: generateColor(forcolors: hueSlider.value))
         hueSlider.addTarget (self,
                              action: #selector(numberValueChanged),for: UIControl.Event.valueChanged)
         self.addSubview(hueSlider)
         self.addSubview(hue)
         
         SatSlider = SaturationSlider(frame: CGRect(x: 384, y: 86.5, width: 534, height: 4))
         let saturation = UILabel(frame:CGRect(x: 930, y: 74, width: 106, height: 24))
         saturation.textColor = UIColor(red: 140, green: 141, blue: 140, alpha: 1)
         saturation.font = UIFont(name: "SF-UI-Display-Regular.otf", size: 20)
         saturation.text = "Saturation"
         SatSlider.value = 0.5
         SatSlider.thumbTintColor = satGenerateColor(forcolors: SatSlider.value)
         SatSlider.isContinuous = true
         SatSlider.awakeFromNib(color: satGenerateColor(forcolors: SatSlider.value))
         SatSlider.addTarget (self,
                              action: #selector(satNumberValueChanged),for: UIControl.Event.valueChanged)
         self.addSubview(SatSlider)
         self.addSubview(saturation)
        
         BriSlider = BrightnessSlider(frame: CGRect(x: 384, y: 133, width: 534, height: 4))
         let bright = UILabel(frame:CGRect(x: 930, y: 120, width: 106, height: 24))
         bright.textColor = UIColor(red: 140, green: 141, blue: 140, alpha: 1)
         bright.font = UIFont(name: "SF-UI-Display-Regular.otf", size: 20)
         bright.text = "Brightness"
         BriSlider.value = 0.5
         BriSlider.thumbTintColor = briGenerateColor(forcolors: BriSlider.value)
         BriSlider.isContinuous = true
         BriSlider.awakeFromNib(color: briGenerateColor(forcolors: BriSlider.value))
         BriSlider.addTarget (self,
                               action: #selector(briNumberValueChanged),for: UIControl.Event.valueChanged)
         
        self.addSubview(BriSlider)
        self.addSubview(bright)
    }
}
