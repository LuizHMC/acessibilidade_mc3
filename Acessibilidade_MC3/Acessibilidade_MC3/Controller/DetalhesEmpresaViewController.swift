//
//  DetalhesEmpresaViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 29/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

/**
 Classe que controla a tela que exibe os detalhes de uma empresa.
 
 A classe herda de UIViewController.
 */
class DetalhesEmpresaViewController: UIViewController {

    /**
     Conector da Table View que exibe os dados da empresa.
     */
    @IBOutlet weak var detalhesTableView: UITableView!
    
    /**
     Delegate e Data Source da empresa.
     
     Representado por DetalhesEmpresaController opcional.
     */
    var detalhesDataSourceDelegate: DetalhesEmpresaController?
    
    /**
     Empresa cujos detalhes são exibidos na tela.
     
     Recebe uma empresa de EmpresasViewController quando esta tela é chamada.
     */
    var empresa: Empresa?
    
    /**
     Corresponde a uma nova avaliação adicionada pelo usuário.
     */
    var avaliacao: Avaliacao?
    
    /**
     Usuário que está utilizando o aplicativo no momento.
     
     É representado por uma string opcional.
     */
    var usuario: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detalhesDataSourceDelegate = DetalhesEmpresaController()
        detalhesTableView.delegate = detalhesDataSourceDelegate
        detalhesTableView.dataSource = detalhesDataSourceDelegate
        
        detalhesDataSourceDelegate?.empresa = self.empresa
        
        let headerNib = UINib.init(nibName: "AvaliacaoHeaderView", bundle: Bundle.main)
        detalhesTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "AvaliacaoHeaderView")
        
        navigationItem.title = empresa?.nome
        
        usuario = UserDefaults.standard.string(forKey: "UserId")
        
    }

    /**
    Ação executada ao salvar uma nova avaliação no sistema.
    
    A função é conectada com um botão na tela de adicionar uma avaliação a fim de permitir o Exit daquela tela para esta.
    
    - parameters:
       - sender: A transição executada ao sair da tela.
    */
    @IBAction func adicionaAvaliacao(_ sender: UIStoryboardSegue) {
        if sender.source is AvaliarProsViewController {
            if let senderAdd = sender.source as? AvaliarProsViewController {
                if let avaliacao = senderAdd.avaliacao {
                    self.avaliacao = avaliacao
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let avaliacao = avaliacao {
            registraAvaliacao(avaliacao: avaliacao)
            empresa?.adicionaAvaliacao(avaliacao: avaliacao, usuario: usuario ?? "")
            self.avaliacao = nil
        }
        detalhesTableView.reloadData()
    }
    
    /**
     Funcão que faz o registro no servidor de uma avaliação enviada por um usuário.
     
     - parameters:
        - avaliacao: A nova avaliação enviada pelo usuário.
     */
    func registraAvaliacao(avaliacao: Avaliacao) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let data = dateFormatter.string(from: avaliacao.data)
        
        let avaliacaoCodable = AvaliacaoCodable(_id: nil,
                                                titulo: avaliacao.titulo,
                                                data: data,
                                                cargo: avaliacao.posicao,
                                                tempoServico: converteTempoServico(tempoServico: avaliacao.tempoServico),
                                                pros: avaliacao.vantagens,
                                                contras: avaliacao.desvantagens,
                                                melhorias: avaliacao.sugestoes ?? "",
                                                ultimoAno: Double(avaliacao.ultimoAno),
                                                recomenda: avaliacao.recomendacao,
                                                integracaoEquipe: Double(avaliacao.integracao),
                                                culturaValores: Double(avaliacao.cultura),
                                                renumeracaoBeneficios: Double(avaliacao.remuneracao),
                                                oportunidadeCrescimento: Double(avaliacao.oportunidade),
                                                deficienciaMotora: avaliacao.acessibilidade.contains(.deficienciaMotora),
                                                deficienciaVisual: avaliacao.acessibilidade.contains(.deficienciaVisual),
                                                deficienciaAuditiva: avaliacao.acessibilidade.contains(.deficienciaAuditiva),
                                                deficienciaIntelectual: avaliacao.acessibilidade.contains(.deficienciaIntelectual),
                                                nanismo: avaliacao.acessibilidade.contains(.nanismo),
                                                estadoPendenteAvaliacao: Estado.pendente.rawValue)
        
        if let usuario = usuario {
            AvaliacaoRequest().sendAvaliacao(idEmpresa: empresa?.id, uuid: usuario,
                                             avaliacao: avaliacaoCodable) { (response, error) in
                                                if response != nil {
                                                    print("sucesso")
                                                } else {
                                                    print("erro")
                                                }
            }
            
        }
    }
    
    /**
     Função que converte uma descrição de tempo de serviço, de acordo com o enumerador `TempoServico`, em um double, a fim de que seja enviado ao servidor.
     
     - parameters:
        - tempoServico: A string de descrição do tempo de serviço, conforme casos do enumerador `TempoServico`.
     
     - returns: Um double, utilizado para correspondência com o servidor para descrição do tempo de serviço, conforme valores brutos dos casos do enumerador `TempoServico`.
     */
    func converteTempoServico(tempoServico: String) -> Double {
        switch tempoServico {
        case TempoServico.menos3.descricao:
            return TempoServico.menos3.rawValue
            
        case TempoServico.menos1.descricao:
            return TempoServico.menos1.rawValue
            
        case TempoServico.menos5.descricao:
            return TempoServico.menos5.rawValue
            
        case TempoServico.menos10.descricao:
            return TempoServico.menos10.rawValue
            
        case TempoServico.mais10.descricao:
            return TempoServico.mais10.rawValue
    
        default:
            return 0
        }
    }

}
