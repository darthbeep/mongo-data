#see the perl file for actual info.

import sys
import subprocess
var = "test"
pipe = subprocess.Popen(["perl", "mongo.pl", var], stdin=subprocess.PIPE)
pipe.communicate(var)
pipe.stdin.close()
