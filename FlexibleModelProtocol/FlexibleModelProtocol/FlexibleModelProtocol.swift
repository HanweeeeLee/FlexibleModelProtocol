//
//  FlexibleModelProtocol.swift
//  FlexibleModelProtocol
//
//  Created by hanwe lee on 2020/10/12.
//  Copyright © 2020 hanwe. All rights reserved.
//  e-mail : mobiledev@kakao.com
//

import UIKit

public protocol FlexibleModelProtocol: Codable, Equatable {
    
    static func fromJson<T:FlexibleModelProtocol>(jsonData:Data?,object:T) -> T?
    static func fromXML<T:FlexibleModelProtocol>(xmlData:Data?,object:T) -> T?
    static func fromDictionary<T:FlexibleModelProtocol>(dictionary:Dictionary<String,Any>,object:T) -> T?
    static func fromNSDictionary<T:FlexibleModelProtocol>(nsDictionary:NSDictionary,object:T) -> T?
    
//    static func toCopyOnWriteModel<T:FlexibleModelProtocol>()
    
    func toJson() -> String
    func toXML() -> String?
    func toDictionary() -> Dictionary<String,Any>?
    func toNSDictionary() -> NSDictionary?

}

public protocol CopyOnWriteModelProtocol {
    associatedtype MyType: FlexibleModelProtocol
    var dataWrapper: DataWrapper<MyType> { get set }
    var data:MyType { get set }
}

extension CopyOnWriteModelProtocol {
    var data: MyType {
        get {
            return self.dataWrapper.data
        }
        set {
            if !isKnownUniquelyReferenced(&self.dataWrapper) {
                // dataWrapper에 대한 참조가 Uniquely하지 않으면 새로운 Wrapper를 생성하여 값을 대입해줍니다.
                self.dataWrapper = DataWrapper(data: newValue)
            } else {
                // dataWrapper에 대한 참조가 Uniquely하다면 기존 Wrapper에 대해서 struct 값을 대입해줍니다.
                self.dataWrapper.data = newValue
            }
        }
    }
}

public class DataWrapper<T:FlexibleModelProtocol>:Equatable {
    public static func == (lhs: DataWrapper<T>, rhs: DataWrapper<T>) -> Bool {
        return lhs === rhs 
    }
    
    var data: T

    init(data: T) {
      self.data = data
    }
}

struct CopyOnWriteModel<T:FlexibleModelProtocol> {
    // Data Wrapper
    private var dataWrapper: DataWrapper<T>
    init(data: T) {
        self.dataWrapper = DataWrapper(data: data)
    }
    
    var data: T {
        get {
            return self.dataWrapper.data
        }
        set {
            if !isKnownUniquelyReferenced(&self.dataWrapper) {
                // dataWrapper에 대한 참조가 Uniquely하지 않으면 새로운 Wrapper를 생성하여 값을 대입해줍니다.
                self.dataWrapper = DataWrapper(data: newValue)
            } else {
                // dataWrapper에 대한 참조가 Uniquely하다면 기존 Wrapper에 대해서 struct 값을 대입해줍니다.
                self.dataWrapper.data = newValue
            }
        }
    }
}

extension FlexibleModelProtocol {
    public static func fromJson<T: FlexibleModelProtocol>(jsonData: Data?,object: T) -> T? {
        var returnValue: T? = nil
        let decoder = JSONDecoder()
        if let data = jsonData, let result = try? decoder.decode(T.self, from: data) {
            returnValue = result
        }
        return returnValue
    }
    
    public static func fromXML<T: FlexibleModelProtocol>(xmlData: Data?,object: T) -> T? {
        var returnValue: T? = nil
        
        if let data = xmlData {
            let parser:HWXMLParser = HWXMLParser()
            if let xmlElement = parser.parse(data: data) {
                if let dic = parser.toDictionary(element: xmlElement) {
                    returnValue = fromDictionary(dictionary: dic, object: object)
                }
            }
        }
        
        return returnValue
    }
    
    public static func fromDictionary<T: FlexibleModelProtocol>(dictionary: Dictionary<String,Any>,object: T) -> T? {
        var returnValue: T? = nil
        
        if let jsonData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            returnValue = T.fromJson(jsonData: jsonData, object: object)
        }
        
        return returnValue
    }
    
    public static func fromNSDictionary<T: FlexibleModelProtocol>(nsDictionary: NSDictionary,object: T) -> T? {
        var returnValue: T? = nil
        if let dic = nsDictionary as? Dictionary<String,Any> {
            returnValue = T.fromDictionary(dictionary: dic, object: object)
        }
        return returnValue
    }
}

extension FlexibleModelProtocol {
    public func toJson() -> String {
        var jsonString: String = ""
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.outputFormatting = .sortedKeys
        let jsonData = try? encoder.encode(self)
        if jsonData != nil {
            jsonString = String(data: jsonData!, encoding: .utf8) ?? ""
        }
        return jsonString
    }
    
    public func toXML() -> String? {
        var returnValue: String? = nil
        if let dic = toDictionary() {
            let parser:HWXMLParser = HWXMLParser()
            returnValue = parser.toXMLString(dictionary: dic)
        }
        
        return returnValue
    }
    
    public func toDictionary() -> Dictionary<String,Any>? {
        var returnValue: Dictionary<String,Any>? = nil
        if let data = self.toJson().data(using: .utf8) {
            do {
                returnValue = try JSONSerialization.jsonObject(with:data, options: []) as? [String: Any]
            }
            catch {
                
            }
        }
        return returnValue
    }
    
    public func toNSDictionary() -> NSDictionary? {
        var returnValue:NSDictionary? = nil
        if let dic = self.toDictionary() {
            returnValue = dic as NSDictionary
        }
        return returnValue
    }
    
}


