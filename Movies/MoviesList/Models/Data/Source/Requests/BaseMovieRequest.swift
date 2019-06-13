//
//  BaseMovieRequest.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: Any]
public enum HTTPMethod : String {
    case get = "GET"
}
public class BaseMovieRequest<R: Decodable, E: Decodable>: NSObject {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var isForcingCancel = false

    public override init() {
        super.init()
    }
    

    public func getMoviesRequsetData( from url: String) {
    
        if var urlComponents = URLComponents(string: url) {
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                defer { self?.dataTask = nil }
                if let error = error {
                    if !(self?.isForcingCancel)!
                    {
                        
                    }
                    
                } else if let data = data
                {
                       if let response = response as? HTTPURLResponse
                       {
                        
                        if response.statusCode == 200 {
                        do{
                            let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)

                            let response = try JSONDecoder().decode(R.self, from: data)
                            self?.onRequestSuccess(data: response)
                        }
                        catch let parseError
                        {
                             print("JSON Error \(parseError.localizedDescription)")
                        }
                    }
                        else
                        {
                            
                            do {
                                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                    
                                    let response = try JSONDecoder().decode(E.self, from: data)
                                    self?.onRequestFail(error: response)
                                }
                            catch let parseError
                            {
                                print("JSON Error \(parseError.localizedDescription)")
                            }
                        }
                    }
                    
                }
            }
            dataTask?.resume()
        }
    }

    func getMethodType() -> HTTPMethod {
        return .get
    }
    
    func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    func onRequestSuccess(data: R?) {
        preconditionFailure("Override onRequestSuccess func -> BaseLoginRequest")
    }
    
    func onRequestFail(error: E?) {
        preconditionFailure("Override onRequestFail func -> BaseLoginRequest")
    }
    
    func cancelRequest() {
        dataTask?.cancel()
        isForcingCancel = true
    }
}
