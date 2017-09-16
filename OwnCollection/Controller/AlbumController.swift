//
//  AlbumController.swift
//  OwnCollection
//
//  Created by Joseph Rivard on 9/6/17.
//  Copyright © 2017 Joseph Rivard. All rights reserved.
//

import UIKit

class AlbumController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    var cover: Cover?
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = cover?.title
        
        setupCollectionView()
        setupNavBarButtons()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }
    
    //MARK: Collectionview methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cover?.album?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AlbumCell
        guard let albumImage = cover?.album![indexPath.item] else {return cell}
        cell.albumImage.image = albumImage
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.5, height: view.frame.width * 0.4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let fullImageController = FullImageController(collectionViewLayout: layout)
        fullImageController.album = cover?.album!
        fullImageController.indexPath = indexPath
        navigationController?.pushViewController(fullImageController, animated: true)
    }
    
    
    //MARK: Imagepicker method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        if cover?.album == nil {
            cover?.album = [UIImage]()
        }
        
        cover?.album?.append(selectedImage)
        dismiss(animated: true) {
            self.collectionView?.reloadData()
        }
    }
    
    
    //MARK: Actions
    @objc func handleAdd() {
        let imagePickerController = LightImagePickerController()
        imagePickerController.blackNavControllerSetupWith(imagePickerController)
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    //MARK: views setup
    func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.rgb(68, 79, 96)
        collectionView?.register(AlbumCell.self, forCellWithReuseIdentifier: cellId)
    }
    func setupNavBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }
    
}
