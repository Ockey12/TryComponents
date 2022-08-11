//
//  FileImporter().swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/08/05.
//
// 参考Webサイト
// https://genjiapp.com/blog/2021/09/06/swiftui-open-file.html

import SwiftUI
import UniformTypeIdentifiers

struct FileImporterView: View {
    
    @State private var image: NSImage? = nil
    @State private var importerPresented = false
    @State private var isDropTargeted = false
    
    var body: some View {
        VStack {
            if isDropTargeted {
                ZStack {
                    Rectangle()
                        .fill(Color(.windowBackgroundColor))
                        .opacity(0.8)
                        .frame(width: 500, height: 500)
                    
                    Text("Drop Here")
                        .font(.system(size: 64).bold())
                }
            } else {
                Image(nsImage: image ?? NSImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500)
            }
            
            Button {
                importerPresented = true
            } label: {
                Text("Open")
            }
            .padding()
            
        }// VStack
        .frame(width: 500, height: 550)
        .fileImporter(isPresented: $importerPresented, allowedContentTypes: [.png, .jpeg]) { result in
            switch result {
            case .success(let url):
                print(url)
                guard let newImage = NSImage(contentsOf: url) else { return }
                image = newImage
            case .failure:
                print("failure")
            }
        }// .fileImporter
        .onDrop(of: [.png, .jpeg, .url,.fileURL], isTargeted: $isDropTargeted) { providers in
            guard let provider = providers.first else { return false }
            
            if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil) { data, error in
                    guard let imageData = data as? Data,
                          let newImage = NSImage(data: imageData) else { return }
                    image = newImage
                }
            } else if provider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) { data, error in
                    guard let urlData = data as? Data,
                          let url = URL(dataRepresentation: urlData, relativeTo: nil),
                          let newImage = NSImage(contentsOf: url) else { return }
                    image = newImage
                }
            }
            
            return true
        }// onDrop
    }// body
}// FileImporterView

struct FileImporterView_Previews: PreviewProvider {
    static var previews: some View {
        FileImporterView()
    }
}
