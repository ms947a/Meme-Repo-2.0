//
//  ViewController.swift
//  Meme 1.01
//
//  Created by Michael Sumrall on 6/28/17.
//  Copyright © 2017 Michael Sumrall. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    
    //Text Attributes that will determine the size and color of text
    let memeTextAttributes = [
        NSStrokeWidthAttributeName: -3.0,
        NSForegroundColorAttributeName: UIColor.white,
        NSStrokeColorAttributeName: UIColor.black,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!] as [String : Any]
    
    
    //Outlets
    
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var memeViewer: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextBox: UITextField!
    @IBOutlet weak var bottomTextBox: UITextField!
    
    let topTextDefaultValue = "TOP"
    let bottomTextDefaultValue = "BOTTOM"
    
    //Album Button
    
    @IBAction func albumButton(_ sender: UIBarButtonItem) {
        pickImageFromCameraOrLibrary(source: UIImagePickerControllerSourceType.photoLibrary)
    }
    // Share Button
    @IBAction func actionButton(_ sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage],
                                                              applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            activity,completed, items, error in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    // Camera Button
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        pickImageFromCameraOrLibrary(source: UIImagePickerControllerSourceType.camera)
    }
    
    func pickImageFromCameraOrLibrary (source:UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.isEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeViewer.image = image
            dismiss(animated: true, completion: nil)
        }
        
    }
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = UIApplication.shared.delegate as! AppDelegate
        
        
        prepareTextField(topTextBox, with: topTextDefaultValue)
        prepareTextField(bottomTextBox, with: bottomTextDefaultValue)
        
        
        self.subscribeToKeyboardNotification()
        
        memeViewer.contentMode = .scaleAspectFit
        
        
        
    }
    
    //View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotification()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        
    }
    func subscribeToKeyboardNotification() {
        NotificationCenter.default .addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    func prepareTextField(_ textField:UITextField, with defaultText: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = self
        textField.text = defaultText
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotification()
    }
    
    func unsubscribeToKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    func keyboardWillShow (_ notification:Notification) {
        if bottomTextBox.isFirstResponder {
            self.view.frame.origin.y = -getKeyboardHeight(_notification: notification)
            
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    
    
    func keyboardWillHide(_ notification: Notification) {
        if bottomTextBox.isFirstResponder {
            self.view.frame.origin.y = +getKeyboardHeight(_notification: notification)
            
        }
    }
    
    func getKeyboardHeight(_notification:Notification) -> CGFloat {
        
        let userInfo = _notification.userInfo!
        let keyboradSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboradSize.cgRectValue.height
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.frame.origin.y = 0
        if textField == topTextBox && topTextBox.text == "" {
            topTextBox.text = "TOP"
        }
        else if textField == bottomTextBox && bottomTextBox.text == "" {
            bottomTextBox.text = "BOTTOM"
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func generateMemedImage() -> UIImage{
        
        navigationBar.isHidden = true
        toolBar.isHidden = true
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        navigationBar.isHidden = false
        toolBar.isHidden = false
        
        return memedImage
    }
    func save() {
        let meme = Meme(topText: topTextBox.text!, bottomText: bottomTextBox.text!, originalImage:
            memeViewer.image!, memedImage: memedImage)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
   
}
// set constant value for text boxes

    var topTextBox: String!
    var bottomTextBox: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
