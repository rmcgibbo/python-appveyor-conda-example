import sys
import subprocess
import shutil
 
f = subprocess.check_output(['conda', 'build', sys.argv[1], '--output'], shell=True)
path = [line.strip() for line in f.split('\n') if line.strip().endswith('.bz2')][0]
shutil.move(path, '.')