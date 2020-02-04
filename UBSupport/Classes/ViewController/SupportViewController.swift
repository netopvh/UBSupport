//
//  SupportViewController.swift
//  UBSupport
//
//  Created by Usemobile on 23/04/19.
//

import UIKit
import USE_Coordinator

open class BaseSupportVC: CoordinatedViewController {
    
    // MARK: - Properties
    var settings: SupportSettings = .default
    
    open func addCloseButton() {
        let image = self.settings.closeImage ?? UIImage.getFrom(customClass: SupportViewController.self, nameResource: "close")
        let button = UIBarButtonItem(image: image?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(closePressed))
        button.tintColor = self.settings.closeColor
        self.navigationItem.leftBarButtonItem  = button
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func closePressed() {
        (self.coordinator as? SupportCoordinator)?.endCoordinator()
    }
}

public class SupportViewController: BaseSupportVC {
    
    // MARK: - UI Components
    
    lazy var supportView: SupportView = {
        let view = SupportView(settings: self.settings)
        view.delegate = self
        return view
    }()
    
    // MARK: - Life Cycle
    
    init(settings: SupportSettings = .default) {
        super.init(nibName: nil, bundle: nil)
        self.settings = settings
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        self.view = self.supportView
        self.addCloseButton()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = .support
    }
    
    public func setupSupport(_ support: [SupportCellViewModel]) {
        self.supportView.setupSupport(support)
    }
    
    public func insertSupport(_ support: [SupportCellViewModel]) {
        self.supportView.insertSupport(support)
    }
    
    public func updateModel(_ model: SupportCellViewModel) {
        self.supportView.updateModel(model)
    }
    
}

extension SupportViewController: SupportViewDelegate {
    func didSelectModel(_ view: SupportView, model: SupportCellViewModel) {
        (self.coordinator as? SupportCoordinator)?.showSupportDetails(support: model)
    }
    func sendMessagePressed(_ view: SupportView) {
        (self.coordinator as? SupportCoordinator)?.showContact()
    }
}
