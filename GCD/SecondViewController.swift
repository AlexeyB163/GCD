//
//  SecondViewController.swift
//  GCD
//
//  Created by User on 26.03.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicate: UIActivityIndicatorView!
    
    fileprivate var imageUrl: URL?
    fileprivate var image: UIImage? {
        get {
            imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            activityIndicate.stopAnimating()
            activityIndicate.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3, closure: loginAlert)
    }
    
    fileprivate func delay(_ delay: Int,  closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay), execute: closure)
        
    }
    
    fileprivate func loginAlert() {
        let alert = UIAlertController(title: "Зарегистрированны?", message: "Введите ваш логин и пароль", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.addTextField { userName in
            userName.placeholder = "Введите логин"
        }
        alert.addTextField { userPassword in
            userPassword.placeholder = "Введите пароль"
            userPassword.isSecureTextEntry = true
        }
        present(alert, animated: true)
        
    }
    
    fileprivate func fetchImage() {
        imageUrl = URL(string: "https://www.moto1pro.com/sites/default/files/enduropro/fotosprincipales/graham-jarvis-redbull-romaniacs-2013.jpg")
        activityIndicate.isHidden = false
        activityIndicate.startAnimating()
        //процесс загрузки помещаем в другой поток
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageUrl, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
            
        }
    }
}
