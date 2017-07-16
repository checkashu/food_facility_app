Assumptions:
1. In second point we just want to see the status of permit as of today.
2. Object id appears to be the unique identification id for each data point.
3. 


API:
1. 'applicant/name=?' searches on user name
2. 'applicant/check_expiration=true,date=?' searches if a user's permit has expired or not
3. 'applicant/street_name_search=true,street_name=?' searches on street_name
4. 'entries/addition=true' adds an entry in table
5. 'entries/addition=false' deletes entry in table
6. 'path/from=?,to=?' will give you the optimal path. One with minimum transfers.

