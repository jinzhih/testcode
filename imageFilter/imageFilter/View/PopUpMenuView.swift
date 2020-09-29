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
    func hsbAdjustment(hue: Float, sat: Float, bri: Float)
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
    //MARK: hsb value change function
    @objc func hueNumberValueChanged(sender: UISlider) {
        delegate?.hsbAdjustment(hue: sender.value, sat:satSlider.value, bri: briSlider.value)
        hueSlider.thumbTintColor = hueGenerateColor(forcolors: hueSlider.value)
        hueSlider.awakeFromNib(color: hueGenerateColor(forcolors: hueSlider.value))
    }
    
    @objc func satNumberValueChanged(sender: UISlider) {
        delegate?.hsbAdjustment(hue: sender.value, sat:satSlider.value, bri: briSlider.value)
        satSlider.thumbTintColor = satGenerateColor(forcolors: satSlider.value)
        satSlider.awakeFromNib(color: satGenerateColor(forcolors: satSlider.value))
    }
    
    @objc func briNumberValueChanged(sender: UISlider) {
        delegate?.hsbAdjustment(hue: sender.value, sat:satSlider.value, bri: briSlider.value)
        briSlider.thumbTintColor = briGenerateColor(forcolors: briSlider.value)
        briSlider.awakeFromNib(color: briGenerateColor(forcolors: briSlider.value))
    }
    
    override func awakeFromNib() {
        hueSlider = HueGraindentSlider(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 4))
        hueLable = UILabel(frame:CGRect(x: 0, y: 0, width: 106, height: 24))
        hueLable.textColor = UIColor(red: 140, green: 141, blue: 140, alpha: 1)
        hueLable.font = UIFont(name: "SF-UI-Display-Regular.otf", size: 20)
        hueLable.text = "Hue"
        hueSlider.value = 0.5
        hueSlider.thumbTintColor = hueGenerateColor(forcolors: hueSlider.value)
        hueSlider.isContinuous = true
        hueSlider.awakeFromNib(color: hueGenerateColor(forcolors: hueSlider.value))
        hueSlider.addTarget (self,
                             action: #selector(hueNumberValueChanged),for: UIControl.Event.valueChanged)
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
        slidesAutoLayout()
        lablesAutoLayout()
    }
    //MARK: generate color according the current slider's valude
    func hueGenerateColor(forcolors currentVaule: Float) -> UIColor{
        return UIColor(hue: (1-CGFloat(currentVaule)), saturation: 1, brightness: 1, alpha: 1)
    }
    
    func satGenerateColor(forcolors currentVaule: Float) -> UIColor{
        return UIColor(hue: 1, saturation: CGFloat(currentVaule), brightness: CGFloat(currentVaule+0.5), alpha: 1)
    }
    
    func briGenerateColor(forcolors currentVaule: Float) -> UIColor{
        return UIColor(hue: 1, saturation: 0, brightness: CGFloat(currentVaule), alpha: 1)
    }
    //MARK: sliders auto layout function
    private func slidesAutoLayout() {
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
        }
        self.hueSlider.snp.makeConstraints{ (make) in
            make.height.equalTo(4)
            make.bottom.equalTo(self.satSlider).offset(-46.5)
            make.right.equalToSuperview().offset(-UIScreen.main.bounds.width/4)
            make.left.equalToSuperview().offset(UIScreen.main.bounds.width/4)
        }
    }
    //MARK:lables auto layout function
    private func lablesAutoLayout() {
        self.brightLable.snp.makeConstraints{ (make) in
        make.bottom.equalToSuperview().offset(-36.5)
        make.width.equalTo(UIScreen.main.bounds.width/4-30)
        make.height.equalTo(24)
        make.right.equalToSuperview()
        }
        self.saturationLable.snp.makeConstraints{ (make) in
        make.bottom.equalToSuperview().offset(-76.5)
        make.width.equalTo(UIScreen.main.bounds.width/4-30)
        make.height.equalTo(24)
        make.right.equalToSuperview()
        }
        self.hueLable.snp.makeConstraints{ (make) in
        make.bottom.equalToSuperview().offset(-116.5)
        make.width.equalTo(UIScreen.main.bounds.width/4-30)
        make.height.equalTo(24)
        make.right.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.hueSlider.setNeedsLayout()
        self.hueSlider.layoutIfNeeded()

        self.satSlider.setNeedsLayout()
        self.satSlider.layoutIfNeeded()
        
        self.briSlider.setNeedsLayout()
        self.briSlider.layoutIfNeeded()
        
        self.hueSlider.bounds = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 4)
        self.satSlider.bounds = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 4)
        self.briSlider.bounds = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 4)
        
        self.hueSlider.setup()
        self.satSlider.setup()
        self.briSlider.setup()
        
        self.hueLable.snp.updateConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width/4-30)
        }
        self.saturationLable.snp.updateConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width/4-30)
        }
        self.brightLable.snp.updateConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width/4-30)
        }
    }
}
