//
//  DetailsViewController.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 07/03/2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var goBackBlock: (() -> Void)?
    var detailsModel: DetailsModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
    }
}
