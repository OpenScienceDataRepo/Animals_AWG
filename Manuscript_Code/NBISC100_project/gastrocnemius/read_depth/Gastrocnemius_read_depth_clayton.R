#load library
library(ggplot2)
library(tidyverse)
library(scales)
library(RColorBrewer)

#load data
gastroc.metrics.df <- read_csv("gastrocnemius_qc_metrics.csv")

# prepare data for specific read_depth plots
read_depth.gastroc.metrics.df <- gastroc.metrics.df %>% select(osd_num, read_depth, sequencing_instrument)

#Add new columns for library_kit
read_depth.gastroc.metrics.df <- read_depth.gastroc.metrics.df %>%
  mutate(library_kit= recode(osd_num,
                            "OSD-401"="polyA-nonUPX kit",
                            "OSD-101"="ribo-deplete kit",
                            "OSD-419"="polyA-UPX kit"))

# Box_plot1: gastroc_read_depth by library kit
ggplot(read_depth.gastroc.metrics.df, aes(x = osd_num, y = read_depth/1e6, fill= osd_num)) +
  geom_boxplot(size = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 12))+
  scale_fill_brewer(palette = "Set2")+
  labs(title = "Read Depth of Gastroc Datasets by Library Kits", x = "OSD-number", y = "Read depth (millions)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("read_depth_gastroc_libraryKits_SAC.png", dpi = 300,
       width = 6.7, height = 4, units = "in")

# Box_plot2: gastroc_read_depth by sequencing instrument
ggplot(read_depth.gastroc.metrics.df, aes(x = osd_num, y = read_depth/1e6, fill= osd_num)) +
  geom_boxplot(size = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~sequencing_instrument, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 12))+
  scale_fill_brewer(palette = "Set2")+
  labs(title = "Read Depth of Gastroc Datasets by Sequencer", x = "OSD-number", y = "Read depth (millions)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("read_depth_gastroc_sequencer_SAC.png", dpi = 600,
       width = 6.7, height = 6, units = "in")
