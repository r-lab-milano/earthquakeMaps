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