# sc-best-practices.org

import tempfile
from pathlib import Path

import anndata2ri
import lamindb as ln
import rpy2.robjects

#%load_ext rpy2.ipython

ln.connect("theislab/sc-best-practices")

ln.track("QaILJZMpZyJ4")

af = ln.Artifact.connect("theislab/sc-best-practices").get(
    key="introduction/interoperability_adata.h5ad", is_latest=True
)
adata = af.load()

temp_dir = tempfile.TemporaryDirectory()
h5ad_file = str(Path(temp_dir.name) / "example.h5ad")
adata.write_h5ad(h5ad_file)

