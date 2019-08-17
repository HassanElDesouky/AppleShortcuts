//
//  IconChooseColorCell.swift
//  AppleShortcuts
//
//  Created by Hassan El Desouky on 8/10/19.
//  Copyright © 2019 Hassan El Desouky. All rights reserved.
//

import UIKit

class IconChooseColorCell: UICollectionViewCell {
  
  let view: UIImageView = {
    let cv = UIImageView()
    cv.translatesAutoresizingMaskIntoConstraints = false
    return cv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setupView() {
    self.addSubview(view)
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: self.topAnchor),
      view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      view.leftAnchor.constraint(equalTo: self.leftAnchor),
      view.rightAnchor.constraint(equalTo: self.rightAnchor),
      ])
  }
}

