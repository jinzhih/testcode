//
//  SaturationSlider.swift
//  imageFilter
//
//  Created by Jin Hou on 24/9/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit
@IBDesignable
class SaturationSlider: UISlider {
    @IBInspectable var thickness: CGFloat = 4 {
         didSet {
             setup()
         }
     }

     @IBInspectable var sliderThumbImage: UIImage? {
         didSet {
             setThumbImage(sliderThumbImage, for: .normal)
         }
     }
    
     @IBInspectable var trackHeight: CGFloat = 4
     @IBInspectable var thumbRadius: CGFloat = 10
     
     
     func setup() {
       
         let maxTrackColor = UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 1)
         do {
             self.setMinimumTrackImage(try self.gradientImage(
             size: self.trackRect(forBounds: self.bounds).size,
             colorSet: [UIColor(hue: 1, saturation: 0, brightness: 0.5, alpha: 1).cgColor,UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 1).cgColor,]),
                                   for: .normal)
             self.setMaximumTrackImage(try self.gradientImage(
             size: self.trackRect(forBounds: self.bounds).size,
             colorSet: [UIColor(hue: 1, saturation: 0, brightness: 0.5, alpha: 1).cgColor,UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 1).cgColor,]),
             for: .normal)
           //  self.setThumbImage(sliderThumbImage, for: .normal)
           //  self.setThumbImage(CGRect(x: 0,y: 0,width: 4,height: 4), for: .highlighted)
         } catch {
            // self.minimumTrackTintColor = minTrackStartColor
             self.maximumTrackTintColor = maxTrackColor
         }
     }
     
     func gradientImage(size: CGSize, colorSet: [CGColor]) throws -> UIImage? {
         let tgl = CAGradientLayer()
         tgl.frame = CGRect.init(x:0, y:0, width:size.width, height: size.height)
         tgl.cornerRadius = tgl.frame.height / 2
         tgl.masksToBounds = false
         tgl.colors = colorSet
         tgl.startPoint = CGPoint.init(x:0.0, y:0.5)
         tgl.endPoint = CGPoint.init(x:1.0, y:0.5)

         UIGraphicsBeginImageContextWithOptions(size, tgl.isOpaque, 0.0);
         guard let context = UIGraphicsGetCurrentContext() else { return nil }
         tgl.render(in: context)
         let image =

     UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets:
         UIEdgeInsets.init(top: 0, left: size.height, bottom: 0, right: size.height))
         UIGraphicsEndImageContext()
         return image!
     }

     override func trackRect(forBounds bounds: CGRect) -> CGRect {
         return CGRect(
             x: bounds.origin.x,
             y: bounds.origin.y,
             width: UIScreen.main.bounds.width/2,
             height: thickness
         )
        }

     

     override init(frame: CGRect) {
         super.init(frame: frame)
         setup()
     }
    func awakeFromNib(color: UIColor) {
           super.awakeFromNib()
           let thumb = thumbImage(radius: thumbRadius, color: color)
           let thumbHighlighted = thumbImage(radius: thumbRadius*2, color: color)
           setThumbImage(thumb, for: .normal)
           setThumbImage(thumbHighlighted, for: .highlighted)

       }
       
       private func thumbImage(radius: CGFloat, color: UIColor) -> UIImage {
               var thumbView: UIView = {
               let thumb = UIView()
                      thumb.backgroundColor = color
                      thumb.layer.borderWidth = 0.4
                      thumb.layer.borderColor = UIColor.darkGray.cgColor
               return thumb
           }()
           thumbView.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
           thumbView.layer.cornerRadius = radius / 2

           let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
          
           return renderer.image { rendererContext in
               thumbView.layer.render(in: rendererContext.cgContext)
           }
       }
    

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setup()
     }
    
     
     
    
}
