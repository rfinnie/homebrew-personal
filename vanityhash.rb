class Vanityhash < Formula
  desc "Brute forcing hashes for fun and profit"
  homepage "https://github.com/rfinnie/vanityhash"
  head "https://github.com/rfinnie/vanityhash.git", :branch => "main"

  depends_on "pandoc" => :build
  depends_on "python@3"

  def install
    system "make", "all", "vanityhash.1"
    bin.install "vanityhash"
    man1.install "vanityhash.1"
  end
end
