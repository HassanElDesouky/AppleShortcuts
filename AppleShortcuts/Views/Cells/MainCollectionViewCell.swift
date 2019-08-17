//
//  MainCollectionViewCell.swift
//  AppleShortcuts
//
//  Created by Hassan El Desouky on 8/8/19.
//  Copyright © 2019 Hassan El Desouky. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCell()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: UI
  let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.makeRoundedCorners(by: 12)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  let listNameLabel: UILabel = {
    let label = UILabel()
    label.text = "List"
    label.textColor = UIColor.white
    label.font = UIFont.boldSystemFont(ofSize: 19)
    label.textAlignment = .left
    return label
  }()
  
  let editButton: UIButton = {
    let button = UIButton(type: .custom) as UIButton
    button.setImage(UIImage(named: "Edit"), for: UIControl.State.normal)
    return button
  }()
  
  // MARK: Setup Cell
  fileprivate func setupCell() {
    setCellShadow()
    self.addSubview(iconImageView)
    self.addSubview(listNameLabel)
    self.addSubview(editButton)
    iconImageView.anchor(top: safeTopAnchor, left: safeLeftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
    listNameLabel.anchor(top: iconImageView.bottomAnchor, left: safeLeftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 8, paddingBottom: 0, paddingRight: 0)
    editButton.anchor(top: safeTopAnchor, left: nil, bottom: nil, right: safeRightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 36, height: 36)
  }
  
  // MARK: Methods
  func setCellShadow() {
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.layer.shadowOpacity = 0.2
    self.layer.shadowRadius = 1.0
    self.layer.masksToBounds = false
    self.layer.cornerRadius = 3
    self.clipsToBounds = false
  }
}

