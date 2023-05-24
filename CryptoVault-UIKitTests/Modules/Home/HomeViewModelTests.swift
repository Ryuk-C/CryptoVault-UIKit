//
//  HomeViewModelTests.swift
//  CryptoVault-UIKitTests
//
//  Created by Cuma on 24/05/2023.
//

@testable import CryptoVault_UIKit
import XCTest

final class HomeViewModelTests: XCTestCase {
    
    private var viewModel: HomeViewModel!
    private var view: MockViewController!
    private var service: MockService!
    
    override func setUp() {
        super.setUp()
        view = .init()
        service = .init()
        viewModel = .init(view: view, service: service)
    }
    
    override func tearDown() {
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {

        XCTAssertFalse(view.invokedConfigureVC)
        XCTAssertFalse(service.invokedFetchMarketList)
        XCTAssertFalse(view.invokedConfigureCollectionView)

        viewModel.viewDidLoad()

        XCTAssertEqual(view.invokedConfigureVCCount, 1)
        XCTAssertEqual(service.invokedFetchMarketListCount, 1)
        XCTAssertEqual(view.invokedConfigureCollectionViewCount, 1)
    }
    
    func test_loadingInvokesRequiredMethods() {
        
        XCTAssertFalse(view.invokedSetLoading)
        
        viewModel.fetchCryptoList()
        
        XCTAssertEqual(view.invokedSetLoadingCount, 1)
        
    }
    
    func test_navigateToDetailInvokesRequiredMethods() {
        
        XCTAssertTrue(view.invokedNavigateToDetailScreenParametersList.isEmpty)
        
        viewModel.navigateToDetail(id: "1", pageTitle: "1", price: "1")
        
        XCTAssertEqual(
            view.invokedNavigateToDetailScreenParametersList
            .map {
                ($0.id, $0.pageTitle, $0.price) == ("1", "1", "1")
            },
            [true]
        )
    }
}
