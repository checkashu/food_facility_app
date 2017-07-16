Assumptions:
1. In second point we just want to see the status of permit as of today.
2. Object id appears to be the unique identification id for each data point.
3. 


API:
1. get 'applicant/name=?' searches on user name. Example:(url/applicant?name=Natan)
2. get 'applicant/check_expiration=true,date=?' searches if a user's permit has expired or not. Example(url/applicant?date=23-02-2015&check_expiration=true)
3. get 'applicant/street_name_search=true,street_name=?' searches on street_name. Example(url/applicant?street_name=MISSOURI&street_name_search=true)
4. put 'entries/addition=true' adds an entry in table. Example()
5. delete 'entries/addition=false' deletes entry in table. Example(url/entries/destroy?objectid=437211)
6. 'path/from=?,to=?' will give you the optimal path. One with minimum transfers.

