//
//  IconColorController.swift
//  AppleShortcuts
//
//  Created by Hassan El Desouky on 8/10/19.
//  Copyright © 2019 Hassan El Desouky. All rights reserved.
//

import UIKit

class IconColorController: UIViewController {
  
  let collectionView: UICollectionView = {
    let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    cv.backgroundColor = .white
    cv.allowsSelection = true
    cv.translatesAutoresizingMaskIntoConstraints = false
    return cv
  }()
  let cellId = "ColorCell"
  let colorsTable: [Int: [UIColor]] = [0: [#colorLiteral(red: 0.9654200673, green: 0.1590853035, blue: 0.2688751221, alpha: 1),#colorLiteral(red: 0.7559037805, green: 0.1139892414, blue: 0.1577021778, alpha: 1)], 1: [#colorLiteral(red: 0.9338900447, green: 0.4315618277, blue: 0.2564975619, alpha: 1),#colorLiteral(red: 0.8518816233, green: 0.1738803983, blue: 0.01849062555, alpha: 1)], 2: [#colorLiteral(red: 0.9953531623, green: 0.54947716, blue: 0.1281470656, alpha: 1),#colorLiteral(red: 0.9409626126, green: 0.7209432721, blue: 0.1315650344, alpha: 1)], 3: [#colorLiteral(red: 0.9409626126, green: 0.7209432721, blue: 0.1315650344, alpha: 1),#colorLiteral(red: 0.8931249976, green: 0.5340107679, blue: 0.08877573162, alpha: 1)],
                                       4: [#colorLiteral(red: 0.3796315193, green: 0.7958304286, blue: 0.2592983842, alpha: 1),#colorLiteral(red: 0.2060100436, green: 0.6006633639, blue: 0.09944178909, alpha: 1)], 5: [#colorLiteral(red: 0.2761503458, green: 0.824685812, blue: 0.7065336704, alpha: 1),#colorLiteral(red: 0, green: 0.6422213912, blue: 0.568986237, alpha: 1)], 6: [#colorLiteral(red: 0.2494148612, green: 0.8105323911, blue: 0.8425348401, alpha: 1),#colorLiteral(red: 0, green: 0.6073564887, blue: 0.7661359906, alpha: 1)], 7: [#colorLiteral(red: 0.3045541644, green: 0.6749247313, blue: 0.9517192245, alpha: 1),#colorLiteral(red: 0.008423916064, green: 0.4699558616, blue: 0.882807076, alpha: 1)],
                                       8: [#colorLiteral(red: 0.1774400771, green: 0.466574192, blue: 0.8732826114, alpha: 1),#colorLiteral(red: 0.00491155684, green: 0.287129879, blue: 0.7411141396, alpha: 1)], 9: [#colorLiteral(red: 0.4613699913, green: 0.3118675947, blue: 0.8906354308, alpha: 1),#colorLiteral(red: 0.3018293083, green: 0.1458326578, blue: 0.7334778905, alpha: 1)], 10: [#colorLiteral(red: 0.7080290914, green: 0.3073516488, blue: 0.8653779626, alpha: 1),#colorLiteral(red: 0.5031493902, green: 0.1100070402, blue: 0.6790940762, alpha: 1)], 11: [#colorLiteral(red: 0.9495453238, green: 0.4185881019, blue: 0.6859942079, alpha: 1),#colorLiteral(red: 0.8123683333, green: 0.1657164991, blue: 0.5003474355, alpha: 1)]]
  
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

extension IconColorController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return colorsTable.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IconChooseColorCell
    guard let colors = colorsTable[indexPath.row] else { fatalError("Colors table error") }
    cell.setGradientBackgroundColor(colorOne: colors[0], colorTow: colors[1])
    cell.makeRoundedCorners()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let colors = colorsTable[indexPath.row] else { fatalError("Colors table erro") }
    let colorDataDict:[String: [UIColor]] = ["colorDict": [colors[0], colors[1]]]
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "colorRefersh"), object: nil, userInfo: colorDataDict)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 70, height: 70)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
  }
}

