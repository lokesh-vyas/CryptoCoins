//
//  SplashViewController.swift
//  CryptoCoins
//
//  Created by Lokesh Vyas on 21/10/24.
//

import UIKit

final class SplashViewController: UIViewController {
    var coordinator: SplashCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 86/255, green: 12/255, blue: 225/255, alpha: 1.0)
        
        let label = UILabel()
        label.text = "Crypto Currency"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.view.trailingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 20).isActive = true
        
        let imageView = UIImageView(image: UIImage(named: "active-crypto-coin"))
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.coordinator?.navigateToHome()
        }
    }
}

#Preview {
    SplashViewController()
}
