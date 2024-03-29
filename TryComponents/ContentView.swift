//
//  ContentView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/08/05.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
//        StructHolderToTextConverterView()
//            .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 1000, maxHeight: .infinity)
//        ScrollView {
//            VStack {
//                StructHolderToTextConverterView()
//                    .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 1000, maxHeight: .infinity)
//
//                Divider()
//
//                SyntaxArrayParserView()
//                    .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 1000, maxHeight: .infinity)
//
//                Divider()
//
//                TokenVisitorView()
//                    .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 1000, maxHeight: .infinity)
//
//                Divider()
//
//                AstVisitorView()
//                    .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 1000, maxHeight: .infinity)
//            }
//        }
//        ChangelableScaleTypeView()
//        ScrollView {
//            TypeView()
//                .scaleEffect(0.5)
//                .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 1000, maxHeight: .infinity)
//                .background(.gray)
//        }
//        SwiftASTView()
//        StringVisitorView()
//            .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 1000, maxHeight: .infinity)
        
//        GetTextWidthView()
//        GetTextWidthParentView()
        ChangeableScaleView()
    } // body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
