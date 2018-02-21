import subprocess
var = "test"
pipe = subprocess.Popen(["perl", "mongo.pl", var], stdin=subprocess.PIPE)
pipe.stdin.write(var)
pipe.stdin.close()
