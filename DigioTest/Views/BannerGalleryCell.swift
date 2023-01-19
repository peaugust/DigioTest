//
//  HomeBannerCell.swift
//  DigioTest
//
//  Created by Pedro Freddi on 13/01/23.
//

import Foundation
import UIKit

protocol GalleryCell {}

enum HomeBanner: Int {
    case spotlight = 0, cash, products
    func getReusableIdentifier() -> String {
        switch self {
        case .spotlight, .cash:
            return "RectangleBannerCell"
        case .products:
            return "SquareBannerCell"
        }
    }

    func getRowHeight() -> CGFloat {
        switch self {
        case .spotlight:
            return 160
        case .cash:
            return 100
        case .products:
            return 130
        }
    }

    func getCellSize() -> CGSize {
        switch self {
        case .spotlight:
            return CGSize(width: 350, height: 150)
        case .cash:
            return CGSize(width: 350, height: 100)
        case .products:
            return CGSize(width: 100, height: 100)
        }
    }
}

class BannerGalleryCell: UITableViewCell {
    // MARK: - Properties

    var cellType: HomeBanner?

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UINib(nibName: "SquareBannerCell", bundle: nil), forCellWithReuseIdentifier: "SquareBannerCell")
        collectionView.register(UINib(nibName: "RectangleBannerCell", bundle: nil), forCellWithReuseIdentifier: "RectangleBannerCell")

        return collectionView
    }()

    var content: [Banner] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func prepareForReuse() {
        content = []
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        contentView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    func setup(_ banners: [Banner], cellType: HomeBanner) {
        self.cellType = cellType
        self.content = banners
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    private func loadImage(_ url: String, at indexPath: IndexPath) {
        ImageLoader.shared.load(url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let cell = self.collectionView.cellForItem(at: indexPath) as? SquareBannerCell {
                    cell.setupImage(image)
                }
            }
        }
    }
}

extension BannerGalleryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = self.cellType else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
        switch cellType {
        case .spotlight, .cash:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.getReusableIdentifier(), for: indexPath) as? RectangleBannerCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.setupCell(content[indexPath.row].imageUrl)
            return cell
        case .products:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.getReusableIdentifier(), for: indexPath) as? SquareBannerCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.setupLoadingCell()
            loadImage(content[indexPath.row].imageUrl, at: indexPath)
            return cell
        }
    }
}

extension BannerGalleryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellType?.getCellSize() ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch cellType {
        case .spotlight, .cash:
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        case .products:
            return UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 0)
        default:
            return .zero
        }
    }
}
