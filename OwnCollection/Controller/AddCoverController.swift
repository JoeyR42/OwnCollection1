//
//  AddCoverController.swift
//  OwnCollection
//
//  Created by Joseph Rivard on 9/1/17.
//  Copyright © 2017 Joseph Rivard. All rights reserved.
//

import UIKit

//protocol AddCoverControllerDelegate: class {
//    func didFinishAdding(cell: AlbumPreviewCell)
//    func didCancel()
//}

class AddCoverController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //MARK: Properties
    var homeController: HomeController?
    var cover: Cover?
    
    let cellId = "cellId"
    
    let imagePickerCell: UITableViewCell = UITableViewCell()
    let titleCell: UITableViewCell = UITableViewCell()
    let subTitleCell: UITableViewCell = UITableViewCell()
    
    
    var titleText: UITextField = UITextField()
    var subTitleText: UITextField = UITextField()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2), style: .grouped)
        tv.backgroundColor = UIColor.rgb(184, 189, 196)
        tv.isScrollEnabled = false
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    var chosenImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "placeHolder")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.rgb(184, 189, 196)
        tableView.backgroundColor = UIColor(red: 68/255, green: 79/255, blue: 96/255, alpha: 0.85)
        view.backgroundColor = UIColor(red: 68/255, green: 79/255, blue: 96/255, alpha: 0.85)
        
//        tableView.backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
//        view.backgroundColor = UIColor(red: 184/255, green: 189/255, blue: 196/255, alpha: 0.85)
        
        navigationController?.blackNavControllerSetupWith(navigationController!)
        navigationItem.title = "Add New Cover"
        setupNavBarButtons()
        setupCells()
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)
        
        view.addSubview(chosenImage)
        chosenImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        chosenImage.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8).isActive = true
        chosenImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        chosenImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true

        if let cover = cover {
            navigationItem.title = cover.title
            chosenImage.image = cover.coverImage
            titleText.text = cover.title
            subTitleText.text = cover.subTitle
        }
    }
    
    
    //MARK: Tableview controls
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0:
            return "Title and Subtitle"
        case 1:
            return "Choose an image"
        default:
            fatalError()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return 2
        case 1:
            return 1
        default:
            fatalError()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row){
            case 0:
                return titleCell
            case 1:
                return subTitleCell
            default:
                fatalError()
            }
        case 1:
            switch(indexPath.row){
            case 0:
                return imagePickerCell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section != 1 {
            return nil
        }
        return indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            handleShowImagePicker()
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
        }
    }
    
    
    //MARK: ImagePicker methods
    func handleShowImagePicker() {
        let imagePickerController = LightImagePickerController()
        imagePickerController.blackNavControllerSetupWith(imagePickerController)
                
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        chosenImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: view setups
    func setupNavBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
    }
    func setupCells() {
        titleText = UITextField(frame: titleCell.contentView.bounds.insetBy(dx: 15, dy: 0))
        titleText.placeholder = "Cover Title"
//        titleText.attributedPlaceholder = NSAttributedString(string: "Cover Title", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        titleCell.addSubview(titleText)
//        titleCell.backgroundColor = .lightGray
        
        subTitleText = UITextField(frame: subTitleCell.contentView.bounds.insetBy(dx: 15, dy: 0))
        subTitleText.placeholder = "Cover SubTitle"
//        subTitleText.attributedPlaceholder = NSAttributedString(string: "Cover SubTitle", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        subTitleCell.addSubview(subTitleText)
//        subTitleCell.backgroundColor = .lightGray
        
        imagePickerCell.textLabel?.text = "Choose an Image"
        imagePickerCell.textLabel?.textColor = .lightGray
        imagePickerCell.accessoryType = .disclosureIndicator
//        imagePickerCell.backgroundColor = .lightGray
    }
    
    
    //MARK: Actions
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    @objc func handleDone() {
        if let cover = cover {
            cover.coverImage = chosenImage.image ?? #imageLiteral(resourceName: "placeHolder")
            cover.title = titleText.text ?? ""
            cover.subTitle = subTitleText.text ?? ""
            
            guard let hc = homeController else {return}
            
            dismiss(animated: true, completion: {
                hc.collectionView?.reloadData()
            })
        } else {
            guard let hc = homeController else {return}
            let newCover = Cover(coverImage: chosenImage.image!, title: titleText.text ?? "", subTitle: subTitleText.text ?? "")
            hc.dataModel.covers.append(newCover)
            
            dismiss(animated: true) {
                hc.collectionView?.reloadData()
            }
        }
    }
}















