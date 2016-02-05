//
//  MemeTableViewController.swift
//  MemeMe v2.0
//
//  Created by Latchezar Mladenov on 2/4/16.
//  Copyright © 2016 Latchezar Mladenov. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController{
    var memes: [Meme] {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.memes
    }
    required init!(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView!.reloadData()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")!
        cell.imageView?.image = self.memes[indexPath.row].memedImage
        cell.textLabel!.text = self.memes[indexPath.row].topText + "..." + self.memes[indexPath.row].bottomText
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = self.memes[indexPath.row]
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("memeDetail") as! MemeDetailViewController
        self.navigationController!.pushViewController(detailController, animated: true)
        detailController.memeImage = meme.memedImage
    }
}
