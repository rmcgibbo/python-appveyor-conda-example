import os
import sys
import stat
import shutil

def remove_readonly(func, path, excinfo):
    os.chmod(path, stat.S_IWRITE)
    func(path)

def main():
    i = 0
    while os.path.exists(sys.argv[1]) and i < 10:
        try:
            shutil.rmtree(sys.argv[1], onerror=remove_readonly)
        except Exception as e:
            print "Error"
            print e
        i += 1

if __name__ == '__main__':
    main()
