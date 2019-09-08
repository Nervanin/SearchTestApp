//
//  ViewController.swift
//  SearchTestApp
//
//  Created by Konstantin on 08/09/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
    
    var networkService = NetworkService()
    let searchView = SearchModule()
    lazy var collectionView = UICollectionView()
    let catalogName = UILabel()
    let subCatalogName = UILabel()
    let clearButton = UIButton()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.sendRequest()
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
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(56)
            make.width.equalTo(view.frame.width - 16)
        }
        searchView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        searchView.layer.borderWidth = 1
        searchView.layer.cornerRadius = 10
        searchView.layer.masksToBounds = true
        
        catalogName.text = "Каталог"
        catalogName.snp.updateConstraints { (make) in
            make.left.equalTo(searchView.snp.left)
            make.top.equalTo(searchView.snp.bottom).offset(8)
        }
        
        subCatalogName.text = "Подкаталог"
        subCatalogName.snp.updateConstraints { (make) in
            make.left.equalTo(catalogName.snp.right).offset(8)
            make.top.equalTo(searchView.snp.bottom).offset(8)
        }
        
        clearButton.isHidden = false
        clearButton.setTitle("Отчистить", for: .normal)
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.snp.updateConstraints { (make) in
            make.top.equalTo(searchView.snp.bottom)
            make.right.equalTo(searchView.snp.right)
            //make.left.equalTo(subCatalogName.snp.right).offset(-16)
            make.width.equalTo(100)
           // make.height.equalTo(30)
        }

    }
    
    func wrapedView() {
        searchView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(40)
            make.width.equalTo(view.frame.width - 16)
        }
        searchView.layer.borderWidth = 0
        
        catalogName.text = "Каталог"
        catalogName.snp.updateConstraints { (make) in
            make.left.equalTo(searchView.snp.left)
            make.top.equalTo(searchView.snp.bottom).inset(8)
        }
        
        subCatalogName.text = "Подкаталог"
        subCatalogName.snp.updateConstraints { (make) in
            make.left.equalTo(catalogName.snp.right).offset(8)
            make.top.equalTo(searchView.snp.bottom).inset(8)
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

