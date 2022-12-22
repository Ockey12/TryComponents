//
//  ChangeableScaleView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/12/22.
//

import SwiftUI

struct ChangeableScaleView: View {
//    @EnvironmentObject var monitor: BuildFileMonitor
    
//    @State private var importerPresented = false
//    @State private var importType = ImportType.none
    
//    @State private var buildFileURL = FileManager.default.temporaryDirectory
//    @State private var projectDirectoryURL = FileManager.default.temporaryDirectory
    
    @State private var diagramViewSize = CGSize(width: 1000, height: 1000)
    @State private var diagramViewScale: CGFloat = 0.2
    
    let minScale: CGFloat = 0.1
    let maxScale: CGFloat = 0.7
    
    // DiagramView()の周囲の余白
    // .frame()のwidthとheightに加算する
    let diagramViewPadding: CGFloat = 300
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                ScrollView([.vertical, .horizontal]) {
                    ZStack {
                        VStack(spacing: 0) {
                            ForEach(0..<5) { row in
                                VStack(spacing: 0) {
                                    HStack(spacing: 0) {
                                        ForEach(0..<10) { column in
                                            HStack(spacing: 0) {
                                                ZStack {
                                                    Rectangle()
                                                        .frame(width: 1600, height: 1600)
                                                        .background(.green)
                                                    Text("行: \(row), 列: \(column)")
                                                        .font(.system(size: 100))
                                                        .foregroundColor(.black)
                                                } // ZStack
                                                Rectangle()
                                                    .frame(width: 100)
                                                    .foregroundColor(.clear)
                                            } // VStack
                                        } // ForEach(0..<10)
                                    } // HStack
                                    Rectangle()
                                        .frame(height: 100)
                                        .foregroundColor(.clear)
                                } // VStack
                            } // ForEach(0..<5)
                        } // VStack
                        .background(.orange)

//                        ArrowView(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 1600*2 + 100*2, y: 1600*1 + 100*1))
//                        ArrowView(start: CGPoint(x: 1600*4 + 100*4, y: 1600*2 + 100*2), end: CGPoint(x: 1600*2 + 100*1, y: 1600*4 + 100*4))
                        ArrowView(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 1600*4 + 100*4, y: 1600*3 + 100*3))
                        ArrowView(start: CGPoint(x: 1600*10 + 100*9, y: 0), end: CGPoint(x: 1600*6 + 100*5, y: 1600*3 + 100*3))
                        ArrowView(start: CGPoint(x: 0, y: 1600*5 + 100*4), end: CGPoint(x: 1600*4 + 100*3, y: 1600*2 + 100*2))
                        ArrowView(start: CGPoint(x: 1600*10 + 100*9, y: 1600*5 + 100*4), end: CGPoint(x: 1600*6 + 100*5, y: 1600*2 + 100*2))
                    } // ZStack
                    .background() {
                        GeometryReader { geometry in
                            Path { path in
                                let width = geometry.size.width
                                let height = geometry.size.height
                                DispatchQueue.main.async {
                                    self.diagramViewSize = CGSize(width: width + diagramViewPadding, height: height + diagramViewPadding)
                                } // DispatchQueue
                            } // Path
                        } // GeometryReader
                    } // .background()
                    .scaleEffect(diagramViewScale)
                    .frame(width: diagramViewSize.width*diagramViewScale,
                           height: diagramViewSize.height*diagramViewScale)
                    .background(.cyan)
                    
                    
                } // ScrollView
                .background(.white)
            } // GeometryReader
            
            Divider()
            
            HStack {
                Text("拡大率: \(diagramViewScale)")
                    .padding(.leading)
                Slider(value: $diagramViewScale, in: minScale...maxScale)
                    .padding(.trailing)
            }
            .padding()
            
//            HStack {
//                // プロジェクトのディレクトリを選択するボタン
//                Button {
//                    importerPresented = true
//                    importType = .projectDirectory
//                } label: {
//                    Text("Select Project Directory")
//                }
//                .padding()
//
//                // 監視するビルドファイルを選択するボタン
//                Button {
//                    importerPresented = true
//                    importType = .buildFile
//                } label: {
//                    Text("Select Build File")
//                }
//                .padding()
//            } // HStack
//
//            // ビルドファイルとプロジェクトディレクトリのURL、ビルドされた時間を表示する
//            VStack {
//                HStack {
//                    Text("Build File URL: \(buildFileURL)")
//                    Spacer()
//                }
//                HStack {
//                    Text("Project Directory URL: \(projectDirectoryURL)")
//                    Spacer()
//                }
//                HStack {
//                    Text("Change Date: \(monitor.changeDate)")
//                    Spacer()
//                }
//            } // VStack
//            .padding()
        } // VStack
//        .fileImporter(isPresented: $importerPresented, allowedContentTypes: [.directory]) { result in
//            switch result {
//            case .success(let url):
//                switch importType {
//                case .buildFile:
//                    // 監視するビルドファイルを選択するモード
//                    monitor.stopMonitoring()
//                    monitor.buildFileURL = url
//                    monitor.startMonitoring()
//                    buildFileURL = url
//                case .projectDirectory:
//                    // プロジェクトのディレクトリを選択するモード
//                    monitor.projectDirectoryURL = url
//                    projectDirectoryURL = url
//                case .none:
//                    break
//                }
//            case .failure:
//                print("ERROR: Failed fileImporter")
//            }
//        } // .fileImporter
    } // var body
//
//    // fileImporterを開くとき、監視するビルドファイルを選択するのか、プロジェクトのディレクトリを選択するのかを表す
//    private enum ImportType {
//        case buildFile
//        case projectDirectory
//        case none
//    }
}

//struct ChangeableScaleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangeableScaleView()
//    }
//}
