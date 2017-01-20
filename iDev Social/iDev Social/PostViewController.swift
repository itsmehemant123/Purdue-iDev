//
//  PostViewController.swift
//  iDev Social
//
//  Created by Hemanth Devarapalli on 1/19/17.
//  Copyright © 2017 Hemanth Devarapalli. All rights reserved.
//

import UIKit
import Firebase
import Photos

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var dataRef = FIRDatabase.database().reference()
    var storRef = FIRStorage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var postField: UITextField!
    @IBAction func onGallery(_ sender: Any) {
        let imagePickController = UIImagePickerController()
        imagePickController.delegate = self
        imagePickController.allowsEditing = true
        imagePickController.sourceType = .photoLibrary
        self.present(imagePickController, animated: true, completion: nil)
    }
    @IBAction func onPost(_ sender: Any) {
        let usersRef = dataRef.child("posts").childByAutoId()
        var postInfo: [String: String] = [:]
        postInfo["text"] = postField.text!
        postInfo["user"] = FIRAuth.auth()?.currentUser?.email
        
        guard let image = imageField.image else {
            usersRef.setValue(postInfo)
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let data = UIImageJPEGRepresentation(image, 0.8)
        let photoRef = storRef.child("images")
        let uuid = UUID().uuidString
        photoRef.child(uuid).put(data!, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            } else {
                postInfo["image"] = uuid
                usersRef.setValue(postInfo)
            }
        }
        usersRef.setValue(postInfo)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("Error picking image")
            return
        }
        
        imageField.image = image
        
        picker.dismiss(animated: true, completion: nil)
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
