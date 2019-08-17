//
//  ViewController.swift
//  AppleShortcuts
//
//  Created by Hassan El Desouky on 8/8/19.
//  Copyright © 2019 Hassan El Desouky. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  //MARK : Properties
  let cellId = "Cell"
  var lists = [List]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.lists = CoreDataManager.shared.fetchLists()
    setupCollectionView()
    setupNavigationBarController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.lists = CoreDataManager.shared.fetchLists()
  }
  
  //MARK : Setup Methods
  fileprivate func setupNavigationBarController() {
    self.navigationController?.navigationBar.shadowImage = UIImage()
    navigationItem.title = "Lists"
    
    if #available(iOS 11.0, *) {
      self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewList)), animated: true)
  }
  
  fileprivate func setupCollectionView() {
    collectionView?.backgroundColor = .white
    collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.alwaysBounceVertical = true
  }
  
  //MARK : CollectionView Delegate Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return lists.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainCollectionViewCell
    let list = lists[indexPath.row]
    cell.listNameLabel.text = list.name
    cell.setGradientBackgroundColor(colorOne: UIColor.color(data: list.firstColor!)!, colorTow: UIColor.color(data: list.secondColor!)!)
    cell.editButton.addTarget(self, action: #selector(editCellButton), for: .touchUpInside)
    cell.makeRoundedCorners(by: 16)
    if let image = list.imageData {
      cell.iconImageView.image = UIImage(data: image)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (view.frame.width / 2) - 20, height: 110)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  }
  
  //MARK : - Actions
  @objc func addNewList() {
    let storyboard = UIStoryboard(name: "CreateList", bundle: nil)
    guard let createListController = storyboard.instantiateViewController(withIdentifier: "CreateListController") as? CreateListController else { return }
    createListController.delegate = self // delegate connected
    let vc = UINavigationController(rootViewController: createListController)
    present(vc, animated: true, completion: nil)
  }

  @objc func editCellButton() {
    print("Edit")
  }
}

extension ViewController: CreateListControllerDelegate {
  func didAddList(list: List) {
    self.collectionView.performBatchUpdates({
      let indexPath = IndexPath(row: lists.count - 1, section: 0)
      self.collectionView.insertItems(at: [indexPath])
    }, completion: nil)
  }
}
