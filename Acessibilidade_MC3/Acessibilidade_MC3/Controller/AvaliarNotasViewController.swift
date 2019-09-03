//
//  AvaliarNotas.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliarNotasViewController: UITableViewController {
    
    var avaliacao: Avaliacao?
    var empresa: Empresa?
    
    @IBOutlet var integracaoBotoes: [UIButton]!
    var notaIntegracao: Float = 0
    
    @IBOutlet var culturaBotoes: [UIButton]!
    var notaCultura: Float = 0
    
    @IBOutlet var remuneracaoBotoes: [UIButton]!
    var notaRemuneracao: Float = 0
    
    @IBOutlet var oportunidadeBotoes: [UIButton]!
    var notaOportunidade: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ajustarUI()
       
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        headerView.backgroundColor = .brancoAzulado
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func ajustarUI() {
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.tintColor = .rioCristalino
    }
    
    @IBAction func tocaIntegracao(_ sender: UIButton) {
        notaIntegracao = apertaBotao(conjuntoDeBotoes: integracaoBotoes, sender: sender)
    }
    
    @IBAction func tocaCultura(_ sender: UIButton) {
        notaCultura = apertaBotao(conjuntoDeBotoes: culturaBotoes, sender: sender)
    }
    
    @IBAction func tocaRemuneracao(_ sender: UIButton) {
        notaRemuneracao = apertaBotao(conjuntoDeBotoes: remuneracaoBotoes, sender: sender)
    }
    
    @IBAction func tocaOportunidade(_ sender: UIButton) {
        notaOportunidade = apertaBotao(conjuntoDeBotoes: oportunidadeBotoes, sender: sender)
    }
    
    func apertaBotao(conjuntoDeBotoes: [UIButton], sender: UIButton) -> Float {
        for button in conjuntoDeBotoes {
            if button.tag <= sender.tag {
                button.setImage(UIImage(named: "GoldenStar"), for: .normal)
            } else {
                button.setImage(UIImage(named: "Star"), for: .normal)
            }
        }
        return Float(sender.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        avaliacao?.nota = media(valores: [notaIntegracao, notaCultura, notaRemuneracao, notaOportunidade])
        
        if let avaliarEmpresa = segue.destination as? AvaliarDeficienciasViewController {
            avaliarEmpresa.avaliacao = self.avaliacao
            avaliarEmpresa.empresa = self.empresa
        }
    }
    
    private func media(valores: [Float]) -> Float {
        var media: Float = 0
        
        for elemento in valores {
            media += elemento
        }
        media /= Float(valores.count)
        
        return media
    }
}
