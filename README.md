# Scripts 


This `Scripts` is a collection of scripts developed to made easier my life.

It's 100% Open Source and licensed under the [GPL3](LICENSE).

---

Table of Contents
* [Scripts](#scripts)
  * [cpptest.bashrc](#cpptestbashrc)
  * [vhdltest.bashrc](#vhdltestbashrc)
  * [ubuntu_icpc_config.bashrc](#ubuntu_icpc_configbashrc)
* [Help](#help)
* [Contributing](#scripts)
  * [bugs](#Bug_Reports_&_Feature_Requests)
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
At the end, the script will erase the execution file (`.out`).

### vhdltest.bashrc

This script was made to quickly test my `.vhdl` files. Typical uses are:
```bash
# Compile, execute and clean a vhdl file:
testvhdl <vhdl_file>
```
If the `<vhdl_file>` doesn't end in `.vhd`, the script won't run. Also, if the `<vhdl_file>` doesn't exist, the script will exit.

The script also defines some flags:
* `-s <test_bench_vhdl_file>`  to simulate the vhdl file using `gtkwave`

The script run these commands in order:

```bash
ghdl -a <vhdl_file>
ghdl -e <vhdl_file_name>
ghdl -r <vhdl_file_name>
```

And if you want to simulate the program:

```bash
ghdl -a <test_bench_vhdl_file>
ghdl -e <test_bench_vhdl_file_name>
ghdl -r <test_bench_vhdl_file_name> --vcd=<test_bench_vhdl_file_name>.vcd
gtkwave <test_bench_vhdl_file_name>.vcd
```

If any of them failed, will output the error and finish the execution.
At the end, the script will erase the object files (`.o`), the test bench file (`.vcd`) and the library work file (`.cf`).

### ubuntu_icpc_config.bashrc

This script was made to quickly config an Ubuntu enviroment for ACM ICPC contest. Typical uses are:
```bash
# Set up the system with the languages that I used and my editors with a few configurations
ubuntu_icpc_config
```

The script also defines some flags:
* `-d`  to use a few debug options

The script made an update and upgrade at the beginning. Later, start with the languages configuration running this commands in order:

```bash
# Installing git
sudo apt -y install git-core

# Installing gcc
sudo apt -y install gcc

# Installing g++
sudo apt -y install g++

# Installing python
sudo apt -y install python

# Installing python3
sudo apt -y install python3

# Installing java
sudo apt -y install openjdk-11-jdk
```

One finished the set up of the programming languages, begins the set up of the editors with the following commands:

```bash
# Vim
sudo apt -y install vim

# Sublime Text 3
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt -y upgrade
sudo apt -y install sublime-text

# AStyle Formatter Plugin
mkdir ~/.config/sublime-text-3/Packages/
(cd ~/.config/sublime-text-3/Packages/ && git clone git://github.com/timonwong/SublimeAStyleFormatter.git)
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


