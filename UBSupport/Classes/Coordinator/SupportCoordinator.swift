//
//  SupportCoordinator.swift
//  UBSupport
//
//  Created by Usemobile on 23/04/19.
//

import Foundation
import USE_Coordinator

public protocol SupportCoordinatorDelegate: class {
    func didVoteUseful(_ coordinator: SupportCoordinator, supportId: String?, useful: Bool)
    func sendContact(_ coordinator: SupportCoordinator, subject: String, message: String, objectId: String?)
    func endCoordinator(_ coordinator: SupportCoordinator)
}

public class SupportCoordinator: NavigationCoordinator {
    
    public var model: SupportModel?
    public var settings: SupportSettings = .default
    public var objectId: String?
    public weak var delegate: SupportCoordinatorDelegate?
    public var rootController: SupportViewController?
    
    public func start(model: SupportModel,settings: SupportSettings = .default) {
        self.model = model
        self.settings = settings
        let root = SupportViewController(settings: settings)
        self.rootController = root
        self.start(root: root)
    }
    
    public func startWithTravelId(_ travelId: String, model: SupportModel,settings: SupportSettings = .default) {
        self.objectId = travelId
        self.model = model
        self.settings = settings
        let root = ContactViewController(model: model, settings: settings)
        root.addCloseButton()
        self.start(root: root)
    }
    
    public func startWithCellModel(_ model: SupportModel, cellModel: SupportCellViewModel, settings: SupportSettings) {
        self.model = model
        self.settings = settings
        let root = SupportDetailsViewController(model: cellModel, settings: settings)
        root.addCloseButton()
        self.start(root: root)
    }
    
    func showSupportDetails(support: SupportCellViewModel) {
        let detailsVC = SupportDetailsViewController(model: support, settings: self.settings)
        detailsVC.coordinator = self
        self.navigationController.pushViewController(detailsVC, animated: true)
    }
    
    public func showContact() {
        let model = self.model ?? SupportModel(email: "", phone: "")
        let contactVC = ContactViewController(model: model, settings: self.settings)
        contactVC.coordinator = self
        self.navigationController.pushViewController(contactVC, animated: true)
    }
    
    func didVoteUseful(model: SupportCellViewModel, useful: Bool) {
        self.rootController?.updateModel(model)
        self.delegate?.didVoteUseful(self, supportId: model.objectId, useful: useful)
    }
    
    func sendContact(_ subject: String, message: String) {
        self.delegate?.sendContact(self, subject: subject, message: message, objectId: self.objectId)
    }
    
    public func setupSupport(_ support: [SupportCellViewModel]) {
        self.rootController?.setupSupport(support)
    }
    
    public func insertSupport(_ support: [SupportCellViewModel]) {
        self.rootController?.insertSupport(support)
    }
    
    public func endCoordinator() {
        self.navigationController.dismiss(animated: true, completion: nil)
        self.delegate?.endCoordinator(self)
    }
}

