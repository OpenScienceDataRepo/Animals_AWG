# Built off of Charley's gastrocnemius genome alignment code

#load library
library(ggplot2)
library(tidyverse)
library(scales)
library(RColorBrewer)

#load data
kidney.metrics.df <- read_csv("kidney_FLT_GC_qc_metrics_ORIGINAL.csv")

#prepare data for genome mapping
genome.alignment.kidney.metrics.df <- kidney.metrics.df %>% select(osd_num,sample,uniquely_mapped_percent,multimapped_percent,multimapped_toomany_percent,unmapped_tooshort_percent, unmapped_other_percent)

#Add a new column for library_kit
genome.alignment.kidney.metrics.df <-  genome.alignment.kidney.metrics.df %>%
  mutate(library_kit= case_when(osd_num == "OSD-102" ~ "ribo-deplete kit",
                                osd_num == "OSD-163" ~ "ribo-deplete kit",
                                osd_num == "OSD-253" ~ "ribo-deplete kit",
                                osd_num == "OSD-457" ~ "polyA-nonUPX kit",
                                osd_num == "OSD-462" & str_detect(sample, "UPX") ~ "polyA-UPX kit",
                                osd_num == "OSD-462" & str_detect(sample, "mRNA") ~ "polyA-nonUPX kit",
                                osd_num == "OSD-462" & str_detect(sample, "totRNA") ~ "ribo-deplete kit",
                                osd_num == "OSD-513" ~ "ribo-deplete kit",
                                osd_num == "OSD-771" ~ "ribo-deplete kit")) %>% 
  drop_na(library_kit)

# Box_plot1: percentage of uniquely mapped data by library kit
ggplot(genome.alignment.kidney.metrics.df, aes(x = osd_num, y= uniquely_mapped_percent, fill = osd_num)) +
  geom_boxplot(linewidth = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 8))+
  scale_fill_brewer(palette = "Set2")+
  labs(title = "Uniquely Mapped Percentage of Kidney Datasets by Library Kits", x = "OSD-number", y = "Uniquely mapped (%)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("genome_uniquely_mapped_kidney_LibraryKits.png", dpi = 300,
       width = 14, height = 4, units = "in")


# Box_plot2: percentage of total mapped data by library kit
ggplot(genome.alignment.kidney.metrics.df, aes(x = osd_num, y= 100 - (unmapped_tooshort_percent + unmapped_other_percent), fill = osd_num)) +
  geom_boxplot(linewidth = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 10))+
  scale_fill_brewer(palette = "Set2")+
  labs(title = "Total Mapped Percentage of Kidney Datasets by Library Kits", x = "OSD-number", y = "Total mapped (%)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("genome_total_mapped_kidney_LibraryKits.png", dpi = 300,
       width = 14, height = 4, units = "in")
