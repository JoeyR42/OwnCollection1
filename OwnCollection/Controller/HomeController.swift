//
//  ViewController.swift
//  OwnCollection
//
//  Created by Joseph Rivard on 8/30/17.
//  Copyright © 2017 Joseph Rivard. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, AlbumPreviewCellDelegate {

    let cellId = "cellId"
    var dataModel: DataModel = DataModel()
    var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.blackNavControllerSetupWith(navigationController!)
        navigationItem.title = "Covers"
        setupNavBarButtons()
        setupCollectionView() //setsup bg color and registers cell
    }
    
    //MARK: Collectionview methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.covers.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AlbumPreviewCell
        
        let coverCell = dataModel.covers[indexPath.item]
        cell.cover = coverCell
        cell.delegate = self
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.48, height: view.frame.height * 0.4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing {
            isEditing = false
            
            let addController = AddCoverController()
            addController.homeController = self
            addController.cover = dataModel.covers[indexPath.item]
            let navController = LightContentBarController(rootViewController: addController)
            navController.modalPresentationStyle = .overCurrentContext
            
            present(navController, animated: true, completion: nil)
        } else {
            let layout = UICollectionViewFlowLayout()
            let albumController = AlbumController(collectionViewLayout: layout)
            albumController.cover = dataModel.covers[indexPath.item]
            
            navigationController?.pushViewController(albumController, animated: true)
        }
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? AlbumPreviewCell {
                    cell.isEditing = editing
                }
            }
        }
    }
    
    //MARK: AlbumPreviewCell Delegate
    func delete(cell: AlbumPreviewCell){
        guard let indexPath = collectionView?.indexPath(for: cell) else {return}
        isEditing = false
        
        let alert = UIAlertController(title: "Delete \(dataModel.covers[indexPath.item].title)?", message: "Are you sure you want to delete this cover?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {alert in
            
            self.dataModel.covers.remove(at: indexPath.item)
            self.collectionView?.deleteItems(at: [indexPath])
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: {alert in
            self.dismiss(animated: true, completion: nil)
        }))

        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: View setups
    func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.rgb(68, 79, 96)
        collectionView?.register(AlbumPreviewCell.self, forCellWithReuseIdentifier: cellId)
    }
    func setupNavBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        setEditButton()
    }
    
    
    //MARK: Actions
    @objc func handleAdd() {
        isEditing = false
        
        let addController = AddCoverController()
        addController.homeController = self
        let navController = LightContentBarController(rootViewController: addController)
        navController.modalPresentationStyle = .overCurrentContext
        
        present(navController, animated: true, completion: nil)
    }
    
    //MARK: Helper functions
    func setEditButton() {
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
}


















