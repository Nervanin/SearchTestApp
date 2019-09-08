//
//  ViewController.swift
//  SearchTestApp
//
//  Created by Konstantin on 08/09/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
    
    struct Constants {
        static let searchViewOffset: CGFloat = 8
        static let searchViewHeight: CGFloat = 56
        static let searchViewLowHeight: CGFloat = 40
        static let searchViewWidth: CGFloat = 16
        static let catalogNameOffset: CGFloat = 8
        static let subCatalogNameOffset: CGFloat = 8
        static let clearButtonWidth: CGFloat = 100
    }
    
    var networkService = NetworkService()
    let searchView = SearchModule()
    lazy var collectionView = UICollectionView()
    let catalogName = UILabel()
    let subCatalogName = UILabel()
    let clearButton = UIButton()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(collectionView)
        collectionView.addSubview(searchView)
        collectionView.addSubview(catalogName)
        collectionView.addSubview(subCatalogName)
        collectionView.addSubview(clearButton)
        searchView.searchButton.addTarget(self, action: #selector(searchButtonDidPressed), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearSerchField), for: .touchUpInside)
        searchView.delegate = self
        setGestureRecognizer()
        wrapedView()
    }
    
    func unwrapedView() {
        searchView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(Constants.searchViewOffset)
            make.top.equalToSuperview().offset(Constants.searchViewOffset)
            make.height.equalTo(Constants.searchViewHeight)
            make.width.equalTo(view.frame.width - Constants.searchViewWidth)
        }
        searchView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        searchView.layer.borderWidth = 1
        searchView.layer.cornerRadius = 10
        searchView.layer.masksToBounds = true
        
        catalogName.text = "Каталог ->"
        catalogName.snp.updateConstraints { (make) in
            make.left.equalTo(searchView.snp.left)
            make.top.equalTo(searchView.snp.bottom).offset(Constants.catalogNameOffset)
        }
        
        subCatalogName.text = "Подкаталог"
        subCatalogName.snp.updateConstraints { (make) in
            make.left.equalTo(catalogName.snp.right).offset(Constants.subCatalogNameOffset)
            make.top.equalTo(searchView.snp.bottom).offset(Constants.subCatalogNameOffset)
        }
        
        clearButton.isHidden = false
        clearButton.setTitle("Отчистить", for: .normal)
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.snp.updateConstraints { (make) in
            make.top.equalTo(searchView.snp.bottom)
            make.right.equalTo(searchView.snp.right)
            make.width.equalTo(Constants.clearButtonWidth)
        }

    }
    
    func wrapedView() {
        searchView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(Constants.searchViewOffset)
            make.top.equalToSuperview().offset(Constants.searchViewOffset)
            make.height.equalTo(Constants.searchViewLowHeight)
            make.width.equalTo(view.frame.width - Constants.searchViewWidth)
        }
        searchView.layer.borderWidth = 0
        
        catalogName.text = "Каталог ->"
        catalogName.snp.updateConstraints { (make) in
            make.left.equalTo(searchView.snp.left)
            make.top.equalTo(searchView.snp.bottom).inset(Constants.catalogNameOffset)
        }
        
        subCatalogName.text = "Подкаталог"
        subCatalogName.snp.updateConstraints { (make) in
            make.left.equalTo(catalogName.snp.right).offset(Constants.subCatalogNameOffset)
            make.top.equalTo(searchView.snp.bottom).inset(Constants.subCatalogNameOffset)
        }
        
        clearButton.isHidden = true
    }
    
    func setGestureRecognizer() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer(gesture:)))
        swipeDown.direction = .down
        swipeUp.direction = .up
        collectionView.addGestureRecognizer(swipeDown)
        collectionView.addGestureRecognizer(swipeUp)
        collectionView.addGestureRecognizer(tap)
    }
    
    @objc func tapGestureRecognizer(gesture: UIGestureRecognizer) {
        guard let parametr = searchView.searchField.text else {
            return
        }
        networkService.sendRequest(parametr: parametr)
        wrapedView()
        searchView.wrappedView()
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                let transition = CATransition()
                transition.duration = 0.2
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                unwrapedView()
                searchView.unwrappedView()
            case UISwipeGestureRecognizer.Direction.up:
                let transition = CATransition()
                transition.duration = 0.2
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                wrapedView()
                searchView.wrappedView()
            default:
                break
            }
        }
    }
    
    @objc func clearSerchField() {
        searchView.searchField.text = ""
    }
}

extension CatalogViewController: SearchButtonProtocol {
    @objc func searchButtonDidPressed() {
        unwrapedView()
        searchView.unwrappedView()
    }
}

