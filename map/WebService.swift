//
//  WebService.swift
//  map
//
//  Created by shailesh on 07/09/18.
//  Copyright © 2018 Shailesh. All rights reserved.
//

import UIKit
import Alamofire

class WebService: NSObject {
    
 
    let BASE_URL = ""
        func callPostService(url:String,parameters:NSDictionary){
            
            
            print("url is===>\(url)")
            
            let request = NSMutableURLRequest(url: NSURL(string:url)! as URL)
 
            
            let session = URLSession.shared
            request.httpMethod = "POST"
            
            //Note : Add the corresponding "Content-Type" and "Accept" header. In this example I had used the application/json.
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                guard data != nil else {
                    print("no data found: \(error)")
                    return
                }
                let responeString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("***********MY RESPONCE************\(responeString)")
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        print("Response: \(json)")
                     } else {
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)// No error thrown, but not NSDictionary
                        print("Error could not parse JSON: \(jsonStr)")
                     }
                } catch let parseError {
                    print(parseError)// Log the error thrown by `JSONObjectWithData`
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: '\(jsonStr)'")
                 }
            }
            
            task.resume()
        }
}


let BASE_URL = ""

    public func webService(Suburl:String, dataParamater:NSDictionary, stringParamater:String, fileData:Data, fileParamaterName:String, type:NSString, isAuthroise:Bool, header:HTTPHeaders){
        let url = BASE_URL+Suburl
        
        if isAuthroise == true{
            
        }
        
        if type.isEqual(to: "GET"){
            Alamofire.request(url, method: .get, parameters: dataParamater as? [String:Any], headers:header).validate().responseJSON { (response:DataResponse<Any>) in
                switch(response.result){
                case.success(_):
                    print(response.data ?? "success")
                    if response.result.value != nil{
                        print(response.result.value ?? "a")
                        
                    }
                case .failure(_):
                    print(response.result.error ?? "b")
                }
            }
            
            
        }
        else if type.isEqual(to: "POST"){
            Alamofire.request(url, method: .post, parameters: dataParamater as? [String:Any], headers:header).validate().responseJSON { (response:DataResponse<Any>) in
                switch(response.result){
                case.success(_):
                    print(response.data ?? "success")
                    if response.result.value != nil{
                        print(response.result.value ?? "A")
                        
                    }
                case .failure(_):
                    print(response.result.error ?? "A")
                }
            }

            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    










