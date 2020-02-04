//
//  AppDelegate.swift
//  UBSupport
//
//  Created by Tulio Parreiras on 04/23/2019.
//  Copyright (c) 2019 Tulio Parreiras. All rights reserved.
//

import UIKit

import UBSupport

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: SupportCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let navigation = UINavigationController()
        let coordinator = SupportCoordinator(navigationController: navigation)
        coordinator.delegate = self
        let model = SupportModel(email: "tulio@usemobile.xyz", phone: "(31) 98492-3952")
        let settings = SupportSettings.default
        settings.language = .es
//        settings.emptySupportText = true
        coordinator.start(model: model, settings: settings)
//        coordinator.start(model: model)
//        coordinator.startWithCellModel(model, cellModel: SupportCellViewModel(title: "Testando", message: "Mensagem Teste", objectId: "123", voted: 0), settings: .default)
        self.coordinator = coordinator
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        
//        let models = [SupportCellViewModel(title: "Cobrança Indevida, como proceder?", message: "ABC"), SupportCellViewModel(title: "Tive probleas com o motorista o que devo fazer?", message: "Test", objectId: "1234")]
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: SupportCoordinatorDelegate {
    func didVoteUseful(_ coordinator: SupportCoordinator, supportId: String?, useful: Bool) {
        coordinator.showContact()
    }
    
    func sendContact(_ coordinator: SupportCoordinator, subject: String, message: String, objectId: String?) {
        coordinator.navigationController.popToRootViewController(animated: true)
    }
    
    func endCoordinator(_ coordinator: SupportCoordinator) {
        self.coordinator = nil
    }
}
