# Figure generation code for NBISC100 AWG OSDR project
# Code written by Stuart Clayton (https://github.com/sclayton33)

import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

qc_df = pd.read_csv("gastrocnemius_qc_metrics.csv")

# --------------------- rRNA contamination plot ---------------------
plt.figure(figsize=(6, 6))
sns.boxplot(
    data=qc_df,
    x="osd_num",
    y="rrna_contamination",
    palette="Set2",
    showfliers=True, # show outliers
)

# Axis labels and title
plt.xlabel("OSD Number", fontsize=12)
plt.ylabel("% rRNA Contamination", fontsize=12)
plt.title("rRNA Contamination by OSD Number", fontsize=14)

sns.despine()
plt.tight_layout()
plt.savefig("rRNA_contamination_sac.png", dpi=300)