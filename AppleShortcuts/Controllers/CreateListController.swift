//
//  CreateListController.swift
//  AppleShortcuts
//
//  Created by Hassan El Desouky on 8/9/19.
//  Copyright © 2019 Hassan El Desouky. All rights reserved.
//

import UIKit
import CoreData

protocol CreateListControllerDelegate: class {
  func didAddList(list: List)
}

class CreateListController: UITableViewController {
  
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var nameTextField: UITextField!
  lazy var iconImage: UIImageView = {
    let imgView = UIImageView()
    return imgView
  }()
  @IBOutlet weak var iconCellView: UIImageView!
  var chooseIconTapped = false
  
  weak var delegate: CreateListControllerDelegate?
  var list: List?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    handleEmptyFields()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    checkFields()
    setupEditingHistory()
  }
  
  @IBAction func handleSave(_ sender: Any) {
    if list == nil {
      createList()
    } else {
      saveListChanges()
    }
  }
  
  @IBAction func handleCancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func handleIcon(notification: Notification) {
    guard let iconDict = notification.userInfo else { return }
    guard let icon = iconDict["finalIcon"] as? UIImage else { return }
    iconImage.image = icon
    iconCellView.image = icon
  }
  
  private func saveListChanges() {
    // TODO: Handle saving list changes
  }
  
  private func createList() {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let list = NSEntityDescription.insertNewObject(forEntityName: "List", into: context)
    list.setValue(nameTextField.text, forKey: "name")
    if let firstColor = firstColorData {
      list.setValue(firstColor, forKey: "firstColor")
    }
    if let secondColor = secondColorData {
      list.setValue(secondColor, forKey: "secondColor")
    }
    if let image = iconImage.image {
      let imageData = image.jpegData(compressionQuality: 0.8)
      list.setValue(imageData, forKey: "imageData")
      iconCellView.image = UIImage(data: imageData!)
    }
    do {
      try context.save()
      dismiss(animated: true) {
        self.delegate?.didAddList(list: list as! List)
      }
    } catch {
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }
  
  private func handleEmptyFields() {
    doneBarButton.isEnabled = false
    nameTextField.delegate = self
  }
  
  fileprivate func setupEditingHistory() {
    if list == nil {
      navigationItem.title = "Create List"
      NotificationCenter.default.addObserver(self, selector: #selector(handleIcon), name: NSNotification.Name(rawValue: "finalIcon"), object: nil)
    } else {
      navigationItem.title = "Edit List"
      nameTextField.text = list?.name
      if let image = list?.imageData {
        iconCellView.image = UIImage(data: image)
      }
      chooseIconTapped = true
    }
  }
  
  fileprivate func checkFields() {
    if list != nil || chooseIconTapped && nameTextField.text!.count > 0 {
      doneBarButton.isEnabled = true
    }
  }
}

extension CreateListController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 1 {
      chooseIconTapped = true
      let iconController = storyboard?.instantiateViewController(withIdentifier: "ListIconController") as! ListIconController
      iconController.list = list
      navigationController?.pushViewController(iconController, animated: true)
    }
  }
}

extension CreateListController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = (nameTextField.text! as NSString).replacingCharacters(in: range, with: string)
    if text.isEmpty || !chooseIconTapped {
      doneBarButton.isEnabled = false
    } else {
      doneBarButton.isEnabled = true
    }
    return true
  }
}
