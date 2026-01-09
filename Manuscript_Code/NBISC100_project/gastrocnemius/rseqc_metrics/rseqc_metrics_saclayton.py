# Figure generation code for NBISC100 AWG OSDR project
# Code written by Stuart Clayton (https://github.com/sclayton33)

import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

qc_df = pd.read_csv("gastrocnemius_qc_metrics.csv")

# --------------------- RSeQC metrics - percent antisense plot ---------------------
plt.figure(figsize=(6, 6))
sns.boxplot(
    data=qc_df,
    x="osd_num",
    y="pct_antisense",
    palette="Set2",
    showfliers=True, # show outliers
)

# Axis labels and title
plt.xlabel("OSD Number", fontsize=12)
plt.ylabel("% antisense", fontsize=12)
plt.title("antisense by OSD Number", fontsize=14)

sns.despine()
plt.tight_layout()
plt.savefig("antisense_sac.png", dpi=300)


# --------------------- RSeQC metrics - geneBody coverage plot ---------------------
plt.figure(figsize=(6, 6))
sns.boxplot(
    data=qc_df,
    x="osd_num",
    y="ratio_genebody_cov_3_to_5",
    palette="Set2",
    showfliers=True, # show outliers
)

# Axis labels and title
plt.xlabel("OSD Number", fontsize=12)
plt.ylabel("3' to 5' geneBody coverage ratio", fontsize=12)
plt.title("geneBody Coverage by OSD Number", fontsize=14)

sns.despine()
plt.tight_layout()
plt.savefig("geneBody_coverage_sac.png", dpi=300)


# --------------------- RSeQC metrics - percent sense plot ---------------------
plt.figure(figsize=(6, 6))
sns.boxplot(
    data=qc_df,
    x="osd_num",
    y="pct_sense",
    palette="Set2",
    showfliers=True, # show outliers
)

# Axis labels and title
plt.xlabel("OSD Number", fontsize=12)
plt.ylabel("% sense", fontsize=12)
plt.title("sense by OSD Number", fontsize=14)

sns.despine()
plt.tight_layout()
plt.savefig("sense_sac.png", dpi=300)


# --------------------- RSeQC metrics - percent undertermined sense plot ---------------------
plt.figure(figsize=(6, 6))
sns.boxplot(
    data=qc_df,
    x="osd_num",
    y="pct_undetermined",
    palette="Set2",
    showfliers=True, # show outliers
)

# Axis labels and title
plt.xlabel("OSD Number", fontsize=12)
plt.ylabel("% undetermined sense", fontsize=12)
plt.title("Undetermined sense by OSD Number", fontsize=14)

sns.despine()
plt.tight_layout()
plt.savefig("undetermined_sense_sac.png", dpi=300)