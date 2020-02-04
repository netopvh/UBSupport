//
//  SupportViewModel.swift
//  UBSupport
//
//  Created by Usemobile on 23/04/19.
//

import Foundation

public class SupportCellViewModel: Equatable {
    public let title: String
    public let message: String
    public let objectId: String?
    
    public var voted: Int
    
    public init(title: String, message: String, objectId: String? = nil, voted: Int = 0) {
        self.title = title
        self.message = message
        self.objectId = objectId
        self.voted = voted
    }
    
    public static func ==(lhs: SupportCellViewModel, rhs: SupportCellViewModel) -> Bool {
        return lhs.title == rhs.title && lhs.message == rhs.message && lhs.objectId == rhs.objectId
    }
    
}

public class SupportModel {
    public let email: String
    public let phone: String
    public let subjects: [String]?
    
    public init(email: String, phone: String, subjects: [String]? = nil) {
        self.email = email
        self.phone = phone
        self.subjects = subjects
    }
}
