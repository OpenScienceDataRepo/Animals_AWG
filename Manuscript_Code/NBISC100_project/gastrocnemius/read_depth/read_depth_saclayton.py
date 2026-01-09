# Figure generation code for NBISC100 AWG OSDR project
# Code written by Stuart Clayton (https://github.com/sclayton33)

import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter

qc_df = pd.read_csv("gastrocnemius_qc_metrics.csv")

# Read depth plot
plt.figure(figsize=(6, 6))
sns.boxplot(
    data=qc_df,
    x="osd_num",
    y="read_depth",
    palette="Set2",
    showfliers=True, # show outliers
)

# Axis labels and title
plt.xlabel("OSD Number", fontsize=12)
plt.ylabel("Read Depth (millions)", fontsize=12)
plt.title("Read Depth by OSD Number", fontsize=14)

# Format y-axis to millions
plt.gca().yaxis.set_major_formatter(FuncFormatter(lambda x, _: f"{x/1e6:.0f}M"))

sns.despine()
plt.tight_layout()
plt.savefig("Read_Depth_sac.png", dpi=300)