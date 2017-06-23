# TF 22/06/17
# Graphs with a logo bottom right

####
# Psuedocode ----
# 1. Load packages ---- 

library(grid)
library(png)
library(gtable)
library(ggplot2)
library(ggthemes)
library(dplyr)
library(gridExtra)
library(scales)
library(data.table)
library(RColorBrewer)  

# 2. Create dataframe and create a plot ----
# Many thanks to http://www.r-graph-gallery.com; I didn't create this plot myself, 
# I'm just using the one they produced for illustration purposes to show the logo!
# Full info of the logo used can be found here:

# http://www.r-graph-gallery.com/136-stacked-area-chart/

# Get data into R
set.seed(345)
Sector <- rep(c("S01","S02","S03","S04","S05","S06","S07"),times=7)
Year <- as.numeric(rep(c("1950","1960","1970","1980","1990","2000","2010"),each=7))
Value <- runif(49, 10, 100)
data <- data.frame(Sector,Year,Value)

# Make a plot using ggplot2
d <- ggplot(data, aes(x=Year, y=Value, fill=Sector)) +
  geom_area(colour="black", size=.2, alpha=.4) +
  scale_fill_brewer(palette="Greens", breaks=rev(levels(data$Sector))) +
  theme_minimal() +
  theme(plot.margin=margin(10,10,30,10)) +
  labs(y="", x="",
       title="Wow, a logo in the bottom right corner! ", 
       subtitle = "That is really cool, great work Tom.")


# 3. Read the image into the console ----
img <- readPNG(system.file("img", "Rlogo.png", package="png")) # This is for the base Rlogo
g <- rasterGrob(img)

# If you want to use another .png file, use the following code
# img <- readPNG("Image.png")
# g <- rasterGrob(img)


# 4. Make the shape to insert your image into ----

# We need to think about a grid as a series of quadrilaterals...
size = unit(2, "cm")

# Set up the layout for grid;
heights = unit.c(unit(1, "npc") - size,size)
widths = unit.c(unit(1, "npc") - size, size)
lo = grid.layout(2, 2, widths = widths, heights = heights)

# Show the layout; seriously, run the line of code before so you can see how it works!
grid.show.layout(lo)

# Position the elements within the viewports ----
grid.newpage()
pushViewport(viewport(layout = lo))

# The plot
pushViewport(viewport(layout.pos.row=1:2, layout.pos.col = 1:2))
print(d, newpage=FALSE)
popViewport()

# The logo
pushViewport(viewport(layout.pos.row=2, layout.pos.col = 2))
print(grid.draw(g), newpage=FALSE)
popViewport()
popViewport()

# 5. Save the object ----
g = grid.grab()

grid.newpage()
grid.draw(g)

rm(list=ls())

# 6. Now let's try the same thing but with a google logo ----
# I'm resetting the console and reading the data again 
# because R seems to react badly to multiple plots

# Get the data back in
set.seed(345)
Sector <- rep(c("S01","S02","S03","S04","S05","S06","S07"),times=7)
Year <- as.numeric(rep(c("1950","1960","1970","1980","1990","2000","2010"),each=7))
Value <- runif(49, 10, 100)
data <- data.frame(Sector,Year,Value)

# Plot away
d <- ggplot(data, aes(x=Year, y=Value, fill=Sector)) +
  geom_area(colour="black", size=.2, alpha=.4) +
  scale_fill_brewer(palette="Greens", breaks=rev(levels(data$Sector))) +
  theme_minimal() +
  theme(plot.margin=margin(10,10,30,10)) +
  labs(y="", x="",
       title="Wow, a logo in the bottom right corner! ", 
       subtitle = "That is really cool, great work Tom.")

# Download the logo from wikipedia
y = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1000px-Google_%22G%22_Logo.svg.png"
download.file(y, 'y.png', mode = 'wb')
jj <- readPNG("y.png",native=TRUE)
g <- rasterGrob(jj)

# Set the grid up...
size = unit(2, "cm")

# Set up the layout for grid;
heights = unit.c(unit(1, "npc") - size,size)
widths = unit.c(unit(1, "npc") - size, size)
lo = grid.layout(2, 2, widths = widths, heights = heights)

# Show the layout; seriously, run the line of code before so you can see how it works!
grid.show.layout(lo)

# Position the elements within the viewports 
grid.newpage()
pushViewport(viewport(layout = lo))

# The plot
pushViewport(viewport(layout.pos.row=1:2, layout.pos.col = 1:2))
print(d, newpage=FALSE)
popViewport()

# The logo
pushViewport(viewport(layout.pos.row=2, layout.pos.col = 2))
print(grid.draw(g), newpage=FALSE)
popViewport()
popViewport()

# Save the object 
g = grid.grab()

grid.newpage()
grid.draw(g)


####