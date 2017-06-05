Now that we have loaded data into the tables, let's go ahead and run some queries. Citus supports standard `INSERT`, `UPDATE` and `DELETE` commands for inserting and modifying rows in a distributed table which is the typical way of interaction for a user-facing application.

For example, you can insert a new company by running:
`
INSERT INTO companies VALUES (5000, 'New Company', 'https://randomurl/image.png', now(), now());
`{{execute}}

If you want to double the budget for all the campaigns of a company, you can run an UPDATE command:

`
UPDATE campaigns
SET monthly_budget = monthly_budget*2
WHERE company_id = 5;
`{{execute}}

Another example of such an operation would be to run transactions which span multiple tables. Let's say you want to delete a campaign and all its associated ads, you could do it atomically by running.

`
BEGIN;
DELETE from campaigns where id = 46 AND company_id = 5;
DELETE from ads where campaign_id = 46 AND company_id = 5;
COMMIT;
`{{execute}}

Other than transactional operations, you can also run analytics queries on this data using standard SQL. One interesting query for a company to run would be to see details about its campaigns with maximum budget.

`
SELECT name, cost_model, state, monthly_budget
FROM campaigns
WHERE company_id = 5
ORDER BY monthly_budget DESC
LIMIT 10;
`{{execute}}

We can also run a join query across multiple tables to see information about running campaigns which receive the most clicks and impressions.

`
SELECT campaigns.id, campaigns.name, campaigns.monthly_budget,
    sum(impressions_count) as total_impressions, sum(clicks_count) as total_clicks
FROM ads, campaigns
WHERE ads.company_id = campaigns.company_id
AND campaigns.company_id = 5
AND campaigns.state = 'running'
GROUP BY campaigns.id, campaigns.name, campaigns.monthly_budget
ORDER BY total_impressions, total_clicks;
`{{execute}}
