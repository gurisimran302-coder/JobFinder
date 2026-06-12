//
//  JobListViewControllerV.swift
//  JobFinder
//
//  Created by Gursimran Singh on 11/06/26.
//

import UIKit

final class JobListViewController: UIViewController {
    
    private let viewModel: JobListViewModel
    
    private let tableView = UITableView()
    
    private let activityIndicator =
    UIActivityIndicatorView(style: .large)
    
    private let emptyLabel = UILabel()
    
    private let searchController =
    UISearchController()
    
    init(viewModel: JobListViewModel) {
        
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = AppConstants.NavigationTitles.jobs
        
        view.backgroundColor = .systemBackground
        
        setupTableView()
        
        setupSearch()
        
        setupViews()
        
        bindViewModel()
        
        Task {
            await viewModel.fetchJobs()
        }
    }
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        
        tableView.pinToSafeArea(of: view)
        
        tableView.register(
            JobCell.self,
            forCellReuseIdentifier: JobCell.identifier
        )
        
        tableView.dataSource = self
        
        tableView.delegate = self
    }
    
    private func setupSearch() {
        
        searchController.searchResultsUpdater = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder =
        AppConstants.Search.placeholder
        
        navigationItem.searchController =
        searchController
        
        definesPresentationContext = true
    }
    
    private func setupViews() {
                
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emptyLabel.text = AppConstants.Messages.noJobsFound
        
        emptyLabel.textAlignment = .center
        
        emptyLabel.isHidden = true
        
        view.addSubview(activityIndicator)
        
        view.addSubview(emptyLabel)
        
        activityIndicator.centerInSuperview()
        
        emptyLabel.centerInSuperview()
        
    }
    
    private func bindViewModel() {
        
        viewModel.onStateChange = { [weak self] state in
            
            guard let self = self else { return }
            
            switch state {
                
            case .loading:
                
                self.activityIndicator.startAnimating()
                
                self.emptyLabel.isHidden = true
                
            case .loaded:
                
                self.activityIndicator.stopAnimating()
                
                self.emptyLabel.isHidden = true
                
                self.tableView.reloadData()
                
            case .empty:
                
                self.activityIndicator.stopAnimating()
                
                self.emptyLabel.isHidden = false
                
                self.tableView.reloadData()
                
            case .error(let message):
                
                self.activityIndicator.stopAnimating()
                
                self.showError(message)
                
            default:
                break
            }
        }
    }
    
    private func showError(_ message: String) {
        
        let alert = UIAlertController(
            title: AppConstants.Messages.errorTitle,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: AppConstants.Messages.ok,
                style: .default
            )
        )
        
        present(alert, animated: true)
    }
}

extension JobListViewController:
    UITableViewDataSource,
    UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        
        viewModel.filteredJobs.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: JobCell.identifier,
            for: indexPath
        ) as! JobCell
        
        cell.configure(
            with: viewModel.filteredJobs[indexPath.row]
        )
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        
        let job = viewModel.filteredJobs[indexPath.row]
        
        let detailVM =
        JobDetailViewModel(job: job)
        
        let vc =
        JobDetailViewController(
            viewModel: detailVM
        )
        
        navigationController?
            .pushViewController(
                vc,
                animated: true
            )
    }
}

extension JobListViewController:
UISearchResultsUpdating {

    func updateSearchResults(
        for searchController: UISearchController
    ) {

        viewModel.search(
            text: searchController
                .searchBar
                .text ?? ""
        )
    }
}
