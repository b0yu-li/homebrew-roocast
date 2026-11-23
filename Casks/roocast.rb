cask "roocast" do
  version "0.12.0"
  sha256 "9188a68e671841fa34045ded869a765c74a5c9f8335ea090eb4e6ef7183d6787"

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

  # Brew courtesy: the app can replace its own binary when the user runs
  # Check for Updates → Install Update. Does NOT enable silent auto-update in Roocast.
  auto_updates true

  depends_on macos: :sonoma

  app "Roocast.app"

  zap trash: [
    "~/.config/roocast",
    "~/Library/Application Support/Roocast",
    "~/Library/Logs/Roocast",
  ]
end
