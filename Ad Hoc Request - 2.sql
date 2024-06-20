
/*2. Generate a report that provides an overview of the number of stores in each city. The results will be stored in descending order 
of store counts, allowing us to identify the cities with the highest store presence. The report includes two essesntial fields. City
and store count, which will assist in optimizing our retail operations.*/
Select city, count(store_id) as Store_count
from dim_stores
group by city
order by store_count desc;