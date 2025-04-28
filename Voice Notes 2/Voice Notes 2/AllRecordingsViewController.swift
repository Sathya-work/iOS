import UIKit
import AVFoundation

class AllRecordingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate {
    
    
    @IBOutlet weak var recordingsTableView: UITableView!
    
    private var recordings: [Recording] = []
    var audioPlayer: AVAudioPlayer?
    var currentlyPlayingIndex: IndexPath?
    var isPaused: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingsTableView.dataSource = self
        recordingsTableView.delegate = self
        recordingsTableView.showsVerticalScrollIndicator = true
        recordingsTableView.isScrollEnabled = true
        loadRecordings()
    }
    
    private func loadRecordings() {
        recordings.removeAll()
        let documentPath = getDocumentsDirectory()
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentPath, includingPropertiesForKeys: [.creationDateKey], options: [])
            let audioFiles = directoryContents.filter { $0.pathExtension == "m4a" }
            for fileURL in audioFiles {
                let attributes = try FileManager.default.attributesOfItem(atPath: fileURL.path)
                let creationDate = attributes[.creationDate] as? Date ?? Date()
                let fileName = fileURL.deletingPathExtension().lastPathComponent
                let customName = UserDefaults.standard.string(forKey: "customName_\(fileName)") ?? fileName
                let isFavorite = UserDefaults.standard.bool(forKey: "favorite_\(fileURL.lastPathComponent)")
                let recording = Recording(url: fileURL, date: creationDate, customName: customName, isFavorite: isFavorite)
                recordings.append(recording)
            }
            recordings.sort { $0.date > $1.date }
            recordingsTableView.reloadData()
        } catch {
            showAlert(title: "Error", message: "Could not load recordings: \(error.localizedDescription)")
        }
    }
    
    private func deleteRecording(at index: Int) {
        let recording = recordings[index]
        do {
            try FileManager.default.removeItem(at: recording.url)
            let fileName = recording.url.deletingPathExtension().lastPathComponent
            UserDefaults.standard.removeObject(forKey: "customName_\(fileName)")
            UserDefaults.standard.removeObject(forKey: "favorite_\(recording.url.lastPathComponent)")
            recordings.remove(at: index)
            recordingsTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        } catch {
            showAlert(title: "Delete Error", message: error.localizedDescription)
        }
    }
    
    private func renameRecording(at index: Int) {
        let recording = recordings[index]
        let fileName = recording.url.deletingPathExtension().lastPathComponent
        let alert = UIAlertController(title: "Rename Recording", message: "Enter a new name", preferredStyle: .alert)
        alert.addTextField { $0.text = recording.customName }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self = self, let newName = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines), !newName.isEmpty else { return }
            let existing = self.recordings.contains { $0.customName.lowercased() == newName.lowercased() && $0.url != recording.url }
            if existing {
                self.showAlert(title: "Duplicate Name", message: "A recording with that name already exists.")
                return
            }
            UserDefaults.standard.set(newName, forKey: "customName_\(fileName)")
            self.recordings[index].customName = newName
            self.recordingsTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        })
        present(alert, animated: true)
    }
    
    private func toggleFavorite(at index: Int) {
        recordings[index].isFavorite.toggle()
        let key = "favorite_\(recordings[index].url.lastPathComponent)"
        UserDefaults.standard.set(recordings[index].isFavorite, forKey: key)
        recordingsTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    private func playRecording(at url: URL, indexPath: IndexPath) {
        do {
            if currentlyPlayingIndex == indexPath {
                if isPaused {
                    audioPlayer?.play()
                    isPaused = false
                    recordings[indexPath.row].isPlaying = true
                    recordings[indexPath.row].isPaused = false
                } else {
                    audioPlayer?.pause()
                    isPaused = true
                    recordings[indexPath.row].isPlaying = false
                    recordings[indexPath.row].isPaused = true
                }
            } else {
                audioPlayer?.stop()
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.delegate = self
                audioPlayer?.play()
                currentlyPlayingIndex = indexPath
                isPaused = false
                for i in recordings.indices {
                    recordings[i].isPlaying = false
                    recordings[i].isPaused = false
                }
                recordings[indexPath.row].isPlaying = true
            }
            recordingsTableView.reloadData()
        } catch {
            showAlert(title: "Playback Error", message: error.localizedDescription)
        }
    }
    
    private func scheduleReminder(for recording: Recording) {
        let alert = UIAlertController(title: "Set Reminder", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 50, width: 270, height: 100)
        
        alert.view.addSubview(datePicker)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Set", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let selectedDate = datePicker.date
            self.createNotification(for: recording, at: selectedDate)
            self.showToast(message: "✅ Reminder scheduled for \(DateFormatter.localizedString(from: selectedDate, dateStyle: .short, timeStyle: .short))")
        })
        
        present(alert, animated: true)
    }
    
    private func createNotification(for recording: Recording, at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Voice Note Reminder"
        content.body = "Reminder for note: \(recording.customName)"
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("📛 Reminder scheduling failed: \(error.localizedDescription)")
            } else {
                print("✅ Reminder scheduled for \(date)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordingCell", for: indexPath)
        let recording = recordings[indexPath.row]
        cell.textLabel?.text = recording.customName
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: recording.date, dateStyle: .short, timeStyle: .short)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recording = recordings[indexPath.row]
        playRecording(at: recording.url, indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { [weak self] _, _, completion in
            self?.toggleFavorite(at: indexPath.row)
            completion(true)
        }
        favoriteAction.image = UIImage(systemName: recordings[indexPath.row].isFavorite ? "heart.fill" : "heart")
        favoriteAction.backgroundColor = .systemBlue
        
        let renameAction = UIContextualAction(style: .normal, title: "Rename") { [weak self] _, _, completion in
            self?.renameRecording(at: indexPath.row)
            completion(true)
        }
        renameAction.backgroundColor = .systemGray4
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.deleteRecording(at: indexPath.row)
            completion(true)
        }
        
        let reminderAction = UIContextualAction(style: .normal, title: "Reminder") { [weak self] _, _, completion in
            guard let self = self else { return }
            self.scheduleReminder(for: self.recordings[indexPath.row])
            completion(true)
        }
        reminderAction.backgroundColor = .systemIndigo
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, renameAction, favoriteAction, reminderAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let recording = recordings[indexPath.row]
        let playPauseAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            guard let self = self else { return }
            self.playRecording(at: recording.url, indexPath: indexPath)
            completion(true)
        }
        
        if recording.isPlaying && !recording.isPaused {
            playPauseAction.title = "Pause"
            playPauseAction.image = UIImage(systemName: "pause.fill")
            playPauseAction.backgroundColor = .systemOrange
        } else {
            playPauseAction.title = "Play"
            playPauseAction.image = UIImage(systemName: "play.fill")
            playPauseAction.backgroundColor = .systemGreen
        }
        
        let config = UISwipeActionsConfiguration(actions: [playPauseAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        toastLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let textSize = toastLabel.intrinsicContentSize
        let padding: CGFloat = 16
        let labelWidth = min(view.frame.width - 2 * padding, textSize.width + 40)
        let labelHeight = textSize.height + 20
        
        toastLabel.frame = CGRect(x: (view.frame.width - labelWidth)/2,
                                  y: view.frame.height - labelHeight - 100,
                                  width: labelWidth,
                                  height: labelHeight)
        
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
}
