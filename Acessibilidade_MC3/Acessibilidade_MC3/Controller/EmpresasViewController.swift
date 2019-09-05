//
//  EmpresasViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 27/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit
import Foundation

class EmpresasViewController: UIViewController {

    @IBOutlet weak var empresaTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var empresasDataSourceDelegate: EmpresasController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empresasDataSourceDelegate = EmpresasController(tableView: empresaTableView)
        empresaTableView.delegate = empresasDataSourceDelegate
        empresaTableView.dataSource = empresasDataSourceDelegate
        empresaTableView.rowHeight = 217
        
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Busca"
        self.searchController.searchBar.delegate = empresasDataSourceDelegate
        self.searchController.searchBar.isTranslucent = false
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        empresaTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let empresaInfo = segue.destination as? DetalhesEmpresaViewController {
            if let selecionada = empresaTableView.indexPathForSelectedRow {
                empresaInfo.empresa = empresasDataSourceDelegate?.empresas[selecionada.row]
            }
        }
    }
    
    @IBAction func adicionaEmpresa(_ sender: UIStoryboardSegue) {
        if sender.source is NovaEmpresaTableViewController {
            if let senderAdd = sender.source as? NovaEmpresaTableViewController {
                if let empresa = senderAdd.empresa {
                    self.empresasDataSourceDelegate?.empresas.append(empresa)
                    
                }
            }
        }
    }
    
}
