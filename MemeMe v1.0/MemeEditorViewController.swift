//
//  MemeEditorViewController.swift
//  MemeMe v2.0
//
//  Created by Latchezar Mladenov on 12/14/15.
//  Copyright © 2015 Latchezar Mladenov. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    var memedImage: UIImage?
    var textFieldDelegate : MemeMeTextFieldDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TO-DO: Edit meme functionality
        textFieldDelegate = MemeMeTextFieldDelegate(topTextField: topTextField, bottomTextField: bottomTextField)
        setupTextField("TOP", textField: topTextField)
        setupTextField("BOTTOM", textField: bottomTextField)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    func pickAnImage(pickOption: Bool) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if pickOption == true {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        else {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum (sender: AnyObject) {
        let pickOption: Bool = true
        pickAnImage(pickOption)
    }
    
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let pickOption: Bool = false
        pickAnImage(pickOption)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButtonPressed() {
        if imagePickerView.image != nil {
            memedImage = generateMemedImage()
            let activityViewController = UIActivityViewController(activityItems: [memedImage as! AnyObject], applicationActivities: nil)
            activityViewController.completionWithItemsHandler = {activityType, completed, returnedItems, error in
                if completed {
                    print("completed")
                    self.saveMeme()
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    print("not completed")
                }
                
            }
            presentViewController(activityViewController, animated: true, completion: nil)
        } else {
            showAlertView("No meme created");
        }
    }
    
    func showAlertView(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveMeme() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imagePickerView.image!, memedImage: memedImage!)
        // Add it to the memes array on the AppDelegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        viewBarsVisibility()
        //Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndPDFContext()
        viewBarsVisibility()
        return memedImage
    }
    
    func viewBarsVisibility() {
        navBar.hidden = !navBar.hidden
        toolbar.hidden = !toolbar.hidden
    }
    
    func setupTextField(string: String, textField: UITextField) {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3
        ]
        
        let attributedString = NSAttributedString(string: string, attributes: memeTextAttributes)
        textField.attributedText = attributedString
        textField.defaultTextAttributes = memeTextAttributes
        // Text should be center-aligned
        textField.textAlignment = .Center
    }

    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if textFieldDelegate!.activeTextField === bottomTextField {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if textFieldDelegate!.activeTextField == bottomTextField {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

