//
//  QuotesViewController.swift
//  quotesApp
//
//  Created by Кирилл Елсуфьев on 20.12.2022.
//

import UIKit
import SnapKit
import Starscream

class QuotesViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: QuotesViewModel
    var socket: WebSocket?
    
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.isMultipleTouchEnabled = true
        
        tableView.register(QuotesTableViewCell.self, forCellReuseIdentifier: String(describing: QuotesTableViewCell.self))
        
        return tableView
    }()
    
    // MARK: - Initializers
    
    init(viewModel: QuotesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        viewModel = QuotesViewModel()
        super.init(coder: coder)
    }
    
    deinit {
        socket?.disconnect()
        socket?.delegate = nil
    }
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupSocket()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        socket?.onEvent = { event in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private methods
    private func setupSocket() {
        viewModel.setupTimeoutInterval()
        socket = WebSocket(request: viewModel.request)
        socket?.delegate = self
        socket?.connect()
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - Extensions
extension QuotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuotesTableViewCell.self))
                as? QuotesTableViewCell else { fatalError("fatal Error cell cannot be inited") }
        let model = viewModel.quote[indexPath.row]
        
        let data = QuotesModel(name: model.c, descLastActive: (model.ltr, model.name), changingPercantage: model.chg, changingLastDeal: (model.ltp, model.pcp))
        
        cell.update(model: data)
        return cell
    }
    
}

extension QuotesViewController: WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        switch event {
        case .connected(let headers):
            viewModel.isConnected = true
            print("websocket is connected: \(headers)")
            DispatchQueue.global().async {
                guard let socket = self.socket else { return }
                self.websocketDidConnect(socket)
            }
        case .disconnected(let reason, let code):
            viewModel.isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            guard let socket = self.socket else { return }
            self.tableView.reloadData()
            self.websocketDidReceiveMessage(socket, text: string)
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_), .pong(_), .viabilityChanged(_), .reconnectSuggested(_):
            break
        case .cancelled, .error(_):
            viewModel.isConnected = false
        }
    }
    
    
    func websocketDidConnect(_ socket: Starscream.WebSocket) {
        let array = QuotesType.allCases.map {  $0.rawValue }
        let message = "[\"realtimeQuotes\", \(array)]"
        let quoteMessage = "[\"quotes\", \(array)]"
        socket.write(string: message)
        socket.write(string: quoteMessage)
    }
    
    func websocketDidReceiveMessage(_ socket: Starscream.WebSocket, text: String) {
        DispatchQueue.main.async {
            self.viewModel.updateQuotes(text: text)
            self.tableView.reloadData()
        }
    }
    
}
