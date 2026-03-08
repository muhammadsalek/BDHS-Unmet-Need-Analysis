
# ============================================================
# 1️⃣ INSTALL & LOAD ADVANCED SPATIAL PACKAGES
# ============================================================

packages <- c(
  "sf","readxl","dplyr","stringr","janitor",
  "ggplot2","ggspatial","ggtext",
  "tmap","spdep","spatialreg",
  "rmapshaper","viridis","classInt",
  "patchwork","tidyverse"
)

installed <- packages %in% rownames(installed.packages())
if(any(!installed)){
  install.packages(packages[!installed], dependencies = TRUE)
}

invisible(lapply(packages, library, character.only = TRUE))

# ============================================================
# 2️⃣ FILE PATHS
# ============================================================

excel_path <- "F:/BDHS/Unmeet need/Data/division_global_unmet_need_percentages.xlsx"
shp_path   <- "D:/Research/BDHS Research/Nepal/SBA/Bangladesh/Spatial/spatial/bd_shp/bd.shp"

# ============================================================
# 3️⃣ IMPORT DATA
# ============================================================

excel_data <- read_excel(excel_path)
bd_shape <- st_read(shp_path)

# ============================================================
# 4️⃣ CLEAN COLUMN NAMES
# ============================================================

excel_data <- janitor::clean_names(excel_data)
bd_shape   <- janitor::clean_names(bd_shape)

# ============================================================
# 5️⃣ CHECK COLUMN NAMES
# ============================================================

cat("\nExcel Columns:\n")
print(colnames(excel_data))

cat("\nShapefile Columns:\n")
print(colnames(bd_shape))


library(dplyr)
library(stringr)

# Excel divisions
excel_data <- excel_data %>%
  mutate(division_std = str_to_title(str_trim(division)))

# Shapefile divisions (use 'name' column)
bd_shape <- bd_shape %>%
  mutate(division_std = str_to_title(str_trim(name)))

# Unique division names
excel_divisions <- unique(excel_data$division_std)
shape_divisions <- unique(bd_shape$division_std)

cat("\nUnique divisions in Excel:\n")
print(excel_divisions)

cat("\nUnique divisions in Shapefile:\n")
print(shape_divisions)







# ============================================================
# 1️⃣ RECODES TO MATCH DIVISION NAMES
# ============================================================

excel_data <- excel_data %>%
  mutate(division_std = recode(division_std,
                               "Barishal" = "Barisal",
                               "Chattogram" = "Chittagong"))

# Optional: check again
excel_only <- setdiff(unique(excel_data$division_std),
                      unique(bd_shape$division_std))
shape_only <- setdiff(unique(bd_shape$division_std),
                      unique(excel_data$division_std))

cat("\nDivisions in Excel NOT in Shapefile after recode:\n")
print(excel_only)

cat("\nDivisions in Shapefile NOT in Excel after recode:\n")
print(shape_only)

# ============================================================
# 2️⃣ MERGE EXCEL DATA WITH SHAPEFILE
# ============================================================

library(dplyr)
bd_map <- bd_shape %>%
  left_join(excel_data, by = "division_std")

# Check merge
summary(bd_map)









# ============================================================
# 1️⃣ CONVERT TO sp OBJECT FOR spdep
# ============================================================

library(sp)
bd_sp <- as_Spatial(bd_map)  # needed for spdep functions

# ============================================================
# 2️⃣ CREATE QUEEN CONTIGUITY SPATIAL WEIGHTS
# ============================================================

library(spdep)
nb_queen <- poly2nb(bd_sp, queen = TRUE)          # neighbors list
lw_queen <- nb2listw(nb_queen, style = "W", zero.policy = TRUE)  # weights

# Optional: check neighbor structure
print(nb_queen)

# ============================================================
# 3️⃣ GLOBAL MORAN'S I
# ============================================================

moran_global <- moran.test(bd_map$unmet_global_pct, lw_queen, zero.policy = TRUE)
print(moran_global)

# ============================================================
# 4️⃣ LOCAL MORAN'S I (LISA)
# ============================================================

local_moran <- localmoran(bd_map$unmet_global_pct, lw_queen, zero.policy = TRUE)

# Add LISA results to bd_map
bd_map$Ii <- local_moran[, "Ii"]       # Local Moran statistic
bd_map$Z.Ii <- local_moran[, "Z.Ii"]   # Z-score
bd_map$Pr.z <- local_moran[, "Pr(z > 0)"]  # p-value

# ============================================================
# 5️⃣ CLASSIFY LISA CLUSTERS
# ============================================================

bd_map <- bd_map %>%
  mutate(lisa_cluster = case_when(
    Z.Ii > 1.96 & unmet_global_pct > mean(unmet_global_pct, na.rm = TRUE) ~ "High-High",
    Z.Ii > 1.96 & unmet_global_pct < mean(unmet_global_pct, na.rm = TRUE) ~ "Low-High",
    Z.Ii < -1.96 & unmet_global_pct > mean(unmet_global_pct, na.rm = TRUE) ~ "High-Low",
    Z.Ii < -1.96 & unmet_global_pct < mean(unmet_global_pct, na.rm = TRUE) ~ "Low-Low",
    TRUE ~ "Not Significant"
  ))

# ============================================================
# 6️⃣ PLOT LISA CLUSTER MAP
# ============================================================

library(ggplot2)
library(ggspatial)
library(ggtext)
library(viridis)

ggplot(bd_map) +
  geom_sf(aes(fill = lisa_cluster), color = "black", size = 0.3) +
  scale_fill_manual(
    values = c("High-High" = "red", "Low-Low" = "blue",
               "High-Low" = "orange", "Low-High" = "cyan",
               "Not Significant" = "grey80"),
    name = "LISA Cluster"
  ) +
  ggspatial::annotation_scale(location = "bl", width_hint = 0.4) +
  ggspatial::annotation_north_arrow(location = "tr",
                                    which_north = "true",
                                    style = north_arrow_fancy_orienteering) +
  labs(title = "LISA Cluster Map of Unmet Need (%) in Bangladesh",
       subtitle = "Division Level Analysis",
       caption = "Data Source: BDHS") +
  theme_minimal() +
  theme(plot.title = ggtext::element_markdown(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12),
        legend.position = "right")











# ============================================================
# 4️⃣ LOCAL MORAN'S I (LISA) – corrected
# ============================================================

local_moran <- localmoran(bd_map$unmet_global_pct, lw_queen, zero.policy = TRUE)

# Add LISA results to bd_map
bd_map$Ii <- local_moran[, "Ii"]       # Local Moran statistic
bd_map$Z.Ii <- local_moran[, "Z.Ii"]   # Z-score
# Removed: Pr.z (not available)

# ============================================================
# 5️⃣ CLASSIFY LISA CLUSTERS
# ============================================================

bd_map <- bd_map %>%
  mutate(lisa_cluster = case_when(
    Z.Ii > 1.96 & unmet_global_pct > mean(unmet_global_pct, na.rm = TRUE) ~ "High-High",
    Z.Ii > 1.96 & unmet_global_pct < mean(unmet_global_pct, na.rm = TRUE) ~ "Low-High",
    Z.Ii < -1.96 & unmet_global_pct > mean(unmet_global_pct, na.rm = TRUE) ~ "High-Low",
    Z.Ii < -1.96 & unmet_global_pct < mean(unmet_global_pct, na.rm = TRUE) ~ "Low-Low",
    TRUE ~ "Not Significant"
  ))

# ============================================================
# 6️⃣ PLOT LISA CLUSTER MAP
# ============================================================

library(ggplot2)
library(ggspatial)
library(ggtext)
library(viridis)

ggplot(bd_map) +
  geom_sf(aes(fill = lisa_cluster), color = "black", size = 0.3) +
  scale_fill_manual(
    values = c("High-High" = "red", "Low-Low" = "blue",
               "High-Low" = "orange", "Low-High" = "cyan",
               "Not Significant" = "grey80"),
    name = "LISA Cluster"
  ) +
  ggspatial::annotation_scale(location = "bl", width_hint = 0.4) +
  ggspatial::annotation_north_arrow(location = "tr",
                                    which_north = "true",
                                    style = north_arrow_fancy_orienteering) +
  labs(title = "LISA Cluster Map of Unmet Need (%) in Bangladesh",
       subtitle = "Division Level Analysis",
       caption = "Data Source: BDHS") +
  theme_minimal() +
  theme(plot.title = ggtext::element_markdown(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12),
        legend.position = "right")














# ============================================================
# 1️⃣ CLASSIFY ALL DIVISIONS BY Unmet Need (FORCED COLORS)
# ============================================================

bd_map <- bd_map %>%
  mutate(lisa_cluster_forced = case_when(
    unmet_global_pct > mean(unmet_global_pct, na.rm = TRUE) ~ "High",
    unmet_global_pct <= mean(unmet_global_pct, na.rm = TRUE) ~ "Low"
  ))

# ============================================================
# 2️⃣ PLOT MAP WITH FORCED COLORS
# ============================================================

library(ggplot2)
library(ggspatial)
library(ggtext)
library(viridis)

ggplot(bd_map) +
  geom_sf(aes(fill = lisa_cluster_forced), color = "black", size = 0.3) +
  scale_fill_manual(
    values = c("High" = "red", "Low" = "blue"),
    name = "Unmet Need Level"
  ) +
  ggspatial::annotation_scale(location = "bl", width_hint = 0.4) +
  ggspatial::annotation_north_arrow(location = "tr",
                                    which_north = "true",
                                    style = north_arrow_fancy_orienteering) +
  labs(title = "Unmet Need (%) by Division in Bangladesh",
       subtitle = "Division Level – Colored by Above/Below Mean",
       caption = "Data Source: BDHS") +
  theme_minimal() +
  theme(plot.title = ggtext::element_markdown(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12),
        legend.position = "right")

















library(ggplot2)
library(ggspatial)
library(ggtext)
library(viridis)

# Create choropleth map based on actual values
ggplot(bd_map) +
  geom_sf(aes(fill = unmet_global_pct), color = "black", size = 0.3) +
  
  # Color gradient
  scale_fill_viridis_c(option = "magma",
                       direction = -1,
                       name = "Unmet Need (%)") +
  
  # Add north arrow and scale bar
  ggspatial::annotation_scale(location = "bl", width_hint = 0.4) +
  ggspatial::annotation_north_arrow(location = "tr",
                                    which_north = "true",
                                    style = north_arrow_fancy_orienteering) +
  
  # Titles and labels
  labs(title = "Spatial Distribution of Unmet Need (%) in Bangladesh",
       subtitle = "Division Level Choropleth Map",
       caption = "Data Source: BDHS") +
  
  # Theme
  theme_minimal() +
  theme(plot.title = ggtext::element_markdown(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12),
        legend.position = "right")















library(ggplot2)
library(ggspatial)
library(ggtext)
library(viridis)
library(sf)

# ===============================
# 1️⃣ Choropleth Map with Labels
# ===============================

ggplot(bd_map) +
  geom_sf(aes(fill = unmet_global_pct), color = "white", size = 0.6) +  # borders in white for clear divisions
  geom_sf_text(aes(label = division_std), size = 4, color = "black", fontface = "bold") + # division labels
  
  # Viridis palette (Nature/Community friendly)
  scale_fill_viridis_c(option = "plasma", direction = -1, name = "Unmet Need (%)") +
  
  # Latitude / Longitude grid
  coord_sf(expand = FALSE) +
  theme_minimal() +
  
  # Frame around map
  theme(panel.border = element_rect(color = "black", fill = NA, size = 1.2),
        plot.title = ggtext::element_markdown(size = 18, face = "bold", color = "#2c3e50"),
        plot.subtitle = element_text(size = 14, face = "italic", color = "#34495e"),
        plot.caption = element_text(size = 10, color = "#7f8c8d"),
        legend.position = "right") +
  
  # Titles
  labs(title = "Spatial Distribution of Unmet Need for Family Planning",
       subtitle = "Division Level Analysis, Bangladesh",
       caption = "Data Source: BDHS") +
  
  # Scale bar and north arrow
  ggspatial::annotation_scale(location = "bl", width_hint = 0.3, style = "ticks") +
  ggspatial::annotation_north_arrow(location = "tr",
                                    which_north = "true",
                                    style = north_arrow_fancy_orienteering,
                                    pad_x = unit(0.1, "in"),
                                    pad_y = unit(0.1, "in")) +
  
  # Grid lines for lat/lon
  theme(panel.grid.major = element_line(color = "grey80", linetype = "dashed"),
        panel.grid.minor = element_blank())














library(ggplot2)
library(ggspatial)
library(sf)
library(viridis)

# ===============================
# Single Clean & Polished Choropleth Map
# ===============================

# Choose one of these palettes by uncommenting the desired line
#palette_fill <- scale_fill_viridis_c(option = "plasma", direction = -1, name = "Unmet Need (%)")  # Bright Plasma
 #palette_fill <- scale_fill_viridis_c(option = "magma", direction = -1, name = "Unmet Need (%)")  # Warm Magma
#palette_fill <- scale_fill_viridis_c(option = "inferno", direction = -1, name = "Unmet Need (%)") # Dark Inferno
 #palette_fill <- scale_fill_viridis_c(option = "cividis", direction = -1, name = "Unmet Need (%)") # High contrast
#palette_fill <- scale_fill_gradient(low = "#a1d99b", high = "#005a32", name = "Unmet Need (%)")  # Green Gradient
 palette_fill <- scale_fill_gradientn(colors = c("#fee0d2", "#fc9272", "#de2d26"), name = "Unmet Need (%)")  # Red-Orange

# Plot
ggplot(bd_map) +
  geom_sf(aes(fill = unmet_global_pct), color = "white", size = 0.6) +      # Division borders
  geom_sf_text(aes(label = division_std), size = 4, color = "black", fontface = "bold") +  # Division labels
  palette_fill +                                                            # Chosen palette
  coord_sf(expand = FALSE) +                                                # Correct coordinates
  theme_minimal() +
  theme(panel.border = element_rect(color = "black", fill = NA, size = 1.2), # Frame around map
        legend.position = "right",
        panel.grid.major = element_line(color = "grey80", linetype = "dashed"),
        panel.grid.minor = element_blank()) +
  ggspatial::annotation_scale(location = "bl", width_hint = 0.3, style = "ticks") +
  ggspatial::annotation_north_arrow(location = "tr",
                                    which_north = "true",
                                    style = north_arrow_fancy_orienteering,
                                    pad_x = unit(0.1, "in"),
                                    pad_y = unit(0.1, "in"))















library(ggplot2)
library(ggspatial)
library(sf)

# ===============================
# Single Polished Choropleth Map
# ===============================

palette_fill <- scale_fill_gradientn(
  colors = c("#fee0d2", "#fc9272", "#de2d26"),
  name = "Unmet Need (%)"
)

ggplot(bd_map) +
  geom_sf(aes(fill = unmet_global_pct), color = "white", size = 0.6) +   # Division borders
  geom_sf_text(aes(label = division_std), size = 3, color = "black", fontface = "bold") +  # Smaller font
  palette_fill +                                                           # Red-Orange palette
  coord_sf(expand = FALSE) +                                               # Correct coordinates
  theme_minimal() +
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1.2),  # Frame around map
    legend.position = "right",
    panel.grid.major = element_line(color = "grey80", linetype = "dashed"),
    panel.grid.minor = element_blank()
  ) +
  ggspatial::annotation_scale(location = "bl", width_hint = 0.3, style = "ticks") +
  ggspatial::annotation_north_arrow(location = "tr",
                                    which_north = "true",
                                    style = north_arrow_fancy_orienteering,
                                    pad_x = unit(0.1, "in"),
                                    pad_y = unit(0.1, "in"))

















library(ggplot2)
library(ggspatial)
library(sf)

# ===============================
# Polished Choropleth Map with Wider Frame Border
# ===============================

palette_fill <- scale_fill_gradientn(
  colors = c("#fee0d2", "#fc9272", "#de2d26"),
  name = "Unmet Need (%)"
)

ggplot(bd_map) +
  geom_sf(aes(fill = unmet_global_pct), color = "white", size = 0.6) +   # Division borders
  geom_sf_text(aes(label = division_std), size = 3, color = "black", fontface = "bold") +  # Smaller font
  palette_fill +                                                           # Red-Orange palette
  coord_sf(expand = FALSE) +                                               # Correct coordinates
  theme_minimal() +
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 2.5),  # Wider frame border
    legend.position = "right",
    panel.grid.major = element_line(color = "grey80", linetype = "dashed"),
    panel.grid.minor = element_blank()
  ) +
  ggspatial::annotation_scale(location = "bl", width_hint = 0.3, style = "ticks") +
  ggspatial::annotation_north_arrow(location = "tr",
                                    which_north = "true",
                                    style = north_arrow_fancy_orienteering,
                                    pad_x = unit(0.1, "in"),
                                    pad_y = unit(0.1, "in"))
























library(ggplot2)
library(ggspatial)
library(sf)

# Red-Orange palette
palette_fill <- scale_fill_gradientn(
  colors = c("#fee0d2", "#fc9272", "#de2d26"),
  name = "Unmet Need (%)"
)

ggplot(bd_map) +
  geom_sf(aes(fill = unmet_global_pct), color = "white", size = 0.6) +  # Division borders
  geom_sf_text(aes(label = division_std), size = 2.5, color = "black", fontface = "bold") +  # Labels
  palette_fill +
  
  # Increase map size inside the plot area
  coord_sf(expand = FALSE, clip = "on") +  
  
  # Minimal clean theme
  theme_minimal() +
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1),   # thin frame
    legend.position = "right",
    panel.grid.major = element_line(color = "grey80", linetype = "dashed"),
    panel.grid.minor = element_blank(),
    plot.margin = margin(t = 5, r = 5, b = 5, l = 5, unit = "pt")       # reduce space around
  ) +
  
  # North arrow and scale bar
  ggspatial::annotation_scale(location = "bl", width_hint = 0.3, style = "ticks") +
  ggspatial::annotation_north_arrow(location = "tr",
                                    which_north = "true",
                                    style = north_arrow_fancy_orienteering,
                                    pad_x = unit(0.05, "in"),
                                    pad_y = unit(0.05, "in"))













library(ggplot2)
library(ggspatial)
library(sf)
library(ggtext)

# Red-Orange palette
palette_fill <- scale_fill_gradientn(
  colors = c("#fee0d2", "#fc9272", "#de2d26"),
  name = "Unmet Need (%)"
)

ggplot(bd_map) +
  # Division polygons
  geom_sf(aes(fill = unmet_global_pct), color = "white", size = 0.6) +
  
  # Division labels with subtle shadow for readability
  geom_sf_text(aes(label = division_std), size = 2.5, fontface = "bold", color = "black",
               nudge_y = 0, nudge_x = 0, check_overlap = TRUE) +
  
  # Fill color palette
  palette_fill +
  
  # Expand map to fill panel
  coord_sf(expand = FALSE, clip = "on") +
  
  # Clean, polished theme
  theme_minimal(base_size = 12) +
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1),  # thin frame
    legend.position = "right",
    panel.grid.major = element_line(color = "grey85", linetype = "dashed"),
    panel.grid.minor = element_blank(),
    plot.margin = margin(t = 2, r = 2, b = 2, l = 2, unit = "pt")     # tight margins
  ) +
  
  # North arrow and scale bar
  ggspatial::annotation_scale(location = "bl", width_hint = 0.25, style = "ticks") +
  ggspatial::annotation_north_arrow(location = "tr",
                                    which_north = "true",
                                    style = north_arrow_fancy_orienteering,
                                    pad_x = unit(0.03, "in"),
                                    pad_y = unit(0.03, "in"))










library(ggplot2)
library(ggspatial)
library(sf)
library(ggtext)

# Red-Orange palette
palette_fill <- scale_fill_gradientn(
  colors = c("#fee0d2", "#fc9272", "#de2d26"),
  name = "Unmet Need (%)"
)

ggplot(bd_map) +
  # Division polygons
  geom_sf(aes(fill = unmet_global_pct), color = "white", size = 0.6) +
  
  # Division labels
  geom_sf_text(aes(label = division_std), size = 2.5, fontface = "bold", color = "black",
               check_overlap = TRUE) +
  
  # Fill color palette
  palette_fill +
  
  # Expand map to fill panel
  coord_sf(expand = FALSE, clip = "on") +
  
  # Clean theme
  theme_minimal(base_size = 12) +
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1),
    legend.position = "right",
    panel.grid.major = element_line(color = "grey85", linetype = "dashed"),
    panel.grid.minor = element_blank(),
    plot.margin = margin(t = 2, r = 2, b = 2, l = 2, unit = "pt")
  ) +
  
  # Stylish North arrow (Compass) — corrected
  ggspatial::annotation_north_arrow(
    location = "tr",
    which_north = "true",
    pad_x = unit(0.03, "in"),   # move pad_x here
    pad_y = unit(0.03, "in"),   # move pad_y here
    style = north_arrow_fancy_orienteering(
      line_col = "black",       # Arrow line color
      fill = c("white", "red"), # Red tip for N, white background
      text_col = "black",       # N label color
      text_face = "bold",
      text_size = 12
    )
  ) +
  
  # Scale bar
  ggspatial::annotation_scale(location = "bl", width_hint = 0.25, style = "ticks")
































library(ggplot2)
library(ggspatial)
library(sf)
library(ggtext)

# Red-Orange palette
palette_fill <- scale_fill_gradientn(
  colors = c("#fee0d2", "#fc9272", "#de2d26"),
  name = "Unmet Need (%)"
)

ggplot(bd_map) +
  # Division polygons
  geom_sf(aes(fill = unmet_global_pct), color = "white", size = 0.6) +
  
  # Division labels
  geom_sf_text(aes(label = division_std), size = 2.5, fontface = "bold", color = "black",
               check_overlap = TRUE) +
  
  # Fill color palette
  palette_fill +
  
  # Expand map to fill panel
  coord_sf(expand = FALSE, clip = "on") +
  
  # Clean theme with sky-blue background & dashed grid lines
  theme_minimal(base_size = 12) +
  theme(
    panel.background = element_rect(fill = "#e0f7fa", color = NA), # light sky blue background
    plot.background = element_rect(fill = "#e0f7fa", color = NA),
    panel.border = element_rect(color = "black", fill = NA, size = 1),
    legend.position = "right",
    panel.grid.major = element_line(color = "#81d4fa", linetype = "dashed"), # light blue dashed grid
    panel.grid.minor = element_blank(),
    plot.margin = margin(t = 2, r = 2, b = 2, l = 2, unit = "pt")
  ) +
  
  # Stylish North arrow (Compass)
  ggspatial::annotation_north_arrow(
    location = "tr",
    which_north = "true",
    pad_x = unit(0.03, "in"),
    pad_y = unit(0.03, "in"),
    style = north_arrow_fancy_orienteering(
      line_col = "black",
      fill = c("white", "red"),
      text_col = "black",
      text_face = "bold",
      text_size = 12
    )
  ) +
  
  # Scale bar
  ggspatial::annotation_scale(location = "bl", width_hint = 0.25, style = "ticks")









