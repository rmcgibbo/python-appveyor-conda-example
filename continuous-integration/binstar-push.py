import os
import glob
import subprocess
import traceback

token = os.environ['BINSTAR_TOKEN']
cmd = ['anaconda_server', '-t', token, 'upload', '--force']
cmd.extend(glob.glob('*.tar.bz2'))
try:
    subprocess.check_call(cmd)
except subprocess.CalledProcessError:
    traceback.print_exc()

