import os
from gooddata_sdk import GoodDataSdk
from pathlib import Path


def main():
    host = os.environ.get("HOST", "http://gooddata-cn-ce:3000")
    token = os.environ.get("TOKEN", "YWRtaW46Ym9vdHN0cmFwOmFkbWluMTIz")
    header_host = os.environ.get("HEADER_HOST", "localhost")

    sdk = GoodDataSdk.create(host_=host, token_=token, Host=header_host)

    print("Bootstraping data source...", flush=True)
    sdk.catalog_data_source.load_and_put_declarative_data_sources(Path("gooddata"), Path("ds-credentials.yaml"))
    print("Bootstraping workspace...", flush=True)
    sdk.catalog_workspace.load_and_put_declarative_workspaces(Path("gooddata"))
    print("GoodData is bootstraped.", flush=True)


if __name__ == "__main__":
    main()
