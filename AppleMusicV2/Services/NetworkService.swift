//
//  ImageService.swift
//  AppleMusicV2
//
//  Created by CONG LE on 1/17/24.
//

import UIKit

enum NetworkError: Error {
    case badURL
    case noData
    case dataDecodingFailed(Error)
    case other(Error)
    
    // 1xx Informational
    case continueRequest // 100
    case switchingProtocols // 101
    case processing // 102
    
    // 2xx Success
    // Usually, you don't need to handle 2xx responses as errors
    case ok // 200
    case created // 201
    case accepted // 202
    case nonAuthoritativeInformation // 203
    case noContent // 204
    case resetContent // 205
    case partialContent // 206
    case multiStatus // 207
    case alreadyReported // 208
    case imUsed // 226
    
    // 3xx Redirection
    // Redirections are typically handled automatically by URLSession
    case multipleChoices // 300
    case movedPermanently // 301
    case found // 302
    case seeOther // 303
    case notModified // 304
    case useProxy // 305
    case temporaryRedirect // 307
    case permanentRedirect // 308
    
    // 4xx Client Error
    case badRequest // 400
    case unauthorized // 401
    case paymentRequired // 402
    case forbidden // 403
    case notFound // 404
    case methodNotAllowed // 405
    case notAcceptable // 406
    case proxyAuthenticationRequired // 407
    case requestTimeout // 408
    case conflict // 409
    case gone // 410
    case lengthRequired // 411
    case preconditionFailed // 412
    case payloadTooLarge // 413
    case uriTooLong // 414
    case unsupportedMediaType // 415
    case rangeNotSatisfiable // 416
    case expectationFailed // 417
    case iAmATeapot // 418
    case misdirectedRequest // 421
    case unprocessableEntity // 422
    case locked // 423
    case failedDependency // 424
    case tooEarly // 425
    case upgradeRequired // 426
    case preconditionRequired // 428
    case tooManyRequests // 429
    case requestHeaderFieldsTooLarge // 431
    case unavailableForLegalReasons // 451
    
    // 5xx Server Error
    case internalServerError // 500
    case notImplemented // 501
    case badGateway // 502
    case serviceUnavailable // 503
    case gatewayTimeout // 504
    case httpVersionNotSupported // 505
    case variantAlsoNegotiates // 506
    case insufficientStorage // 507
    case loopDetected // 508
    case notExtended // 510
    case networkAuthenticationRequired // 511
    case requestFailed(statusCode: Int)

    var localizedDescription: String {
        switch self {
        case .badURL:
            return "The URL provided was malformed or incorrect."
        case .noData:
            return "No data was returned by the server."
        case .dataDecodingFailed:
            return "Failed to decode the data returned by the server."
        case .other(let error):
            return "An unexpected error occurred: \(error.localizedDescription)"
            
        case .continueRequest:
            return "Continue with the request."
        case .switchingProtocols:
            return "Switching protocols as required."
        case .processing:
            return "Processing request."
            
        case .badRequest:
            return "Bad request. The server cannot or will not process the request due to an apparent client error."
        case .unauthorized:
            return "Unauthorized. Authentication is required and has failed or has not yet been provided."
        case .forbidden:
            return "Forbidden. The request was valid, but the server is refusing action."
        case .notFound:
            return "Not found. The requested resource could not be found but may be available in the future."
        case .methodNotAllowed:
            return "Method not allowed. A request method is not supported for the requested resource."
        case .notAcceptable:
            return "Not acceptable. The requested resource is capable of generating only content not acceptable according to the Accept headers sent in the request."
        case .proxyAuthenticationRequired:
            return "Proxy authentication required. The client must first authenticate itself with the proxy."
        case .requestTimeout:
            return "Request timeout. The server timed out waiting for the request."
        case .conflict:
            return "Conflict. The request could not be processed because of conflict in the request."
        case .gone:
            return "Gone. The resource requested is no longer available and will not be available again."
        case .lengthRequired:
            return "Length required. The request did not specify the length of its content, which is required by the requested resource."
        case .preconditionFailed:
            return "Precondition failed. The server does not meet one of the preconditions that the requester put on the request."
        case .payloadTooLarge:
            return "Payload too large. The request is larger than the server is willing or able to process."
        case .uriTooLong:
            return "URI too long. The URI provided was too long for the server to process."
        case .unsupportedMediaType:
            return "Unsupported media type. The request entity has a media type which the server or resource does not support."
        case .rangeNotSatisfiable:
            return "Range not satisfiable. The client has asked for a portion of the file, but the server cannot supply that portion."
        case .expectationFailed:
            return "Expectation failed. The server cannot meet the requirements of the Expect request-header field."
        case .iAmATeapot:
            return "I'm a teapot. The server refuses the attempt to brew coffee with a teapot."
        case .misdirectedRequest:
            return "Misdirected request. The request was directed at a server that is not able to produce a response."
        case .unprocessableEntity:
            return "Unprocessable entity. The request was well-formed but was unable to be followed due to semantic errors."
        case .locked:
            return "Locked. The resource that is being accessed is locked."
        case .failedDependency:
            return "Failed dependency. The request failed because it depended on another request and that request failed."
        case .tooEarly:
            return "Too early. The server is unwilling to risk processing a request that might be replayed."
        case .upgradeRequired:
            return "Upgrade required. The client should switch to a different protocol."
        case .preconditionRequired:
            return "Precondition required. The origin server requires the request to be conditional."
        case .tooManyRequests:
            return "Too many requests. The user has sent too many requests in a given amount of time."
        case .requestHeaderFieldsTooLarge:
            return "Request header fields too large. The server is unwilling to process the request because either an individual header field, or all the header fields collectively, are too large."
        case .unavailableForLegalReasons:
            return "Unavailable for legal reasons. The requested resource is not available due to legal reasons."
            
        case .internalServerError:
            return "Internal server error. A generic error message, given when an unexpected condition was encountered and no more specific message is suitable."
        case .notImplemented:
            return "Not implemented. The server either does not recognize the request method, or it lacks the ability to fulfill the request."
        case .badGateway:
            return "Bad gateway. The server was acting as a gateway or proxy and received an invalid response from the upstream server."
        case .serviceUnavailable:
            return "Service unavailable. The server is currently unavailable (because it is overloaded or down for maintenance)."
        case .gatewayTimeout:
            return "Gateway timeout. The server was acting as a gateway or proxy and did not receive a timely response from the upstream server."
        case .httpVersionNotSupported:
            return "HTTP version not supported. The server does not support the HTTP protocol version used in the request."
        case .variantAlsoNegotiates:
            return "Variant also negotiates. Transparent content negotiation for the request results in a circular reference."
        case .insufficientStorage:
            return "Insufficient storage. The server is unable to store the representation needed to complete the request."
        case .loopDetected:
            return "Loop detected. The server detected an infinite loop while processing the request."
        case .notExtended:
            return "Not extended. Further extensions to the request are required for the server to fulfill it."
        case .networkAuthenticationRequired:
            return "Network authentication required. The client needs to authenticate to gain network access."
        case .paymentRequired:
            return "paymentRequired"
        case .requestFailed(statusCode: let statusCode):
            return "requestFailed with error code: \(statusCode)"
            
            // 2xx codes
        case .ok:
            return "The request has succeeded."
        case .created:
            return "The request has been fulfilled and resulted in a new resource being created."
        case .accepted:
            return "The request has been accepted for processing, but the processing has not been completed."
        case .nonAuthoritativeInformation:
            return "non Authoritative Information"
        case .noContent:
            return "No Content"
        case .resetContent:
            return "Reset Content"
        case .partialContent:
            return "Partial Content"
        case .multiStatus:
            return "Multi Status"
        case .alreadyReported:
            return "Already Reported"
        case .imUsed:
            return "Im Used"
            
            // 3xx codes
        case .multipleChoices:
            return "Multiple Choices"
        case .movedPermanently:
            return "Moved Permanently"
        case .found:
            return "Found"
        case .seeOther:
            return "See Other"
        case .notModified:
            return "Not Modified"
        case .useProxy:
            return "Use Proxy"
        case .temporaryRedirect:
            return "Temporary Redirect"
        case .permanentRedirect:
            return "Permanent Redirect"
        }
    }
    
    
}


protocol ErrorLogging {
    func logError(_ error: NetworkError)
}

extension ErrorLogging {
    func logError(_ error: NetworkError) {
        // TODO: Implement a logging mechanism or use a third-party service
        print("Error: \(error.localizedDescription)")
        // TODO: Replace print statement with a proper logging mechanism
    }
}


class NetworkService: ErrorLogging {
    static let shared = NetworkService()
    
    func fetchData(from urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    self?.logError(error as! NetworkError)
                    completion(.failure(.other(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.requestFailed(statusCode: 0)))
                    return
                }
                //TODO: Hnadle all the error codes here
                switch httpResponse.statusCode {
                case 200...299:
                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }
                    completion(.success(data))
                case 401:
                    completion(.failure(.unauthorized))
                case 403:
                    completion(.failure(.forbidden))
                case 404:
                    completion(.failure(.notFound))
                case 405:
                    completion(.failure(.methodNotAllowed))
                case 409:
                    completion(.failure(.conflict))
                case 500:
                    completion(.failure(.internalServerError))
                case 503:
                    completion(.failure(.serviceUnavailable))
                default:
                    completion(.failure(.requestFailed(statusCode: httpResponse.statusCode)))
                }
            }
        }.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, NetworkError>)  -> Void) {
        self.fetchData(from: urlString) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(.dataDecodingFailed(URLError(.cannotDecodeContentData))))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchDecodable<T: Decodable>(from urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        self.fetchData(from: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(.dataDecodingFailed(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
