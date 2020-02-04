//
//  SupportCell.swift
//  UBSupport
//
//  Created by Usemobile on 23/04/19.
//

import Foundation
import UIKit

class SupportCell: UITableViewCell {
    
    // MARK: - Properties
    
    var model: SupportCellViewModel? {
        didSet {
            self.supportCellView.label.text = self.model?.title ?? ""
        }
    }
    
    var settings: SupportCellSettings = .default {
        didSet {
            self.supportCellView.settings = self.settings
        }
    }
    
    // MARK: - UIComponents
    
    lazy var supportCellView: SupportCellView = {
        let view = SupportCellView()
        self.contentView.addSubview(view)
        return view
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
        let verticalPadding: CGFloat = 10
        let horizontalPadding: CGFloat = 16
        self.supportCellView.fillSuperview(padding: .init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding))
    }
    
    func setSelected(_ selected: Bool) {
        self.supportCellView.setSelected(selected)
    }
}
