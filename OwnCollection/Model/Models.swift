//
//  Model.swift
//  OwnCollection
//
//  Created by Joseph Rivard on 9/1/17.
//  Copyright © 2017 Joseph Rivard. All rights reserved.
//

import UIKit

class Cover: NSObject, NSCoding {
    
    var coverImage: UIImage
    var title: String
    var subTitle: String
    var album: [UIImage]?
    
    init(coverImage: UIImage, title: String, subTitle: String) {
        self.coverImage = coverImage
        self.title = title
        self.subTitle = subTitle
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(coverImage, forKey: "CoverImage")
        aCoder.encode(title, forKey: "Title")
        aCoder.encode(subTitle, forKey: "SubTitle")
        aCoder.encode(album, forKey: "Album")
    }
    
    required init?(coder aDecoder: NSCoder) {
        coverImage = aDecoder.decodeObject(forKey: "CoverImage") as! UIImage
        title = aDecoder.decodeObject(forKey: "Title") as! String
        subTitle = aDecoder.decodeObject(forKey: "SubTitle") as! String
        album = aDecoder.decodeObject(forKey: "Album") as? [UIImage]
    }
    
    
}


class DataModel {
    
    var covers = [Cover]()
    
    init() {
        loadChecklists()
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("OwnCollection.plist")
    }
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(covers, forKey: "Covers")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            covers = unarchiver.decodeObject(forKey: "Covers") as! [Cover]
            unarchiver.finishDecoding()
        }
    }
}



















