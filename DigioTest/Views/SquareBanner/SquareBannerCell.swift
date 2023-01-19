//
//  RectangleBannerCell.swift
//  DigioTest
//
//  Created by Pedro Freddi on 17/01/23.
//

import UIKit

class SquareBannerCell: UICollectionViewCell, GalleryCell {

    // MARK: - IBOutlets

    @IBOutlet var cardView: UIView!
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Properties
    
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupBorders()
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
        self.activityIndicator.stopAnimating()
    }

    // MARK: - Setup

    func setupLoadingCell() {
        activityIndicator.center = self.contentView.center
        self.contentView.addSubview(activityIndicator)
    }
    
    func setupImage(_ image: UIImage?) {
        self.activityIndicator.stopAnimating()
        self.imageView.image = image
    }

    private func setupBorders() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 18
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
}
