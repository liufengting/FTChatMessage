//
//  SignInViewController.swift
//  FTChatMessage
//
//  Created by liufengting on 2016/10/18.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit
import FTIndicator
import FTPickerView

class SignInViewController: UIViewController {
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.accountTextField.text = "liufengting"
        self.passwordTextField.text = "123456"
        
        
    }
    
    var accounts : [String] = ["liufengting",
                               "123456",
                               "Test01",
                               "Test02",
                               "Test03",
                               "Test04",
                               "Test05"]
    
    
    @IBAction func chooseAccountAction(_ sender: UIButton) {
        FTPickerView.show(withTitle: "Choose account",
                          nameArray: self.accounts,
                          doneBlock: { (selectedIndex) in
                            self.accountTextField.text = self.accounts[selectedIndex]
                            }) {
                                
                            }
    }

    @IBAction func signInAction(_ sender: UIButton) {
        
        
//        if self.accountTextField.text == "" {
//            return;
//        }
//        if self.passwordTextField.text == "" {
//            return;
//        }
//        self.view.endEditing(true)
//        
//        FTIndicator.showProgressWithmessage("Signing in...", userInteractionEnable:false)
//
//        NIMSDK.shared().loginManager.login(self.accountTextField.text!, token: (self.passwordTextField.text! as NSString).tokenByPassword()) { (error) in
//            if (error != nil) {
//                FTIndicator.showError(withMessage: "Sign in failed with code:\((error! as NSError).code)")
//            }else{
//                FTIndicator.showSuccess(withMessage: "Sign in succeeded.");
//                
//                DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                    self.performSegue(withIdentifier: "SigninToHome", sender: self)
//                }
//            }
//        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
