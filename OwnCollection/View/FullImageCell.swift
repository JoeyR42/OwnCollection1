//
//  FullImageCell.swift
//  OwnCollection
//
//  Created by Joseph Rivard on 9/8/17.
//  Copyright © 2017 Joseph Rivard. All rights reserved.
//

import UIKit

class FullImageCell: UICollectionViewCell {
    
    var image: UIImage? {
        didSet {
            fullImage.image = image
        }
    }
    
    var fullImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(fullImage)
//        fullImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
//        fullImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
//        fullImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
//        fullImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        fullImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fullImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fullImage.heightAnchor.constraint(equalToConstant: self.frame.height - 100).isActive = true
        fullImage.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
