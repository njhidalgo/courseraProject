//
//  ViewController.swift
//  Coursera Project
//
//  Created by Nahim Jesus Hidalgo Sabido on 4/6/16.
//  Copyright © 2016 Nahim Jesus Hidalgo Sabido. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var searchResult: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        
        searchField.clearButtonMode = .Always
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.text == ""{
            
            let alertaCampoVacio = UIAlertController(title: "Error", message: "No puedes dejar el campo vacío", preferredStyle: UIAlertControllerStyle.Alert)
            alertaCampoVacio.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertaCampoVacio, animated: true, completion: nil)
            
        }else{
            
           buscarLibro(searchField.text!)
           searchField.resignFirstResponder()
            
        }
        
        return false
    }
    
    func buscarLibro(isbn:String){
        
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbn)"
        let url = NSURL(string: urls)
        let datos: NSData? = NSData(contentsOfURL: url!)
        
        if datos == nil{
            
            let alertaProblemaInternet = UIAlertController(title: "Error", message: "Existe una falla en internet. Verifique su conexion y vuelva a intentar", preferredStyle: UIAlertControllerStyle.Alert)
            alertaProblemaInternet.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertaProblemaInternet, animated: true, completion: nil)
            
        }else{
            
            let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
            if texto == "{}"{
                
                let alertaIsbnInexistente = UIAlertController(title: "Error", message: "El ISBN ingresado no se encuentro en el sistema.", preferredStyle: UIAlertControllerStyle.Alert)
                alertaIsbnInexistente.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertaIsbnInexistente, animated: true, completion: nil)
                
            }else{
               searchResult.text = texto as! String
            }
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}

