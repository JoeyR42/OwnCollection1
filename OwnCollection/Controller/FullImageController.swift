//
//  FullImage.swift
//  OwnCollection
//
//  Created by Joseph Rivard on 9/8/17.
//  Copyright © 2017 Joseph Rivard. All rights reserved.
//

import UIKit

class FullImageController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    var cellId = "CellId"
    var album: [UIImage]?
    var indexPath: IndexPath?
    
    
    override func viewDidLoad() {
        navigationController?.hidesBarsOnTap = true
        setupCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.scrollToItem(at: indexPath!, at: .centeredHorizontally, animated: false)
    }
    
    //MARK: Collectionview methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album!.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FullImageCell
        cell.image = album?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    //MARK: views setup
    func setupCollectionView() {
        collectionView?.register(FullImageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.isPagingEnabled = true
    }
}
















