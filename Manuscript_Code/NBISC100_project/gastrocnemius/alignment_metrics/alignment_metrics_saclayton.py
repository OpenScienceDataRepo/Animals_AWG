# Figure generation code for NBISC100 AWG OSDR project
# Code written by Stuart Clayton (https://github.com/sclayton33)

import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

qc_df = pd.read_csv("gastrocnemius_qc_metrics.csv")

# --------------------- Genome alignment plot ---------------------
plt.figure(figsize=(6, 6))
sns.boxplot(
    data=qc_df,
    x="osd_num",
    y="uniquely_mapped_percent",
    palette="Set2",
    showfliers=True, # show outliers
)

# Axis labels and title
plt.xlabel("OSD Number", fontsize=12)
plt.ylabel("% Uniquely Mapped", fontsize=12)
plt.title("Genome Alignment by OSD Number", fontsize=14)

sns.despine()
plt.tight_layout()
plt.savefig("Uniquely_Mapped_sac.png", dpi=300)


# --------------------- transcriptome alignment plot ---------------------
plt.figure(figsize=(6, 6))
sns.boxplot(
    data=qc_df,
    x="osd_num",
    y="pct_uniquely_aligned",
    palette="Set2",
    showfliers=True, # show outliers
)

# Axis labels and title
plt.xlabel("OSD Number", fontsize=12)
plt.ylabel("% uniquely aligned", fontsize=12)
plt.title("% uniquely aligned by OSD Number", fontsize=14)

sns.despine()
plt.tight_layout()
plt.savefig("uniquely_aligned_sac.png", dpi=300)