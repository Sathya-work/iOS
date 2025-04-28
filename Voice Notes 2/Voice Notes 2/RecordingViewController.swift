import UIKit
import AVFoundation

class RecordingViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingTimeLabel: UILabel!
    @IBOutlet weak var pauseResumeButton: UIButton!
    
    private var audioRecorder: AVAudioRecorder?
    private var isRecording = false
    private var isPaused = false
    private var timer: Timer?
    private var recordingTime: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingLabel.text = "Recording..."
        recordingTimeLabel.text = formatTimeInterval(0)
        pauseResumeButton.setImage(UIImage(named: "pause"), for: .normal)
        requestMicrophonePermission()
        pauseResumeButton.clipsToBounds = true
        pauseResumeButton.layer.cornerRadius = pauseResumeButton.frame.size.height / 2
        pauseResumeButton.imageView?.contentMode = .scaleAspectFit
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startRecording()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isRecording && !isPaused {
            showSaveOrDiscardAlert()
        }
    }

    func showSaveOrDiscardAlert() {
        let alert = UIAlertController(title: "Save Recording?", message: "Do you want to save the recording before leaving?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            self.stopRecording()
        })

        alert.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.audioRecorder?.stop()
            self.audioRecorder?.deleteRecording()
        })

        present(alert, animated: true)
    }

    private func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
            DispatchQueue.main.async {
                if !granted {
                    self?.showAlert(title: "Microphone Access Denied", message: "Please enable microphone access in Settings.")
                    self?.timer?.invalidate()
                    self?.isRecording = false
                    self?.isPaused = false
                }
            }
        }
    }

    private func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try audioSession.setActive(true)

            let fileURL = getDocumentsDirectory().appendingPathComponent("recording_\(Date().timeIntervalSince1970).m4a")
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()

            isRecording = true
            isPaused = false
            recordingTime = 0
            startTimer()

        } catch {
            showAlert(title: "Recording Failed", message: error.localizedDescription)
        }
    }
    
    @IBAction func stopRecordingTapped(_ sender: UIButton) {
        stopRecording()
        navigationController?.popViewController(animated: true)
    }
    
    private func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        timer?.invalidate()
        isRecording = false
        isPaused = false
    }
    
    @IBAction func pauseResumeTapped(_ sender: UIButton) {
        guard let recorder = audioRecorder else { return }

        if isPaused {
            recorder.record()
            isPaused = false
            pauseResumeButton.setImage(UIImage(named: "pause"), for: .normal)
            recordingLabel.text = "Recording..."
            startTimer()
        } else {
            recorder.pause()
            isPaused = true
            pauseResumeButton.setImage(UIImage(named: "resume"), for: .normal)
            recordingLabel.text = "Recording paused"
            timer?.invalidate()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc private func updateTimer() {
        recordingTime += 1
        recordingTimeLabel.text = formatTimeInterval(recordingTime)
    }

    private func formatTimeInterval(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = Int(interval) / 60 % 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
