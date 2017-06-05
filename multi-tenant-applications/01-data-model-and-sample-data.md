We will demo building the database for an ad-analytics app which companies can use to view, change, analyze and manage their ads and campaigns (see an [example app](http://citus-example-ad-analytics.herokuapp.com)). Such an application has good characteristics of a typical multi-tenant system. Data from different tenants is stored in a central database, and each tenant has an isolated view of their own data.

We will use three Postgres tables to represent this data. To get started, we prepared three csv files to these tables;

- companies.csv
- campaign.csv
- ads.csv
