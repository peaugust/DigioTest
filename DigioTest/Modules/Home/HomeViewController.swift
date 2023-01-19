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
    func navigateToScreen(_ banner: Banner)
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
        let router = HomeRouter()

        self.interactor = interactor
        router.navigationViewController = self.navigationController
        presenter.viewController = self
        presenter.router = router
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
    
    func navigateToScreen(_ banner: Banner) {
        self.interactor?.navigateToScreen(banner)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableview.dequeueReusableCell(withIdentifier: "HorizontalBannerCell", for: indexPath) as? BannerGalleryCell else { return UITableViewCell() }
        cell.setup(banners[indexPath.section], cellType: HomeBanner(rawValue: indexPath.section)!)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = HomeBanner(rawValue: indexPath.section) else { return 0 }
        return cellType.getRowHeight()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return banners.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let cellType = HomeBanner(rawValue: section) else { return 0 }

        switch cellType {
        case .spotlight:
            return 0
        case .cash:
            return 20
        case .products:
            return 30
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cellType = HomeBanner(rawValue: section) else { return nil }
        
        // TODO: Review it before send
        switch cellType {
        case .spotlight:
            let view = UIView(frame: .zero)
            view.backgroundColor = .clear
            view.isUserInteractionEnabled = false
            return view
        case .cash:
            let label = UILabel()
            label.text = "digio Cash"
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            return view
        case .products:
            let label = UILabel()
            label.text = "Produtos"
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            return view
        }
    }
}
