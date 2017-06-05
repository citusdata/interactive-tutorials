export PATH=/usr/lib/postgresql/9.6/bin/:$PATH

psql -c "SELECT logicalrelid FROM pg_dist_partition WHERE logicalrelid = 'companies'::regclass" -q | grep -q "companies" &> /dev/null &&
psql -c "SELECT logicalrelid FROM pg_dist_partition WHERE logicalrelid = 'campaigns'::regclass" -q | grep -q "campaigns" &> /dev/null &&
psql -c "SELECT logicalrelid FROM pg_dist_partition WHERE logicalrelid = 'ads'::regclass" -q | grep -q "ads" &> /dev/null &&
echo "done"
