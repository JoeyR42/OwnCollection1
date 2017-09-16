//
//  AlbumCell.swift
//  OwnCollection
//
//  Created by Joseph Rivard on 9/6/17.
//  Copyright © 2017 Joseph Rivard. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    var albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(albumImage)
        albumImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        albumImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        albumImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        albumImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
