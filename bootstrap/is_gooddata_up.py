from gooddata_sdk import GoodDataSdk
import os

TIMEOUT = 180


def main():
    host = os.environ.get("HOST", "http://gooddata-cn-ce:3000")
    token = os.environ.get("TOKEN", "YWRtaW46Ym9vdHN0cmFwOmFkbWluMTIz")
    header_host = os.environ.get("HEADER_HOST", "localhost")


    sdk = GoodDataSdk.create(host_=host, token_=token, Host=header_host)
    print("Check if gooddata is up and running...", flush=True)
    try:
        sdk.support.wait_till_available(TIMEOUT)
    except TimeoutError:
        print(f"GD.CN did not start up in predifned timeout of {TIMEOUT} seconds.", flush=True)
    else:
        print("GD.CN is up and running.", flush=True)

if __name__ == "__main__":
    main()