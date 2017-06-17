class NodeExporterBinary < Formula
  desc "Exporter for machine metrics (binary releases)"
  homepage "https://github.com/prometheus/node_exporter"
  version "0.14.0"
  url "https://github.com/prometheus/node_exporter/releases/download/v0.14.0/node_exporter-0.14.0.darwin-amd64.tar.gz"
  sha256 "a2841d4cd2ab262d2e50192a2a32a9262afa8fc34680edb7531de042bab35328"

  def install
    bin.install "node_exporter"
  end

  plist_options :manual => "node_exporter", :startup => true

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/node_exporter</string>
        </array>
        <key>UserName</key>
        <string>nobody</string>
        <key>StandardErrorPath</key>
        <string>/dev/null</string>
        <key>StandardOutPath</key>
        <string>/dev/null</string>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
      </dict>
    </plist>
    EOS
  end
end
