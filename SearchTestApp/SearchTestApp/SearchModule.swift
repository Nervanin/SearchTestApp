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
        static let searchButtonSize: CGFloat = 25
        static let searchButtonLowSize: CGFloat = 20
        static let searchFieldOffset: CGFloat = 16
        static let searchFieldInset: CGFloat = 8
        
    }
    
    let searchField = UITextField()
    let searchButton = UIButton()
    var delegate: SearchButtonProtocol?
    
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
        searchField.becomeFirstResponder()
        searchButton.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(Constants.searchIconLeftOffset)
            make.centerY.equalToSuperview()
            make.size.equalTo(Constants.searchButtonSize)
        }
        searchField.placeholder = "Поиск"
        searchField.snp.updateConstraints { (make) in
            make.left.equalTo(searchButton.snp.right).offset(Constants.searchFieldOffset)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(Constants.searctFieldRightInset)
        }
    }
    
    func wrappedView() {
        searchButton.setImage(UIImage(named: "searchIcon"), for: .normal)
        searchButton.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(Constants.searchIconLeftOffset)
            make.centerY.equalToSuperview()
            make.size.equalTo(Constants.searchButtonLowSize)
        }
        searchField.resignFirstResponder()
        searchField.placeholder = ""
    }
    
    @objc func searchButtonDidPressed() {
        unwrappedView()
        delegate?.searchButtonDidPressed()
    }
}
