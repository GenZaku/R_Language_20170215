# R 的 ggmap 套件：繪製地圖與資料分佈圖，空間資料視覺化
#   https://blog.gtwang.org/r/r-ggmap-package-spatial-data-visualization/

if (!require(ggmap)) install.packages('ggmap')
library(ggmap)

#if (!require(mapproj)) install.packages('mapproj')
#library(mapproj)

# 地圖的位置是透過 location 參數來指定，直接輸入地名即可，而 zoom 則是控制地圖的大小。這是畫出來的圖：
map <- get_map(location = 'Taiwan', zoom = 7)
ggmap(map)

# get_map 有相當多的參數可以使用，language 可以設定地圖上文字標示的語言：
map <- get_map(location = 'Taiwan', zoom = 7,
               language = "zh-TW")
ggmap(map)

# location 參數也可以接受經緯度，需要畫出比較精確的位置時，可以這樣使用：
map <- get_map(location = c(lon = 120.233937, lat = 22.993013),
               zoom = 10, language = "zh-TW")
ggmap(map)

# maptype 參數：指定地圖的類型（預設是 terrain）：
map <- get_map(location = c(lon = 120.233937, lat = 22.993013),
               zoom = 10, language = "zh-TW", maptype = "terrain")
ggmap(map)

# roadmap 地圖
map <- get_map(location = c(lon = 120.233937, lat = 22.993013),
               zoom = 10, language = "zh-TW", maptype = "roadmap")
ggmap(map)

# satellite 地圖
map <- get_map(location = c(lon = 120.233937, lat = 22.993013),
               zoom = 10, language = "zh-TW", maptype = "satellite")
ggmap(map)

# hybrid 地圖
map <- get_map(location = c(lon = 120.233937, lat = 22.993013),
               zoom = 10, language = "zh-TW", maptype = "hybrid")
ggmap(map)

# toner-lite 地圖
map <- get_map(location = c(lon = 120.233937, lat = 22.993013),
               zoom = 10, language = "zh-TW", maptype = "toner-lite")
ggmap(map)

# ggmap 的 darken 這個參數可以讓地圖變暗（或是變亮）：
map <- get_map(location = c(lon = 120.233937, lat = 22.993013),
               zoom = 10, language = "zh-TW")
ggmap(map, darken = 0.5)

# 若要讓地圖變亮，可以執行：
map <- get_map(location = c(lon = 120.233937, lat = 22.993013),
               zoom = 10, language = "zh-TW")
ggmap(map, darken = c(0.5, "white"))

## 將資料畫在地圖上
# 從政府資料開放平臺上下載紫外線即時監測資料的 csv 檔，接著將資料讀進 R 中。（這裡我用的資料是 2015/11/16 15:22:15 的資料）
# http://data.gov.tw/node/6076

uv <- read.csv("http://opendata.epa.gov.tw/ws/Data/UV/?format=csv", sep = ',', fileEncoding = "UTF-8-BOM")  # http://stackoverflow.com/questions/21624796/read-a-utf-8-text-file-with-bom
lon.deg <- sapply((strsplit(as.character(uv$WGS84Lon), ",")), as.numeric)
uv$lon <- lon.deg[1, ] + lon.deg[2, ]/60 + lon.deg[3, ]/3600
lat.deg <- sapply((strsplit(as.character(uv$WGS84Lat), ",")), as.numeric)
uv$lat <- lat.deg[1, ] + lat.deg[2, ]/60 + lat.deg[3, ]/3600

map <- get_map(location = 'Taiwan', zoom = 7)
ggmap(map) + geom_point(aes(x = lon, y = lat, size = UVI), data = uv)

# 依照資料發佈單位（PublishAgency）分開畫圖：
ggmap(map) +
  geom_point(aes(x = lon, y = lat, size = UV), data = uv) +
  facet_grid( ~ PublishAgency)