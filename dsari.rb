class Dsari < Formula
  desc "Do Something and Record It - Lightweight CI/CD system"
  homepage "https://github.com/rfinnie/dsari"
  head "https://github.com/rfinnie/dsari.git", :branch => "main"

  depends_on "python@3"

  def install
    pyver = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{pyver}/site-packages"
    system "python3", *Language::Python.setup_install_args(libexec)
    man1.install "doc/dsari-daemon.1"
    man1.install "doc/dsari-info.1"
    man1.install "doc/dsari-render.1"
    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
