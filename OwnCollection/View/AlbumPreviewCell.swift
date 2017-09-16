//
//  AlbumPreviewCell.swift
//  OwnCollection
//
//  Created by Joseph Rivard on 8/31/17.
//  Copyright © 2017 Joseph Rivard. All rights reserved.
//

import UIKit

protocol AlbumPreviewCellDelegate: class {
    func delete(cell: AlbumPreviewCell)
}

class AlbumPreviewCell: UICollectionViewCell {
    
    weak var delegate: AlbumPreviewCellDelegate?
    
    var cover: Cover? {
        didSet {
            coverImage.image = cover?.coverImage
            titleLabel.text = cover?.title
            subTitleLabel.text = cover?.subTitle
        }
    }
    
    var isEditing = false {
        didSet {
            buttonBlur.isHidden = !isEditing
            button.isHidden = !isEditing
        }
    }
    
    let buttonBlur: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blur.alpha = 0.75
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.clipsToBounds = true
        blur.layer.cornerRadius = 15
        blur.isHidden = true
        return blur
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "cancelX"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = true
        return btn
    }()
    
    let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(coverImage)
        coverImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        coverImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        coverImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        coverImage.heightAnchor.constraint(equalToConstant: frame.height * 0.68).isActive = true
        coverImage.alpha = 0
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: frame.height * 0.10).isActive = true
        titleLabel.alpha = 0
        
        addSubview(subTitleLabel)
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        subTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        subTitleLabel.heightAnchor.constraint(equalToConstant: frame.height * 0.10).isActive = true
        subTitleLabel.alpha = 0
        
        addSubview(buttonBlur)
        buttonBlur.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        buttonBlur.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        buttonBlur.heightAnchor.constraint(equalToConstant: 32).isActive = true
        buttonBlur.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        
        addSubview(button)
        button.addTarget(self, action: #selector(handleButtonPress), for: .touchUpInside)
        button.centerXAnchor.constraint(equalTo: buttonBlur.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: buttonBlur.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn, .allowUserInteraction], animations: {
            self.coverImage.alpha = 1
            self.titleLabel.alpha = 1
            self.subTitleLabel.alpha = 1
        }, completion: nil)
    }
    
    @objc func handleButtonPress(sender: UIButton!) {
        delegate?.delete(cell: self)
        //These two lines fix bug where they appear on new covers
        button.isHidden = true
        buttonBlur.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
