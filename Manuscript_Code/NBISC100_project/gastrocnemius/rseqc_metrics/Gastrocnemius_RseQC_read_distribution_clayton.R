#load library
library(ggplot2)
library(tidyverse)
library(scales)
library(RColorBrewer)

#load data
gastroc.metrics.df <- read_csv("gastrocnemius_qc_metrics.csv")

# prepare data for RseQC read distribution
RseQC_read_distribution.gastroc.metrics.df <-gastroc.metrics.df %>%
  select(osd_num, cds_exons_pct,`5_utr_exons_pct`,`3_utr_exons_pct`,introns_pct, tss_up_5kb_10kb_pct)

# Add a new column for library kit
RseQC_read_distribution.gastroc.metrics.df <- RseQC_read_distribution.gastroc.metrics.df %>%
  mutate(library_kit= recode(osd_num,
                            "OSD-401"="polyA-nonUPX kit",
                            "OSD-101"="ribo-deplete kit",
                            "OSD-419"="polyA-UPX kit"))

## cds exons----------------------
# Box_plot1: gastroc_RseQC_cds_exons by library kit
ggplot(RseQC_read_distribution.gastroc.metrics.df, aes(x = osd_num, y = cds_exons_pct, fill = osd_num)) +
  geom_boxplot(size = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 10))+
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Read Distribution (CDS Exons) of Gastroc Datasets by Library Kits", x = "OSD-number", y = "cds exons(%)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("RseQC_cds_exons_gastroc_libraryKits_SAC.png", dpi = 300,
       width = 7.7, height = 4, units = "in")

## 5'UTRs---------------
# Box_plot1: gastroc_RseQC_5'UTR by library kit
ggplot(RseQC_read_distribution.gastroc.metrics.df, aes(x = osd_num, y = `5_utr_exons_pct`, fill = osd_num)) +
  geom_boxplot(size = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 10))+
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Read Distribution (5' UTRs) of Gastroc Datasets by Library Kits", x = "OSD-number", y = "5' UTRs (%)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("RseQC_5UTRs_gastroc_libraryKits_SAC.png", dpi = 300,
       width = 7.7, height = 4, units = "in")

## 3' UTRs --------------
# Box_plot1: gastroc_RseQC_3'UTR by library kit
ggplot(RseQC_read_distribution.gastroc.metrics.df, aes(x = osd_num, y = `3_utr_exons_pct`, fill = osd_num)) +
  geom_boxplot(size = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 10))+
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Read Distribution (3' UTRs) of Gastroc Datasets by Library Kits", x = "OSD-number", y = "3' UTRs (%)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("RseQC_3UTRs_gastroc_libraryKits_SAC.png", dpi = 300,
       width = 7.7, height = 4, units = "in")

## introns ------------
# Box_plot1: gastroc_RseQC_3'UTR by library kit
ggplot(RseQC_read_distribution.gastroc.metrics.df, aes(x = osd_num, y = introns_pct, fill = osd_num)) +
  geom_boxplot(size = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 10))+
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Read Distribution (Introns) of Gastroc Datasets by Library Kits", x = "OSD-number", y = "introns (%)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("RseQC_introns_gastroc_libraryKits_SAC.png", dpi = 300,
       width = 7.7, height = 4, units = "in")

## tss_up 5 to 10 kb -------
# Box_plot1: gastroc_RseQC_introns by library kit
ggplot(RseQC_read_distribution.gastroc.metrics.df, aes(x = osd_num, y = tss_up_5kb_10kb_pct, fill = osd_num)) +
  geom_boxplot(size = 0.1, varwidth = TRUE) +
  stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
  facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
  scale_y_continuous(breaks = pretty_breaks(n = 10))+
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Read Distribution (TSS up 5-10 kb) of Gastroc Datasets by Library Kits", x = "OSD-number", y = "tss up 5-10 kb (%)") +
  theme_classic() +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

ggsave("RseQC_tssUp5_gastroc_libraryKits_SAC.png", dpi = 300,
       width = 8.3, height = 4, units = "in")
