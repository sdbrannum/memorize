//
//  Grid.swift
//  Memorize
//
//  Created by Steven Brannum on 7/4/20.
//  Copyright © 2020 Steven Brannum. All rights reserved.
//

import SwiftUI

struct Grid<TItem, TItemView>: View where TItem: Identifiable, TItemView: View {
    private var items: [TItem]
    private var viewForItem: (TItem) -> TItemView
  
    init(_ items: [TItem], viewForItem: @escaping (TItem) -> TItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
     
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item: TItem, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}
//
//struct Grid_Previews: PreviewProvider {
//    static var previews: some View {
//        Grid()
//    }
//}

