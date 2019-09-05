# Scripts 


This `Scripts` is a collection of scripts developed to made easier my life.

It's 100% Open Source and licensed under the [GPL3](LICENSE).

---

Table of Contents
* [Scripts](#scripts)
  * [cpptest.bashrc](#cpptestbashrc)
* [Help](#help)
* [Contributing](#scripts)
  * [cpptest.bashrc](#Bug_Reports_&_Feature_Requests)
* [License](#license)
* [Contributors](#contributors)

## Scripts

Like this project? Please give it a ★ on [our GitHub](https://github.com/akotadi/Scripts)! 

### cpptest.bashrc

This script was made to quickly test my `.cpp` files. Typical uses are:
```bash
# Compile, execute and clean a cpp file:
testcpp <cpp_file>
```
If the `<cpp_file>` doesn't end in `.cpp`, the script won't run. Also, if the `<cpp_file>` doesn't exist, the script will exit.

The script also defines some flags:
* `-d`  to add the flag `-DDEBUG` at compilation time
* `-v <version_number>`  to add the flag `-std=c++<version_number>` at compilation time

This script can redirect the standard input and output at execution time like any command in Linux:
* `< <input_file>` 
* `> <output_file>` 

The script run these commands in order:
```bash
g++ <cpp_file> -o <cpp_file_name>.out -std=c++<version_number> -DDEBUG
```

```bash
./<cpp_file_name>.out
```

If any of them failed, will output the error and finish the execution.


## Help

**Got a question?**

File a GitHub [issue](https://github.com/akotadi/Scripts/issues) or contact me at: 
[![E-Mail](https://img.shields.io/badge/email-hello@cloudposse.com-blue.svg)][email].

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/akotadi/Scripts/issues) to report any bugs or file feature requests.


## License 

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

GNU GENERAL PUBLIC LICENSE  
Version 3, 29 June 2007

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

## Contributors
* Manuel CH: [<img title="Akotadi" src="http://www.iconninja.com/ico/16/github-4286.ico"/>][github] [akotadi][github]



  [github]: https://github.com/akotadi/
  [email]: mailto:manuel_7795@hotmail.com?subject=Scripts-Repository&body=https://github.com/akotadi/Scripts


