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
    var filterIsActive = false
    let imgArray = [#imageLiteral(resourceName: "originalPen"), #imageLiteral(resourceName: "filter")]
  
    @IBOutlet weak var myPopUpContainerView: PopUpMenuView!
    @IBOutlet weak var mySecondPopUpView: PopUpMenuView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterImage: UIImageView!
    
    var orignialImage: UIImage?
    var processingImageAfterHue: UIImage?
    var processingImageAfterSat: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        myPopUpContainerView.delegate = self
        myPopUpContainerView.isHidden = true
        mySecondPopUpView.isHidden = true
        orignialImage = imageView.image
        
        
    }

    
    @IBAction func filterBtnSelected(_ sender: UIButton) {
        filterIsActive = filterIsActive == true ? false : true
        changeFilterImage()
        changePopMenueStatus()
       
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
           var filteredImage: UIImage?
           if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage,
           let cgiImageResult = context.createCGImage(output, from: output.extent){
               filteredImage = UIImage(cgImage: cgiImageResult)
           }
           
           
           return  filteredImage
       }
    
    func changeFilterImage() {
        if filterIsActive == true {
            filterImage.image = imgArray[1]
        }else {
            filterImage.image = imgArray[0]
        }
    }
    
    func changePopMenueStatus() {
        if filterIsActive == true {
            self.myPopUpContainerView.isHidden = false
            self.mySecondPopUpView.isHidden = false
        }else {
            self.myPopUpContainerView.isHidden = true
            self.mySecondPopUpView.isHidden = true
        }
    }
}

extension MainViewController: DataDelegate {
    func printThisString(value: Float, _ index: Int) {
       
    }
    
    func hueChange(hue: Float, sat: Float, bri: Float) {
        guard let image = orignialImage  else {
            return
        }
        imageView.image = applyFilterTo(image: image, filterEffect: Filter(filterName: "CIHueAdjust", filterEffectValue: 3.14*(hue-0.5)/0.5, filterEffectValueName: kCIInputAngleKey))
       
        
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
    

    func hsbAdustment(hue: Float, sat: Float, bri: Float){
              guard let image = orignialImage  else {
            return
                    }
        imageView.image = applyFilterTo(image: image, filterEffect: Filter(filterName: "CIHueAdjust", filterEffectValue: 3.14*(hue-0.5)/0.5, filterEffectValueName: kCIInputAngleKey))
        processingImageAfterHue = imageView.image
        imageView.image = applyFilterTo(image: processingImageAfterHue!, filterEffect: Filter(filterName: "CIColorControls", filterEffectValue: sat*2, filterEffectValueName: kCIInputSaturationKey))
        processingImageAfterSat = imageView.image
        imageView.image = applyFilterTo(image: processingImageAfterSat!, filterEffect: Filter(filterName: "CIColorControls", filterEffectValue: (bri-0.5)/0.5, filterEffectValueName: kCIInputBrightnessKey))
        
        
                 }

    }

