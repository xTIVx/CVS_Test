//
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/23/24.
//

import SwiftUI
import Combine

struct PostListView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var viewModel: PostListViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.posts, id: \.id) { post in
                        PostItem(post: post)
                            .onTapGesture {
                                coordinator.push(.postDetails(post))
                            }
                    }
                }
                .padding()
            }
            
            ProgressView(label: { Text("Loading") })
                .onlyIf(viewModel.isLoading)
        }
        .navigationTitle("Posts")
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: viewModel.searchText) { oldValue, newValue in
            viewModel.updateSearch()
        }
    }
}

extension PostListView {
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 2)
    }
}

#Preview {
    PostListView(viewModel: .init(flickrService: FlickrWebService.shared))
}
