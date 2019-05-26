// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

import Foundation

protocol JSONDeserializable {
    static func fromJSON(_ dictionary: [String: Any]) -> Self?
    static func fromJSON(_ data: Data) -> Self?
    static func fromJSONString(_ string: String) -> Self?
}

extension JSONDeserializable where Self: Codable {
    static func fromJSON(_ dictionary: [String: Any]) -> Self? {
        guard
            let data = try? JSONSerialization.data(withJSONObject: dictionary),
            let instance = fromJSON(data)
        else { return nil }

        return instance
    }

    static func fromJSON(_ data: Data) -> Self? {
        return try? JSONDecoder().decode(self, from: data)
    }

    static func fromJSONString(_ string: String) -> Self? {
        guard let data = string.data(using: .utf8) else { return nil }

        return try? JSONDecoder().decode(self, from: data)
    }
}
