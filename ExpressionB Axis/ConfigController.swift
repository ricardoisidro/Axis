//
//  ConfigController.swift
//  ExpressionB Axis
//
//  Created by ExpresionBinaria on 10/4/18.
//  Copyright © 2018 ExpresionBinaria. All rights reserved.
//

import UIKit

class ConfigController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var switchCamera: UISwitch!
    @IBOutlet weak var switchSMS: UISwitch!
    @IBOutlet weak var cellURL: UITableViewCell!
    @IBOutlet weak var cellPhone: UITableViewCell!
    @IBOutlet weak var cellCommand: UITableViewCell!
    @IBOutlet weak var txtURL: UITextField!
    @IBOutlet weak var txtSettingsPhone: UITextField!
    @IBOutlet weak var txtSettingsCommand: UITextField!
    @IBOutlet weak var cellSMSURL: UITableViewCell!
    

    //let disabledColor = UIColor.lightGray
    let disabledColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
    let enabledColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSettingsPhone.delegate = self
        
        let actualURL = UserDefaults.standard.string(forKey: "CameraURL") ?? ""
        txtURL.text = actualURL
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //navigationController?.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let newURL = txtURL.text
        print("Guardando la URL: " + (newURL ?? ""))
        UserDefaults.standard.set(newURL, forKey: "CameraURL")
        print("URL en settings: " + (UserDefaults.standard.string(forKey: "CameraURL") ?? "URLvacia"))
    }
    
    
    @IBAction func enableCameraConfig(_ sender: UISwitch) {
        if(switchCamera.isOn) {
            switchSMS.isOn = false
            activateCameraSettings()
        }
        else {
            switchSMS.isOn = true
            activateSMSSettings()
        }
    }

    
    @IBAction func enableSMSConfig(_ sender: UISwitch) {
        if(switchSMS.isOn) {
            switchCamera.isOn = false
            activateSMSSettings()
        }
        else {
            switchCamera.isOn = true
            activateCameraSettings()

        }
    }
    
    func activateCameraSettings () {
        cellURL.isUserInteractionEnabled = true
        cellURL.backgroundColor = enabledColor
        cellPhone.isUserInteractionEnabled = false
        cellPhone.backgroundColor = disabledColor
        cellCommand.isUserInteractionEnabled = false
        cellCommand.backgroundColor = disabledColor
        cellSMSURL.isUserInteractionEnabled = false
        cellSMSURL.backgroundColor = disabledColor
        
    }
    
    func activateSMSSettings () {
        cellURL.isUserInteractionEnabled = false
        cellURL.backgroundColor = disabledColor
        cellPhone.isUserInteractionEnabled = true
        cellPhone.backgroundColor = enabledColor
        cellCommand.isUserInteractionEnabled = true
        cellCommand.backgroundColor = enabledColor
        cellSMSURL.isUserInteractionEnabled = true
        cellSMSURL.backgroundColor = enabledColor
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        
        
        if viewController.isKind(of:MainController.self) {
            
            navigationController.popToRootViewController(animated: animated)
            
            
        }
    }*/
    
    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
