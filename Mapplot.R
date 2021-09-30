library(odbc)
library(DBI)
library(maps)
library(ggplot2)

#Connecting to database and quering data
con <- dbConnect(odbc::odbc(), "Local")
cities <- DBI::dbGetQuery(con,"SELECT TOP 20 
                                CityName, 
                                Latitude,
                                Longitude,
                                Population,
                                CountryName
                                FROM [General].dbo.worldcities 
                                JOIN [General].dbo.Countries 
                                  ON worldcities.CountryId = Countries.CountryId 
                                WHERE CountryCode = 'US' 
                                ORDER BY Population DESC")
# changing long/lat to numeric
cities$Latitude <- as.numeric(cities$Latitude)
cities$Longitude <- as.numeric(cities$Longitude)
us <- map_data("state") 
# Map plot
map_plot <- ggplot(us)  + geom_map(map=us, fill="white", color="black" , aes(map_id=region))
map_plot <- map_plot + geom_point(data = cities ,aes(x = Longitude, y =Latitude , size=Population) )                                                            
map_plot <- map_plot + coord_map() + expand_limits(x = us$long, y=us$lat) +ggtitle("Population of US Cities") 
map_plot <- map_plot + theme(axis.line=element_blank(),axis.text.x=element_blank(),
                                   axis.text.y=element_blank(),axis.ticks=element_blank(),
                                   axis.title.x=element_blank())

map_plot