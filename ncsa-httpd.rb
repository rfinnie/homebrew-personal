class NcsaHttpd < Formula
  desc "NCSA HTTPd"
  homepage "https://github.com/rfinnie/ncsa-httpd"
  head "https://github.com/rfinnie/ncsa-httpd.git", :branch => "main"

  def install
    system "make", "macos"

    (libexec/"ncsa-httpd").install "httpd"

    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/archie"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/calendar"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/date"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/donothing"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/finger"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/fortune"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/imagemap"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/jj"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/mail"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/nph-error.pl"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/nph-test-cgi"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/phf"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/post-query"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/query"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/redirect"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/test-cgi"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/test-cgi.tcl"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/test-env"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/uptime"
    (libexec/"ncsa-httpd/cgi-bin").install "cgi-bin/wais.pl"

    (libexec/"ncsa-httpd/support").install "support/dbm2std"
    (libexec/"ncsa-httpd/support").install "support/dbmdigest"
    (libexec/"ncsa-httpd/support").install "support/dbmgroup"
    (libexec/"ncsa-httpd/support").install "support/dbmpasswd"
    (libexec/"ncsa-httpd/support").install "support/htdigest"
    (libexec/"ncsa-httpd/support").install "support/htpasswd"
    (libexec/"ncsa-httpd/support").install "support/inc2shtml"
    (libexec/"ncsa-httpd/support").install "support/std2dbm"
    (libexec/"ncsa-httpd/support").install "support/unescape"
    (libexec/"ncsa-httpd/support").install "support/webgrab"

    (libexec/"ncsa-httpd/support/auth").install "support/auth/pgp-dec"
    (libexec/"ncsa-httpd/support/auth").install "support/auth/pgp-enc"
    (libexec/"ncsa-httpd/support/auth").install "support/auth/ripem-dec"
    (libexec/"ncsa-httpd/support/auth").install "support/auth/ripem-enc"
    (libexec/"ncsa-httpd/support/auth").install "support/auth/uudecode"
    (libexec/"ncsa-httpd/support/auth").install "support/auth/uuencode"

    (pkgshare/"conf").install "conf/access.conf-dist" => "access.conf"
    (pkgshare/"conf").install "conf/httpd.conf-dist" => "httpd.conf"
    (pkgshare/"conf").install "conf/localhost_srm.conf-dist" => "localhost_srm.conf"
    (pkgshare/"conf").install "conf/mime.types"
    (pkgshare/"conf").install "conf/srm.conf-dist" => "srm.conf"
    (pkgshare/"icons").install Dir["icons/*.xbm"], Dir["icons/*.gif"]

    (libexec/"ncsa-httpd/httpd-install").write <<~EOS
      #!/bin/sh
      
      set -e

      mkdir -p /usr/local/etc/httpd
      if ! [ -e /usr/local/etc/httpd/httpd ]; then
        ln -s #{HOMEBREW_PREFIX}/opt/ncsa-httpd/libexec/ncsa-httpd/httpd /usr/local/etc/httpd/httpd
      fi

      mkdir -p /usr/local/etc/httpd/htdocs
      mkdir -p /usr/local/etc/httpd/logs

      mkdir -p /usr/local/etc/httpd/conf
      for i in #{HOMEBREW_PREFIX}/opt/ncsa-httpd/share/ncsa-httpd/conf/*; do
        [ -e /usr/local/etc/httpd/conf/$(basename $i) ] && continue
        cp $i /usr/local/etc/httpd/conf/$(basename $i)
      done

      mkdir -p /usr/local/etc/httpd/support
      for i in #{HOMEBREW_PREFIX}/opt/ncsa-httpd/libexec/ncsa-httpd/support/*; do
        [ -e /usr/local/etc/httpd/support/$(basename $i) ] && continue
        ln -sf $i /usr/local/etc/httpd/support/$(basename $i)
      done

      mkdir -p /usr/local/etc/httpd/cgi-bin
      for i in #{HOMEBREW_PREFIX}/opt/ncsa-httpd/libexec/ncsa-httpd/cgi-bin/*; do
        [ -e /usr/local/etc/httpd/cgi-bin/$(basename $i) ] && continue
        ln -sf $i /usr/local/etc/httpd/cgi-bin/$(basename $i)
      done

      mkdir -p /usr/local/etc/httpd/icons
      for i in #{HOMEBREW_PREFIX}/opt/ncsa-httpd/share/ncsa-httpd/icons/*; do
        [ -e /usr/local/etc/httpd/icons/$(basename $i) ] && continue
        ln -sf $i /usr/local/etc/httpd/icons/$(basename $i)
      done
    EOS
    (libexec/"ncsa-httpd/httpd-install").chmod 0755
  end

  def caveats
    <<~EOS
      DO NOT RUN THIS IN ANY TRUSTED ENVIRONMENT!

      This software is over two decades old and contains manu known
      security holes.

      NCSA HTTPd requires a certain setup under /usr/local/etc/httpd/.
      To copy configurations and symlink other files, please run:

          sudo #{HOMEBREW_PREFIX}/opt/ncsa-httpd/libexec/ncsa-httpd/httpd-install

      And then to start httpd:

          sudo /usr/local/etc/httpd/httpd
    EOS
  end
end
