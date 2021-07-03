//
//  LoadingIndicatorViewController.swift
//  vkApp
//
//  Created by Anna Delova on 4/26/21.
//

import UIKit

class LoadingIndicatorViewController: UIViewController {

    let loadingIndicatorView = LoadingIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configure()
        configureLoadingIndicator()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        // Do any additional setup after loading the view.
    }
    
    private func configure() {
        view.backgroundColor = .systemPink// set BG color
        
    }
    private func configureLoadingIndicator() {

        view.addSubview(loadingIndicatorView)
        NSLayoutConstraint.activate([
        
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicatorView.heightAnchor.constraint(equalToConstant: 20),
            loadingIndicatorView.widthAnchor.constraint(equalToConstant: 100)
        ])
    
    }
    
    @objc func viewTapped() {
        
        loadingIndicatorView.animate()
        
    }
    
    @IBAction func button(_ sender: UIButton) {

        
    }
    
    
}
