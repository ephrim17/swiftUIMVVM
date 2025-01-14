//
//  ImagePicker.swift
//  SwiftMVVM
//
//  Created by Ephrim Daniel on 14/01/25.
//

import SwiftUI

struct ImagePicker: View {
    
    @State private var image : Image?
    @State private var inputImage : UIImage?
    
    @State private var isPresentable : Bool = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            Button ("select Image") {
                isPresentable = true
            }
        }.sheet(isPresented: $isPresentable, content: {
            ImagePickerVC(image: $inputImage)
        })
        .onChange(of: inputImage) {
            loadImage()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

#Preview {
    ImagePicker()
}
