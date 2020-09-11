//
//  FLoopView.swift
//  FLoopViewDemo
//
//  Created by Fang on 2020/9/9.
//

import UIKit

protocol FLoopModelProtocol {
    var name :String? { get set }
    var imageUrl :String? { get set }
    var string :String? { get set }
}

class FLoopView: UIView, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let spacing: CGFloat = 5.0
    
    lazy var layout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView :UICollectionView = {
        
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        coll.delegate = self
        coll.dataSource = self
        coll.register(FLoopViewCell.classForCoder(), forCellWithReuseIdentifier: String(utf8String: class_getName(FLoopViewCell.classForCoder()))!)
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.backgroundColor = .blue
        coll.isPagingEnabled = true
        coll.showsVerticalScrollIndicator = false
        return coll
    }()
    
    var dataArray :Array<FLoopModelProtocol>?
    var numberOfPage:Int {
        didSet {
            resetCollectionViewCellSize()
        }
    }
    
    override init(frame: CGRect) {
        numberOfPage = 1
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        numberOfPage = 1
        super.init(coder: coder)
        createUI()
    }
    
    //MARK: createUI
    func createUI() {
        addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        resetCollectionViewCellSize()
    }
    
    func resetCollectionViewCellSize() {
        layout.itemSize = CGSize(width: frame.size.width, height: (frame.size.height / CGFloat(numberOfPage)))
    }
    
    func getPageNumber() -> Int {
        guard dataArray?.count ?? 0 > 0 else {
            return 0
        }
        if numberOfPage == 1 {
            return dataArray!.count + 2
        }
        let count = dataArray?.count ?? 0
        return getLeastCommonMultiple(x: count, y: numberOfPage) / numberOfPage + 2
    }
    
    //最小公倍数
    func getLeastCommonMultiple(x: Int, y: Int) -> Int {
        var max = 0
        var min = 0
        if (x > y) {
            max = x;
            min = y;
        }else{
            max = y;
            min = x;
        }
        while (min != 0) {
           let temp = max % min;
            max = min;
            min = temp;
        }
        return x*y/max
    }
    
    //MARK: collectionViewDelegate | collectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if dataArray?.count ?? 0 > 0  {
           return numberOfPage * getPageNumber()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(utf8String: class_getName(FLoopViewCell.classForCoder()))!, for: indexPath) as! FLoopViewCell
        
        let index = labs((indexPath.row + dataArray!.count - numberOfPage)) % dataArray!.count
        let model = dataArray![index]
        cell.label.text = model.string
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            
            let index = collectionView.contentOffset.y / layout.itemSize.height
            
            if index == CGFloat((getPageNumber() - 1) * numberOfPage)  {
                let indexPath = IndexPath(item: numberOfPage, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
            } else if index == 0 {
                let indexPath = IndexPath(item: (getPageNumber() - 2) * numberOfPage, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
            }
        }
    }
    
    //MARK: - upData
    func updateArray(array: Array<FLoopModelProtocol>) {
        if array.count <= 0 {
            dataArray = nil
        } else {
            dataArray = array
        }
        
        collectionView.reloadData()
        if dataArray?.count ?? 0 > 0 {
            DispatchQueue.main.async { [self] in
                self.collectionView.scrollToItem(at: IndexPath(item: numberOfPage, section: 0), at: .top, animated: false)
            }
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
