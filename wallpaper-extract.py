from os import environ
from glob import glob
from shutil import copyfile
from pathlib import Path
from imghdr import what as GetExtension

from PIL import Image


onedrivedir = environ['ONEDRIVE']
wallpaperdir = Path().joinpath(onedrivedir, R'Photos\wallpapers')
portraitdir = Path().joinpath(wallpaperdir, 'portrait')
landscapedir = Path().joinpath(wallpaperdir, 'landscape')

# R'C:\Users\root\OneDrive\Photos\wallpapers'

localappdata = environ['LOCALAPPDATA']
imgdir = R'Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets'
srcdir = Path().joinpath(localappdata, imgdir) 

# R'C:\Users\root\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets'

def IsLandscape(dimensions):
    return dimensions == (1920, 1080)


def IsPortrait(dimensions):
    return dimensions == (1080, 1920)


def IsWallpaper(dimensions):
    return IsLandscape(dimensions) or IsPortrait(dimensions)


def GetDimensions(filename):
    return Image.open(filename).size


#
# (1) Check if file is a legit wallpaper
# (2) Add correct extension to file
# (3) Copy file to target directory
#
try:
    files = glob(f'{srcdir}\*')
    for file in files:
        dimensions = GetDimensions(file)
        if not IsWallpaper(dimensions):
            continue
        
        extension = GetExtension(file)
        src = Path(file)

        destdir = portraitdir if IsPortrait(dimensions) else landscapedir
        newfilename = f'{src.name}.{extension}'
        dst = Path().joinpath(destdir, newfilename)
        copyfile(src, dst)
        print(fR'[*] Copied \{Path(destdir).name}\{newfilename}!')
except Exception as e:
    print('[-] Exception: ', e)
