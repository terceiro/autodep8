
## dkms (kpatch)

    Test-Command: /usr/lib/dkms/dkms-autopkgtest
    Restrictions: needs-root, allow-stderr
    Depends: @, dkms

## elpa (flycheck)

    Test-Command: dh_elpa_test --autopkgtest
    Depends: @, @builddeps@
    Restrictions: rw-build-tree

## nodejs (node-tar)

    Test-Command: cd $ADTTMP && nodejs -e "require('"'"'tar'"'"');"
    Depends: @

## perl (libtest-most-perl)

    Test-Command: /usr/share/pkg-perl-autopkgtest/runner build-deps
    Depends: @, @builddeps@, pkg-perl-autopkgtest
    
    Test-Command: /usr/share/pkg-perl-autopkgtest/runner runtime-deps
    Depends: @, pkg-perl-autopkgtest
    
    Test-Command: /usr/share/pkg-perl-autopkgtest/runner runtime-deps-and-recommends
    Depends: @, pkg-perl-autopkgtest
    Restrictions: needs-recommends

## python (python-flaky)

    Test-Command: cd "$ADTTMP" ; python -c "import flaky; print flaky"
    Depends: python-flaky
    
    Test-Command: cd "$ADTTMP" ; python3 -c "import flaky; print(flaky)"
    Depends: python3-flaky
    
    Test-Command: cd "$ADTTMP" ; pypy -c "import flaky; print flaky"
    Depends: pypy-flaky
    

## r (r-cran-evaluate)

    Test-Command: R -e "library('evaluate')"
    Depends: @
    Restrictions: allow-stderr

## ruby (ruby-sqlite3)

    Test-Command: gem2deb-test-runner --autopkgtest --check-dependencies 2>&1
    Depends: @, libsqlite3-dev,rake,ruby-hoe,ruby-minitest,ruby-redcloth, gem2deb-test-runner

