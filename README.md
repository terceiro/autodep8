# autodep8

autodep8 will detect well-known types of packages and generate
DEP-8-compliant test control files for them. It can be used by DEP-8
implementations to support implicit test control files.

## Usage

```
$ autodep8                 # assumes source package in current dir
$ autodep8 /path/to/srcpkg # path to source package
```

If a known package type is detected, autodep8 exits with 0 and prints the
suggested contents of debian/tests/control to the standard output.

If a known package type is NOT detected, autodep8 exits with 1 and
produces not output.

## Copyright

Copyright © 2014 by the contributing authors. See `git log` for details.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

