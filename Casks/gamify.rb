cask "gamify" do
  version "0.6"
  sha256 "d8bcf1d671043e20cedb748129c2f01d3bba833fea58832010a580a49f19a416"

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
  depends_on macos: ">= :sonoma"

  app "Gamify.app"

  # Not notarized yet: clear the quarantine flag, as the release notes tell DMG users to do.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Gamify.app"]
  end

  # Bottles (installed Windows programs and games) live in Application Support.
  zap trash: [
    "~/Library/Application Support/Gamify",
    "~/Library/Caches/Gamify",
    "~/Library/Preferences/local.gamify.app.plist",
    "~/Library/Saved Application State/local.gamify.app.savedState",
  ]

  caveats <<~EOS
    Gamify needs Rosetta 2; its first-run tutorial installs it.
    `brew uninstall --zap gamify` also deletes your bottles and the games in them.
  EOS
end
