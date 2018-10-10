//
//  ViewController.swift
//  ExpressionB Axis
//
//  Created by ExpresionBinaria on 10/2/18.
//  Copyright © 2018 ExpresionBinaria. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var txtLoginUser: UITextField!
    @IBOutlet weak var txtLoginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func login(_ sender: UIButton) {
        let user = txtLoginUser.text
        let pass = txtLoginPassword.text
        
        if(user != "julio" || pass != "palacios") {
            let alert = UIAlertController(title: "Login incorrecto", message: "Por favor, verifica tus credenciales", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
        
        doLogin(user: user!, pass: pass!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func doLogin(user: String, pass: String) {
        
    }
    
}

