//
//  CopyOnWriteManager.swift
//  FlexibleModelProtocol
//
//  Created by hanwe lee on 2020/10/22.
//

public protocol CopyOnWriteModelProtocol {
    associatedtype ModelType: FlexibleModelProtocol
    var dataWrapper: DataWrapper<ModelType>? { get set }
    var data:ModelType? { get set }
}

extension CopyOnWriteModelProtocol {
    
    func setDataWrapper() {
        
    }
    
    var data: ModelType? {
        get {
            return self.dataWrapper?.data
        }
        set {
            if !isKnownUniquelyReferenced(&self.dataWrapper) {
                if let value = newValue {
                    self.dataWrapper = DataWrapper(originModel: value)
                }
            } else {
                self.dataWrapper?.data = newValue
            }
        }
    }
}

public class DataWrapper<T:FlexibleModelProtocol>:Equatable {
    public static func == (lhs: DataWrapper<T>, rhs: DataWrapper<T>) -> Bool {
        return lhs === rhs
    }
    
    var data: T?
    
    init(originModel: T) {
        self.data = originModel
    }
}
