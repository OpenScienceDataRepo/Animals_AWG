# Built off of Charley's gastrocnemius transcriptome alignment code

#load library
library(ggplot2)
library(tidyverse)
library(scales)
library(RColorBrewer)

#load data
kidney.metrics.df <- read_csv("kidney_FLT_GC_qc_metrics_ORIGINAL.csv")

#prepare data for transcriptome mapping
transcriptome.alignment.kidney.metrics.df <- kidney.metrics.df %>% select(osd_num,sample, pct_uniquely_aligned, pct_multi_aligned, pct_unalignable)

#Add a new column for library_kit
transcriptome.alignment.kidney.metrics.df <-  transcriptome.alignment.kidney.metrics.df %>%
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

# Box_plot1: percentage of uniquely aligned data to transcriptome by library kit
ggplot(transcriptome.alignment.kidney.metrics.df, aes(x = osd_num, y= pct_uniquely_aligned, fill = osd_num)) +
  geom_boxplot(linewidth = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 8))+
  scale_fill_brewer(palette = "Set2")+
  labs(title = "Uniquely Aligned Percentage of Kidney Datasets by Library Kits", x = "OSD-number", y = "Uniquely aligned (%)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("transcriptome_unique_alignment_kidney_libraryKits.png", dpi = 300,
       width = 14, height = 4, units = "in")

# Box_plot2: percentage of total aligned data to transcriptome by library kit
ggplot(transcriptome.alignment.kidney.metrics.df, aes(x = osd_num, y= (pct_uniquely_aligned+pct_multi_aligned), fill = osd_num)) +
  geom_boxplot(linewidth = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 10))+
  scale_fill_brewer(palette = "Set2")+
  labs(title = "Total Aligned Percentage of Kidney Datasets by Library Kits", x = "OSD-number", y = "Total aligned (%)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("transcriptome_total_alignment_kidney_libraryKits.png", dpi = 300,
       width = 14, height = 4, units = "in")