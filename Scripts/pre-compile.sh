#!/bin/sh

#  pre-compile.sh
#  PlannerCal
#
#  Created by Kamaal M Farah on 17/04/2021.
#  

export PATH=$PATH:/usr/local/go/bin

set -o pipefail && sh Scripts/spm-acknowledgements/run.sh || exit 1

if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi