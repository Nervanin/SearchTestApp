//
//  Networking.swift
//  SearchTestApp
//
//  Created by Konstantin on 08/09/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func sendRequest()
}

class NetworkService: NetworkServiceProtocol {
    
    var parametrs = ["IDCategory": "null", "IDClient": "null", "pageNumberIncome": "1", "pageSizeIncome": "12", "SearchString": "Чайник"]
    var headers: HTTPHeaders = ["AccessKey": "test_05fc5ed1-0199-4259-92a0-2cd58214b29c"]
    let encoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(arrayEncoding: .noBrackets))
    func sendRequest() {
        AF.request("http://iswiftdata.1c-work.net/api/products/searchproductsbycategory", method: .get, parameters: parametrs, headers: headers, interceptor: nil).response { response in
            print(response)
        }
    }
}
