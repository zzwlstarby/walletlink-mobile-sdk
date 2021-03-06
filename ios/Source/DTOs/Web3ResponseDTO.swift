// Copyright (c) 2018-2019 Coinbase, Inc. <https://coinbase.com/>
// Licensed under the Apache License, version 2.0

import CBCore

struct Web3ResponseDTO<T: Codable>: Codable, JSONSerializable {
    let type: String = "WEB3_RESPONSE"
    let id: String
    let response: Web3Response<T>

    init(id: String, method: RequestMethod, result: T) {
        self.id = id
        response = Web3Response<T>(method: method, result: result, errorMessage: nil)
    }

    init(id: String, method: RequestMethod, errorMessage: String) {
        self.id = id
        response = Web3Response<T>(method: method, result: nil, errorMessage: errorMessage)
    }
}

struct Web3Response<T: Codable>: Codable {
    let method: RequestMethod
    let result: T?
    let errorMessage: String?
}
