//
//  IconGlyphController.swift
//  AppleShortcuts
//
//  Created by Hassan El Desouky on 8/10/19.
//  Copyright © 2019 Hassan El Desouky. All rights reserved.
//

import UIKit

class IconGlyphController: UIViewController {
  
  let collectionView: UICollectionView = {
    let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    cv.backgroundColor = .white
    cv.allowsSelection = true
    cv.translatesAutoresizingMaskIntoConstraints = false
    return cv
  }()
  let cellId = "ColorCell"
  let iconsNames = ["avatar-1.png", "avatar.png", "back 6.16.26 AM.png", "book.png", "cancel.png", "chat-1.png", "chat-2.png", "chat.png", "copy.png", "dislike 6.16.26 AM.png", "download 6.16.26 AM.png", "download-1.png", "edit 6.16.26 AM.png", "envelope.png", "folder 6.16.26 AM.png", "garbage 6.16.26 AM.png", "glasses.png", "hand.png", "headphones.png", "heart.png", "house 6.16.26 AM.png", "like 6.16.26 AM.png", "link 6.16.26 AM.png", "logout.png", "magnifying-glass.png", "monitor.png", "musical-note.png", "next 6.16.26 AM.png", "next-1.png", "padlock.png", "paper-plane 6.16.26 AM.png", "phone-call.png", "photo-camera 6.16.26 AM.png", "pie-chart.png", "piggy-bank.png", "placeholder 6.16.26 AM.png", "printer.png", "reload.png", "settings 6.16.26 AM.png", "settings-1 6.16.26 AM.png", "share 6.16.26 AM.png", "shopping-bag.png", "shopping-cart.png", "shuffle 6.16.26 AM.png", "speaker 6.16.26 AM.png", "star 6.16.26 AM.png", "tag.png", "upload 6.16.26 AM.png", "upload-1.png", "vector.png"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
  }
  
  fileprivate func setupCollectionView() {
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
      collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 16),
      collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
      collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
      ])
    let flawLayout = UICollectionViewFlowLayout()
    flawLayout.scrollDirection = .vertical
    flawLayout.minimumLineSpacing = 5.0
    flawLayout.minimumInteritemSpacing = 5.0
    self.collectionView.collectionViewLayout = flawLayout
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.collectionView.register(IconChooseColorCell.self, forCellWithReuseIdentifier: cellId)
  }
}

extension IconGlyphController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return iconsNames.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IconChooseColorCell
    DispatchQueue.main.async {
      cell.view.image = UIImage(named: self.iconsNames[indexPath.row])
      cell.view.image = cell.view.image?.withRenderingMode(.alwaysTemplate)
      cell.view.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedIcon = UIImage(named: iconsNames[indexPath.row])!
    let iconDict: [String: UIImage] = ["iconDict": selectedIcon]
    NotificationCenter.default.post(name: Notification.Name(rawValue: "iconRefresh"), object: nil, userInfo: iconDict)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 45, height: 45)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
}
