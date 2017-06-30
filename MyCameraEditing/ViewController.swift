//
//  ViewController.swift
//  MyCameraEditing
//
//  Created by 佐藤賢 on 2017/07/01.
//  Copyright © 2017年 佐藤賢. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

  override func viewDidLoad() {
    super.viewDidLoad()
    cameraButton.layer.cornerRadius = 20    //ボタンを角丸に
    cameraButton.layer.masksToBounds = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBOutlet weak var pictureImage: UIImageView!
  @IBOutlet weak var cameraButton: UIButton!
  
  @IBAction func cameraButtonAction(_ sender: Any) {
    let alertController = UIAlertController(title: "確認", message: "確認してください", preferredStyle: .actionSheet)
    // カメラが利用できるかチェック
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action:UIAlertAction) in
      
      let ipc = UIImagePickerController()
      ipc.sourceType = .camera
      ipc.delegate = self
      self.present(ipc, animated: true, completion: nil)
    })
      alertController.addAction(cameraAction)
    }
    
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
      let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (action:UIAlertAction) in
        
        let ipc = UIImagePickerController()
        ipc.sourceType = .photoLibrary
        ipc.delegate = self
        self.present(ipc, animated: true, completion: nil)
      })
      alertController.addAction(photoLibraryAction)
    }
    
    let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
    alertController.addAction(cancelAction)
    
    // iPadで落ちてしまう対策
    alertController.popoverPresentationController?.sourceView = view
    
    present(alertController, animated: true, completion: nil)
  }

  
  // 撮影が終わった時に呼び出されるdelegateメソッド
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    // 撮影した写真を、captureImageに渡す  (as? UIImage = Any型からUIImage型にキャスト変換)
    captureImage = info[UIImagePickerControllerOriginalImage] as? UIImage
    // カメラ画面を閉じる
    dismiss(animated: true, completion: {
      // エフェクト画面に遷移
      self.performSegue(withIdentifier: "showEffectView", sender: nil)
    })
  }
  
  var captureImage : UIImage?
  // 画面遷移時に実行されるメソッド
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // 次の画面のインスタンスを取得
    let nextViewController = segue.destination as! EffectViewController
    // 次の画面のインスタンスに取得した画像を渡す
    nextViewController.originalImage = captureImage
  }

}

