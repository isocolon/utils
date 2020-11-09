from pathlib import Path
from datetime import date, timedelta


start = date(2021, 1, 1)
end   = date(2021, 12, 31)

days = (end - start).days
current = start

root = Path(R'..\2021')

for _ in range(days+1):
    filename = f'{current}.txt'
    fullpath = Path.joinpath(root, filename)
    Path(fullpath).touch()
    current += timedelta(days=1)
