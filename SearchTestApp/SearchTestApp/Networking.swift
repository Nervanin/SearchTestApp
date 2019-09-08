//
//  Networking.swift
//  SearchTestApp
//
//  Created by Konstantin on 08/09/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkServiceProtocol {
    func sendRequest(parametr: String)
}

class NetworkService: NetworkServiceProtocol {
    
    func sendRequest(parametr: String) {
        let parametrs = ["IDCategory": "null", "IDClient": "null", "pageNumberIncome": "1", "pageSizeIncome": "12", "SearchString": "\(parametr)"]
        let headers: HTTPHeaders = ["AccessKey": "test_05fc5ed1-0199-4259-92a0-2cd58214b29c"]
        AF.request("http://iswiftdata.1c-work.net/api/products/searchproductsbycategory", method: .get, parameters: parametrs, headers: headers, interceptor: nil).response { response in
            guard let data = response.data else {
                return
            }
            print(data)
            do {
                let json = try JSON(data: data)
                print(json)
                for item in json["listProducts"] {
                    print(item)
                }
            } catch {
                print(error)
            }
            
        }
    }
}
