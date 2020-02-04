//
//  ContactViewController.swift
//  UBSupport
//
//  Created by Usemobile on 25/04/19.
//

import UIKit
import USE_Coordinator

class ContactViewController: BaseSupportVC {
    
    // MARK: - UI Components

    lazy var contactView: ContactView = {
        let view = ContactView(model: self.model, settings: self.settings)
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    
    var model: SupportModel
    var travelId: String?
    
    // MARK: - Life Cycle
    
    init(model: SupportModel, settings: SupportSettings = .default) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.settings = settings
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.contactView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = .contact
    }

}

// MARK: - Delegates

extension ContactViewController: ContactViewDelegate {
    func sendPressed(_ view: ContactView, subject: String, message: String) {
        (self.coordinator as? SupportCoordinator)?.sendContact(subject, message: message)
    }
}
