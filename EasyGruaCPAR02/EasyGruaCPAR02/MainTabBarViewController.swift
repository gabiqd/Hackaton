//
//  MainTabBarViewController.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    let selectedColor   = UIColor.SanCristobalDarkGreen
    let unselectedColor = UIColor.SanCristobalGreen
    let authUI = FUIAuth.defaultAuthUI()
    
    enum tabBarIndex{
        case Inicio
        case Perfil
        
        var imagelabel: String{
            switch self {
            case .Inicio:
                return "Inicio"
            case .Perfil:
                return "Perfil"
            }
        }
        
        var description: String{
            switch self {
            case .Inicio:
                return "Inicio"
            case .Perfil:
                return "Perfil"
            }
        }
        static let allValues = [Inicio, Perfil]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.delegate = self
        
        authUI?.delegate = self
        authUI?.customStringsBundle = Bundle.main // Or any custom bundle.
        
        
        let providers: [FUIAuthProvider] = [
            FUIFacebookAuth(),
            ]
        authUI?.providers = providers
        
        checkUserState()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isUserSignedIn() {
            showLoginView()
        }
    }
    
    private func isUserSignedIn() -> Bool {
        guard Auth.auth().currentUser != nil else { return false }
        return true
    }
    
    private func showLoginView() {
        if let authVC = FUIAuth.defaultAuthUI()?.authViewController() {
            present(authVC, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var tabBarItemsVC = [UIViewController]()
        
        for index in tabBarIndex.allValues{
            var tabBarViewController: UIViewController?
            
            let auxTabBarItem = UITabBarItem(title: index.description, image: UIImage(named: "\(index.imagelabel.lowercased())"), selectedImage: UIImage(named: "\(index.imagelabel.lowercased())-selected"))
            
            switch index{
            case .Inicio: tabBarViewController = BaseNavigationController(rootViewController: AskForCraneViewController())
            auxTabBarItem.tag = 1
            tabBarViewController?.tabBarItem = auxTabBarItem
            case .Perfil: tabBarViewController = PerfilViewController()
            auxTabBarItem.tag = 2
            tabBarViewController?.tabBarItem = auxTabBarItem
            }
            
            tabBarItemsVC.append(tabBarViewController!)
        }
        
        self.viewControllers = tabBarItemsVC
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let selectedTabBarItem = tabBar.subviews[item.tag].subviews.first as? UIImageView
        selectedTabBarItem?.contentMode = .center
        
        selectedTabBarItem?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: {() -> Void in
                        selectedTabBarItem?.transform = .identity
        },
                       completion: nil)
        
    }
}

extension MainTabBarViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        switch error {
        case .some(let error as NSError) where UInt(error.code) == FUIAuthErrorCode.userCancelledSignIn.rawValue:
            print("User cancelled sign-in")
        case .some(let error as NSError) where error.userInfo[NSUnderlyingErrorKey] != nil:
            print("Login error: \(error.userInfo[NSUnderlyingErrorKey]!)")
        case .some(let error):
            print("Login error: \(error.localizedDescription)")
        case .none:
            return
        }
    }
    
    private func checkUserState() {
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                
                guard let currentUser = user else{
                    return
                }
                print(currentUser.uid)
                
            } else {
                self.showLoginView()
            }
        }
    }
    
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        return FUICustomAuthPickerViewController(nibName: nil,
                                                 bundle: Bundle.main,
                                                 authUI: authUI)
    }
    
    
    func emailEntryViewController(forAuthUI authUI: FUIAuth) -> FUIEmailEntryViewController {
        return FUICustomEmailEntryViewController(nibName: nil,
                                                 bundle: Bundle.main,
                                                 authUI: authUI)
    }
    
    func passwordRecoveryViewController(forAuthUI authUI: FUIAuth, email: String) -> FUIPasswordRecoveryViewController {
        return FUICustomPasswordRecoveryViewController(nibName: nil,
                                                       bundle: Bundle.main,
                                                       authUI: authUI,
                                                       email: email)
    }
    
    func passwordSignInViewController(forAuthUI authUI: FUIAuth, email: String) -> FUIPasswordSignInViewController {
        return FUICustomPasswordSignInViewController(nibName: nil,
                                                     bundle: Bundle.main,
                                                     authUI: authUI,
                                                     email: email)
    }
    
    func passwordSignUpViewController(forAuthUI authUI: FUIAuth, email: String) -> FUIPasswordSignUpViewController {
        return FUICustomPasswordSignUpViewController(nibName: nil,
                                                     bundle: Bundle.main,
                                                     authUI: authUI,
                                                     email: email)
    }
    
    func passwordVerificationViewController(forAuthUI authUI: FUIAuth, email: String, newCredential: AuthCredential) -> FUIPasswordVerificationViewController {
        return FUICustomPasswordVerificationViewController(nibName: nil,
                                                           bundle: Bundle.main,
                                                           authUI: authUI,
                                                           email: email,
                                                           newCredential: newCredential)
    }
    
}

