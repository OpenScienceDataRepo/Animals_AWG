#load library
library(ggplot2)
library(tidyverse)
library(scales)
library(RColorBrewer)

#load data
gastroc.metrics.df <- read_csv("gastrocnemius_qc_metrics.csv")

#prepare data for genome mapping
 genome.alignment.gastroc.metrics.df <- gastroc.metrics.df %>% select(osd_num,uniquely_mapped_percent,multimapped_percent,multimapped_toomany_percent,unmapped_tooshort_percent, unmapped_other_percent)

 #Add a new column for library_kit
 genome.alignment.gastroc.metrics.df <-  genome.alignment.gastroc.metrics.df %>%
   mutate(library_kit= recode(osd_num,
                              "OSD-401"="polyA-nonUPX kit",
                              "OSD-101"="ribo-deplete kit",
                              "OSD-419"="polyA-UPX kit"))

# Box_plot1: percentage of uniquely mapped data by library kit
 ggplot(genome.alignment.gastroc.metrics.df, aes(x = osd_num, y= uniquely_mapped_percent, fill = osd_num)) +
   geom_boxplot(linewidth = 0.1, varwidth = TRUE) +
   stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
   facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
   scale_y_continuous(breaks = pretty_breaks(n = 8))+
   scale_fill_brewer(palette = "Set2")+
   labs(title = "Uniquely Mapped Percentage of Gastroc Datasets by Library Kits", x = "OSD-number", y = "Uniquely mapped (%)") +
   theme_classic() +
   theme(legend.position = "none")+
   theme(plot.title = element_text(hjust = 0.5))

 ggsave("genome_uniquely_mapped_gastroc_LibraryKits_SAC.png", dpi = 300,
        width = 7, height = 4, units = "in")


 # Box_plot2: percentage of total mapped data by library kit
 ggplot(genome.alignment.gastroc.metrics.df, aes(x = osd_num, y= 100 - (unmapped_tooshort_percent + unmapped_other_percent), fill = osd_num)) +
   geom_boxplot(linewidth = 0.1, varwidth = TRUE) +
   stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
   facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
   scale_y_continuous(breaks = pretty_breaks(n = 10))+
   scale_fill_brewer(palette = "Set2")+
   labs(title = "Total Mapped Percentage of Gastroc Datasets by Library Kits", x = "OSD-number", y = "Total mapped (%)") +
   theme_classic() +
   theme(legend.position = "none")+
   theme(plot.title = element_text(hjust = 0.5))

 ggsave("genome_total_mapped_gastroc_LibraryKits_SAC.png", dpi = 300,
        width = 7, height = 4, units = "in")
