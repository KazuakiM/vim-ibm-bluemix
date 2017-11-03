# vim-ibm-bluemix

[![TravisCI](https://travis-ci.org/KazuakiM/vim-ibm-bluemix.svg?branch=master)](https://travis-ci.org/KazuakiM/vim-ibm-bluemix)
[![AppVeyor](https://ci.appveyor.com/api/projects/status/f2c4uar6px9ob2q2/branch/master?svg=true)](https://ci.appveyor.com/project/KazuakiM/vim-ibm-bluemix/branch/master)
[![Issues](https://img.shields.io/github/issues/KazuakiM/vim-ibm-bluemix.svg?style=flat-square)](https://github.com/KazuakiM/vim-ibm-bluemix/issues)
[![Document](https://img.shields.io/badge/doc-%3Ah%20ibm_bluemix.txt-blue.svg?style=flat-square)](doc/ibm_bluemix.txt)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/KazuakiM/vim-ibm-bluemix/master/LICENSE)

This plugin is IBM Watson API Client.  

Support functions.
* [language-translator](https://www.ibm.com/watson/developercloud/language-translator/api/v2/)

![usage](https://raw.githubusercontent.com/KazuakiM/img/master/docs/vim-ibm-bluemix01.gif)

## Usage

1. You can make account at [IBM HP](https://www.ibm.com/watson/).
1. You set to vimrc or something. I think you should not public this setting
   ```vim
   " e.g. Japanese <- -> English
   let g:ibm_bluemix#config = {
   \    'username': 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
   \    'password': 'xxxxxxxxxxxx',
   \    'source': 'ja',
   \    'target': 'en',
   \}
   ```

## Author

[KazuakiM](https://github.com/KazuakiM/)

## License

This software is released under the MIT License, see LICENSE.
