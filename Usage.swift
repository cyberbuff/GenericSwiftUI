//
//  Usage.swift
//  GenericSwiftUI
//
//  Created by 0x6c on 10/17/20.
//  Copyright © 2020 0x6c. All rights reserved.
//

import Combine
import SwiftUI

struct TestCell : ListCellType {
    typealias ObjectType = TestObject
    
    var object: TestObject

    var body: some View {
        Text(object.name)
    }

}

struct TestObject: ListObjectType {
    var id = UUID()
    var name = "Hello World!"
}

class TestViewModel: ListViewModelType {
    
    typealias ObjectCell = TestCell
    
    @Published var objects: [TestObject] = []
    @Published var isLoading = true
    @Published var alert : String = ""
    
    func getObjects() {
        APIClient.getData{ (result) in
            self.isLoading = false
            switch result{
                case .success(let objects):
                    self.objects = objects
                case .failure(let error):
                    print(error)
                    self.alert = error
            }
        }
    }

}

struct TestView : View {
    var body: some View{
        GenericTableView<TestViewModel>(viewModel: TestViewModel())
    }
}