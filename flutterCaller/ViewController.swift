import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private let urls: [String] = ["ourApp://some.domain.com",
                                  "ourApp://something",
                                  "ourApp:// wrongURL",
                                  "ourApp://"]
    
    private func openApp(urlIndex: Int) {
        guard let url = URL(string: urls[urlIndex]) else {
            showAlert("We can not create the URL.")
            return
        }
        guard UIApplication.shared.canOpenURL(url) else {
            showAlert("We can not open the URL.")
            return
        }
        UIApplication.shared.open(url,
                                  options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: "ddd"]) { suc in
            print(suc)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.detailTextLabel?.text = urls[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openApp(urlIndex: indexPath.row)
    }
}

extension ViewController {
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
}
