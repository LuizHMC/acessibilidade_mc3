//
//  PickerController.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 30/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

let estadosCompletoBrasil:[String] = ["Acre",
    "Alagoas",
    "Amapá",
   "Amazonas",
   "Bahia",
   "Ceará",
   "Distrito Federal",
   "Espírito Santo",
   "Goiás",
   "Maranhão",
   "Mato Grosso",
   "Mato Grosso do Sul",
   "Minas Gerais",
   "Pará",
   "Paraíba",
   "Paraná",
   "Pernambuco",
   "Piauí",
   "Rio de Janeiro",
   "Rio Grande do Norte",
   "Rio Grande do Sul",
   "Rondônia",
   "Roraima",
   "Santa Catarina",
   "São Paulo",
   "Sergipe"]

class PickerController: NSObject, UIPickerViewDelegate, UIPickerViewDataSource, UIPickerViewAccessibilityDelegate {
    
    var componentes: [String]
    var tag: Int
    var selecionado: String
    
    init(componentes: [String], tag: Int) {
        self.componentes = componentes
        self.selecionado = ""
        self.tag = tag
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return componentes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return componentes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selecionado = componentes[row]
    }

    func pickerView(_ pickerView: UIPickerView, accessibilityLabelForComponent component: Int) -> String? {
        switch tag {
        case 1:
            return estadosCompletoBrasil[component]
//        case 2:
//            return ""
//        case 3:
//            return ""
        default:
            return componentes[component]
        }
        
    }
    
}
