//
//  MemeDetailViewController.swift
//  MemeMe v2.0
//
//  Created by Latchezar Mladenov on 2/5/16.
//  Copyright © 2016 Latchezar Mladenov. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var memeImage : UIImage? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editTapped")
        imageView.image = memeImage
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController!.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController!.tabBar.hidden = false
    }
    
//    func editTapped() {
//        let storyboard = UIStoryboard (name: "Main", bundle: nil)
//        let editVC = storyboard.instantiateViewControllerWithIdentifier("createMeme")as! MemeEditorViewController
//        navigationController?.pushViewController(editVC, animated: true)
//    }

}

