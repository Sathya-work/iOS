//
//  FavouritesViewController.swift
//  Voice Notes 2
//
//  Created by Sathyanarayana on 4/19/25.
//


import UIKit
import AVFoundation

class FavouritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var favouritesTableView: UITableView!
    
    private var favouriteRecordings: [Recording] = []
    var audioPlayer: AVAudioPlayer?
    var currentlyPlayingIndex: IndexPath?
    var isPaused: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritesTableView.dataSource = self
        favouritesTableView.delegate = self
        favouritesTableView.showsVerticalScrollIndicator = true
        favouritesTableView.isScrollEnabled = true
        loadFavorites()
    }
    
    private func loadFavorites() {
        favouriteRecordings.removeAll()
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let files = try FileManager.default.contentsOfDirectory(at: documentPath, includingPropertiesForKeys: [.creationDateKey])
            for fileURL in files where fileURL.pathExtension == "m4a" {
                let attributes = try FileManager.default.attributesOfItem(atPath: fileURL.path)
                let date = attributes[.creationDate] as? Date ?? Date()
                let fileName = fileURL.deletingPathExtension().lastPathComponent
                let customName = UserDefaults.standard.string(forKey: "customName_\(fileName)") ?? fileName
                let isFavorite = UserDefaults.standard.bool(forKey: "favorite_\(fileURL.lastPathComponent)")
                if isFavorite {
                    favouriteRecordings.append(Recording(url: fileURL, date: date, customName: customName, isFavorite: true))
                }
            }
        } catch {
            print("Error loading favorites: \(error.localizedDescription)")
        }
        favouritesTableView.reloadData()
    }
    
    private func toggleFavorite(at index: Int) {
        favouriteRecordings[index].isFavorite.toggle()
        let key = "favorite_\(favouriteRecordings[index].url.lastPathComponent)"
        UserDefaults.standard.set(favouriteRecordings[index].isFavorite, forKey: key)
        if !favouriteRecordings[index].isFavorite {
            favouriteRecordings.remove(at: index)
            favouritesTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        } else {
            favouritesTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
    
    private func deleteRecording(at index: Int) {
        let recording = favouriteRecordings[index]
        do {
            try FileManager.default.removeItem(at: recording.url)
            let fileName = recording.url.deletingPathExtension().lastPathComponent
            UserDefaults.standard.removeObject(forKey: "customName_\(fileName)")
            UserDefaults.standard.removeObject(forKey: "favorite_\(recording.url.lastPathComponent)")
            favouriteRecordings.remove(at: index)
            favouritesTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        } catch {
            print("Delete Error: \(error.localizedDescription)")
        }
    }
    
    private func renameRecording(at index: Int) {
        let recording = favouriteRecordings[index]
        let fileName = recording.url.deletingPathExtension().lastPathComponent
        
        let alert = UIAlertController(title: "Rename Recording", message: "Enter a new name", preferredStyle: .alert)
        alert.addTextField { $0.text = recording.customName }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self = self,
                  let newName = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  !newName.isEmpty else { return }
            
            let existing = self.favouriteRecordings.contains {
                $0.customName.lowercased() == newName.lowercased() && $0.url != recording.url
            }
            if existing {
                return
            }
            
            UserDefaults.standard.set(newName, forKey: "customName_\(fileName)")
            self.favouriteRecordings[index].customName = newName
            self.favouritesTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        })
        
        present(alert, animated: true)
    }
    
    private func playRecording(at url: URL, indexPath: IndexPath) {
        do {
            if currentlyPlayingIndex == indexPath {
                if isPaused {
                    audioPlayer?.play()
                    isPaused = false
                    favouriteRecordings[indexPath.row].isPlaying = true
                    favouriteRecordings[indexPath.row].isPaused = false
                } else {
                    audioPlayer?.pause()
                    isPaused = true
                    favouriteRecordings[indexPath.row].isPlaying = false
                    favouriteRecordings[indexPath.row].isPaused = true
                }
            } else {
                audioPlayer?.stop()
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.delegate = self
                audioPlayer?.play()
                currentlyPlayingIndex = indexPath
                isPaused = false
                
                for i in favouriteRecordings.indices {
                    favouriteRecordings[i].isPlaying = false
                    favouriteRecordings[i].isPaused = false
                }
                
                favouriteRecordings[indexPath.row].isPlaying = true
            }
            
            favouritesTableView.reloadData()
        } catch {
            print("Playback Error: \(error.localizedDescription)")
        }
    }
    
    private func scheduleReminder(for recording: Recording) {
        let alert = UIAlertController(title: "Set Reminder", message: "\n\n\n\n\n", preferredStyle: .alert)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 50, width: 270, height: 100)
        alert.view.addSubview(datePicker)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Set", style: .default) { _ in
            let selectedDate = datePicker.date
            self.createNotification(for: recording, at: selectedDate)
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
                print("Reminder scheduling failed: \(error.localizedDescription)")
            } else {
                print("✅ Reminder scheduled for \(date)")
            }
        }
    }
    
    // MARK: - Table View Data Source & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteRecordings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath)
        let recording = favouriteRecordings[indexPath.row]
        cell.textLabel?.text = recording.customName
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: recording.date, dateStyle: .short, timeStyle: .short)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playRecording(at: favouriteRecordings[indexPath.row].url, indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { [weak self] _, _, completion in
            self?.toggleFavorite(at: indexPath.row)
            completion(true)
        }
        favoriteAction.image = UIImage(systemName: favouriteRecordings[indexPath.row].isFavorite ? "heart.fill" : "heart")
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
            self.scheduleReminder(for: self.favouriteRecordings[indexPath.row])
            completion(true)
        }
        reminderAction.backgroundColor = .systemIndigo
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, renameAction, favoriteAction, reminderAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let recording = favouriteRecordings[indexPath.row]
        
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
}
