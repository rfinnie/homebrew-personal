class Emad < Formula
  desc "Emad in Mindjail"
  homepage "https://github.com/rfinnie/emad"
  head "https://github.com/rfinnie/emad.git", :branch => "main"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "ncurses"

  def install
    system "autoreconf", "-ivf"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install", "execgamesdir=#{bin}"
  end
end
