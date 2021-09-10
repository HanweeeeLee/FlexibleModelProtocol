//
//  FlexibleModelProtocol.swift
//  FlexibleModelProtocol
//
//  Created by hanwe lee on 2020/10/12.
//  Copyright © 2020 hanwe. All rights reserved.
//  e-mail : mobiledev@kakao.com
//

public protocol FlexibleModelProtocol: Codable, Equatable {
    
    associatedtype selfType: FlexibleModelProtocol
    
    static func fromJson(jsonData: Data?) -> selfType?
    static func fromXML(xmlData: Data?) -> selfType?
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> selfType?
    static func fromNSDictionary(nsDictionary: NSDictionary) -> selfType?
    
    func toJson() -> String
    func toXML() -> String?
    func toDictionary() -> Dictionary<String, Any>?
    func toNSDictionary() -> NSDictionary?
    
    func toCopyOnWriteModel<T: CopyOnWriteModelProtocol>(object: inout T) -> T?
}

extension FlexibleModelProtocol {
    public static func fromJson(jsonData: Data?) -> selfType? {
        var returnValue: selfType? = nil
        let decoder = JSONDecoder()
        if let data = jsonData, let result = try? decoder.decode(selfType.self, from: data) {
            returnValue = result
        }
        return returnValue
    }
    
    public static func fromXML(xmlData: Data?) -> selfType? {
        var returnValue: selfType? = nil
        
        if let data = xmlData {
            let parser: HWXMLParser = HWXMLParser()
            if let xmlElement = parser.parse(data: data) {
                if let dic = parser.toDictionary(element: xmlElement) {
                    returnValue = fromDictionary(dictionary: dic)
                }
            }
        }
        
        return returnValue
    }
    
    public static func fromDictionary(dictionary: Dictionary<String, Any>) -> selfType? {
        var returnValue: selfType? = nil
        
        if let jsonData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            returnValue = selfType.fromJson(jsonData: jsonData) as? Self.selfType
        }
        
        return returnValue
    }
    
    public static func fromNSDictionary(nsDictionary: NSDictionary) -> selfType? {
        var returnValue: selfType? = nil
        if let dic = nsDictionary as? Dictionary<String, Any> {
            returnValue = selfType.fromDictionary(dictionary: dic) as? Self.selfType
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
    
    public func toDictionary() -> Dictionary<String, Any>? {
        var returnValue: Dictionary<String, Any>? = nil
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
        var returnValue: NSDictionary? = nil
        if let dic = self.toDictionary() {
            returnValue = dic as NSDictionary
        }
        return returnValue
    }
    
}

extension FlexibleModelProtocol {
    public func toCopyOnWriteModel<T: CopyOnWriteModelProtocol>(object: inout T) -> T? {
        var returnValue: T? = nil
        if let typeModel = self as? T.ModelType {
            object.dataWrapper = DataWrapper(originModel: typeModel)
            returnValue = object
        }
        return returnValue
    }
}


