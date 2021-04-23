#!/bin/sh

#  pre-compile.sh
#  PlannerCal
#
#  Created by Kamaal M Farah on 17/04/2021.
#  

sh Scripts/spm-acknowledgements/run.sh

if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi