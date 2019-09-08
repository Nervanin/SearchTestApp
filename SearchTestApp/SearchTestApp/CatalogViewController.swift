//
//  ViewController.swift
//  SearchTestApp
//
//  Created by Konstantin on 08/09/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
    
    let searchView = SearchModule()
    lazy var collectionView = UICollectionView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(collectionView)
        searchView.searchButton.addTarget(self, action: #selector(searchButtonDidPressed), for: .touchUpInside)
        searchView.delegate = self
        setGestureRecognizer()
        wrapedView()
    }
    
    func unwrapedView() {
        collectionView.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(56)
            make.width.equalTo(view.frame.width - 16)
        }
        searchView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        searchView.layer.borderWidth = 1
        searchView.layer.cornerRadius = 10
        searchView.layer.masksToBounds = true
    }
    
    func wrapedView() {
        collectionView.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(40)
            make.width.equalTo(view.frame.width - 16)
        }
        searchView.layer.borderWidth = 0
    }
    
    func setGestureRecognizer() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = .down
        swipeUp.direction = .up
        collectionView.addGestureRecognizer(swipeDown)
        collectionView.addGestureRecognizer(swipeUp)
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
}

extension CatalogViewController: SearchButtonProtocol {
    @objc func searchButtonDidPressed() {
        unwrapedView()
        searchView.unwrappedView()
    }
}

