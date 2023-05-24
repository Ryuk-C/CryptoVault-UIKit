//
//  CryptoDetailViewModel.swift
//  CryptoVault-UIKitTests
//
//  Created by Cuma on 24/05/2023.
//

@testable import CryptoVault_UIKit
import XCTest

final class CryptoDetailViewModelTests: XCTestCase {
    
    private var viewModel: CryptoDetailViewModel!
    private var view: MockCryptoDetailScreen!
    private var service: MockService!
    
    override func setUp() {
        view = .init()
        service = .init()
        viewModel = .init(view: view, service: service)
    }
    
    override func tearDown() {
        view = nil
        service = nil
        viewModel = nil
    }
    
    func test_viewDidLoadInvokesRequiredMethods() {
        XCTAssertFalse(view.invokedConfigureVC)
        XCTAssertFalse(service.invokedFetchCryptoDetail)
        
        viewModel.viewDidLoad(id: "1")
        
        XCTAssertEqual(view.invokedConfigureVCCount, 1)
        XCTAssertEqual(service.invokedFetchCryptoDetailCount, 1)
        
    }
    
    func test_fetchDetailInvokesRequiredMethods() {
        
        XCTAssertFalse(view.invokedSetLoading)
        XCTAssertFalse(service.invokedFetchCryptoDetail)

        viewModel.fetchDetail(id: "1")
        
        XCTAssertEqual(view.invokedSetLoadingCount, 1)
        XCTAssertEqual(service.invokedFetchCryptoDetailCount, 1)
        
    }
}
