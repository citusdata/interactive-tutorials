export PATH=/usr/lib/postgresql/9.6/bin:$PATH;

psql -c "\d companies" &&
psql -c "\d campaigns" &&
psql -c "\d ads"&&
echo "done";
