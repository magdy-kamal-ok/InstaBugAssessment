//
//  BaseMovieRequest.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

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
                if let error = error,  let response = response as? HTTPURLResponse
                {
                    if !(self?.isForcingCancel)!
                    {
                        self?.setErrorResponse(message: error.localizedDescription, errorCode: response.statusCode)
                       
                    }
                    
                } else if let data = data
                {
                       if let response = response as? HTTPURLResponse
                       {
                            let resultStatus = self?.getStatus(response)
                            switch resultStatus!
                            {
                                case .success:
                                    self?.serializeSuccessResponse(from: data)
                                case .failure:
                                    self?.serializeFailureResponse(from: data)
                            }
                    }
                    
                }
                else
                {
                    self?.cancelRequest()
                }
            }
            dataTask?.resume()
        }
    }


    func  getStatus(_ response: HTTPURLResponse) -> ResponseStatus{
        switch response.statusCode {
        case 200...299: return .success
        default: return .failure
        }
    }
    
  
    func serializeSuccessResponse(from data:Data)
    {
        do{
            
            let response = try JSONDecoder().decode(R.self, from: data)
            self.onRequestSuccess(data: response)
        }
        catch let parseError
        {
            self.setErrorDecodingData(message: parseError.localizedDescription)
        }
    }
    
    func serializeFailureResponse(from data:Data)
    {
        do {
 
            let response = try JSONDecoder().decode(E.self, from: data)
            self.onRequestFail(error: response)
        }
        catch let parseError
        {
            self.setErrorDecodingData(message: parseError.localizedDescription)
        }
    }
    
    func setErrorDecodingData(message:String, encodingStatus:EncoingStatus = EncoingStatus.failure)
    {
        let jsonData = """
            {
            \(ErrorModel.ErrorCodingKeys.statusCode.rawValue):\(encodingStatus),
            \(ErrorModel.ErrorCodingKeys.statusMessage.rawValue):\(message)
            }
            """.data(using: .utf8)!
        serializeFailureResponse(from: jsonData)
        
    }
    
    func setErrorResponse(message:String, errorCode:Int)
    {
        let jsonData = """
            {
            \(ErrorModel.ErrorCodingKeys.statusCode.rawValue):\(errorCode),
            \(ErrorModel.ErrorCodingKeys.statusMessage.rawValue):\(message)
            }
            """.data(using: .utf8)!
        serializeFailureResponse(from: jsonData)
        
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
