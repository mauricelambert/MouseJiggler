![MouseJiggler Logo](https://mauricelambert.github.io/info/nim/security/MouseJiggler_small.png "MouseJiggler logo")

# MouseJiggler

## Description

This program generates mouse and keyboard events to simulate user activity, useful to maintain online status, to avoid productivity tracking and prevent the system from entering sleep mode.

## Requirements

 - No requirements

## Download

 - https://github.com/mauricelambert/MouseJiggler/releases

## Compilation

```bash
nim --app:gui c --stackTrace:off  --lineTrace:off --checks:off --assertions:off -d:release -d=mingw --opt:size --passl:"-s" MouseJiggler.nim
```

## Licence

Licensed under the [GPL, version 3](https://www.gnu.org/licenses/).
