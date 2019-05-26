// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

import Foundation

/// Type of incoming server message
enum ServerMessageType: String, Codable {
    /// New server initiated event
    case event = "Event"

    /// A successful response to a client initiated request
    case ok = "OK"

    /// A successful response to a client `PublishEvent`
    case publishEventOK = "PublishEventOK"

    /// An error response to a client initiated request
    case fail = "Fail"

    var isOK: Bool {
        switch self {
        case .ok, .publishEventOK:
            return true
        case .fail, .event:
            return false
        }
    }
}
