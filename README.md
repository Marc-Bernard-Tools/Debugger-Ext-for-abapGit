![Version](https://img.shields.io/endpoint?url=https://shield.abap.space/version-shield-json/github/Marc-Bernard-Tools/Debugger-Ext-for-abapGit/src/zabapgit_ext_debugger.enho.fa4cfd43.abap/version&label=Version&color=blue)

[![License](https://img.shields.io/github/license/Marc-Bernard-Tools/Debugger-Ext-for-abapGit?label=License&color=green)](LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg?color=green)](https://github.com/Marc-Bernard-Tools/.github/blob/main/CODE_OF_CONDUCT.md)
[![REUSE Status](https://api.reuse.software/badge/github.com/Marc-Bernard-Tools/Debugger-Ext-for-abapGit)](https://api.reuse.software/info/github.com/Marc-Bernard-Tools/Debugger-Ext-for-abapGit)

# Debugger Extension for abapGit

Enhancement for the ABAP debugger to jump to the correct trigger location for exception classes that use static methods to raise exceptions like `ZCX_ABAPGIT_EXCEPTION` used in abapGit.

Made by [Marc Bernard Tools](https://marcbernardtools.com/) giving back to the [SAP Community](https://community.sap.com/)

NO WARRANTIES, [MIT License](LICENSE)

## Background

The ABAP debugger has a feature to "show the trigger location" of the last raised exception. The feature works well when `RAISE EXCEPTION` is used directly. However, if you embed `RAISE EXCEPTION` in a static method of your exception class, for example in `ZCX_ABAPGIT_EXCEPTION=>RAISE(...)`, then the debugger will jump to the location inside your static method and not to the location of the method call.  

You can implement a `GET_SOURCE_POSITION` method in your exception class, but unfortunately, the debugger does not call it :shrug:.

## Usage

After installing this enhancement, the debugger will check if an exception class contains the `SRC_INFO` (or `MS_SRC_INFO`) attribute and use it to determine the trigger location of the exception. 

## Prerequisites

- SAP Basis 7.02 or higher
- Add `SRC_INFO` attribute to your exception class

    ```abap
    DATA src_info TYPE tpda_sys_srcinfo.
    ```

- Add `GET_SOURCE_POSITION` method in your exception class

- Add the following to the end of the `CONSTRUCTOR` method of your exception class

    ```abap
    METHOD constructor.

      "...
    
      " Save for debugger
      get_source_position(
        IMPORTING
          program_name = src_info-program
          include_name = src_info-include
          source_line  = src_info-line ).

    ENDMETHOD.
    ```

## Installation

You can install the Debugger Extension for abapGit using [abapGit](https://github.com/abapGit/abapGit) either creating a new online repository for https://github.com/Marc-Bernard-Tools/Debugger-Ext-for-abapGit or downloading the repository [ZIP file](https://github.com/Marc-Bernard-Tools/Debugger-Ext-for-abapGit/archive/main.zip) and creating a new offline repository.

Recommended SAP package: `$ABAPGIT-EXT-DEBUGGER`.

## Contributions

All contributions are welcome! Read our [Contribution Guidelines](CONTRIBUTING.md), fork this repo, and create a pull request.

## About

Made with :heart: in Canada

Copyright 2025 Marc Bernard <https://marcbernardtools.com/>

Follow [@marcfbe](https://twitter.com/marcfbe) on Twitter

<p><a href="https://marcbernardtools.com/"><img width="160" height="65" src="https://marcbernardtools.com/info/MBT_Logo_640x250_on_Gray.png" alt="MBT Logo"></a></p>
