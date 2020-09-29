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
    var orignialImage: UIImage?
    var processingImageAfterHue: UIImage?
    var processingImageAfterSat: UIImage?
    
    @IBOutlet weak var myPopUpContainerView: PopUpMenuView!
    @IBOutlet weak var mySecondPopUpView: PopUpMenuView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPopUpContainerView.delegate = self
        myPopUpContainerView.isHidden = true
        mySecondPopUpView.isHidden = true
        orignialImage = imageView.image
    }
    //MARK: when screen rotates popupview autolayout
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.myPopUpContainerView.setNeedsLayout()
        self.myPopUpContainerView.layoutIfNeeded()
    }
    
    @IBAction func filterBtnSelected(_ sender: UIButton) {
        filterIsActive = filterIsActive == true ? false : true
        changeFilterImage()
        changePopMenueStatus()
    }
    //MARK: filter image function
    private func applyFilterTo(image:UIImage, filterEffect:Filter) -> UIImage? {
        guard let cgImage = image.cgImage else {
            return nil
        }
        let ciImage = CIImage(cgImage: cgImage)
        let filter = CIFilter(name:filterEffect.filterName)
        var filteredImage: UIImage?
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        if let filterEffectValue = filterEffect.filterEffectValue,
            let filterEffectValueName = filterEffect.filterEffectValueName{
            filter?.setValue(filterEffectValue, forKey: filterEffectValueName)
        }
        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage,
            let cgiImageResult = context.createCGImage(output, from: output.extent){
            filteredImage = UIImage(cgImage: cgiImageResult)
        }
        return  filteredImage
    }
    //MARK: change filter button backgroud image
    func changeFilterImage() {
        if filterIsActive == true {
            filterImage.image = imgArray[1]
        }else {
            filterImage.image = imgArray[0]
        }
    }
    //MARK: change filter button status
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
//MARK: HSB adjustment function
    func hsbAdjustment(hue: Float, sat: Float, bri: Float){
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

