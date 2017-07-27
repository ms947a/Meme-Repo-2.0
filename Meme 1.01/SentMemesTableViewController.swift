//
//  SentMemesTableViewController.swift
//  Meme 1.01
//
//  Created by Michael Sumrall on 7/19/17.
//  Copyright © 2017 Michael Sumrall. All rights reserved.
//

import UIKit
import Foundation

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme]!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
    
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        
        tableView?.reloadData()
        
        self.tabBarController?.tabBar.isHidden = false    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        let meme = memes[indexPath.row]
        cell.tableImageView.image = meme.memedImage
        
        return cell
    }
    


}
