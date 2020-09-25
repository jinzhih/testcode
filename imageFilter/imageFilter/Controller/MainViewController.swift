//
//  MainViewController.swift
//  imageFilter
//
//  Created by Jin Hou on 23/9/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit
import CoreImage

class MainViewController: UIViewController {
    let context = CIContext()
    @IBOutlet weak var showHue: UILabel!
    @IBOutlet weak var myPopUpContainerView: PopUpMenuView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterBtn: UIButton!
    private var orignialImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPopUpContainerView.delegate = self
        myPopUpContainerView.isHidden = true
        orignialImage = imageView.image
    }

    
    @IBAction func filterBtnSelected(_ sender: UIButton) {
        self.myPopUpContainerView.isHidden = false
       
    }
    
    private func applyFilterTo(image:UIImage, filterEffect:Filter) -> UIImage? {
           guard let cgImage = image.cgImage else {
               return nil
           }
           
           let ciImage = CIImage(cgImage: cgImage)
           let filter = CIFilter(name:filterEffect.filterName)
           
           filter?.setValue(ciImage, forKey: kCIInputImageKey)
           if let filterEffectValue = filterEffect.filterEffectValue,
               let filterEffectValueName = filterEffect.filterEffectValueName{
               filter?.setValue(filterEffectValue, forKey: filterEffectValueName)
           }
           print(filter?.value(forKey: kCIOutputImageKey))
           var filteredImage: UIImage?
           if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage,
           let cgiImageResult = context.createCGImage(output, from: output.extent){
               filteredImage = UIImage(cgImage: cgiImageResult)
           }
           
           
           return  filteredImage
       }
}

extension MainViewController: DataDelegate {
    func printThisString(value: Float, _ index: Int) {
       
        showHue.text = "\(value)"
    }
    
    func hueChange(value: Float) {
        guard let image = orignialImage  else {
                   return
               }
        imageView.image = applyFilterTo(image: image, filterEffect: Filter(filterName: "CIHueAdjust", filterEffectValue: 3.14*(value-0.5)/0.5, filterEffectValueName: kCIInputAngleKey))
           }
    func satChange(value: Float) {
           guard let image = orignialImage  else {
                      return
                  }
        
        imageView.image = applyFilterTo(image: image, filterEffect: Filter(filterName: "CIColorControls", filterEffectValue: value*2, filterEffectValueName: kCIInputSaturationKey))
              }
    func briChange(value: Float) {
              guard let image = orignialImage  else {
                         return
                     }
        imageView.image = applyFilterTo(image: image, filterEffect: Filter(filterName: "CIColorControls", filterEffectValue: (value-0.5)/0.5, filterEffectValueName: kCIInputBrightnessKey))
                 }
    }

    

