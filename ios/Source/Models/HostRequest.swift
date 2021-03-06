// Copyright (c) 2018-2019 Coinbase, Inc. <https://coinbase.com/>
// Licensed under the Apache License, version 2.0

import BigInt

public enum HostRequest {
    /// A message signature request
    case signMessage(
        requestId: HostRequestId,
        address: String,
        message: String,
        isPrefixed: Bool,
        typedDataJson: String?
    )

    /// A transaction signature request
    case signAndSubmitTx(
        requestId: HostRequestId,
        fromAddress: String,
        toAddress: String?,
        weiValue: BigInt,
        data: Data,
        nonce: Int?,
        gasPrice: BigInt?,
        gasLimit: BigInt?,
        chainId: Int,
        shouldSubmit: Bool
    )

    /// A signed transaction submission request
    case submitSignedTx(requestId: HostRequestId, signedTx: Data, chainId: Int)

    /// EIP 1102. Permission to allow message/transaction signature requests
    case dappPermission(requestId: HostRequestId)

    /// Request was canceled on host side
    case requestCanceled(requestId: HostRequestId)

    /// The name of the dapp making the request
    public var dappName: String? {
        switch self {
        case let .signMessage(hostRequestId, _, _, _, _),
             let .signAndSubmitTx(hostRequestId, _, _, _, _, _, _, _, _, _),
             let .dappPermission(hostRequestId),
             let .submitSignedTx(hostRequestId, _, _),
             let .requestCanceled(hostRequestId):
            return hostRequestId.dappName
        }
    }

    /// The url of the dapp making the request
    public var dappUrl: URL {
        switch self {
        case let .signMessage(hostRequestId, _, _, _, _),
             let .signAndSubmitTx(hostRequestId, _, _, _, _, _, _, _, _, _),
             let .dappPermission(hostRequestId),
             let .submitSignedTx(hostRequestId, _, _),
             let .requestCanceled(hostRequestId):
            return hostRequestId.dappURL
        }
    }

    /// WalletLink event ID
    var eventId: String {
        switch self {
        case let .signMessage(hostRequestId, _, _, _, _),
             let .signAndSubmitTx(hostRequestId, _, _, _, _, _, _, _, _, _),
             let .dappPermission(hostRequestId),
             let .submitSignedTx(hostRequestId, _, _),
             let .requestCanceled(hostRequestId):
            return hostRequestId.eventId
        }
    }

    /// WalletLink request ID
    var requestId: String {
        switch self {
        case let .signMessage(hostRequestId, _, _, _, _),
             let .signAndSubmitTx(hostRequestId, _, _, _, _, _, _, _, _, _),
             let .dappPermission(hostRequestId),
             let .submitSignedTx(hostRequestId, _, _),
             let .requestCanceled(hostRequestId):
            return hostRequestId.id
        }
    }

    /// WalletLink session ID
    var sessionId: String {
        switch self {
        case let .signMessage(hostRequestId, _, _, _, _),
             let .signAndSubmitTx(hostRequestId, _, _, _, _, _, _, _, _, _),
             let .dappPermission(hostRequestId),
             let .submitSignedTx(hostRequestId, _, _),
             let .requestCanceled(hostRequestId):
            return hostRequestId.sessionId
        }
    }

    /// WalletLink Host request ID
    public var hostRequestId: HostRequestId {
        switch self {
        case let .signMessage(hostRequestId, _, _, _, _),
             let .signAndSubmitTx(hostRequestId, _, _, _, _, _, _, _, _, _),
             let .dappPermission(hostRequestId),
             let .submitSignedTx(hostRequestId, _, _),
             let .requestCanceled(hostRequestId):
            return hostRequestId
        }
    }
}
