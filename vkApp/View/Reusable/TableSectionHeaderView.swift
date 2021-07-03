//
//  TableSectionHeaderView.swift
//  vkApp
//
//  Created by Anna Delova on 4/21/21.
//


//HeaderCreation with code

import UIKit

final class TableSectionHeaderView: UITableViewHeaderFooterView {
    
    // create a label
    private let myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .ultraLight)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configurateViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // set identifier
    override var reuseIdentifier: String? {
        "TableSectionHeaderView"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
    
    private func configurateViews() {
        addSubview(myLabel)
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabel.frame = self.bounds

    }
    
    func configure(with name: String) {
        myLabel.text = name
    }
}
