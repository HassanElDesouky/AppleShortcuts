//
//  IconOtherController.swift
//  AppleShortcuts
//
//  Created by Hassan El Desouky on 8/10/19.
//  Copyright © 2019 Hassan El Desouky. All rights reserved.
//

import UIKit

class IconOtherController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func handleSelectPhoto(_ sender: Any) {
    let imagePC = UIImagePickerController()
    imagePC.delegate = self
    imagePC.allowsEditing = true
    present(imagePC, animated: true, completion: nil)
  }
}

extension IconOtherController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let edditedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      let iconDict: [String: UIImage] = ["iconDict": edditedImage]
      NotificationCenter.default.post(name: Notification.Name(rawValue: "iconImage"), object: nil, userInfo: iconDict)
    }
    if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      let iconDict: [String: UIImage] = ["iconDict": originalImage]
      NotificationCenter.default.post(name: Notification.Name(rawValue: "iconImage"), object: nil, userInfo: iconDict)
    }
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
}
