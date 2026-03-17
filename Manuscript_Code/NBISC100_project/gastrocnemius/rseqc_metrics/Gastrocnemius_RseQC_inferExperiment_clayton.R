#load library
library(ggplot2)
library(tidyverse)
library(scales)
library(RColorBrewer)

#load data
gastroc.metrics.df <- read_csv("gastrocnemius_qc_metrics.csv")

# prepare data for RseQC infer experiment
RseQC_inferExp.gastroc.metrics.df <-gastroc.metrics.df %>%
  select(osd_num, pct_sense)

# Add a new column for library kit
RseQC_inferExp.gastroc.metrics.df <- RseQC_inferExp.gastroc.metrics.df %>%
  mutate(library_kit= recode(osd_num,
                            "OSD-401"="polyA-nonUPX kit",
                            "OSD-101"="ribo-deplete kit",
                            "OSD-419"="polyA-UPX kit"))

# Box_plot1: gastroc_RseQC_strandedness by library kit
ggplot(RseQC_inferExp.gastroc.metrics.df, aes(x = osd_num, y = pct_sense, fill = osd_num)) +
  geom_boxplot(size = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 10))+
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Strandedness of Gastroc Datasets by Library Kits", x = "OSD-number", y = "sense(%)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("RseQC_strandedned_gastroc_libraryKits_SAC.png", dpi = 300,
       width = 6.7, height = 4, units = "in")
