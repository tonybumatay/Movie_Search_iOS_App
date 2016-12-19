//
//  CellStruct.swift
//  Lab4
//
//  Created by Tony Bumatay on 10/18/16.
//  Copyright © 2016 Tony Bumatay. All rights reserved.
//

import Foundation
import UIKit

class CellData: UICollectionViewCell {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    var movImage = UIImage() {
        didSet{
            movieImage.image = movImage
        }
    }
    
    var title = String() {
        didSet {
            movieLabel.text = title
        }
    }
    
    var id = String()
    
}
