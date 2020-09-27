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
      var hueLable: UILabel!
      var saturationLable: UILabel!
      var brightLable: UILabel!
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
         
         hueLable = UILabel(frame:CGRect(x: 0, y: 0, width: 106, height: 24))
        
         hueLable.textColor = UIColor(red: 140, green: 141, blue: 140, alpha: 1)
         hueLable.font = UIFont(name: "SF-UI-Display-Regular.otf", size: 20)
         hueLable.text = "Hue"
         hueSlider.value = 0.5
         hueSlider.thumbTintColor = generateColor(forcolors: hueSlider.value)
         hueSlider.isContinuous = true
         hueSlider.awakeFromNib(color: generateColor(forcolors: hueSlider.value))
         hueSlider.addTarget (self,
                              action: #selector(numberValueChanged),for: UIControl.Event.valueChanged)
         self.addSubview(hueSlider)
         self.addSubview(hueLable)
         
         satSlider = SaturationSlider(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 4))
         saturationLable = UILabel(frame:CGRect(x: 0, y: 0, width: 106, height: 24))
         saturationLable.textColor = UIColor(red: 140, green: 141, blue: 140, alpha: 1)
         saturationLable.font = UIFont(name: "SF-UI-Display-Regular.otf", size: 20)
         saturationLable.text = "Saturation"
         satSlider.value = 0.5
         satSlider.thumbTintColor = satGenerateColor(forcolors: satSlider.value)
         satSlider.isContinuous = true
         satSlider.awakeFromNib(color: satGenerateColor(forcolors: satSlider.value))
         satSlider.addTarget (self,
                              action: #selector(satNumberValueChanged),for: UIControl.Event.valueChanged)
         self.addSubview(satSlider)
         self.addSubview(saturationLable)
        
         briSlider = BrightnessSlider(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 4))
         brightLable = UILabel(frame:CGRect(x: 0, y: 0, width: 106, height: 24))
         brightLable.textColor = UIColor(red: 140, green: 141, blue: 140, alpha: 1)
         brightLable.font = UIFont(name: "SF-UI-Display-Regular.otf", size: 20)
         brightLable.text = "Brightness"
         briSlider.value = 0.5
         briSlider.thumbTintColor = briGenerateColor(forcolors: briSlider.value)
         briSlider.isContinuous = true
         briSlider.awakeFromNib(color: briGenerateColor(forcolors: briSlider.value))
         briSlider.addTarget (self,
                               action: #selector(briNumberValueChanged),for: UIControl.Event.valueChanged)
         
        self.addSubview(briSlider)
        self.addSubview(brightLable)
        
        slidersAuthLayout()
        lablesLayout()
    }
    
    private func slidersAuthLayout() {
        self.briSlider.snp.makeConstraints{ (make) in
         make.height.equalTo(4)
         make.bottom.equalToSuperview().offset(-40)
         make.right.equalToSuperview().offset(-UIScreen.main.bounds.width/4)
         make.left.equalToSuperview().offset(UIScreen.main.bounds.width/4)
        }
        self.satSlider.snp.makeConstraints{ (make) in
         make.height.equalTo(4)
         make.bottom.equalTo(self.briSlider).offset(-46.5)
         make.right.equalToSuperview().offset(-UIScreen.main.bounds.width/4)
         make.left.equalToSuperview().offset(UIScreen.main.bounds.width/4)
            print(UIScreen.main.bounds.width/4)
        }
        self.hueSlider.snp.makeConstraints{ (make) in
         make.height.equalTo(4)
         make.bottom.equalTo(self.satSlider).offset(-46.5)
         make.right.equalToSuperview().offset(-UIScreen.main.bounds.width/4)
         make.left.equalToSuperview().offset(UIScreen.main.bounds.width/4)
        }
    }
    
    
    private func lablesLayout() {
        self.brightLable.snp.makeConstraints{ (make) in
         
         make.bottom.equalToSuperview().offset(-36.5)
        // make.right.equalToSuperview().offset(-UIScreen.main.bounds.width/4)
            
         make.left.equalTo(self.briSlider.snp.left).offset(20+UIScreen.main.bounds.width/2)
        }
        self.saturationLable.snp.makeConstraints{ (make) in
        
         make.bottom.equalToSuperview().offset(-76.5)
      //   make.right.equalToSuperview().offset(-UIScreen.main.bounds.width/4)
            
         make.left.equalTo(self.satSlider.snp.left).offset(20+UIScreen.main.bounds.width/2)
        }
        self.hueLable.snp.makeConstraints{ (make) in
        make.bottom.equalToSuperview().offset(-116.5)
        //make.right.equalToSuperview().offset(-UIScreen.main.bounds.width/4)
           
        make.left.equalTo(self.briSlider.snp.left).offset(20+UIScreen.main.bounds.width/2)
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
        
        self.hueLable.setNeedsLayout()
        self.hueLable.layoutIfNeeded()
        
        self.saturationLable.setNeedsLayout()
        self.saturationLable.layoutIfNeeded()
        
        self.brightLable.setNeedsLayout()
        self.brightLable.layoutIfNeeded()
        
        slidersAuthLayout()
        lablesLayout()
    }
}
