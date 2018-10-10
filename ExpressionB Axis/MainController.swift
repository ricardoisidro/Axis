//
//  MainController.swift
//  ExpressionB Axis
//
//  Created by ExpresionBinaria on 10/3/18.
//  Copyright © 2018 ExpresionBinaria. All rights reserved.
//

import UIKit
import WebKit

class MainController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var cameraWebView: WKWebView!
    @IBOutlet weak var btnOpenDoor: UIButton!
    @IBOutlet weak var txtCamera: UITextField!
    
    var dataTask: URLSessionDataTask?
    var initialImage: UIImage = UIImage(named: "fondo_default")!
    let mySession = URLSession.shared
    
    let camerasArray = ["CÁMARA 1"]
    
    var selectedCamera: String?
    var bgImage: UIImageView?
    
    let preferredURL = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let savedURL = preferredURL.string(forKey: "CameraURL")
        print("Inicia view con url: " + (savedURL ?? ""))
        if(preferredURL.object(forKey: "CameraURL") == nil) {
            
            bgImage = UIImageView(image: initialImage)
            bgImage?.image = initialImage
            bgImage?.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(bgImage!)
            
            let margins = view.layoutMarginsGuide
            NSLayoutConstraint.activate(
                [(bgImage?.leadingAnchor.constraint(equalTo: margins.leadingAnchor))!,
                 (bgImage?.trailingAnchor.constraint(equalTo: margins.trailingAnchor))!,
                 (bgImage?.bottomAnchor.constraint(equalTo: btnOpenDoor.bottomAnchor))!,
                 (bgImage?.topAnchor.constraint(equalTo: txtCamera.topAnchor))!])
            
            bgImage?.isHidden = false
            cameraWebView.isHidden = true
            /*if #available(iOS 11, *) {
             let guide = view.safeAreaLayoutGuide
             NSLayoutConstraint.activate([
             bgImage!.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
             bgImage!.bottomAnchor.constraint(equalToSystemSpacingBelow: bgImage!.bottomAnchor, multiplier: 1.0)
             ])
             
             } else {
             let standardSpacing: CGFloat = 8.0
             NSLayoutConstraint.activate([
             bgImage!.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
             bottomLayoutGuide.topAnchor.constraint(equalTo: bgImage!.bottomAnchor, constant: standardSpacing)
             ])
             }*/
            
        }
        else {
            //preferredURL.set("http://casadelpatoferoz.axiscam.net:1080/view/viewer_index.shtml", forKey: "CameraURL")
            
            bgImage?.isHidden = true
            cameraWebView.isHidden = false
            
            createCameraPicker()
            createToolbar()
            
            btnOpenDoor.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            
            view.addSubview(cameraWebView)
            
            if let url = URL(string: savedURL!) {
                let req = URLRequest(url: url)
                cameraWebView.load(req)
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openDoor(_ sender: UIButton) {
        sendMessage(message: "activate")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {self.sendMessage(message: "deactivate")})
    }
    
    func createCameraPicker() {
        let cameraPicker = UIPickerView()
        cameraPicker.delegate = self
        
        txtCamera.inputView = cameraPicker
    }
    
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(MainController.dismissKeyboard))
        toolbar.setItems([okButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        txtCamera.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func sendMessage(message: String){
        
        dataTask?.cancel()
        guard let url = createURLWithComponents(message: message) else {
            print("Invalid URL")
            return
        }
        print(url)
        
        dataTask = mySession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        dataTask?.resume()
    }
    
    func createURLWithComponents(message: String) -> URL? {
        let components = NSURLComponents()
        components.scheme = "http"
        components.host = "casadelpatoferoz.axiscam.net"
        components.port = 1080
        components.user = "julio"
        components.password = "palacios"
        components.path = "/axis-cgi/virtualinput/" + message + ".cgi"
        let queryItemQuery = URLQueryItem(name: "schemaversion", value: "1")
        let queryItemPort = URLQueryItem(name: "port", value: "1")
        components.queryItems = [queryItemQuery, queryItemPort]
        return components.url
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return camerasArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCamera = camerasArray[row]
        txtCamera.text = selectedCamera
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = camerasArray[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return myTitle
    }

}
