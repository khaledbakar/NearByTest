//
//  SignUpVC.swift
//  GoGTest
//
//  Created by mac on 10/7/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import CoreData

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var lblUserError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPassError: UILabel!
    
    @IBOutlet weak var lblBirthDay: UITextField!
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblUserName: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    var imagePicker: UIImagePickerController!
    var UserAccountDouble = [Users]()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        lblUserError.isHidden = true
        lblEmailError.isHidden = true
        lblPassError.isHidden = true

        // Do any additional setup after loading the view.
    }

  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func ImageSelect(_ sender: Any) {
        present(imagePicker,animated: true , completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imgProfile.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func signInNavBu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func SignUpBu(_ sender: Any) {
       // let username = userNameTxt.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        let newUser:Users!
        newUser = Users(context: context)
        let passwordTriming = lblPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let userTriming = lblUserName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        loadUserName(UserNameDouble: userTriming!)
        if(userTriming == UserAccountDouble.first?.username){
            let alert = UIAlertController(title: "Not Exist", message: "There's no account here!", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
        else {
            if userTriming != "" && userTriming != nil{
                if passwordTriming != "" && passwordTriming != nil {
                    if (lblEmail.text?.contains("@"))! {
                        newUser.username = lblUserName.text?.lowercased()
                        newUser.password = lblPassword.text?.lowercased()
                        newUser.profilepic = imgProfile.image
                        newUser.birthday = lblBirthDay.text?.lowercased()
                        newUser.email = lblEmail.text?.lowercased()
                        do{
                            ad.saveContext()
                            lblUserName.text = ""
                            lblPassword.text = ""
                            lblEmail.text = ""
                            lblBirthDay.text = ""
                            imgProfile.image = UIImage(named: "add_photo")
                            print(newUser.username)
                            dismiss(animated: true, completion: nil)
                        }
                        catch {
                            print ("Error ")
                        }
                    }
                    else {
                        lblEmailError.isHidden = false
                        lblEmailError.text = "wrong Email"
                    }
                }
                else {
                    lblPassError.isHidden = false
                    lblPassError.text = "Wrong Password"
                }
            } else  {
                lblUserError.isHidden = false
                lblUserError.text = "Enter the true USERNAME"
            }
        }
        
    }
    func  loadUserName(UserNameDouble :String)  {
        let fetchRequest:NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", UserNameDouble)
        
        
        do {
            UserAccountDouble = try context.fetch(fetchRequest)
            
            
        } catch {
            print ("Wrong username or password")
           
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
