//
//  FilterCollectionView.swift
//  A4
//
//  Created by Cole on 11/12/23.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class FilterCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties (view)
    
    let filterButton = UIButton()
    var isSelectedFilter: Bool = false {
        didSet {
            updateButtonAppearance()
        }
    }
    
    // MARK: - Properties (data)
    
    static let reuse = "FilterCollectionViewReuse"
    var buttonTapped: (() -> Void)?
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFilterButton()
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    func configure(filterName: String, isSelected: Bool, target: Any?, action: Selector) {
        filterButton.setTitle(filterName, for: .normal)
        filterButton.addTarget(target, action: action, for: .touchUpInside)
        isSelectedFilter = isSelected
        
        
    }
    
    
    private func setupFilterButton() {
        filterButton.setTitleColor(UIColor.a4.black, for: .normal)
        filterButton.setTitleColor(UIColor.a4.white, for: .selected)
        filterButton.layer.cornerRadius = 16
        filterButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        if filterButton.isSelected {
            filterButton.backgroundColor = UIColor.a4.yellowOrange
        }
        else {
            filterButton.backgroundColor = UIColor.a4.offWhite
        }
        
        
        contentView.addSubview(filterButton)
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filterButton.heightAnchor.constraint(equalToConstant: 32),
            filterButton.widthAnchor.constraint(equalToConstant: 116)
        ])
        
    }
    
    private func updateButtonAppearance() {
        if isSelectedFilter {
            filterButton.backgroundColor = UIColor.a4.yellowOrange
            filterButton.isSelected = true
        }
        else {
            filterButton.backgroundColor = UIColor.a4.offWhite
            filterButton.isSelected = false
        }
    }
    
    
}
