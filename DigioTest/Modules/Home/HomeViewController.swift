//
//  ViewController.swift
//  DigioTest
//
//  Created by Pedro Freddi on 13/01/23.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayContentLoading()
    func displayContent(viewModel: Home.Content.ViewModelSuccess)
    func displayContentFailure(viewModel: Home.Content.ViewModelFailure)
}

class HomeViewController: UIViewController, HomeDisplayLogic {

    // MARK: - IBOutlets

    @IBOutlet var tableview: UITableView!

    // MARK: - Properties

    var interactor: HomeBusinessLogic?
    var banners: [[Banner]] = []

    // MARK: - Lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        interactor?.requestHomeContent()
    }

    // MARK: - Setup

    private func setup() {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let worker = HomeWorker()

        self.interactor = interactor
        presenter.viewController = self
        interactor.presenter = presenter
        interactor.homeWorker = worker
    }

    private func setupTableView() {
        tableview.register(BannerGalleryCell.self, forCellReuseIdentifier: "HorizontalBannerCell")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
    }

    // MARK: - HomeDisplayLogic implementation

    func displayContent(viewModel: Home.Content.ViewModelSuccess) {
        banners = viewModel.banners
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }

    func displayContentFailure(viewModel: Home.Content.ViewModelFailure) {
        // TODO: Implement it
        print("Error: ", viewModel.errorMessage)
    }
    
    func displayContentLoading() {
        // TODO: Implement it
        print("Loading...")
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banners.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableview.dequeueReusableCell(withIdentifier: "HorizontalBannerCell", for: indexPath) as? BannerGalleryCell else { return UITableViewCell() }
        cell.content = banners[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // call interactor
        return nil
    }
}
