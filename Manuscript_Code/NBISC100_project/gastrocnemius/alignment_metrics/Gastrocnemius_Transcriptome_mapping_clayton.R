# load library
library(ggplot2)
library(tidyverse)
library(scales)
library(RColorBrewer)

# load QC dataset
gastroc.metrics.df <- read_csv("gastrocnemius_qc_metrics.csv")

# prepare data for transcriptome alignment
transcriptome.alignment.gastroc.metrics.df <- gastroc.metrics.df %>%
    select(osd_num, pct_uniquely_aligned, pct_multi_aligned, pct_unalignable)

# hard-coded OSD and kit orders
osd_order <- c("OSD-401", "OSD-419", "OSD-101")
kit_order <- c("polyA-nonUPX kit", "polyA-UPX kit", "ribo-deplete kit")

# add a new column for library_kit
transcriptome.alignment.gastroc.metrics.df <- transcriptome.alignment.gastroc.metrics.df %>%
mutate(
    osd_num = factor(osd_num, levels = osd_order),
    library_kit= recode(osd_num,
                        "OSD-401"="polyA-nonUPX kit",
                        "OSD-101"="ribo-deplete kit",
                        "OSD-419"="polyA-UPX kit"),
    library_kit = factor(library_kit, levels = kit_order)
)

# Box_plot1: percentage of uniquely aligned data to transcriptome by library kit
ggplot(transcriptome.alignment.gastroc.metrics.df, aes(x = osd_num, y= pct_uniquely_aligned, fill = osd_num)) +
    geom_boxplot(linewidth = 0.1, varwidth = TRUE) +
    stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
    facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
    scale_y_continuous(breaks = pretty_breaks(n = 8))+
    scale_fill_brewer(palette = "Set2")+
    labs(title = "Uniquely Aligned Percentage of Gastroc Datasets by Library Kits", x = "OSD-number", y = "Uniquely aligned (%)") +
    theme_classic() +
    theme(legend.position = "none")+
    theme(
        plot.title = element_text(hjust = 0.5, size = 11),
        plot.title.position = "plot"
    )

ggsave("transcriptome_unique_alignment_gastroc_libraryKits_SAC.png", dpi = 300,
    width = 7.3, height = 4, units = "in")

# Box_plot2: percentage of total aligned data to transcriptome by library kit
ggplot(transcriptome.alignment.gastroc.metrics.df, aes(x = osd_num, y= (pct_uniquely_aligned+pct_multi_aligned), fill = osd_num)) +
    geom_boxplot(linewidth = 0.1, varwidth = TRUE) +
    stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
    facet_wrap(~library_kit, scales = "free_x", drop = TRUE)+
    scale_y_continuous(breaks = pretty_breaks(n = 10))+
    scale_fill_brewer(palette = "Set2")+
    labs(title = "Total Aligned Percentage of Gastroc Datasets by Library Kits", x = "OSD-number", y = "Total aligned (%)") +
    theme_classic() +
    theme(legend.position = "none")+
    theme(
        plot.title = element_text(hjust = 0.5, size = 11),
        plot.title.position = "plot"
    )

ggsave("transcriptome_total_alignment_gastroc_libraryKits_SAC.png", dpi = 300,
    width = 7.3, height = 4, units = "in")
