//
//  AppDelegate.swift
//  UnitySwift
//
//  Created by derrick on 2021/10/30.
//

import UIKit
import UnityFramework

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UnityFrameworkListener , NativeCallsProtocol   {
    func showHostMainWindow(_ color: String!) {
        if(color == Constants.COLOR.BLUE) {
            self.unitySampleView.nativeTitleLable.backgroundColor = .red
            self.unitySampleView.nativeTitleLable.textColor = .white
        } else if(color == Constants.COLOR.RED) {
            self.unitySampleView.nativeTitleLable.backgroundColor = .white
            self.unitySampleView.nativeTitleLable.textColor = .black
        }else if(color == Constants.COLOR.WHITE) {
            self.unitySampleView.nativeTitleLable.backgroundColor = .blue
            self.unitySampleView.nativeTitleLable.textColor = .white
        }
        
        
    }
    
    var window: UIWindow?
    var application: UIApplication?
    var storyboard: UIStoryboard?
    var viewController: ViewController!
    
    var appLaunchOpts: [UIApplication.LaunchOptionsKey: Any]?
    var unitySampleView: UnityUIView!
    var didQuit: Bool = false
    
    @objc var ufw: UnityFramework!
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ufw = getUnityFramework()
        
        appLaunchOpts = launchOptions
        
        storyboard = UIStoryboard(name: "Main", bundle: .main)
        viewController = storyboard?.instantiateViewController(withIdentifier: "Host") as! ViewController
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = viewController;
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        self.ufw?.appController()?.applicationWillResignActive(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.ufw?.appController()?.applicationDidEnterBackground(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.ufw?.appController()?.applicationWillEnterForeground(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.ufw?.appController()?.applicationDidBecomeActive(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.ufw?.appController()?.applicationWillTerminate(application)
    }
    
    // MARK: Unity API
    
    private func getUnityFramework() -> UnityFramework? {
        let bundlePath: String = Bundle.main.bundlePath + "/Frameworks/UnityFramework.framework"
        
        let bundle = Bundle(path: bundlePath )
        if bundle?.isLoaded == false {
            bundle?.load()
        }
        
        let ufw = bundle?.principalClass?.getInstance()
        if ufw?.appController() == nil {
            let machineHeader = UnsafeMutablePointer<MachHeader>.allocate(capacity: 1)
            machineHeader.pointee = _mh_execute_header
            
            ufw!.setExecuteHeader(machineHeader)
        }
        return ufw
    }
    
    func unityIsInitialized( ) -> Bool {
        return (self.ufw != nil && self.ufw?.appController() != nil)
    }
    
    func moveGameScene() {
        if !unityIsInitialized() {
            UnitySampleUtils.showAlert(Constants.ERRORMESSAGES.NOT_INITIALIZED, Constants.ERRORMESSAGES.INIT_FIREST, window: self.window)
        } else {
            self.ufw?.showUnityWindow()
        }
    }
    
    func initUnity() {
        if unityIsInitialized() {
            UnitySampleUtils.showAlert(Constants.ERRORMESSAGES.ALREADY_INIT, Constants.ERRORMESSAGES.UNLOAD_FIREST, window: self.window)
            return
        }
        
        if didQuit {
            UnitySampleUtils.showAlert(Constants.ERRORMESSAGES.CANNOTBE_INITIALIZED, Constants.ERRORMESSAGES.USE_UNLOAD, window: self.window)
            return
        }
        
        ufw = getUnityFramework()
        ufw.setDataBundleId("com.unity3d.framework")
        ufw.register(self)
        NSClassFromString("FrameworkLibAPI")?.registerAPIforNativeCalls(self)
        ufw.runEmbedded(withArgc: CommandLine.argc, argv: CommandLine.unsafeArgv, appLaunchOpts: appLaunchOpts)
        
        attachUnityView()
        
    }
    
    
    func attachUnityView() {
        let view: UIView? = ufw?.appController()?.rootView
        self.unitySampleView = UnityUIView(frame: UIApplication.shared.keyWindow!.frame)
        view?.addSubview(self.unitySampleView)
    }
    
    func unloadButtonTouched(_ sender: UIButton) {
        unloadUnity()
    }
    
    func quitButtonTouched(_ sender: UIButton) {
        if !unityIsInitialized() {
            UnitySampleUtils.showAlert(Constants.ERRORMESSAGES.NOT_INITIALIZED, Constants.ERRORMESSAGES.INIT_FIREST, window: self.window)
        } else {
            getUnityFramework()!.quitApplication(0)
        }
    }
    
    func returnUnity() {
        if didQuit {
            UnitySampleUtils.showAlert(Constants.ERRORMESSAGES.CANNOTBE_INITIALIZED, Constants.ERRORMESSAGES.USE_UNLOAD, window: self.window)
            return
        }
        
        window?.makeKeyAndVisible()
    }
    
    
    private func unloadUnityInternal() {
        self.ufw?.unregisterFrameworkListener(self)
        self.ufw = nil
        window?.makeKeyAndVisible()
    }
    
    private func unloadUnity() {
        if !unityIsInitialized() {
            UnitySampleUtils.showAlert(Constants.ERRORMESSAGES.NOT_INITIALIZED, Constants.ERRORMESSAGES.INIT_FIREST, window: self.window)
            return
        } else {
            getUnityFramework()!.unloadApplication()
        }
    }
    
    func unityDidUnload(_ notification: Notification!) {
        unloadUnityInternal()
        
    }
    
    func unityDidQuit(_ notification: Notification!) {
        unloadUnityInternal()
        self.didQuit = true
    }
    
}
