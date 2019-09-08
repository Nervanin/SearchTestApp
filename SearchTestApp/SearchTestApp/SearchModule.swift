//
//  SearchModule.swift
//  SearchTestApp
//
//  Created by Konstantin on 08/09/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit
import SnapKit

class SearchModule: UIView {
    
    struct Constants {
        static let searchIconLeftOffset: CGFloat = 8
        static let searchIconTopOffset: CGFloat = 8
        static let searctFieldRightInset: CGFloat = 8
    }
    
    let searchField = UITextField()
    let searchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchButton)
        addSubview(searchField)
        wrappedView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func unwrappedView() {
        searchButton.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(Constants.searchIconLeftOffset)
            make.centerY.equalToSuperview()
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        searchField.placeholder = "Поиск"
        searchField.snp.updateConstraints { (make) in
            make.left.equalTo(searchButton.snp.right).offset(16)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(8)
        }
    }
    
    func wrappedView() {
        searchButton.setImage(UIImage(named: "searchIcon"), for: .normal)
        searchButton.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(Constants.searchIconLeftOffset)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        searchField.placeholder = ""
    }
}
