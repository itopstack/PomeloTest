//
//  ArticleCellContentView.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 25/2/2565 BE.
//

import SwiftUI

struct ArticleCellContentView: View {
    let viewModel: ViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: viewModel.thumbnailImageUrl) { image in
                image
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75, height: 75)
            
            VStack(alignment: .leading, spacing: 16) {
                Text(viewModel.title)
                    .font(.headline)
                Text(viewModel.subtitle)
                    .font(.subheadline)
                
                HStack {
                    Spacer()
                    Text(viewModel.updatedDate)
                        .font(.footnote)
                        .italic()
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct ArticleCellContentView_Previews: PreviewProvider {
    
    static let mockArticle: Article = Article(
        url: "https://www.nytimes.com/2022/02/20/your-money/bernie-madoff-sister-dead.html",
        id: 100000008220223,
        publishedDate: "2022-02-20",
        updatedDate: "2022-02-21 22:57:50",
        section: "Your Money",
        title: "Bernie Madoff’s Sister and Her Husband Are Found Dead in Florida",
        abstract: "The authorities said it appeared to be a murder-suicide.",
        medias: [Media(photos: [Photo(url: "https://static01.nyt.com/images/2022/02/20/multimedia/20madoff/20madoff-thumbStandard.jpg")], caption: "President Vladimir V. Putin of Russia meeting with President Donald J. Trump in June 2019.")],
        source: "New York Times"
    )
    
    static var previews: some View {
        ArticleCellContentView(viewModel: ArticleCellContentView.ViewModel(article: mockArticle))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
