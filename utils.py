import os
from gooddata_sdk import GoodDataSdk
from pathlib import Path
from shutil import rmtree

BOOTSTRAP_FOLDER = Path("bootstrap")
LAYOUT_FOLDER = BOOTSTRAP_FOLDER / "gooddata"
HOST = os.environ.get("HOST", "http://localhost:3000")
TOKEN = os.environ.get("TOKEN", "YWRtaW46Ym9vdHN0cmFwOmFkbWluMTIz")

sdk = GoodDataSdk.create(host_=HOST, token_=TOKEN)


"""
The following script should be run locally and not inside container.
"""

def clean_dir(path: str = LAYOUT_FOLDER) -> None:
    if os.path.exists(path):
        rmtree(path)
    os.makedirs(path)

def load():
    print("Loading declarative data sources...")
    sdk.catalog_data_source.load_and_put_declarative_data_sources(LAYOUT_FOLDER, BOOTSTRAP_FOLDER / "ds-credentials.yaml")
    print("Loading declarative workspaces...")
    sdk.catalog_workspace.load_and_put_declarative_workspaces(LAYOUT_FOLDER)
    print("Done")

def store():
    
    clean_dir()

    print("Storing declarative data sources...")
    sdk.catalog_data_source.store_declarative_data_sources(LAYOUT_FOLDER)
    print("Storing declarative workspaces...")
    sdk.catalog_workspace.store_declarative_workspaces(LAYOUT_FOLDER)
    print("Done")
