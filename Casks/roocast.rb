cask "roocast" do
  version "0.11.2"
  sha256 "ff19bab80c72b774249b74f97c3f069e68047ffbbc3fe37690f3ddf76fcc8e3d"

  # Public object URL (Cloudflare R2). Do not point homepage/livecheck at a product site.
  url "https://pub-64ebbf28a53c4384b65e97db467d3eea.r2.dev/Roocast-#{version}.dmg"
  name "Roocast"
  desc "Native macOS launcher"
  homepage "https://github.com/b0yu-li/roocast"

  livecheck do
    url "https://raw.githubusercontent.com/b0yu-li/roocast/main/Sources/Roocast/Version.swift"
    strategy :page_match do |page|
      major = page[/static let major = (\d+)/, 1]
      minor = page[/static let minor = (\d+)/, 1]
      patch = page[/static let patch = (\d+)/, 1]
      next if major.blank? || minor.blank? || patch.blank?

      "#{major}.#{minor}.#{patch}"
    end
  end

  depends_on macos: :sonoma

  app "Roocast.app"

  zap trash: [
    "~/.config/roocast",
    "~/Library/Application Support/Roocast",
    "~/Library/Logs/Roocast",
  ]
end
