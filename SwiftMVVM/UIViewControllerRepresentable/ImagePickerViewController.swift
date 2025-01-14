//
//  ImagePickerViewController.swift
//  SwiftMVVM
//
//  Created by Ephrim Daniel on 14/01/25.
//

import PhotosUI
import SwiftUI

struct ImagePickerVC: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePickerVC
        
        init(_ parent: ImagePickerVC) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass:  UIImage.self) { image, _ in
                    //parent we are initialising from stuct which is ImagePickerVC
                    //and now after picking image we are now sending back the image
                    //using its own property which is here image
                    self.parent.image = image as? UIImage
                }
            }
        }
        
        
    }
    
   
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}
