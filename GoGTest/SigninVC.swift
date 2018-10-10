//
//  SigninVC.swift
//  GoGTest
//
//  Created by mac on 10/7/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import CoreData

class SigninVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    var UserAccount = [Users]()
    var userNameFk:String?
    static var fkUserName:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         lblError.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func LoadUsers(UserName : String , Password : String){
        let fetchRequest:NSFetchRequest<Users> = Users.fetchRequest()
          fetchRequest.predicate = NSPredicate(format: "username == %@", UserName)
        do {
            UserAccount = try context.fetch(fetchRequest)
        } catch {
            print ("Wrong username or password")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    @IBAction func signIn(_ sender: Any) {
        let username = userNameTxt.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = passwordTxt.text

        LoadUsers(UserName: username!, Password: pass!)
        print(username)
        print(UserAccount.first?.username)
        print(pass)
        print(UserAccount.first?.password)
        if (username == UserAccount.first?.username  && pass == UserAccount.first?.password )
        {
            userNameFk = username
            SigninVC.fkUserName = username!
            performSegue(withIdentifier: "signin", sender: nil)
            userNameTxt.text = ""
            passwordTxt.text = ""
        }
        else {
            lblError.isHidden = true
            lblError.text = "Wrong username or password"

        }
    }
  

}
