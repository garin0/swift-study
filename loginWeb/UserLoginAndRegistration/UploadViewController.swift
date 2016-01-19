//
//  UploadViewController.swift
//  UserLoginAndRegistration
//
//  Created by garin on 2016. 1. 19..
//  Copyright © 2016년 Sergey Kargopolov. All rights reserved.
//

import UIKit
import Parse

class UploadViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate{

    @IBOutlet weak var textFieldPreviewTitle: UITextField!
    @IBOutlet weak var imageViewPreview: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func uploadPhoto(sender: AnyObject) {
        //사진을 고를 수 있음.
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageViewPreview.image = image
        self.dismissViewControllerAnimated(true, completion: nil) //이미지 고르면 사라짐
    }
    
    @IBAction func uploadButtonTapped(sender: AnyObject) {
        let imageText = textFieldPreviewTitle.text
        let previewImage = imageViewPreview.image
        
        if imageText!.isEmpty || previewImage == nil{
           print("업로드: 유저가 이미지 혹은 텍스트를 넣지 않음")
            
            
        }else {
            let imageData = UIImagePNGRepresentation(self.imageViewPreview.image!)
            let parseImageFile = PFFile(name: "uploaded_image.png", data: imageData!)
            
            let save = PFObject(className: "Posts")
            save["imageFile"] = parseImageFile
            save["imageText"] = imageText
            save["uploader"] = PFUser.currentUser()
            save.saveInBackgroundWithBlock({ (success:Bool!, error:NSError?) -> Void in
                if error == nil {
                    print("업로드 성공")
                    self.performSegueWithIdentifier("uploadToHome", sender: self)
                }else{
                    print(error)
                }
            })
        }
    }
   
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
