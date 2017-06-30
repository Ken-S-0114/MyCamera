//
//  EffectViewController.swift
//  MyCameraEditing
//
//  Created by 佐藤賢 on 2017/07/01.
//  Copyright © 2017年 佐藤賢. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {

  // 新しく画面が生成された時に呼ばれるメソッド
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //ボタンを角丸に
    effectButton.layer.cornerRadius = 20
    shareButton.layer.cornerRadius = 20
    closeButton.layer.cornerRadius = 20
    effectButton.layer.masksToBounds = true
    shareButton.layer.masksToBounds = true
    closeButton.layer.masksToBounds = true

    // 画面遷移時に元の画像を表示
    effectImage.image = originalImage
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBOutlet weak var effectImage: UIImageView!
  @IBOutlet weak var effectButton: UIButton!
  @IBOutlet weak var shareButton: UIButton!
  @IBOutlet weak var closeButton: UIButton!
  /*
   ファイル名を列挙した配列
   0.モノクロ
   1.Chrome
   2.Fade
   3.Instant
   4.Noir
   5.Process
   6.Tonal
   7.Transfer
   8.Sepia Tone
   */
  let filterArray = ["CIPhotoEffectMono",
                     "CIPhotoEffectChrome",
                     "CIPhotoEffectFade",
                     "CIPhotoEffectInstant",
                     "CIPhotoEffectNoir",
                     "CIPhotoEffectProcess",
                     "CIPhotoEffectTonal",
                     "CIPhotoEffectTransfer",
                     "CISepiaTone"
  ]
  
  var filterSelectNumber = 0
  
  var originalImage : UIImage?
  
  @IBAction func effectButtonAction(_ sender: Any) {
    // フィルタ名を指定
    let filterName = filterArray[filterSelectNumber]
    filterSelectNumber += 1
    
    if filterSelectNumber == filterArray.count {
      filterSelectNumber = 0
    }
    
    let rotate = originalImage!.imageOrientation
    let inputImage = CIImage(image: originalImage!)
    let effectFilter = CIFilter(name: filterName)!
    effectFilter.setDefaults()
    effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
    let outputImage = effectFilter.outputImage
    let ciContext = CIContext(options: nil)
    let cgImage = ciContext.createCGImage(outputImage!, from: outputImage!.extent)
    effectImage.image = UIImage(cgImage: cgImage!, scale: 1.0, orientation: rotate)
  }
  
  @IBAction func shareButtonAction(_ sender: Any) {
    let controller = UIActivityViewController(activityItems: [effectImage.image!], applicationActivities: nil)
    controller.popoverPresentationController?.sourceView = view
    present(controller, animated: true, completion: nil)
  }
  
  @IBAction func closeButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

}
