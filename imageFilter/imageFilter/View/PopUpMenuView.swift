//
//  PopUpMenuView.swift
//  imageFilter
//
//  Created by Jin Hou on 2020/9/24.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit
import SnapKit

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
      var satSlider: SaturationSlider!
      var briSlider: BrightnessSlider!
      let screenBounds:CGRect = UIScreen.main.bounds
      
      @objc func numberValueChanged(sender: UISlider) {
          delegate?.printThisString(value: sender.value, 0)
          delegate?.hsbAdustment(hue: sender.value, sat:satSlider.value, bri: briSlider.value)
          hueSlider.thumbTintColor = generateColor(forcolors: hueSlider.value)
          hueSlider.awakeFromNib(color: generateColor(forcolors: hueSlider.value))
      }
      @objc func hueThumReset(sender: UISlider) {
             hueSlider.thumbTintColor = generateColor(forcolors: hueSlider.value)
         }
      @objc func satNumberValueChanged(sender: UISlider) {
          delegate?.printThisString(value: sender.value, 1)
          delegate?.hsbAdustment(hue: sender.value, sat:satSlider.value, bri: briSlider.value)
          satSlider.thumbTintColor = satGenerateColor(forcolors: satSlider.value)
          satSlider.awakeFromNib(color: satGenerateColor(forcolors: satSlider.value))
      }
      @objc func briNumberValueChanged(sender: UISlider) {
          delegate?.printThisString(value: sender.value, 2)
          delegate?.hsbAdustment(hue: sender.value, sat:satSlider.value, bri: briSlider.value)
          briSlider.thumbTintColor = briGenerateColor(forcolors: briSlider.value)
          briSlider.awakeFromNib(color: briGenerateColor(forcolors: briSlider.value))
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
        
         hueSlider = HueGraindentSlider(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 4))
         //satSlider = SaturationSlider()
        // briSlider = BrightnessSlider()
         
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
         
         satSlider = SaturationSlider(frame: CGRect(x: 0, y: 0, width:1000, height: 4))
         let saturation = UILabel(frame:CGRect(x: 930, y: 74, width: 106, height: 24))
         saturation.textColor = UIColor(red: 140, green: 141, blue: 140, alpha: 1)
         saturation.font = UIFont(name: "SF-UI-Display-Regular.otf", size: 20)
         saturation.text = "Saturation"
         satSlider.value = 0.5
         satSlider.thumbTintColor = satGenerateColor(forcolors: satSlider.value)
         satSlider.isContinuous = true
         satSlider.awakeFromNib(color: satGenerateColor(forcolors: satSlider.value))
         satSlider.addTarget (self,
                              action: #selector(satNumberValueChanged),for: UIControl.Event.valueChanged)
         self.addSubview(satSlider)
         self.addSubview(saturation)
        
         briSlider = BrightnessSlider(frame: CGRect(x: 0, y: 0, width: 1000, height: 4))
         let bright = UILabel(frame:CGRect(x: 930, y: 120, width: 106, height: 24))
         bright.textColor = UIColor(red: 140, green: 141, blue: 140, alpha: 1)
         bright.font = UIFont(name: "SF-UI-Display-Regular.otf", size: 20)
         bright.text = "Brightness"
         briSlider.value = 0.5
         briSlider.thumbTintColor = briGenerateColor(forcolors: briSlider.value)
         briSlider.isContinuous = true
         briSlider.awakeFromNib(color: briGenerateColor(forcolors: briSlider.value))
         briSlider.addTarget (self,
                               action: #selector(briNumberValueChanged),for: UIControl.Event.valueChanged)
         
        self.addSubview(briSlider)
        self.addSubview(bright)
        
        slidersAuthLayout()
    }
    
    private func slidersAuthLayout() {
        self.briSlider.snp.makeConstraints{ (make) in
         make.height.equalTo(4)
         make.bottom.equalToSuperview().offset(-40)
         make.right.equalToSuperview().offset(-240)
         make.left.equalToSuperview().offset(174)
        }
        self.satSlider.snp.makeConstraints{ (make) in
         make.height.equalTo(4)
            make.bottom.equalTo(self.briSlider).offset(-46.5)
         make.right.equalToSuperview().offset(-240)
         make.left.equalToSuperview().offset(174)
        }
        self.hueSlider.snp.makeConstraints{ (make) in
         make.height.equalTo(4)
         make.bottom.equalTo(self.satSlider).offset(-46.5)
make.right.equalToSuperview().offset(-screenBounds.width/4)
         make.left.equalToSuperview().offset(screenBounds.width/4)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.hueSlider.setNeedsLayout()
        self.hueSlider.layoutIfNeeded()
        self.hueSlider.setup()
        
        
        self.satSlider.setNeedsLayout()
        self.satSlider.layoutIfNeeded()
        self.satSlider.setup()
        
        
        self.briSlider.setNeedsLayout()
        self.briSlider.layoutIfNeeded()
        self.briSlider.setup()
    }
}
