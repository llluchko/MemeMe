//
//  MemeCollectionViewController.swift
//  MemeMe v2.0
//
//  Created by Latchezar Mladenov on 2/4/16.
//  Copyright © 2016 Latchezar Mladenov. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    var memes : [Meme]  {
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appdelegate.memes
    }
    
    required init?(coder aDecoder:  NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.collectionView!.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! CustomMemeCell
        let meme = memes[indexPath.item]
        let imageView = UIImageView(image: meme.memedImage)
        cell.backgroundView = imageView
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = self.memes[indexPath.row]
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("memeDetail") as! MemeDetailViewController
        self.navigationController!.pushViewController(detailController, animated: true)
        detailController.memeImage = meme.memedImage
    }
    
}
