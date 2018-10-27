//
//  CameraController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 26/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {
	
	
	
	// MARK: - Properties
	let captureOutput = AVCapturePhotoOutput()
	
	let captureButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(#imageLiteral(resourceName: "capture_photo"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.addTarget(self, action: #selector(onCaptureButtonPress), for: .touchUpInside)
		return button
	}()
	
	let dismissButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(#imageLiteral(resourceName: "right_arrow_shadow"), for: .normal)
		button.addTarget(self, action: #selector(onDismissButtonPress), for: .touchUpInside)
		return button
	}()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		transitioningDelegate = self
		setupCaptureSession()
		setupViews()
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	
	
	// MARK: - Events
	@objc private func onCaptureButtonPress() {
		let settings = AVCapturePhotoSettings()
		captureOutput.capturePhoto(with: settings, delegate: self)
	}
	
	@objc private func onDismissButtonPress() {
		dismiss(animated: true, completion: nil)
	}
	
	
	
	// MARK: - Functions
	private func setupCaptureSession() {
		let captureSession = AVCaptureSession()
		
		// 1. setup inputs2
		guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
		do {
			let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
			if captureSession.canAddInput(captureDeviceInput) {
				captureSession.addInput(captureDeviceInput)
			}
		} catch let error {
			print("Could not setup capture device input:", error)
			return
		}
		
		
		// 2. setup outputs
		if captureSession.canAddOutput(captureOutput) {
			captureSession.addOutput(captureOutput)
		}
		
		
		// 3. setup output preview
		let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		previewLayer.frame = view.frame
		previewLayer.videoGravity = .resizeAspectFill
		
		view.layer.addSublayer(previewLayer)
		captureSession.startRunning()
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		view.backgroundColor = .white
		setupCaptureButton()
		setupDismissButton()
	}
	
	private func setupCaptureButton() {
		view.addSubview(captureButton)
		captureButton.anchor(centerX: view.centerXAnchor)
		captureButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, equalTo: 20)
		captureButton.anchor(width: 80)
		captureButton.anchor(height: 80)
		captureButton.imageView?.anchor(width: 80)
		captureButton.imageView?.anchor(height: 80)
	}
	
	private func setupDismissButton() {
		view.addSubview(dismissButton)
		dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, equalTo: 12)
		dismissButton.anchor(right: view.rightAnchor, equalTo: 20)
		dismissButton.anchor(width: 50)
		dismissButton.anchor(height: 50)
	}
}




// MARK: - Extension: AVCapturePhotoCaptureDelegate
extension CameraController: AVCapturePhotoCaptureDelegate {
	func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
		guard let imageData = photo.fileDataRepresentation() else { return }
		
		let photoPreviewContainer = PhotoPreviewContainer()
		photoPreviewContainer.photoImageView.image = UIImage(data: imageData)
		
		view.addSubview(photoPreviewContainer)
		photoPreviewContainer.anchor(top: view.topAnchor, equalTo: 0)
		photoPreviewContainer.anchor(bottom: view.bottomAnchor, equalTo: 0)
		photoPreviewContainer.anchor(left: view.leftAnchor, equalTo: 0)
		photoPreviewContainer.anchor(right: view.rightAnchor, equalTo: 0)
	}
}



// MARK: - Extension: UIViewControllerTransitioningDelegate
extension CameraController: UIViewControllerTransitioningDelegate {
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return PresentCameraAnimation()
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return DismissCameraAnimation()
	}
}
