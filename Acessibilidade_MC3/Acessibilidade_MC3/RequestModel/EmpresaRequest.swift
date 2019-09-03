//
//  EmpresaRequest.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

//LETTER = AVALIACOES
//USUARIO = USUARIO

import Foundation

class EmpresaRequest {
    func empresaCreate(uuid: String, empresa:EmpresaCodable, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup()
        group.enter()
        let empresaParams = ["nome": empresa.nome,
                             "site": empresa.site,
                             "telefone": empresa.telefone,
                             "media": empresa.media,
                             "mediaRecomendacao": empresa.mediaRecomendacao,
                             "cidade": empresa.cidade,
                             "estado": empresa.estado] as [String : Any]
//        let parameters = ["uuid": uuid, "Empresas": empresaParams] as [String : Any]
        guard let url = URL(string: RequestConstants.POSTEMPRESA) else {
            return
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: empresaParams, options: .prettyPrinted)
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
                    print(data)
                    if let file = data {
                        let json = try JSONSerialization.jsonObject(with: file, options: [])
                        if let safeJson = json as? [String:Any]{
                            print(safeJson)
                            for (key, value) in safeJson {
                                if (key == "result"){
                                    if(value as? Int == 0){
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
    
    func updateEmpresa(uuid: String, empresa: EmpresaCodable, completion: @escaping ([String: Any]?, Error?) -> Void){
        let group = DispatchGroup()
        group.enter()
        let empresaParams = ["nome": empresa.nome,
                             "site": empresa.site,
                             "telefone": empresa.telefone,
                             "media": empresa.media,
                             "mediaRecomendacao": empresa.mediaRecomendacao,
                             "cidade": empresa.cidade,
                             "estado": empresa.estado] as [String : Any]
        //        let parameters = ["uuid": uuid, "Empresas": empresaParams] as [String : Any]
        guard let url = URL(string: RequestConstants.POSTEMPRESA) else {
            return
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: empresaParams, options: .prettyPrinted)
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
                    print(data)
                    if let file = data {
                        let json = try JSONSerialization.jsonObject(with: file, options: [])
                        if let safeJson = json as? [String:Any]{
                            print(safeJson)
                            for (key, value) in safeJson {
                                if (key == "result"){
                                    if(value as? Int == 0){
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
