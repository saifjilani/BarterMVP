//
//  RootViewController.swift
//  swapMe
//
//

import UIKit
import Parse
import ParseUI

class RootViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Parse Login
    //If no user logged in then parse login view opens
    func loginSetup()
    {
        if (PFUser.currentUser() == nil)
        {
            let loginViewController = PFLogInViewController()
            loginViewController.delegate = self
            
            let signupViewController = PFSignUpViewController()
            signupViewController.delegate = self
            
            loginViewController.signUpController = signupViewController
            loginViewController.fields = ([PFLogInFields.LogInButton, PFLogInFields.Facebook, PFLogInFields.Twitter,  PFLogInFields.SignUpButton, PFLogInFields.UsernameAndPassword,  PFLogInFields.PasswordForgotten , PFLogInFields.DismissButton])
            
            let loginTitle = UILabel()
            loginTitle.text = "Barter"
            let signupTitle = UILabel()
            signupTitle.text = "Barter Signup"
            
            loginViewController.logInView?.logo = loginTitle
            signupViewController.signUpView?.logo = signupTitle
            
            
            self.presentViewController(loginViewController, animated: true, completion: nil)
        }
    }
    
    //Checks if username and password are empty
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool
    {
        if (!username.isEmpty || !password.isEmpty)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    //Closes login view after user logs in
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Checks for login error
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?)
    {
        print("Failed to login....")
    }
    
    //MARK: Parse SignUp
    
    //Closes signup view after user signs in
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Checks for signup error
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?)
    {
        print("Failed to signup")
    }
    
    //Checks if user cancelled signup
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController)
    {
        print("User dismissed signup")
    }
    
    //Logs out user
    func logoutAction()
    {
        print("logging out")
        PFUser.logOut()
        self.loginSetup()
    }
    
}
