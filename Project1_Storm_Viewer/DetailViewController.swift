//
//  DetaleViewController.swift
//  Project1_Storm_Viewer
//
//  Created by Petro Strynada on 02.06.2023.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedImageNumber: Int?
    var imageCount: Int?
    var picturesShownTimes: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Picture \(selectedImageNumber ?? 0) of \(imageCount ?? 0), showed \(picturesShownTimes ?? 0) times"
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

}
