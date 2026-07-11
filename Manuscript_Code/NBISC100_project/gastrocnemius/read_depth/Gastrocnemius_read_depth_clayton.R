# load library
library(ggplot2)
library(tidyverse)
library(scales)
library(RColorBrewer)

# load QC dataset
gastroc.metrics.df <- read_csv("gastrocnemius_qc_metrics.csv")

# prepare data for specific read_depth plots
read_depth.gastroc.metrics.df <- gastroc.metrics.df %>%
    select(osd_num, read_depth, sequencing_instrument)

# hard-coded OSD and kit orders
osd_order <- c("OSD-401", "OSD-419", "OSD-101")
kit_order <- c("polyA-nonUPX kit", "polyA-UPX kit", "ribo-deplete kit")
sequencer_order <- c("Illumina HiSeq 3000", "Illumina NovaSeq 6000", "Illumina HiSeq 4000")

#Add new columns for library_kit
read_depth.gastroc.metrics.df <- read_depth.gastroc.metrics.df %>%
mutate(
    osd_num = factor(osd_num, levels = osd_order),
    library_kit= recode(osd_num,
                        "OSD-401"="polyA-nonUPX kit",
                        "OSD-101"="ribo-deplete kit",
                        "OSD-419"="polyA-UPX kit"),
    library_kit = factor(library_kit, levels = kit_order),
    sequencing_instrument = factor(sequencing_instrument, levels = sequencer_order)
)

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
    theme(
        plot.title = element_text(hjust = 0.5, size = 11),
        plot.title.position = "plot"
    )

ggsave("read_depth_gastroc_libraryKits_SAC.png", dpi = 300,
    width = 6.7, height = 4, units = "in")

# Box_plot2: gastroc_read_depth by sequencing instrument
ggplot(read_depth.gastroc.metrics.df, aes(x = osd_num, y = read_depth/1e6, fill= osd_num)) +
    geom_boxplot(size = 0.1, varwidth = TRUE) +
    stat_boxplot(geom = "errorbar", width = 0.2, size= 0.1)+
    facet_wrap(~sequencing_instrument, scales = "free_x", drop = TRUE) +
    scale_y_continuous(breaks = pretty_breaks(n = 12))+
    scale_fill_brewer(palette = "Set2")+
    labs(title = "Read Depth of Gastroc Datasets by Sequencer", x = "OSD-number", y = "Read depth (millions)") +
    theme_classic() +
    theme(legend.position = "none")+
    theme(
        plot.title = element_text(hjust = 0.5, size = 11),
        plot.title.position = "plot"
    )

ggsave("read_depth_gastroc_sequencer_SAC.png", dpi = 600,
    width = 6.7, height = 6, units = "in")
