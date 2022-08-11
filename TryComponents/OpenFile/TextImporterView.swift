//
//  TextImporterView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/08/07.
//

// URLでパスを扱うときに便利なプロパティとメソッド  https://qiita.com/toshi586014/items/52b87c034e411681ca7b


// 指定したディレクトリ下にあるSwiftファイルのパスをURL型で配列に格納する
// 配列の0番目のSwiftファイルのソースコードを表示する
import SwiftUI
import UniformTypeIdentifiers

struct TextImporterView: View {
    
    @State private var image: NSImage? = nil
    @State private var importerPresented = false
    @State private var contents: String = ""
    
    var body: some View {
        VStack {
            
            ScrollView {
                Text(contents)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(minWidth: 650, maxWidth: .infinity, minHeight: 650, maxHeight: .infinity)
            
            Button {
                importerPresented = true
            } label: {
                Text("Open")
            }
            .padding()
            
        }// VStack
        .frame(minWidth: 700, maxWidth: .infinity, minHeight: 700, maxHeight: .infinity)
        .fileImporter(isPresented: $importerPresented, allowedContentTypes: [.directory]) { result in
            switch result {
            // urlは開いたディレクトリのURL
            case .success(let url):
                print(url)
                print("-------------------------------------------")
                
                let fileManager = FileManager()
                let resourceKeys = Set<URLResourceKey>([.nameKey, .isDirectoryKey])
                let directoryEnumerator = fileManager.enumerator(at: url, includingPropertiesForKeys: Array(resourceKeys), options: .skipsHiddenFiles)!
                
                var fileURLs: [URL] = []
                // directoryEnumeratorのうち、URLにキャストできるものをfileURLとして取り出す
                for case let fileURL as URL in directoryEnumerator {
                    guard let resourceValues = try? fileURL.resourceValues(forKeys: resourceKeys),
                          let isDirectory = resourceValues.isDirectory,
                          let name = resourceValues.name
                    else {
                        continue
                    }
                    
                    // 拡張子が"Swift"の場合だけ配列に追加する
                    if fileURL.pathExtension == "swift" {
                        fileURLs.append(fileURL)
                    }
                }
                
                for url in fileURLs {
                    print(url)
                    print(url.pathExtension) // 拡張子を表示
                    print("-------------------------------------------")
                }
                
                guard let fileContents = try? String(contentsOf: fileURLs[0]) else {
                    fatalError("failed to load contents")
                }
                print(fileContents)
                contents = fileContents
            case .failure:
                print("failure")
            }
        }// .fileImporter
    }// body
}

struct TextImporterView_Previews: PreviewProvider {
    static var previews: some View {
        TextImporterView()
    }
}
