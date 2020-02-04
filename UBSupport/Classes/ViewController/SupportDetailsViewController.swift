//
//  SupportDetailsViewController.swift
//  UBSupport
//
//  Created by Usemobile on 23/04/19.
//

import UIKit
import USE_Coordinator

class SupportDetailsViewController: BaseSupportVC {
    
    // MARK: - UI Components
    
    lazy var supportDetailsView: SupportDetailsView = {
        let view = SupportDetailsView(model: self.model, settings: self.settings.supportDetailsSettings)
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    
    var model: SupportCellViewModel
    
    // MARK: - Life Cycle
    
    init(model: SupportCellViewModel, settings: SupportSettings = .default) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.settings = settings
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.supportDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = .support
    }
    
}

extension SupportDetailsViewController: SupportDetailsViewDelegate {
    func didVoteUseful(_ view: SupportDetailsView, useful: Bool) {
        self.model.voted = useful ? 1 : 2
        (self.coordinator as? SupportCoordinator)?.didVoteUseful(model: self.model, useful: useful)
    }
}
