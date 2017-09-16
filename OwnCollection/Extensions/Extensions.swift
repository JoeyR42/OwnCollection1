//
//  Extensions.swift
//  OwnCollection
//
//  Created by Joseph Rivard on 8/30/17.
//  Copyright © 2017 Joseph Rivard. All rights reserved.
//

import UIKit

extension UIColor {
   static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    //Used to specify the constraints
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index,view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UINavigationController {
    func blackNavControllerSetupWith(_ nc: UINavigationController){
        nc.title = title
        nc.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        nc.navigationBar.isTranslucent = false
        nc.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        nc.navigationBar.tintColor = .white
    }
}














//How to make a button - for future reference
//translatesAutoresizingMaskIntoConstraints seems to only need to be used once constraint are added
//        let btn = UIButton(frame: CGRect(x: view.frame.width/2, y: view.frame.height/2, width: 50, height: 50))
//        btn.setTitle("Click Me", for: [])
//        btn.addTarget(self, action: #selector(handlePress), for: UIControlEvents.touchUpInside)
//        self.view.addSubview(btn)


