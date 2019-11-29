//
//  ContentView.swift
//  Instafilter
//
//  Created by Angel Vázquez on 23/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    
    @State private var showingErrorAlert = false
    @State private var errorAlertTitle = ""
    @State private var errorAlertMessage = ""
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        let radius = Binding<Double>(
            get: {
                return self.filterRadius
            },
            set: { newRadius in
                self.filterRadius = newRadius
                self.applyProcessing()
            }
        )
        
        let scale = Binding<Double>(
            get: {
                return self.filterScale
            },
            set: { newScale in
                self.filterScale = newScale
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.top)
                
                HStack {
                    Text("Scale")
                    Slider(value: scale)
                }
                
                HStack {
                    Text("Radius")
                    Slider(value: radius)
                }.padding(.bottom)
                
                HStack {
                    Button("Filter: \(transformFilterName(currentFilter.name))") {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            self.showError(title: "Error", message: "Please select an image first.")
                            return
                        }

                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success!")
                        }

                        imageSaver.errorHandler = {
                            self.showError(title: "Error", message: "An error ocurred: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
        }
        .padding([.horizontal, .bottom])
        .navigationBarTitle("Instafilter")
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
        .actionSheet(isPresented: $showingFilterSheet) {
            ActionSheet(title: Text("Select a filter"), buttons: [
                .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                .default(Text("Gloom")) { self.setFilter(CIFilter.gloom()) },
                .cancel()
            ])
        }
        .alert(isPresented: $showingErrorAlert) {
            Alert(title: Text(errorAlertTitle),
                  message: Text(errorAlertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func showError(title: String, message: String) {
        showingErrorAlert = true
        errorAlertTitle = title
        errorAlertMessage = message
    }
    
    func transformFilterName(_ name: String) -> String {
        let tempName = name.replacingOccurrences(of: "CI", with: "")
        let finalName = tempName.reduce("") { result, character -> String in
            if character.isUppercase {
                return result + " " + String(character)
            } else {
                return result + String(character)
            }
        }
        return finalName.trimmingCharacters(in: .whitespaces)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
