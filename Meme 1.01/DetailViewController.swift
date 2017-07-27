//
//  DetailViewController.swift
//  Meme 1.01
//
//  Created by Michael Sumrall on 7/20/17.
//  Copyright © 2017 Michael Sumrall. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var meme: Meme!
    
    @IBOutlet var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImageView.image = meme.memedImage
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
