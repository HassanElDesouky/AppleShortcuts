//
//  ListIconController.swift
//  AppleShortcuts
//
//  Created by Hassan El Desouky on 8/10/19.
//  Copyright © 2019 Hassan El Desouky. All rights reserved.
//

import UIKit

var firstColorData: Data?
var secondColorData: Data?

class ListIconController: UIViewController {
  
  @IBOutlet weak var iconView: IconView!
  @IBOutlet weak var chooseColorView: UIView!
  @IBOutlet weak var chooseOtherView: UIView!
  @IBOutlet weak var chooseGlyphView: UIView!
  var views: [UIView]!
  var list: List?
  var isImage = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupSavedIcon()
    setupIconView()
  }
  
  @IBAction func handleDone(_ sender: Any) {
    let renderer = UIGraphicsImageRenderer(size: iconView.bounds.size)
    let image = renderer.image { ctx in
      iconView.drawHierarchy(in: iconView.bounds, afterScreenUpdates: true)
    }
    let finalIconDict: [String: UIImage] = ["finalIcon": image]
    NotificationCenter.default.post(name: NSNotification.Name("finalIcon"), object: nil, userInfo: finalIconDict)
    if list != nil {
      let context = CoreDataManager.shared.persistentContainer.viewContext
      let imageData = image.jpegData(compressionQuality: 0.8)
      list?.setValue(imageData, forKey: "imageData")
      do {
        try context.save()
        navigationController?.popViewController(animated: true)
      } catch let err {
        print(err)
      }
    } else {
      navigationController?.popViewController(animated: true)
    }
  }
  
  @IBAction func handleSelectView(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      switchViews(firstView: 1.0, secondView: 0.0, thirdView: 0.0)
      break
    case 1:
      switchViews(firstView: 0.0, secondView: 1.0, thirdView: 0.0)
      break
    case 2:
      switchViews(firstView: 0.0, secondView: 0.0, thirdView: 1.0)
      break
    default:
      break
    }
  }
  
  @objc private func handleChangeColor(notification:  Notification) {
    guard let colorDict = notification.userInfo else { return }
    guard let colors = colorDict["colorDict"] as? [UIColor] else { return }
    firstColorData = colors[0].encode()
    secondColorData = colors[1].encode()
    iconView.backgroundImage.image = nil
    setIconGradient(colorOne: colors[0], colorTwo: colors[1])
  }
  
  @objc private func handleChangeIcon(notification: Notification) {
    guard let iconDict = notification.userInfo else { return }
    guard let image = iconDict["iconDict"] as? UIImage else { return }
    iconView.backgroundImage.image = nil
    iconView.image.image = image
    iconView.image.image = iconView.image.image?.withRenderingMode(.alwaysTemplate)
    iconView.image.tintColor = .white
    iconView.contentMode = .scaleAspectFit
  }
  
  @objc private func handleChangeImage(notification: Notification) {
    guard let iconDict = notification.userInfo else { return }
    guard let image = iconDict["iconDict"] as? UIImage else { return }
    isImage = true
    iconView.image.image = nil
    iconView.backgroundImage.image = image
  }
  
  private func setupSavedIcon() {
    if list != nil {
      if let imageData = list?.imageData {
        iconView.image.image = nil
        if !isImage {
          iconView.backgroundImage.image = UIImage(data: imageData)
        }
      }
    }
  }
  
  private func setIconGradient(colorOne: UIColor, colorTwo: UIColor) {
    iconView.topColor = colorOne
    iconView.bottomColor = colorTwo
  }
  
  private func switchViews(firstView: CGFloat, secondView: CGFloat, thirdView: CGFloat) {
    chooseColorView.alpha = firstView
    chooseOtherView.alpha = thirdView
    chooseGlyphView.alpha = secondView
  }
  
  fileprivate func setupIconView() {
    iconView.makeRoundedCorners(by: 32)
    NotificationCenter.default.addObserver(self, selector: #selector(handleChangeColor), name: NSNotification.Name(rawValue: "colorRefersh"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleChangeIcon), name: Notification.Name(rawValue: "iconRefresh"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleChangeImage), name: Notification.Name(rawValue: "iconImage"), object: nil)
  }
  
  fileprivate func setupViews() {
    switchViews(firstView: 1.0, secondView: 0.0, thirdView: 0.0)
  }
}

