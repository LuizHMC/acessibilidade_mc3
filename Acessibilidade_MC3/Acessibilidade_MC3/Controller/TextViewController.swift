//
//  TextViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 03/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class TextViewController: NSObject, UITextViewDelegate {
    
    var placeholder: String
    var indice: Int
    var textoValido: Bool = false

    weak var tableViewController: UITableViewController?
    
    init(placeholder: String, tVC: UITableViewController, indice: Int) {
        self.placeholder = placeholder
        self.tableViewController = tVC
        self.indice = indice
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
            textView.textColor = .escuroAzulado
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
 
    func textViewDidChange(_ textView: UITextView) {
        if let texto = textView.text {
            if texto != "" {
                textoValido = true
                
            } else {
                textoValido = false
            }
            
            if let tVC = tableViewController as? AvaliarProsViewController {
                tVC.textosValidos[indice] = textoValido
                tVC.validaTexto()
            }
            
        }
    }
    
}
