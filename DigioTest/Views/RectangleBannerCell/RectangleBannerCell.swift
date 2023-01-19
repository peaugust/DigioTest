//
//  RectangleBannerCell.swift
//  DigioTest
//
//  Created by Pedro Freddi on 17/01/23.
//

import UIKit

class RectangleBannerCell: UICollectionViewCell, GalleryCell {

    // MARK: - IBOutlets

    @IBOutlet var imageView: UIImageView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupBorders()
    }

    // MARK: - Setup

    func setupCell(_ imageUrl: String) {
        ImageLoader.shared.load(imageUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
                self.imageView.contentMode = .scaleAspectFill
            }
        }
    }

    private func setupBorders() {
        self.layer.cornerRadius = 8
        self.backgroundColor = .gray
    }
}
