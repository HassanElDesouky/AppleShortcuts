//
//  IconView.swift
//  AppleShortcuts
//
//  Created by Hassan El Desouky on 8/10/19.
//  Copyright © 2019 Hassan El Desouky. All rights reserved.
//

import UIKit

@IBDesignable
class IconView: UIView {
  
  @IBInspectable
  var topColor: UIColor = .clear {
    didSet {
      updateViews()
    }
  }
  
  @IBInspectable
  var bottomColor: UIColor = .clear {
    didSet {
      updateViews()
    }
  }
  
  let image: UIImageView = {
    let im = UIImageView()
    im.contentMode = .scaleAspectFit
    im.translatesAutoresizingMaskIntoConstraints = false
    return im
  }()
  
  let backgroundImage: UIImageView = {
    let im = UIImageView()
    im.contentMode = .scaleAspectFill
    im.translatesAutoresizingMaskIntoConstraints = false
    return im
  }()
  
  override class var layerClass: AnyClass {
    get {
      return CAGradientLayer.self
    }
  }
  
  private func updateViews() {
    let layer = self.layer as! CAGradientLayer
    layer.colors = [topColor.cgColor, bottomColor.cgColor]
    setupImageView()
    setupBackgroundImage()
  }
  
  private func setupImageView() {
    self.addSubview(image)
    NSLayoutConstraint.activate([
      image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      image.heightAnchor.constraint(equalToConstant: 70),
      image.widthAnchor.constraint(equalToConstant: 70)
      ])
  }
  
  private func setupBackgroundImage() {
    self.addSubview(backgroundImage)
    NSLayoutConstraint.activate([
      backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
      backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      backgroundImage.leftAnchor.constraint(equalTo: self.leftAnchor),
      backgroundImage.rightAnchor.constraint(equalTo: self.rightAnchor)
      ])
  }
}

