//
//  WrappedPropertyObservable.swift
//  Tracker
//
//  Created by Евгений on 03.07.2023.
//

import Foundation

// Only one observable for all screens, as it suits for all viewModels
@propertyWrapper
final class Observable<Value> {
    private var onChange: ((Value) -> Void)? = nil
    
    var wrappedValue: Value {
        didSet {
            onChange?(wrappedValue)
        }
    }
    
    var projectedValue: Observable<Value> {
        return self
    }
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    func bind(action: @escaping (Value) -> Void) {
        self.onChange = action
    }
}
