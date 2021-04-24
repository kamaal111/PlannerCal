#!/bin/sh

#  pre-compile.sh
#  PlannerCal
#
#  Created by Kamaal M Farah on 17/04/2021.
#  

export PATH=$PATH:/usr/local/go/bin

set -o pipefail && go run Scripts/spm-acknowledgements/*.go -output Shared/Resources || exit 1

if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi