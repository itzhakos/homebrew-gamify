# Homebrew tap for Gamify

[Gamify](https://github.com/itzhakos/gamify) runs Windows games on Apple Silicon Macs.

```sh
brew install --cask itzhakos/gamify/gamify
```

The cask installs the DMG from
[gamify-releases](https://github.com/itzhakos/gamify-releases/releases). Gamify updates
itself, so `brew upgrade` skips it unless you pass `--greedy`. `scripts/release.sh` in the
main repository bumps `Casks/gamify.rb` on every release.
