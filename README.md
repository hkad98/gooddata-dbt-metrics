# This repository compares GoodData and dbt metrics

Important links:
* [GoodData metrics documentation](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/concepts/metrics/)
* [dbt metrics documentation](https://docs.getdbt.com/docs/build/metrics)

## How to use this repo
There is a docker-compose.yaml file where are two defined services. One service starts GoodData and the second is bootstrapping of GoodData and dbt metrics. Run the following command in the root directory of this repo to start up services.

```bash
docker compose up -d
```

## Exploring

Feel free to explore and compare GoodData and dbt metrics. You can access running GoodData on [http://localhost:3000](http://localhost:3000). There is a bootstraped workspace with basic visualizatons and metrics.

GoodData credentials:
* Username: demo@example.com
* Password: demo123
* Token: YWRtaW46Ym9vdHN0cmFwOmFkbWluMTIz

Database credentials:
* Username: demouser
* Password: demopass
