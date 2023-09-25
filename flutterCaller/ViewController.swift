import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView?
    
    private let urls: [String] = ["ourApp://",
                                  "ourApp://some.domain.com",
                                  "ourApp://some.domain.com/",
                                  "ourApp://some.domain.com/home",
                                  "ourApp://some.domain.com/history",
                                  "ourApp://some.domain.com/details",
                                  "ourApp://some.domain.com/home/details",
                                  "ourApp://some.domain.com/history/details",
                                  "ourApp://home",
                                  "ourApp://history",
                                  "ourApp://something",
                                  "ourApp:// wrongURL"]
    
    private func openApp(urlIndex: Int) {
        guard let url = URL(string: urls[urlIndex]) else {
            showAlert("We can not create the URL.")
            return
        }
        guard UIApplication.shared.canOpenURL(url) else {
            showAlert("We can not open the URL.")
            return
        }
        UIApplication.shared.open(url, options: [:]) { print($0) }
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
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
