//
//  TimelineRouter.swift
//  TrainingIOS
//
//  Created by DaoNhat on 9/7/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import Alamofire

enum TimelineRouter: URLRequestConvertible {
    case getTimeline()
    
    var method: HTTPMethod {
        switch self {
        case .getTimeline:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getTimeline :
            return "/timeline"
        }
    }
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Config.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("JWT eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9", forHTTPHeaderField: "authorization")
        switch self {
        case .getTimeline():
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        }
        
        return urlRequest
    }
}
