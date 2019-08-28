//
//  EmpresasController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 27/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class EmpresasController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // dados provisorios para teste
    var empresas = [Empresa(nome: "Mackenzie",
                            localizacao: "São Paulo, SP",
                            nota: 4.5,
                            recomendacao: 45,
                            acessibilidade: []),
                    Empresa(nome: "Itau",
                             localizacao: "São Paulo, SP",
                             nota: 3.6,
                             recomendacao: 77,
                             acessibilidade: [.deficienciaAuditiva, .nanismo])]
    
    var resultadosBusca = [Empresa]()
    var buscando = false
    
    var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buscando {
            return resultadosBusca.count
        } else {
            return empresas.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "empresaCell", for: indexPath) as? EmpresaTableViewCell else {
            return UITableViewCell()
        }
        
        var dados: [Empresa]
        
        if buscando {
            dados = resultadosBusca
        } else {
            dados = empresas
        }
       
        cell.nomeEmpresaLabel.text = dados[indexPath.row].nome
        cell.localizacaoEmpresaLabel.text = dados[indexPath.row].localizacao
        cell.notaLabel.text = String(dados[indexPath.row].nota)
        cell.recomendacaoLabel.text = String("\(dados[indexPath.row].recomendacao)%")
        
        var contador: Int = 0
        
        guard let imagens = cell.acessibilidades else {
            return UITableViewCell()
        }
        
        for acessivel in dados[indexPath.row].acessibilidade {
            imagens[contador].image = UIImage(named: acessivel.rawValue)
            contador += 1
        }
        for cont in contador..<5 {
            imagens[cont].image = nil
        }
        
        return cell
        
    }
    
}

extension EmpresasController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultadosBusca = empresas.filter({$0.nome.prefix(searchText.count) == searchText})
        buscando = true
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.tintColor = #colorLiteral(red: 0.1980924308, green: 0.5395323634, blue: 0.780749023, alpha: 1)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        buscando = false
        tableView.reloadData()
    }
}
