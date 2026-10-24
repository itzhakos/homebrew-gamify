cask "gamify" do
  version "0.9.1"
  sha256 "3a6dafa15812e9518b48345400326fed326a587760be94dd4cf1d83c68d1b3ac"

  url "https://github.com/itzhakos/gamify-releases/releases/download/v#{version}/Gamify-#{version}.dmg"
  name "Gamify"
  desc "Run Windows games using CrossOver-lineage Wine and Apple D3DMetal"
  homepage "https://github.com/itzhakos/gamify"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself from the same GitHub releases.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Gamify.app"

  # Bottles (installed Windows programs and games) live in Application Support.
  zap trash: [
    "~/Library/Application Support/Gamify",
    "~/Library/Caches/Gamify",
    "~/Library/Preferences/local.gamify.app.plist",
    "~/Library/Saved Application State/local.gamify.app.savedState",
  ]

  caveats <<~EOS
    Gamify is not notarized yet, so macOS blocks the first launch. Allow it once with
      xattr -dr com.apple.quarantine #{appdir}/Gamify.app
    or with System Settings > Privacy & Security > Open Anyway.
    Gamify needs Rosetta 2; its first-run tutorial installs it.
    `brew uninstall --zap gamify` also deletes your bottles and the games in them.
  EOS
end
