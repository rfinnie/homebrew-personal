class Twuewand < Formula
  desc "A truerand algorithm for generating entropy"
  homepage "https://github.com/rfinnie/twuewand"
  head "https://github.com/rfinnie/twuewand.git", :branch => "main"

  depends_on "python@3"

  def install
    pyver = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{pyver}/site-packages"
    system "python3", *Language::Python.setup_install_args(libexec)
    man1.install "doc/twuewand.1"
    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
