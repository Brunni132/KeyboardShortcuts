import SwiftUI
import KeyboardShortcuts

// Location of the save file:
// Users/florian.bronnimann/Library/Containers/com.sindresorhus.KeyboardShortcutsExample/Data/Library/Preferences/com.sindresorhus.KeyboardShortcutsExample.plist

private struct DynamicShortcut: View {
	private struct Shortcut: Hashable, Identifiable {
		var id: String
		var name1: KeyboardShortcuts.Name
        var name2: KeyboardShortcuts.Name
        var appToOpen: String

        public init(id: String, app: String) {
            self.id = id
            appToOpen = app
            name1 = KeyboardShortcuts.Name("sc" + id + "#1")
            name2 = KeyboardShortcuts.Name("sc" + id + "#2")
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
	]

	@State private var shortcut = Self.shortcuts.first!
	@State private var isPressed1 = false
    @State private var isPressed2 = false

	var body: some View {
		VStack {
			Text("Dynamic Recorder")
				.bold()
				.padding(.bottom, 10)
			VStack {
				Picker("Select shortcut:", selection: $shortcut) {
					ForEach(Self.shortcuts) {
						Text($0.id)
							.tag($0)
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
            .onKeyboardShortcut(DynamicShortcut.shortcuts[0].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[0].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[0].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[0].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[1].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[1].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[1].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[1].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[2].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[2].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[2].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[2].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[3].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[3].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[3].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[3].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[4].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[4].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[4].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[4].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[5].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[5].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[5].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[5].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[6].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[6].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[6].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[6].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[7].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[7].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[7].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[7].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[8].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[8].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[8].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[8].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[9].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[9].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[9].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[9].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[10].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[10].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[10].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[10].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[11].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[11].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[11].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[11].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[12].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[12].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[12].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[12].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[13].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[13].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[13].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[13].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[14].name1, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[14].appToOpen) }
            .onKeyboardShortcut(DynamicShortcut.shortcuts[14].name2, type: .keyDown) { openApp(app: DynamicShortcut.shortcuts[14].appToOpen) }
    }
    
    private func openApp(app: String) {
//        let _ = Process.launchedProcess(launchPath: app, arguments: [])
        let url = NSURL(fileURLWithPath: app, isDirectory: true) as URL

        let path = "/bin"
        let configuration = NSWorkspace.OpenConfiguration()
        configuration.arguments = [path]
        NSWorkspace.shared.openApplication(at: url,
                                           configuration: configuration,
                                           completionHandler: nil)
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
