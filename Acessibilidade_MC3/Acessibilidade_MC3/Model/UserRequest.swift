//
//  UserRequest.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

/**
 Classe que controla a requisição dos perfis dos usuários ao servidor.
 */
class UsuarioRequest {
    
    /**
    Função que cria um usuário no servidor.
    - parameters:
        - uuid: Identificador do usuário que está sendo criado.
        - completion: Closure que é chamada com um vetor opcional de strings como Any e um Error opcional.
    */
    func usuarioCreate(uuid: String, usuario: UsuarioCodable, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup()
        group.enter()
        let parameters = ["uuid": uuid,
                          "administrador": usuario.administrador as Any] as [String: Any]
        guard let url = URL(string: RequestConstants.POSTUSUARIO) else {
            return
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Acadresst")
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            group.leave()
            group.notify(queue: .main, execute: {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                guard data != nil else {
                    completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                    return
                }
                do {
                    print(data as Any)
                    if let file = data {
                        let json = try JSONSerialization.jsonObject(with: file, options: [])
                        if let safeJson = json as? [String: Any] {
                            print(safeJson)
                            for (key, value) in safeJson {
                                if key == "result" {
                                    if value as? Int == 0 {
                                        completion(nil, nil)
                                    } else {
                                        completion(safeJson, nil)
                                    }
                                } else {
                                    completion(nil, nil)
                                }
                            }
                        } else {
                            print("no file")
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            })
        })
        task.resume()
    }
    
}
