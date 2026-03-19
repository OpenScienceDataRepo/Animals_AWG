import pandas as pd
from matplotlib_venn import venn3
import matplotlib.pyplot as plt

from supervenn import supervenn  # optional, but useful for comparing > 4 datasets

# skip first row since it just lists dataset name
# read in each sheet as separate df
# some gene symbols are nan, so drop them
OSD_101_gastroc = pd.read_excel("DEGs OSD101_419_401.xlsx", sheet_name="OSD-101 DGE", skiprows=1).dropna()
OSD_401_gastroc = pd.read_excel("DEGs OSD101_419_401.xlsx", sheet_name="OSD-401 DGE", skiprows=1).dropna()
OSD_419_gastroc = pd.read_excel("DEGs OSD101_419_401.xlsx", sheet_name="OSD-419 DGE", skiprows=1).dropna()

# create a set for each and only include genes with an adjusted p-value < 0.05
OSD_101_set = set(OSD_101_gastroc[OSD_101_gastroc["ADJP"] < 0.05]["Symbol"])
OSD_401_set = set(OSD_401_gastroc[OSD_401_gastroc["ADJP"] < 0.05]["Symbol"])
OSD_419_set = set(OSD_419_gastroc[OSD_419_gastroc["ADJP"] < 0.05]["Symbol"])

# compare intersections (shared genes)
shared_genes_in_all_3 = OSD_101_set & OSD_401_set & OSD_419_set
shared_genes_101_419 = OSD_101_set & OSD_419_set
shared_genes_401_419 = OSD_401_set & OSD_419_set
shared_genes_101_401 = OSD_101_set & OSD_401_set

# unique genes in each dataset
unique_OSD_101 = OSD_101_set - (OSD_401_set | OSD_419_set)
unique_OSD_401 = OSD_401_set - (OSD_101_set | OSD_419_set)
unique_OSD_419 = OSD_419_set - (OSD_101_set | OSD_401_set)

# count and list shared and unique genes
print(f"Shared across all 3: {len(shared_genes_in_all_3)}")
print(f"Shared across all 3: {shared_genes_in_all_3}")

print(f"Shared between 101 & 401: {len(shared_genes_101_401)}")
print(f"Shared between 101 & 401: {shared_genes_101_401}")

print(f"Shared between 101 & 419: {len(shared_genes_101_419)}")
print(f"Shared between 101 & 419: {shared_genes_101_419}")

print(f"Shared between 401 & 419: {len(shared_genes_401_419)}")
print(f"Shared between 401 & 419: {shared_genes_401_419}")

print(f"Unique to OSD 101: {len(unique_OSD_101)}")
print(f"Unique to OSD 101: {unique_OSD_101}")

print(f"Unique to OSD 401: {len(unique_OSD_401)}")
print(f"Unique to OSD 401: {unique_OSD_401}")

print(f"Unique to OSD 419: {len(unique_OSD_419)}")
print(f"Unique to OSD 419: {unique_OSD_419}")

# classic venn diagram
plt.figure(figsize=(6,6))
venn3(
    [OSD_101_set, OSD_401_set, OSD_419_set],
    ("OSD-101", "OSD-401", "OSD-419"),
    set_colors=['steelblue', 'orange', 'green'],
    alpha=0.8
)
plt.title("Differentially Expressed Gastroc Genes (padj < 0.05)")
# umcomment below line to save
# plt.savefig("venn3_all_3_gastroc_OSD_SAC.png", dpi=300)

# supervenn version
venn_sets = [OSD_101_set, OSD_401_set, OSD_419_set]
OSD_nums = ["OSD-101", "OSD-401", "OSD-419"]
plt.figure(figsize=(8,3), dpi=300)
supervenn(venn_sets, OSD_nums, rotate_col_annotations=True,
          col_annotations_area_height=1.2, sets_ordering='minimize gaps',side_plots=False)
plt.title("Differentially Expressed Gastroc Genes (padj < 0.05)")
# umcomment below line to save
# plt.savefig("supervenn_all_3_gastroc_OSD_DEGs_SAC.png", dpi=300)