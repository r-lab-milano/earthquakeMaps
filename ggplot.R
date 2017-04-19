## 

require(dplyr)
require(ggplot2)

df <- read.table('./inst/csv/clean_tbl_eq.csv', sep = ',', head = T , stringsAsFactors = FALSE)


dft <- df %>% mutate(
    depth_f = cut(depth , breaks = c(0, 2 , 4, 8, Inf),include.lowest = T ),
    mag_f = cut(mag , breaks = c(0, 3, 5, Inf) ,include.lowest = T),
    lat_f = cut(latitude , breaks = pretty(latitude, n = 3)),
    lon_f = cut(longitude , breaks = pretty(longitude, n = 3))
    
) %>% 
    tbl_df()


ggplot(dft , aes(lat_f, mag)) + geom_violin() + coord_flip()
ggplot(dft , aes(lon_f, mag)) + geom_violin()
ggplot(dft , aes(lat_f, depth)) + geom_violin() + coord_flip()
ggplot(dft , aes(lon_f, depth)) + geom_boxplot() #geom_violin()

ggplot(dft, aes(latitude, longitude)) +  
    stat_binhex() +
    facet_grid(aes(mag_f, depth_f))


####### Added 12/04/2017

par(mfrow=c(4,5))

for(i in 1:20){
    summary(tbl_eq$mag[tbl_eq$year == 1987+i])
    hist(tbl_eq$mag[tbl_eq$year == 1987+i], col="black", main = "")
}

library(dplyr)
library(ggplot2)

hexbins <- function(data, minmag=3){
    depth_f <- cut(tbl_eq$depth, breaks = pretty(tbl_eq$depth, n = 8))
    
    dft <- data %>% filter(mag >= minmag) %>% mutate(
        depth_f = cut(depth, breaks= pretty(depth, n = 8)),
        mag_f = cut(mag, breaks= pretty(mag, n = 8)),
        lat_f = cut(latitude, breaks= pretty(latitude, n = 8)),
        lon_f = cut(longitude, breaks= pretty(longitude, n = 8))) %>%
        tbl_df()
    
    ggplot(dft, aes(latitude, longitude))+stat_binhex()
}


hexbins(data = tbl_eq, minmag = 6)

minmag=3
dft <- tbl_eq %>% filter(mag >= minmag) %>% mutate(
    depth_f = cut(depth, breaks= pretty(depth, n = 8),include.lowest = T),
    mag_f = cut(mag, breaks= pretty(mag, n = 8),include.lowest = T),
    lat_f = cut(latitude, breaks= pretty(latitude, n = 8),include.lowest=T),
    lon_f = cut(longitude, breaks= pretty(longitude, n = 8)), include.lowest=T) %>%
    tbl_df()

ggplot(dft, aes( longitude, latitude, color=mag_f)) + geom_jitter()
ggplot(dft, aes( longitude, latitude, color=depth_f)) + geom_jitter()

table(tbl_eq$mag)
sum(is.na(tbl_eq$mag))
table(dft$mag_f)
sum(is.na(dft$mag_f))
