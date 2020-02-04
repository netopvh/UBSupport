//
//  SupportView.swift
//  UBSupport
//
//  Created by Usemobile on 23/04/19.
//

import Foundation
import TransitionButton

protocol SupportViewDelegate: class {
    func didSelectModel(_ view: SupportView, model: SupportCellViewModel)
    func sendMessagePressed(_ view: SupportView)
}

class SupportView: UIView {
    
    // MARK: - UI Components
    
    lazy var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.addSubview(view)
        return view
    }()
    
    lazy var imvEmpty: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.getFrom(customClass: SupportView.self, nameResource: "support")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = self.settings.emptyTintColor
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.emptyView.addSubview(imageView)
        return imageView
    }()
    
    lazy var lblEmpty: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = self.settings.emptyTintColor
        label.font = self.settings.emptyFont
        label.text = .emptytext
        label.numberOfLines = 0
        self.emptyView.addSubview(label)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(SupportCell.self, forCellReuseIdentifier: kSupportCell)
        tableView.dataSource = self
        tableView.delegate = self
        self.addSubview(tableView)
        return tableView
    }()
    
    lazy var btnSendMessage: CustomButton = {
        let button = CustomButton()
        button.settings = self.settings
        button.setTitle(.sendMessage, for: .normal)
        button.cornerRadius = 27.5
        button.addTarget(self, action: #selector(self.btnSendMessagePressed), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    // MARK: - Properties
    
    weak var delegate: SupportViewDelegate?
    
    let kSupportCell = "SupportCell"
    
    var items: [SupportCellViewModel] = []
    var settings: SupportSettings = .default
    
    init(settings: SupportSettings = .default) {
        self.settings = settings
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.backgroundColor = .white
        self.addConstraints([
            self.emptyView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            self.emptyView.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor),
            self.emptyView.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor),
            self.emptyView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.8),
            self.imvEmpty.centerXAnchor.constraint(equalTo: self.emptyView.centerXAnchor)
            ])
        self.imvEmpty.anchor(top: self.emptyView.topAnchor, left: nil, bottom: nil, right: nil, size: .init(width: 120, height: 120))
        self.lblEmpty.anchor(top: self.imvEmpty.bottomAnchor, left: self.emptyView.leftAnchor, bottom: self.emptyView.bottomAnchor, right: self.emptyView.rightAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
        self.tableView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor)
        var bottomAnchor = self.bottomAnchor
        if #available(iOS 11, *) {
            bottomAnchor = self.safeAreaLayoutGuide.bottomAnchor
        }
        self.btnSendMessage.anchor(top: self.tableView.bottomAnchor, left: nil, bottom: bottomAnchor, right: nil, padding: .init(top: 22.5, left: 0, bottom: 22.5, right: 0), size: .init(width: 0, height: 55))
        self.btnSendMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.btnSendMessage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        self.tableView.isHidden = self.items.isEmpty
    }
    
    func setupSupport(_ models: [SupportCellViewModel]) {
        self.items = models
        self.tableView.reloadData()
        self.tableView.isHidden = self.items.isEmpty
    }
    
    func insertSupport(_ models: [SupportCellViewModel]) {
        defer {
            
        }
        
        let (start, end) = (self.items.count, (self.items.count + models.count))
        let indexPaths = (start ..< end).map { return IndexPath(row: $0, section: 0)}
        
        self.items.append(contentsOf: models)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .fade)
        self.tableView.endUpdates()
        
    }
    
    func updateModel(_ model: SupportCellViewModel) {
        self.items.forEach {
            if $0 == model {
                $0.voted = model.voted
            }
        }
    }
    
    @objc func btnSendMessagePressed() {
        self.delegate?.sendMessagePressed(self)
    }
}

extension SupportView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? SupportCell)?.setSelected(true)
        self.delegate?.didSelectModel(self, model: self.items[indexPath.row])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            (tableView.cellForRow(at: indexPath) as? SupportCell)?.setSelected(false)
        }
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? SupportCell)?.setSelected(true)
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? SupportCell)?.setSelected(false)
    }
}

extension SupportView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSupportCell, for: indexPath) as! SupportCell
        cell.settings = self.settings.supportCellSettings
        cell.model = self.items[indexPath.row]
        return cell
    }
}
