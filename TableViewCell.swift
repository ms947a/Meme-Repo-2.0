//
//  TableViewCell.swift
//  Meme 1.01
//
//  Created by Michael Sumrall on 7/24/17.
//  Copyright © 2017 Michael Sumrall. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
   
    @IBOutlet weak var memedImage: UIImageView!
    @IBOutlet weak var topTextBox: UILabel!
    @IBOutlet weak var bottomTextBox: UILabel!
    //MARK: Custom Cell's Functions
    
    func updateCell(_ meme: Meme) {
        
        //update cell's view
        memedImage.image = meme.memedImage
        topTextBox.text = meme.topText as String?
        bottomTextBox.text = meme.bottomText as String?
    
    
    
    
    }

}
