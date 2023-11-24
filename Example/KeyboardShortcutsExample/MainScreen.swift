import SwiftUI
import KeyboardShortcuts

/**
 Location of the save file:
 /Users/florian.bronnimann/Library/Containers/com.sindresorhus.KeyboardShortcutsExample/Data/Library/Preferences/com.sindresorhus.KeyboardShortcutsExample.plist
 Or when not containarized:
 /Users/florian.bronnimann/Library/Preferences/com.sindresorhus.KeyboardShortcutsExample.plist
*/
extension Binding {
//    func whenSet(execute: @escaping (Value) -> Void) -> Binding {
    func whenSet(execute: @escaping () -> Void) -> Binding {
        return Binding(
            get: { self.wrappedValue },
            set: {
                self.wrappedValue = $0
                execute()
            }
        )
    }
}

private struct DynamicShortcut: View {
	private struct Shortcut: Hashable, Identifiable {
		var id: String
		var name1: KeyboardShortcuts.Name
        var name2: KeyboardShortcuts.Name
        var appToOpen: String? = nil
        var shellCommandArgs: [String]? = nil
        var toggleSet1 = false
        var openBluetoothSettings = false

        public init(id: String) {
            self.id = id
            name1 = KeyboardShortcuts.Name("sc" + id + "#1")
            name2 = KeyboardShortcuts.Name("sc" + id + "#2")
        }

        public init(id: String, app: String) {
            self.init(id: id)
            appToOpen = app
        }

        public init(id: String, toggleSet1: Bool) {
            self.init(id: id)
            self.toggleSet1 = toggleSet1
        }

        public init(id: String, openBluetoothSettings: Bool) {
            self.init(id: id)
            self.openBluetoothSettings = openBluetoothSettings
        }

        public init(id: String, shellCmd: [String]) {
            self.init(id: id)
            shellCommandArgs = shellCmd
        }
    }
    
	private static let shortcuts = [
        Shortcut(id: "Finder", app: "/System/Library/CoreServices/Finder.app"),
        Shortcut(id: "Google Meet", app: "/Users/florian.bronnimann/Applications/Chrome Apps.localized/Google Meet.app"),
        Shortcut(id: "Mail", app: "/Users/florian.bronnimann/Applications/Chrome Apps.localized/Gmail.app"),
        Shortcut(id: "Chrome", app: "/Applications/Google Chrome.app"),
        Shortcut(id: "Translate", app: "/Applications/DeepL.app"),
        Shortcut(id: "Terminal", app: "/Users/florian.bronnimann/Applications/iTerm.app"),
        Shortcut(id: "SublimeText", app: "/Users/florian.bronnimann/Applications/Sublime Text.app"),
        Shortcut(id: "Notes", app: "/System/Applications/Notes.app"),
        Shortcut(id: "Code", app: "/Applications/Visual Studio Code.app"),
        Shortcut(id: "Slack", app: "/Applications/Slack.app"),
        Shortcut(id: "Timer", app: "/System/Applications/Clock.app"),
        Shortcut(id: "Android Studio", app: "/Users/florian.bronnimann/Applications/Android Studio.app"),
        Shortcut(id: "Xcode", app: "/Applications/Xcode.app"),
        Shortcut(id: "Calendar", app: "/Users/florian.bronnimann/Applications/Chrome Apps.localized/Google Calendar.app"),
        Shortcut(id: "YouTube", app: "/Users/florian.bronnimann/Applications/Chrome Apps.localized/YouTube.app"),
        Shortcut(id: "Activity Monitor", app: "/System/Applications/Utilities/Activity Monitor.app"),
        Shortcut(id: "Battery", app: "/Users/florian.bronnimann/Applications/coconutBattery.app"),
//        Shortcut(id: "Mute Mic", shellCmd: ["/usr/bin/osascript", "/Users/florian.bronnimann/Software/mute-toggle.txt"]),
        Shortcut(id: "Toggle first set of keys", toggleSet1: true),
        Shortcut(id: "Open Bluetooth Settings", openBluetoothSettings: true),
	]

	@State private var shortcut = Self.shortcuts.first!
	@State private var isPressed1 = false
    @State private var isPressed2 = false
    @State private var useFirstSet = true
    @State private var useSecondSet = true

	var body: some View {
		VStack {
			Text("Dynamic Recorder")
				.bold()
				.padding(.bottom, 10)
			VStack {
                Toggle("Use first set of keys", isOn: $useFirstSet.whenSet { updateShortcuts() })
                Toggle("Use second set of keys", isOn: $useSecondSet.whenSet { updateShortcuts() })
				Picker("Select shortcut:", selection: $shortcut) {
					ForEach(Self.shortcuts) { shortcut in
						Text(shortcut.id)
							.tag(shortcut)
                            .onKeyboardShortcut(shortcut.name1, type: .keyDown) { run(shortcut: shortcut) }
                            .onKeyboardShortcut(shortcut.name2, type: .keyDown) { run(shortcut: shortcut) }
					}
				}
				Divider()
				DynamicShortcutRecorder(name: $shortcut.name1, isPressed: $isPressed1)
                DynamicShortcutRecorder(name: $shortcut.name2, isPressed: $isPressed2)
			}
		}
			.frame(maxWidth: 300)
			.padding()
			.padding(.bottom, 20)
			.onChange(of: shortcut) { [oldValue = shortcut] in
				onShortcutChange(oldValue: oldValue, newValue: $0)
			}
            .onAppear { updateShortcuts() }
    }
    
    private func runShellCommand(command: Array<String>) {
        let task = Process()

        //the path to the external program you want to run
        let executableURL = URL(fileURLWithPath: command[0])
        task.executableURL = executableURL

        //use pipe to get the execution program's output
        let pipe = Pipe()
        task.standardOutput = pipe

        //this one helps set the directory the executable operates from
//        task.currentDirectoryURL = URL(fileURLWithPath: "/Users/florian.bronnimann/")

        //all the arguments to the executable
        let args = Array(command.dropFirst())
        task.arguments = args

        //what to call once the process completes
        task.terminationHandler = {
            _ in
            print("process run complete.")
        }

        try! task.run()
        task.waitUntilExit()

        //all this code helps you capture the output so you can, for e.g., show the user
        let d = pipe.fileHandleForReading.readDataToEndOfFile()
        let ds = String (data: d, encoding: String.Encoding.utf8)
        print("terminal output: \(ds!)")

        print("execution complete...")
    }
    
    private func openApp(app: String) {
        let url = NSURL(fileURLWithPath: app, isDirectory: true) as URL

        let configuration = NSWorkspace.OpenConfiguration()
        configuration.arguments = []
        NSWorkspace.shared.openApplication(at: url,
                                           configuration: configuration,
                                           completionHandler: nil)
    }
    
    private func run(shortcut: Shortcut) {
        if (shortcut.appToOpen != nil) {
            // FIXME: why do I need the `!` ?
            openApp(app: shortcut.appToOpen!)
        }
        else if (shortcut.shellCommandArgs != nil) {
            runShellCommand(command: shortcut.shellCommandArgs!)
        }
        else if (shortcut.toggleSet1) {
            useFirstSet = !useFirstSet
            updateShortcuts()
        }
        else if (shortcut.openBluetoothSettings) {
//            if let urlString = URL(string: "x-apple.systempreferences:com.apple.preferences.Bluetooth") {
            if #available(macOS 13.0, *) {
                let url = URL(filePath: "/System/Library/PreferencePanes/Bluetooth.prefPane")
                NSWorkspace.shared.open(url)
            } else {
                print("Unsupported")
            }
        }
    }
    
    private func updateShortcuts() {
        DynamicShortcut.shortcuts.forEach { s in
            if (useFirstSet) { KeyboardShortcuts.enable(s.name1) } else { KeyboardShortcuts.disable(s.name1) }
            if (useSecondSet) { KeyboardShortcuts.enable(s.name2) } else { KeyboardShortcuts.disable(s.name2) }
        }
    }

	private func onShortcutChange(oldValue: Shortcut, newValue: Shortcut) {
//		KeyboardShortcuts.disable(oldValue.name)

		KeyboardShortcuts.onKeyDown(for: newValue.name1) { isPressed1 = true }
		KeyboardShortcuts.onKeyUp(for: newValue.name1) { isPressed1 = false }
        KeyboardShortcuts.onKeyDown(for: newValue.name2) { isPressed2 = true }
        KeyboardShortcuts.onKeyUp(for: newValue.name2) { isPressed2 = false }
	}
}

private struct DynamicShortcutRecorder: View {
    @FocusState private var isFocused: Bool

    @Binding var name: KeyboardShortcuts.Name
    @Binding var isPressed: Bool

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            KeyboardShortcuts.Recorder(for: name)
                .focused($isFocused)
                .padding(.trailing, 10)
            Text("Pressed? \(isPressed ? "👍" : "👎")")
                .frame(width: 100, alignment: .leading)
        }
            .onChange(of: name) { _ in
                isFocused = true
            }
    }
}

//private struct DoubleShortcut: View {
//	@State private var isPressed1 = false
//	@State private var isPressed2 = false
//
//	var body: some View {
//		Form {
//			KeyboardShortcuts.Recorder("Shortcut 1:", name: .testShortcut1)
//				.overlay(alignment: .trailing) {
//					Text("Pressed? \(isPressed1 ? "👍" : "👎")")
//						.offset(x: 90)
//				}
//			KeyboardShortcuts.Recorder(for: .fuckingSuperLongTestShortcut) {
//				Text("fuckingSuperLongTestShortcut:") // Intentionally using the verbose initializer for testing.
//			}
//				.overlay(alignment: .trailing) {
//					Text("Pressed? \(isPressed2 ? "👍" : "👎")")
//						.offset(x: 90)
//				}
//			Spacer()
//			Button("Reset All") {
//				KeyboardShortcuts.reset(.testShortcut1, .fuckingSuperLongTestShortcut)
//			}
//		}
//			.offset(x: -40)
//			.frame(maxWidth: 300)
//			.padding()
//			.padding()
//			.onKeyboardShortcut(.testShortcut1) {
//                if ($0 == .keyDown) {
//                    print("Has been pressed")
////                    let _ = Process.launchedProcess(launchPath: "/Applications/Google Chrome.app", arguments: [])
//                    let url = NSURL(fileURLWithPath: "/System/Applications/Utilities/Terminal.app", isDirectory: true) as URL
//
//                    let path = "/bin"
//                    let configuration = NSWorkspace.OpenConfiguration()
//                    configuration.arguments = [path]
//                    NSWorkspace.shared.openApplication(at: url,
//                                                       configuration: configuration,
//                                                       completionHandler: nil)
//                }
//			}
//			.onKeyboardShortcut(.fuckingSuperLongTestShortcut, type: .keyDown) {
//				isPressed2 = true
//			}
//			.task {
//				KeyboardShortcuts.onKeyUp(for: .fuckingSuperLongTestShortcut) {
//					isPressed2 = false
//				}
//			}
//	}
//}

struct MainScreen: View {
	var body: some View {
		VStack {
//			DoubleShortcut()
//			Divider()
			DynamicShortcut()
		}
//			.frame(width: 400, height: 320)
	}
}

struct MainScreen_Previews: PreviewProvider {
	static var previews: some View {
		MainScreen()
	}
}
