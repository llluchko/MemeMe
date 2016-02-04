//
//  MemeTableViewController.swift
//  MemeMe v2.0
//
//  Created by Latchezar Mladenov on 2/4/16.
//  Copyright © 2016 Latchezar Mladenov. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memeCount = 0
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")!
        let meme = self.memes[indexPath.row]
    
        cell.textLabel?.text = meme.bottomText + "..." + meme.topText
        cell.imageView?.image = meme.memedImage
        
        return cell
        
    }  
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
}
