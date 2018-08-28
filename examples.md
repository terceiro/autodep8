
## dkms (kpatch)

    Test-Command: /usr/lib/dkms/dkms-autopkgtest
    Restrictions: needs-root, allow-stderr
    Depends: @, dkms

## elpa (flycheck)

    Test-Command: dh_elpa_test --autopkgtest
    Depends: @, @builddeps@
    Restrictions: rw-build-tree

## go (prometheus)

    Test-Command: /usr/bin/dh_golang_autopkgtest
    Depends: @, @builddeps@, dh-golang
    Restrictions: allow-stderr

## nodejs (node-tar)

    Test-Command: cd "$AUTOPKGTEST_TMP" && nodejs -e "require('tar');"
    Depends: @

## octave (octave-signal)

    Test-Command: DH_OCTAVE_TEST_ENV="xvfb-run -a" /usr/bin/dh_octave_check --use-installed-package
    Depends: @, octave-control (>= 3.1.0), dh-octave-autopkgtest (>= 0.5.6), xauth, xvfb
    Restrictions: allow-stderr

## perl (libtest-most-perl)

    Test-Command: /usr/share/pkg-perl-autopkgtest/runner build-deps
    Depends: @, @builddeps@, pkg-perl-autopkgtest
    
    Test-Command: /usr/share/pkg-perl-autopkgtest/runner runtime-deps
    Depends: @, pkg-perl-autopkgtest
    
    Test-Command: /usr/share/pkg-perl-autopkgtest/runner runtime-deps-and-recommends
    Depends: @, pkg-perl-autopkgtest
    Restrictions: needs-recommends

## python (python-flaky)

    Test-Command: set -e ; for py in $(pyversions -r 2>/dev/null) ; do cd "$AUTOPKGTEST_TMP" ; echo "Testing with $py:" ; $py -c "import flaky; print flaky" ; done
    Depends: python-all, python-flaky
    
    Test-Command: set -e ; for py in $(py3versions -r 2>/dev/null) ; do cd "$AUTOPKGTEST_TMP" ; echo "Testing with $py:" ; $py -c "import flaky; print(flaky)" ; done
    Depends: python3-all, python3-flaky
    
    Test-Command: cd "$AUTOPKGTEST_TMP" ; pypy -c "import flaky; print flaky"
    Depends: pypy-flaky
    

## r (r-cran-evaluate)

    Test-Command: /usr/share/dh-r/pkg-r-autopkgtest
    Depends: @, pkg-r-autopkgtest
    Restrictions: allow-stderr

## ruby (ruby-sqlite3)

    Test-Command: gem2deb-test-runner --autopkgtest --check-dependencies 2>&1
    Depends: @, libsqlite3-dev,rake,ruby-hoe,ruby-minitest,ruby-redcloth, gem2deb-test-runner

