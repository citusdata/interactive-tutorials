We will now go ahead and tell Citus to distribute these tables across the different nodes we have in the cluster. To do so, you can run `create_distributed_table` and specify the table you want to shard and the column you want to shard on. In this case, we will shard all the tables on the `company_id`.

`
SELECT create_distributed_table('companies', 'id');
SELECT create_distributed_table('campaigns', 'company_id');
SELECT create_distributed_table('ads', 'company_id');
`{{execute}}

Sharding all tables on the company identifier allows Citus to [colocate](https://docs.citusdata.com/en/v6.2/sharding/colocation.html#colocation) the tables together and allow for features like primary keys, foreign keys and complex joins across your cluster. You can learn more about the benefits of this approach [here](https://www.citusdata.com/blog/2016/10/03/designing-your-saas-database-for-high-scalability).

Then, you can go ahead and load the data we downloaded into the tables using the standard PostgreSQL `\COPY` command. Please make sure that you specify the correct file path if you downloaded the file to some other location.

`
\copy companies from 'companies.csv' with csv;
\copy campaigns from 'campaigns.csv' with csv;
\copy ads from 'ads.csv' with csv;
`{{execute}}
