# Sugar 🍬

[![Swift 4.0](https://img.shields.io/badge/swift-4.0-orange.svg)](#)
[![@nugmanoff](https://img.shields.io/badge/contact-%40nugmanoff-brightgreen.svg)](https://t.me/nugmanoff)

Trivial command-line tool build in educational purposes & for personal use.  
Allows to easily add pod entry to CocoaPods Podfile without any need to open it with text editor.

## Installation

The easiest way to install Sugar is using Swift Package Manager:

```
$ git clone git@github.com:nugmanoff/sugar.git
$ cd sugar
$ swift build -c release -Xswiftc -static-stdlib
$ cp -f .build/release/sugar /usr/local/bin/sugar
```
## Usage

Without any specifications (have to be executed in the directory where Podfile is located).
```
sugar add Alamofire
```
Specifies particular version of pod to install.
```
sugar add Alamofire -v 4.0
```
Specifies path of Podfile to update.
```
sugar add Alamofire -p /Users/Aidar/Workspace/CLI/sugar
```

## Dependencies

- [Commander](https://github.com/kylef/Commander)   
- [SwiftLint](https://github.com/realm/SwiftLint)
- [Files](https://github.com/JohnSundell/Files)
- [Releases](https://github.com/JohnSundell/Releases)

## Help, feedback or suggestions?

Feel free to contact me on [Telegram](https://t.me/nugmanoff) for discussions, news & announcements about Indexify & other projects.
