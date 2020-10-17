//
//  ListViewModelType.swift
//  GenericSwiftUI
//
//  Created by 0x6c on 10/17/20.
//  Copyright © 2020 0x6c. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

protocol ListObjectType : Codable, Identifiable {
    
}

protocol ListCellType : View {
    associatedtype ObjectType : ListObjectType
    var object : ObjectType { get }
    
    init(object: ObjectType)
}

protocol ListViewModelType : ObservableObject {
    associatedtype ObjectCell : ListCellType

    var objects: [ObjectCell.ObjectType] { get set }
    var isLoading : Bool { get set }
    var alert : String { get set }
    
    func getObjects()
    
}

struct GenericTableView<T: ListViewModelType> : View {
    
    @ObservedObject var viewModel : T
    @State var showAlert = false
    
    var body: some View {
        ZStack{
                if(viewModel.isLoading){
                    LoadingView()
                        .animation(.easeIn, value: true)
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .zIndex(1)
                }
                else if(viewModel.alert != ""){
                    EmptyDataView(text: "Error: " +  viewModel.alert + "\n Try Again Later").onAppear {
                        showAlert = true
                    }
                }
                else if(viewModel.objects.isEmpty){
                    EmptyDataView(text: "No data found.")
                }
                else{
                    List(viewModel.objects) { object in
                        T.ObjectCell(object: object)
                    }
                }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.viewModel.getObjects()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alert), dismissButton: .default(Text("Got it!")))
        }
    }
    
}
